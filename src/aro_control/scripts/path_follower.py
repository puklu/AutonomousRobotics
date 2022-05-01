#!/usr/bin/env python3
"""
Simple path follower.

Always acts on the last received plan.
An empty plan means no action (stopping the robot).
"""

from __future__ import absolute_import, division, print_function
import rospy
import numpy as np
from ros_numpy import msgify, numpify
from tf.transformations import euler_from_quaternion, quaternion_from_euler
from tf2_py import TransformException
import tf2_ros
from threading import RLock
from timeit import default_timer as timer
import actionlib
from aro_msgs.msg import FollowPathAction, FollowPathFeedback, FollowPathResult, FollowPathGoal
from visualization_msgs.msg import Marker
from nav_msgs.msg import Path
from sensor_msgs.msg import PointCloud
from geometry_msgs.msg import Pose, Pose2D, Quaternion, Transform, TransformStamped, Twist, PoseStamped, Point
import random
from sensor_msgs.msg import LaserScan

np.set_printoptions(precision=3)


def segmentPointDist(seg_start, seg_end, point):
    '''
    Returns distance of point from a segment.

    Parameters:
        seg_start (numpy array [2]): x, y coordinates of segment beginning.
        seg_end (numpy array [2]): x, y coordinates of segment end
        point (numpy array [2]): x, y coordinates of point

    Returns:
        dist (float): Euclidean distance between segment and point.   
    '''
    seg = seg_end - seg_start
    len_seg = np.linalg.norm(seg)

    if len_seg == 0:
        return np.linalg.norm(seg_start - point)

    t = max(0.0, min(1.0, np.dot(point - seg_start, seg) / len_seg ** 2))
    proj = seg_start + t * seg

    return np.linalg.norm(point - proj)


def pointSlopeForm(p1, p2):
    '''
    Returns coefficients of a point-slope form of a line equation given by two points.

    Parameters:
        p1 (numpy array [2] (float)): x, y coordinates of first point
        p2 (numpy array [2] (float)): x, y coordinates of second point

    Returns:
        a, b, c (float): coefficients of a point-slope form of a line equation ax + by + c = 0.   
    '''
    dx = p2[0] - p1[0]
    dy = p2[1] - p1[1]

    if dx != 0:
        return dy / dx, -1, -(dy / dx) * p1[0] + p1[1]
    else:
        return 1, 0, -p1[0]


def getCircLineIntersect(p1, p2, circ_c, circ_r):
    '''
    Returns intersection points of a line given by two points
    and circle given by its center and radius. 

    Parameters:
        p1 (numpy array [2] (float)): x, y coordinates of point on the line
        p2 (numpy array [2] (float)): x, y coordinates of second point on the line
        circ_c (numpy array [2] (float)): x, y coordinates of circle center
        circ_r (float): circle radius

    Returns:
        points list(numpy array [2] (float)): x, y coordinates of intersection points   
    '''
    a, b, c = pointSlopeForm(p1, p2)  # get point-slope form of line ax + by + c = 0

    # find intersection based on line and circle equation
    if b != 0:  # line is not parallel to y axis
        const_t = circ_c[0] ** 2 + 2 * circ_c[1] * c / b + circ_c[1] ** 2 + c ** 2 / b ** 2 - circ_r ** 2
        lin_t = 2 * a * c / b ** 2 + 2 * circ_c[1] * a / b - 2 * circ_c[0]
        quad_t = 1 + a ** 2 / b ** 2
        x_vals = np.roots([quad_t, lin_t, const_t])  # find roots of quadratic equation
        y_vals = [-a / b * x - c / b for x in x_vals]  # compute y from substitution in line eq.
    else:
        const_t = c ** 2 + 2 * circ_c[0] * c + circ_c[0] ** 2 + circ_c[1] ** 2 - circ_r ** 2
        lin_t = -2 * circ_c[1]
        quad_t = 1
        y_vals = np.real(np.roots([quad_t, lin_t, const_t]))
        x_vals = [p1[0] for i in y_vals]  # compute x from substitution in line eq.

    points = [[x_vals[i], y_vals[i]] for i in range(len(x_vals))]  # intersection points
    return points


def linePointDist(line_begin, line_end, point):
    '''
    Returns distance of point from a line.

    Parameters:
        line_begin (numpy array [2] (float)): x, y coordinates of line beginning.
        line_end (numpy array [2] (float)): x, y coordinates of line end
        point (numpy array [2] (float)): x, y coordinates of point

    Returns:
        dist (float): Euclidean distance between line and point.   
    '''
    p = point - line_begin
    v = line_end - line_begin
    return abs((v[0]) * (p[1]) - (p[0]) * (v[1])) / np.linalg.norm(v[:2])


def slots(msg):
    '''
    Returns message attributes (slots) as list.

    Parameters:
        msg (ros msg): ROS message

    Returns:
        attributes (list): list of attributes of message    
    '''
    return [getattr(msg, var) for var in msg.__slots__]


def tf3to2(tf):
    '''
    Converts tf to Pose2D.

    Parameters:
        tf (tf): tf to be converted 

    Returns:
        pose2 (geometry_msgs/Pose2D): tf converted to Pose2D     
    '''
    pose2 = Pose2D()
    pose2.x = tf.translation.x
    pose2.y = tf.translation.y
    rpy = euler_from_quaternion(slots(tf.rotation))
    pose2.theta = rpy[2]
    return pose2


class PathFollower(object):
    def __init__(self):

        rospy.logwarn(" path follower being called yo ")
        self.map_frame = rospy.get_param('~map_frame', 'map')
        self.odom_frame = rospy.get_param('~odom_frame', 'odom')  # No-wait frame
        self.robot_frame = rospy.get_param('~robot_frame', 'base_footprint')  # base_footprint for simulation
        self.control_freq = rospy.get_param('~control_freq', 10.0)  # control loop frequency (Hz)
        assert 1.0 <= self.control_freq <= 10.0
        self.goal_reached_dist = rospy.get_param('~goal_reached_dist',
                                                 0.2)  # allowed distance from goal to be supposed reached
        self.max_path_dist = rospy.get_param('~max_path_dist',
                                             3.5)  # maximum distance from a path start to enable start of path following
        self.max_velocity = rospy.get_param('~max_velocity', 0.5)  # maximumm allowed velocity (m/s)
        self.max_angular_rate = rospy.get_param('~max_angular_rate', 0.3)  # maximum allowed angular rate (rad/s)
        self.look_ahead_dist = rospy.get_param('~look_ahead_dist', 0.3)  # look ahead distance for pure pursuit (m)

        self.action_server = actionlib.SimpleActionServer('follow_path', FollowPathAction, execute_cb=self.control,
                                                          auto_start=False)
        self.action_server.register_preempt_callback(self.preempt_control)
        self.action_server.start()

        self.lock = RLock()
        self.path_index = 0
        self.path_frame = None
        self.path_msg = None
        self.path = None

        self.scan_listener = rospy.Subscriber('scan', LaserScan, self.scan_cb)

        # limit for the front to be recognized as obstacle ahead
        self.front_limit = 0.2
        self.backing_limit = 0.2

        # variables for PID
        self.previous_heading_error = 0.0
        self.heading_error_integrated = 0.0

        self.cmd_pub = rospy.Publisher('cmd_vel', Twist, queue_size=1)
        self.lookahead_point_pub = rospy.Publisher('/vis/lookahead_point', Marker,
                                                   queue_size=1)  # Publisher of the lookahead point (visualization only)
        self.path_pub = rospy.Publisher('/vis/path', Path, queue_size=2)
        self.waypoints_pub = rospy.Publisher('/vis/waypoints', PointCloud, queue_size=2)

        self.tf = tf2_ros.Buffer()
        self.tf_sub = tf2_ros.TransformListener(self.tf)

        self.path_sub = rospy.Subscriber('path', Path, self.setPathMsg, queue_size=2)

        # for PID
        self.start_integral = 7
        self.value_for_integrator = 0
        self.time_before = timer()
        self.starting_time = timer()
        self.error_before = 0
        self.is_started = False  # flag to check if the position is too far
        self.previous_path_index = None

        rospy.loginfo('Path follower initialized.')

    def lookup_transform(self, target_frame, source_frame, time, no_wait_frame=None, timeout=rospy.Duration.from_sec(0.0)):
        '''
        Returns transformation between to frames on specified time.

        Parameters:
            target_frame (String): target frame (transform to)
            source_frame (String): source frame (transform from)
            time (rospy time): reference time 
            no_wait_frame (String): connection frame 

        Returns:
            transformation (tf): tf from source frame to target frame
        '''
        if no_wait_frame is None or no_wait_frame == target_frame:
            return self.tf.lookup_transform(target_frame, source_frame, time, timeout=timeout)

        tf_n2t = self.tf.lookup_transform(self.map_frame, self.odom_frame, rospy.Time())
        tf_s2n = self.tf.lookup_transform(self.odom_frame, self.robot_frame, time, timeout=timeout)
        tf_s2t = TransformStamped()
        tf_s2t.header.frame_id = target_frame
        tf_s2t.header.stamp = time
        tf_s2t.child_frame_id = source_frame
        tf_s2t.transform = msgify(Transform, np.matmul(numpify(tf_n2t.transform), numpify(tf_s2n.transform)))
        return tf_s2t

    def getRobotPose(self, target_frame):
        '''
        Returns robot's pose in the specified frame.

        Parameters:
            target_frame (String): the reference frame

        Returns:
            pose (geometry_msgs/Pose2D): Current position of the robot in the reference frame   
        '''
        t = timer()
        tf = self.lookup_transform(target_frame, self.robot_frame, rospy.Time(),
                                   timeout=rospy.Duration.from_sec(0.5), no_wait_frame=self.odom_frame)
        pose = tf3to2(tf.transform)
        return pose

    def clearPath(self):
        '''
        Reinitializes path variables.
        '''
        self.path_msg = None
        self.path = None
        self.path_index = 0

    def setPathMsg(self, msg):
        '''
        Initializes path variables based on received path request.

        Parameters:
            msg (aro_msgs/FollowPathAction request): msg containing header and required path (array of Pose2D) 
        '''

        with self.lock:
            if len(msg.poses) > 0:
                self.path_msg = msg
                self.path = np.array([slots(p.pose.position) for p in msg.poses])
                self.path_index = 0  # path position index
                self.path_frame = msg.header.frame_id
            else:
                self.clearPath()

        self.path_received_time = rospy.Time.now()
        rospy.loginfo('Path received (%i poses).', len(msg.poses))

    def setPathIndex(self, pose):
        # self.look_ahead_dist = 0.3

        """Set path index indicating path segment lying within lookahead distance."""
        for k in np.arange(self.path_index, len(self.path)):
            if np.linalg.norm(self.path[k][:2] - pose[:2]) < self.look_ahead_dist:
                continue
            else:
                if k == self.previous_path_index:
                    continue
                else:
                    self.path_index = k
                    return

        # self.path_index = len(self.path) - 1  # all remaining waypoints are close

    def getLookaheadPoint(self, pose):
        '''
        Returns lookahead point used as a reference point for path following.

        Parameters:
            pose (numpy array [3] (float)): x, y coordinates and heading of the robot

        Returns:
            goal (numpy array [2] (float)): x, y coordinates of the lookahead point  
        '''

        # DONE BY ME: Find local goal (lookahead point) on current path

        goal = None
        # self.look_ahead_dist = 0.3
        self.setPathIndex(pose)
        # next waypoint
        next_waypoint = self.path[self.path_index]

        next_waypoint = next_waypoint[0:2]
        pose2 = pose[0:2]
        # distance from robot to next waypoint
        distance = np.linalg.norm(next_waypoint - pose2)

        # the goal is within the lookahead distance
        if self.path_index == len(self.path) - 1:
            rospy.loginfo("....hello from last waypoint....")
            goal = next_waypoint

        else:
            rospy.loginfo("....hello from intersection finding....")

            this_distance = distance
            while this_distance < self.look_ahead_dist:
                if self.path_index + 1 < len(self.path):
                    self.path_index += 1
                point_to_consider = self.path[self.path_index]
                this_distance = np.linalg.norm(point_to_consider[0:2] - pose2)

            point1 = self.path[self.path_index - 1]
            point2 = self.path[self.path_index]
            intersections = getCircLineIntersect(point1, point2, pose2, self.look_ahead_dist)

            # print("intersections")
            # rospy.loginfo(intersections)

            distance_from_goal0 = np.linalg.norm(intersections[0] - next_waypoint)
            distance_from_goal1 = np.linalg.norm(intersections[1] - next_waypoint)

            if distance_from_goal0 > distance_from_goal1:
                goal = intersections[1]
            else:
                goal = intersections[0]

        return goal

    def publishPathVisualization(self, path):
        '''
        Publishes a given path as sequence of lines and point cloud of particular waypoints.

        Parameters:
            path (nav_msgs/Path): path to be visualized
        '''

        if self.path_msg is None:
            return

        msg = PointCloud()
        msg.header.frame_id = self.map_frame
        msg.header.stamp = rospy.get_rostime()
        for p in path.poses:
            msg.points.append(p.pose.position)

        self.waypoints_pub.publish(msg)
        self.path_pub.publish(path)

    def publishTemporaryGoal(self, goal_pose):
        '''
        Publishes a given pose as red circular marker.

        Parameters:
            goal_pose (numpy array [2] (float)): desired x, y coordinates of the marker in map frame
        '''
        msg = Marker()
        msg.header.frame_id = self.map_frame
        msg.header.stamp = rospy.get_rostime()
        msg.id = 1
        msg.type = 2
        msg.action = 0
        msg.pose = Pose()
        msg.pose.orientation = Quaternion(0.0, 0.0, 0.0, 1.0)
        msg.pose.position = Point(goal_pose[0], goal_pose[1], 0.0)
        msg.color.r = 1.0
        msg.color.g = 0.0
        msg.color.b = 0.0
        msg.color.a = 1.0
        msg.scale.x = 0.05
        msg.scale.y = 0.05
        msg.scale.z = 0.01
        self.lookahead_point_pub.publish(msg)

    def sendVelocityCommand(self, linear_velocity, angular_rate):
        '''
        Calls command to set robot velocity and angular rate.

        Parameters:
            linear_velocity (float): desired forward linear velocity
            angular_rate (float): desired angular rate 
        '''
        msg = Twist()
        msg.angular.z = angular_rate
        msg.linear.x = linear_velocity
        self.cmd_pub.publish(msg)

    def calculate_mean_distance(self, start_angle, end_angle, msg):
        # variable to store the new valid ranges values
        new_range = []

        # finding the indices starting angle and ending angle for the ranges array
        start_index = int(np.floor((np.pi * start_angle / 180 - msg.angle_min) / msg.angle_increment))
        end_index = int(np.floor((np.pi * end_angle / 180 - msg.angle_min) / msg.angle_increment))

        # saving the values for indices that fall within start angle and end angle
        angle_corrected_range = msg.ranges[start_index: end_index]

        # from the values that fall only within start angle and end angle, saving only valid values of range to a new
        # list new_range
        for ranges in angle_corrected_range:
            if msg.range_min < ranges < msg.range_max:
                new_range.append(ranges)

        # calculating the mean of the new ranges
        mean_distance = sum(new_range) / len(new_range)

        return mean_distance

    def scan_cb(self, msg):

        # computing minimum distance for scan angles between -20 to 20 degrees
        self.rng_front = (self.calculate_mean_distance(0, 20, msg) + self.calculate_mean_distance(340, 360, msg)) / 2
        # computing minimum distance for scan angles between 160 and 200 degrees
        self.rng_back = self.calculate_mean_distance(160, 200, msg)

        # computing average distance of obstacles on the right (30-70 degrees to the right)
        self.rng_right = self.calculate_mean_distance(300, 340, msg)
        # computing average distance of obstacles on the left (30-70 degrees to the left)
        self.rng_left = self.calculate_mean_distance(20, 60, msg)

    def control(self, msg):
        '''
        Callback function of action server. Starts the path following process.

        Parameters:
            msg (aro_msgs/FollowPathAction request): msg containing header and required path (array of Pose2D) 
        '''
        rospy.logwarn(" Control being called ")
        rospy.loginfo('New control request obtained.')
        self.setPathMsg(msg)
        rate = rospy.Rate(self.control_freq)
        pose = np.array([0.0, 0.0, 0.0])

        self.publishPathVisualization(self.path_msg)

        # DONE BY ME: implement correct reaction if empty path is received
        if self.path_msg is None:
            # DONE BY ME
            self.sendVelocityCommand(0.0, 0.0)
            pose = np.array([0.0, 0.0, 0.0])
            rospy.logwarn('Empty path msg received.')
            self.action_server.set_succeeded(FollowPathResult(Pose2D(pose[0], pose[1], 0)), text='Goal reached.')
            return

        # Main control loop.
        while True:
            t = timer()  # save current time
            rospy.loginfo_throttle(1.0, 'Following path.')
            pose = np.array([0.0, 0.0, 0.0])
            with self.lock:
                # get robot pose
                try:
                    if self.path_frame is None:
                        rospy.logwarn('No valid path received so far, returning zero position.')
                    else:
                        if self.path_msg is None:
                            pose_msg = self.getRobotPose(self.path_frame)
                        else:
                            pose_msg = self.getRobotPose(self.path_msg.header.frame_id)

                        pose = np.array(slots(pose_msg))

                except TransformException as ex:
                    rospy.logerr('Robot pose lookup failed: %s.', ex)
                    continue

            if self.path_msg is None:
                rospy.logwarn('Path following was preempted. Leaving the control loop.')
                self.sendVelocityCommand(0.0, 0.0)
                return

            # DONE BY ME: set the local goal
            goal = self.getLookaheadPoint(pose)

            # rospy.logwarn(goal)

            # publish visualization of lookahead point
            self.publishTemporaryGoal(goal)

            # DONE BY ME: react on situation when the robot is too far from the path
            # if ((np.linalg.norm(pose[0:2] - start_point[0:2]) >= self.max_path_dist) and not self.started):
            if (np.linalg.norm(pose[0:2] - goal[0:2]) >= self.max_path_dist) and not self.is_started:
                rospy.logerr('First waypoint is too far away.')
                angular_rate = 0.0
                velocity = 0.0
                # self.started = True
                # DONE BY ME
                self.action_server.set_aborted(FollowPathResult(Pose2D(pose[0], pose[1], 0)), text='Distance too high.')

            # Position displacement(direction and Euclidean distance)
            else:
                if self.path_index + 1 > len(self.path) - 1:
                    # rospy.loginfo("hello from goal reaching part..........")
                    goal_dir = self.path[len(self.path) - 1][0:2] - pose[:2]
                    goal_dist = np.linalg.norm(goal_dir)
                    # rospy.loginfo("goal_dist")
                    # rospy.loginfo(goal_dist)
                    # DONE BY ME: react on situation when the robot has reached the goal ????
                    if goal_dist <= self.goal_reached_dist:
                        rospy.loginfo("       GOAL REACHED!!!      ")
                        # DONE BY ME
                        self.sendVelocityCommand(0.0, 0.0)
                        self.path_msg = None
                        self.action_server.set_succeeded(FollowPathResult(Pose2D(pose[0], pose[1], 0)), text='Goal reached.')

                # DONE BY ME: apply control law to produce control inputs
                if self.rng_front >= self.front_limit:
                    rospy.loginfo("hello from control")
                    velocity = 0.3
                    # compute position in the lookahead dist with current robot pos
                    distancePosition = pose[0:2] + self.look_ahead_dist * np.array([np.cos(pose[2]), np.sin(pose[2])])
                    x_coordinate = goal - pose[0:2]
                    y_coordinate = distancePosition - pose[0:2]

                    desiredAngle = np.arctan2(x_coordinate[1], x_coordinate[0])  # desired angle
                    currentAngle = np.arctan2(y_coordinate[1], y_coordinate[0])  # current angle

                    # error difference
                    error_in_angle = desiredAngle - currentAngle

                    error_over = np.sign(-error_in_angle) * (2 * np.pi - abs(error_in_angle))
                    if abs(error_in_angle) > np.pi and np.sign(desiredAngle) != np.sign(currentAngle):
                        error_in_angle = error_over

                    # PID constants
                    k_P = 8
                    k_I = 3
                    k_D = 1

                    # updating angular rate
                    angular_rate = k_P * error_in_angle + k_I * self.value_for_integrator + k_D * (
                            error_in_angle - self.error_before) * self.control_freq

                    if abs(angular_rate) < 2:
                        self.value_for_integrator += error_in_angle / self.control_freq

                    # robot is stopped, integrate the error
                    if np.clip(velocity - 0.05 * np.linalg.norm(angular_rate), 0., self.max_velocity) == 0:
                        k_I = 0
                        k_D = 0

                    # recalculating velocity so the robot slows down during turns
                    velocity = velocity - 0.05 * np.linalg.norm(angular_rate)

                    # save error before and time before for the PID calculation
                    self.time_before = t
                    self.error_before = error_in_angle

                    velocity = np.clip(velocity, 0, self.max_velocity)
                else:
                    # if obstacle ahead or if path not found
                    rospy.logwarn("Obstacle ahead!")
                    velocity = -self.max_velocity
                    # velocity = 0
                    angular_rate = 0
                    self.path_msg = None


            # applying limits on angular rate and linear velocity
            angular_rate = np.clip(angular_rate, -self.max_angular_rate, self.max_angular_rate)

            # rospy.logwarn("///////////// angular rate and velocity ////////////")
            # rospy.logwarn(angular_rate)
            # rospy.logwarn(velocity)
            # Sending the velocity and angular rate
            self.sendVelocityCommand(velocity, angular_rate)

            self.action_server.publish_feedback(
                FollowPathFeedback(Pose2D(pose[0], pose[1], 0), 0.0))  # compute path deviation if needed
            rospy.logdebug(
                'Speed: %.2f m/s, angular rate: %.1f rad/s. (%.3f s), pose = [%.2f, %.2f], goal = [%.2f, %.2f], time = %.2f',
                velocity, angular_rate, timer() - t, pose[0], pose[1], goal[0], goal[1], rospy.get_rostime().to_sec())
            rate.sleep()

    def preempt_control(self):
        '''
        Preemption callback function of action server. Safely preempts the path following process.
        '''

        # DONE BY ME: implement correct behaviour when control is preempted

        with self.lock:
            self.sendVelocityCommand(0.0, 0.0)
            pose = np.array([0.0, 0.0, 0.0])
            print("hello from preempt_control")
            self.action_server.set_aborted(FollowPathResult(Pose2D(pose[0], pose[1], 0)), text='Control preempted.')

        rospy.logwarn('Control preempted.')


if __name__ == '__main__':
    rospy.init_node('path_follower', log_level=rospy.INFO)
    node = PathFollower()
    rospy.spin()
