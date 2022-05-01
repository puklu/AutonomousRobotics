#!/usr/bin/env python3
from __future__ import absolute_import, division, print_function
from geometry_msgs.msg import Pose, Pose2D, Quaternion, Transform, TransformStamped, Twist, PoseStamped, Point, Vector3
import numpy as np
import rospy
import tf2_ros
from ros_numpy import msgify, numpify
from nav_msgs.msg import OccupancyGrid, MapMetaData, Path
from aro_msgs.srv import GenerateFrontier, GenerateFrontierResponse
from aro_msgs.srv import PlanPath, PlanPathRequest, PlanPathResponse
from aro_msgs.msg import FollowPathAction, FollowPathFeedback, FollowPathResult, FollowPathGoal
from tf.transformations import euler_from_quaternion, quaternion_from_euler
import actionlib
import time
from geometry_msgs.msg import PointStamped
from threading import RLock


def slots(msg):
    """Return message attributes (slots) as list."""
    return [getattr(msg, var) for var in msg.__slots__]


def array(msg):
    """Return message attributes (slots) as array."""
    return np.array(slots(msg))


def pose2to3(pose2):
    """Convert Pose2D to Pose."""
    pose3 = Pose()
    pose3.position.x = pose2.x
    pose3.position.y = pose2.y
    rpy = 0.0, 0.0, pose2.theta
    q = quaternion_from_euler(*rpy)
    pose3.orientation = Quaternion(*q)
    return pose3


def tf3to2(tf):
    """Convert Transform to Pose2D."""
    pose2 = Pose2D()
    pose2.x = tf.translation.x
    pose2.y = tf.translation.y
    rpy = euler_from_quaternion(slots(tf.rotation))
    pose2.theta = rpy[2]
    return pose2


class Explorer(object):
    def __init__(self):
        # all is up to you
        print("hello from explorer")

        rospy.wait_for_service('plan_path')
        self.planner = rospy.ServiceProxy('plan_path', PlanPath)

        rospy.wait_for_service("get_closest_frontier")
        self.closest_frontier = rospy.ServiceProxy("get_closest_frontier", GenerateFrontier)

        rospy.wait_for_service('get_random_frontier')
        self.random_frontier = rospy.ServiceProxy('get_random_frontier', GenerateFrontier)

        # for calling the path follower
        self._ac = actionlib.SimpleActionClient('follow_path', FollowPathAction)
        rospy.logwarn('Waiting for path follower action server')
        self._ac.wait_for_server()
        rospy.logwarn('Action server found')

        self.point_pub = rospy.Publisher("/test_point", PointStamped, queue_size=1)
        self.plan_pb = rospy.Publisher('path', Path, latch=True)
        self.vel_publisher = rospy.Publisher('cmd_vel', Twist, latch=True)

        self.gridReady = False
        self.frontier = None
        self.max_age = rospy.Duration(
            rospy.get_param('~max_age', 1.0))  # maximum latency of the path message to be considered as valid
        # self.use_dummy_grid = rospy.get_param('~use_dummy_grid', 0)  # set to zero for regular simulation
        self.map_frame = rospy.get_param('~map_frame', 'map')
        self.odom_frame = rospy.get_param('~odom_frame', 'odom')  # No-wait frame
        self.robot_frame = rospy.get_param('~robot_frame',
                                           'base_footprint')  # base_footprint for simulation, robot for dummy grid
        self.tf = tf2_ros.Buffer()
        self.tf_sub = tf2_ros.TransformListener(self.tf)

        self.dist_limit = 0.3
        self.frontier_dist_limit = 0.7
        self.speed_limit_angular = 5
        self.speed_limit_linear = 2
        self.frontier = None
        self.stopped = False
        self.random_frontier_TF = True #False

        self.path = []  # variable for saving current path
        self.lock = RLock()

        rospy.loginfo('Explorer initialized.')

    def find_a_frontier(self, random=False):
        print("hello from get frontier in explorer")
        if random:
            response = self.random_frontier.call()
            goal = (response.goal_pose.x, response.goal_pose.y)
        else:
            response = self.closest_frontier.call()
            goal = (response.goal_pose.x, response.goal_pose.y)

        return goal

    def find_the_path(self, start, goal):
        # get path call
        print("hello from get path in explorer")
        request = PlanPathRequest(Pose2D(start[0], start[1], 0.0), Pose2D(goal[0], goal[1], 0.0))
        response = self.planner.call(request)
        # rospy.loginfo(response)
        return response.path

    def get_robot_pose(self, target_frame):
        print("hello from get robot pose in explorer")

        tf = self.lookup_transform(target_frame, self.robot_frame, rospy.Time.now(),
                                       timeout=rospy.Duration.from_sec(0.5), no_wait_frame=self.odom_frame)
        pose = tf3to2(tf.transform)
        return pose

    def lookup_transform(self, target_frame, source_frame, time,
                         no_wait_frame=None, timeout=rospy.Duration.from_sec(0.0)):
        if no_wait_frame is None or no_wait_frame == target_frame:
            return self.tf.lookup_transform(target_frame, source_frame, time, timeout=timeout)

        else:
            tf_o2m = self.tf.lookup_transform(self.map_frame, self.odom_frame, rospy.Time())
            tf_r2o = self.tf.lookup_transform(self.odom_frame, self.robot_frame, time, timeout=timeout)
            tf_s2t = TransformStamped()
            tf_s2t.header.frame_id = target_frame
            tf_s2t.header.stamp = time
            tf_s2t.child_frame_id = source_frame
            tf_s2t.transform = msgify(Transform,
                                      np.matmul(numpify(tf_o2m.transform),
                                                numpify(tf_r2o.transform)))

            return tf_s2t

    def publishPath(self, path_2d):
        # publish path
        msg = Path()
        msg.header.frame_id = self.map_frame
        msg.header.stamp = rospy.get_rostime()
        for waypoint in path_2d:
            pose = PoseStamped()
            pose.header.frame_id = self.map_frame
            pose.header.stamp = rospy.get_rostime()
            pose.pose.position.x = waypoint.x
            pose.pose.position.y = waypoint.y
            pose.pose.position.z = 0
            msg.poses.append(pose)

        rospy.logwarn("Publishing plan.")
        self.plan_pb.publish(msg)

    def explorer_callback(self):
        """ Explorer callback """
        rospy.logwarn("........Hello from Explorer Callback.....")
        # self.vel_publisher.publish(
        #     Twist(
        #         linear=Vector3(x=1.0),
        #         # angular=Vector3(z=self.speed_limit_angular)
        #         angular=Vector3(z=0.0)
        #     )
        # )
        # rospy.sleep(3)

        while 1:
            rospy.sleep(0.1)

            self.frontier = np.array(self.find_a_frontier(self.random_frontier_TF))

            pose_msg = self.get_robot_pose(self.map_frame)
            pose = np.array(slots(pose_msg))

            rospy.logwarn("....frontier.....")
            rospy.logwarn(self.frontier)

            self.path = self.find_the_path(pose, self.frontier)
            self.publishPath(self.path)

            rospy.logwarn("           Explorer callback             ")

            rospy.logwarn("....path.....")
            rospy.logwarn(self.path)

            while np.linalg.norm(self.frontier[0:2] - pose[0:2]) > 0.1:
                pose_msg = self.get_robot_pose(self.map_frame)
                pose = np.array(slots(pose_msg))
                if len(self.path) == 0 or np.linalg.norm(pose[0:2] - self.frontier) <= self.frontier_dist_limit:
                    rospy.logwarn("Explorer callback, len(path) == {}".format(len(self.path)))
                    break

                path_stamped = Path()
                path_stamped.header.stamp = rospy.Time.now()
                path_stamped.header.frame_id = self.map_frame
                path_stamped.poses = [PoseStamped(pose=pose2to3(p)) for p in self.path]
                time.sleep(1)
                self._ac.send_goal(FollowPathGoal(path_stamped.header, path_stamped.poses))

if __name__ == '__main__':
    rospy.init_node('explorer', log_level=rospy.INFO)
    node = Explorer()
    node.explorer_callback()
    rospy.spin()
