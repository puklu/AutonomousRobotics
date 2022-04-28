#!/usr/bin/env python3
from __future__ import absolute_import, division, print_function
import rospy
import numpy as np
from scipy.ndimage import morphology
from nav_msgs.msg import OccupancyGrid, MapMetaData, Path
from geometry_msgs.msg import Pose2D, Pose, PoseStamped, Point, Quaternion
from visualization_msgs.msg import MarkerArray, Marker
from aro_msgs.srv import PlanPath, PlanPathRequest, PlanPathResponse
import tf2_ros
import geometry_msgs.msg


from aro_planning.utils import getRobotGridPosition, gridToMapCoordinates, mapToGridCoordinates, getGridPosition
import heapq


class PathPlanner():

    def __init__(self):
        # Initialize the node
        rospy.init_node("path_planner")

        # Get some useful parameters
        self.mapFrame = rospy.get_param("~map_frame", "map")
        self.robotDiameter = float(rospy.get_param("~robot_diameter", 0.8))
        self.occupancyThreshold = int(rospy.get_param("~occupancy_threshold", 90))

        # Helper variable to determine if grid was received at least once
        self.gridReady = False

        # You may wish to listen to the transformations of the robot
        self.tfBuffer = tf2_ros.Buffer()
        # Use the tfBuffer to obtain transformation as needed
        listener = tf2_ros.TransformListener(self.tfBuffer)


        ### added by me ###
        # grid variables
        self.grid_width = None
        self.grid_height = None
        self.grid_resolution = None
        self.grid_data = None
        self.grid_threshold = 25
        self.grid_info = None
        self.robot_grid = 4

        # robot parameters
        self.robot_radius = self.robotDiameter / 2
        self.robot_mask = None

        #############################

        # Subscribe to grid
        self.gridSubscriber = rospy.Subscriber('occupancy', OccupancyGrid, self.grid_cb)

        # Publishers for visualization
        self.path_vis_pub = rospy.Publisher('path', Path, queue_size=1)
        self.start_and_goal_vis_pub = rospy.Publisher('start_and_goal', MarkerArray, queue_size=1)

        rospy.loginfo('Path planner initialized.')

    def publishPath(self, path_2d):
        msg = Path()
        msg.header.frame_id = self.mapFrame
        msg.header.stamp = rospy.get_rostime()
        for waypoint in path_2d:
            pose = PoseStamped()
            pose.header.frame_id = self.mapFrame
            pose.pose.position.x = waypoint.x
            pose.pose.position.y = waypoint.y
            pose.pose.position.z = 0
            msg.poses.append(pose)

        rospy.loginfo("Publishing plan.")
        self.path_vis_pub.publish(msg)

    def publishStartAndGoal(self, start, goal):
        msg = MarkerArray()
        m_start = Marker()
        m_start.header.frame_id = self.mapFrame
        m_start.id = 1
        m_start.type = 2
        m_start.action = 0
        m_start.pose = Pose()
        m_start.pose.orientation = Quaternion(0.0, 0.0, 0.0, 1.0)
        m_start.pose.position = Point(start.x, start.y, 0.0)
        # m_start.points.append(Point(start.x, start.y, 0.0))
        m_start.color.r = 1.0
        m_start.color.g = 0.0
        m_start.color.b = 0.0
        m_start.color.a = 0.8
        m_start.scale.x = 0.1
        m_start.scale.y = 0.1
        m_start.scale.z = 0.001
        msg.markers.append(m_start)

        # goal marker
        m_goal = Marker()
        m_goal.header.frame_id = self.mapFrame
        m_goal.id = 2
        m_goal.type = 2
        m_goal.action = 0
        m_goal.pose = Pose()
        m_goal.pose.orientation = Quaternion(0.0, 0.0, 0.0, 1.0)
        m_goal.pose.position = Point(goal.x, goal.y, 0.0)
        # m_start.points.append(Point(start.x, start.y, 0.0))
        m_goal.color.r = 0.0
        m_goal.color.g = 1.0
        m_goal.color.b = 0.0
        m_goal.color.a = 0.8
        m_goal.scale.x = 0.1
        m_goal.scale.y = 0.1
        m_goal.scale.z = 0.001
        msg.markers.append(m_goal)
        rospy.loginfo("Publishing start and goal markers.")
        self.start_and_goal_vis_pub.publish(msg)

    def distance_between_start_finish(self, start, goal):
        # computes the distance between the start and goal
        start_new = np.array(start)
        goal_new = np.array(goal)
        return np.sqrt(np.sum((start_new - goal_new) * (start_new - goal_new)))

    def neighborhood_of_point(self, point, data):
        data_shape = data.shape
        neighborhood = []
        if point[0] != 0:
            neighborhood.append((point[0] - 1, point[1]))
        if point[1] != 0:
            neighborhood.append((point[0], point[1] - 1))
        if point[0] != data_shape[0] - 1:
            neighborhood.append((point[0] + 1, point[1]))
        if point[1] != data_shape[1] - 1:
            neighborhood.append((point[0], point[1] + 1))

        return neighborhood

    def planPath(self, request):
        """ Plan and return path from the start to the requested goal """
        # Get the position of the goal (real-world)
        startPosition = getGridPosition(request.start, self.grid_info)
        goalPosition = getGridPosition(request.goal, self.grid_info)

        self.publishStartAndGoal(request.start, request.goal)

        # copying the occupancy grid into some temporary variable and inflate the obstacles depending on robot size.
        self.grid_robot_radius = np.floor(self.robot_radius / self.grid_resolution)
        # mask of the robot to inflate obstacles
        self.robot_mask = np.ones((3 + 2 * self.robot_grid, 3 + 2 * self.robot_grid), dtype=bool)

        # reshaping data to matrix
        data = np.array(self.grid_data).reshape((self.grid_height, self.grid_width))

        # data mask for setting obstacle values to one
        data_mask = np.zeros((self.grid_height, self.grid_width), dtype=bool)  # data mask for inflating obstacles
        data_mask_2 = np.zeros((self.grid_height, self.grid_width))  # data mask to save undiscovered points
        data_mask_2[data < 0] = -1  # save undiscovered points
        data_mask[data > self.grid_threshold] = True  # update data mask
        data_mask = morphology.binary_dilation(data_mask, structure=self.robot_mask, iterations=1)  # inflate obstacles
        data[data_mask == True] = 1  # Save results to data
        data[data_mask == False] = 0  # Save results to data
        data[data_mask_2 < 0] = -1  # Save undiscovered points

        # Inflating undiscovered points to avoid getting to places where when arrived were inflated obstacles
        data_mask = np.zeros((self.grid_height, self.grid_width), dtype=bool)
        data_mask[data < 0] = True
        data_mask = morphology.binary_dilation(data_mask, structure=self.robot_mask, iterations=1)
        data[data_mask == True] = -1
        data = data.T

        # computing the path, i.e. run some graph-based search algorithm.
        # using A-star
        # path = []
        path = []
        path_history = {}  # dictionary of node and its origin
        path_cost = {}  # dictionary of a node and its code
        # change to tuple
        startPosition = (startPosition[0], startPosition[1])

        goalPosition = (goalPosition[0], goalPosition[1])

        rospy.loginfo("Finding path to {}".format(goalPosition))

        heapq.heappush(path, (0, startPosition))
        path_history[startPosition] = None
        path_cost[startPosition] = 0
        cell_price_default = 1

        is_solution = False

        while path:
            current_coordinates = heapq.heappop(path)[1]
            if current_coordinates == goalPosition:  # if reached goal
                is_solution = True
                break

            children = self.neighborhood_of_point(current_coordinates, data)
            for child in children:
                if (child not in path_history or path_cost[current_coordinates] + cell_price_default < path_cost[
                    child]) and (
                        data[int(child[0]), int(child[1])] == 0):
                    heapq.heappush(path, (
                        path_cost[current_coordinates] + cell_price_default + self.distance_between_start_finish(child,
                                                                                                                  goalPosition),
                        child))
                    path_history[child] = current_coordinates
                    path_cost[child] = cell_price_default + path_cost[current_coordinates]

        if is_solution:
            path = [goalPosition]
            while path_history[path[-1]] != None:
                path.append(path_history[path[-1]])
            path.reverse()

        # else return empty list
        else:
            rospy.loginfo("no path found")
            path = []

        if len(path) == 0:
            response = PlanPathResponse([])
            # real_path = []

        else:
            real_path = [Pose2D(pos[0], pos[1], 0) for pos in
                         [gridToMapCoordinates(np.array(waypoint) + np.array([0.5, 0.5]), self.grid_info) for waypoint
                          in
                          path]]
            response = PlanPathResponse(real_path)

        self.publishPath(response.path)
        return response

    def extractGrid(self, msg):
        # extracting grid from msg.data and other useful information
        self.grid_info = msg.info
        self.grid_width = msg.info.width
        self.grid_height = msg.info.height
        self.grid_resolution = msg.info.resolution
        self.grid_data = msg.data
        pass

    def grid_cb(self, msg):
        self.extractGrid(msg)
        if not self.gridReady:
            # Create services
            self.plan_service = rospy.Service('plan_path', PlanPath, self.planPath)
            self.gridReady = True


if __name__ == "__main__":
    pp = PathPlanner()
    rospy.spin()
