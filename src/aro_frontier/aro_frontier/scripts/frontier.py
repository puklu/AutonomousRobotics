#!/usr/bin/env python3
from __future__ import division, print_function
import rospy
import numpy as np
from scipy.ndimage import morphology
from nav_msgs.msg import OccupancyGrid, MapMetaData
from geometry_msgs.msg import Pose2D
from aro_msgs.srv import GenerateFrontier, GenerateFrontierRequest, GenerateFrontierResponse
import tf2_ros
import itertools
import tf.transformations as tft

class FrontierExplorer():

    def __init__(self):
        print("hello from frontier explorer")
        # Initialize the node
        rospy.init_node("frontier_explorer")

        # Get some useful parameters
        self.mapFrame = rospy.get_param("~map_frame", "map")
        self.robotFrame = rospy.get_param("~robot_frame", "base_footprint")
        self.robotDiameter = float(rospy.get_param("~robot_diameter", 0.8))
        self.occupancyThreshold = int(rospy.get_param("~occupancy_threshold", 90))

        # Helper variable to determine if grid was received at least once
        self.gridReady = False

        # You may wish to listen to the transformations of the robot
        self.tfBuffer = tf2_ros.Buffer()
        # Use the tfBuffer to obtain transformation as needed
        tfListener = tf2_ros.TransformListener(self.tfBuffer)

        # Subscribe to grid
        self.gridSubscriber = rospy.Subscriber('occupancy', OccupancyGrid, self.grid_cb)

        # grid variables
        self.grid_width = None
        self.grid_height = None
        self.grid_resolution = None
        self.grid_data = None
        self.grid_threshold = 25
        self.grid_info = None
        self.robot_grid = 4

        # self.point_pub = rospy.Publisher("/sample_point", PoseStamped, queue_size=1)

        # robot parameters
        self.robot_radius = self.robotDiameter / 2
        self.robot_mask = None
        self.gridReady = False
        self.tfBuffer = tf2_ros.Buffer()
        tfListener = tf2_ros.TransformListener(self.tfBuffer)

    ################
    def getRobotGridPosition(self, transMsg):
        pos = np.array([transMsg.transform.translation.x - self.grid_info.origin.position.x,
                        transMsg.transform.translation.y - self.grid_info.origin.position.y, 0, 1])
        quat = self.grid_info.origin.orientation
        mat = tft.quaternion_matrix(tft.quaternion_inverse([quat.x, quat.y, quat.z, quat.w]))
        gridPos = (mat.dot(pos[np.newaxis].T).flatten()[:2]) / self.grid_info.resolution
        roundedPos = np.round(gridPos)
        pos = roundedPos if np.allclose(gridPos, roundedPos) else np.floor(gridPos)
        return pos


    def gridToMapCoordinates(self, position):
        position = position * self.grid_info.resolution
        originPos = np.array([self.grid_info.origin.position.x, self.grid_info.origin.position.y])
        pos = np.array([position[0], position[1], 0, 1])
        quat = self.grid_info.origin.orientation
        mat = tft.quaternion_matrix([quat.x, quat.y, quat.z, quat.w])
        pos = mat.dot(pos[np.newaxis].T).flatten()[:2] + originPos
        return pos

    ###############

    def if_frontier_present(self, point, data):
        sh = data.shape
        output = False
        point_new = [0, 0]
        point_new[0] = int(point[0])
        point_new[1] = int(point[1])
        # checks all sides to see if it is frontier
        if point_new[0] != 0:
            output = output or (data[point_new[0] - 1, point_new[1]] == -1)
        if point_new[1] != 0:
            output = output or (data[point_new[0], point_new[1] - 1] == -1)
        if point_new[0] != sh[0] - 1:
            output = output or (data[point_new[0] + 1, point_new[1]] == -1)
        if point_new[1] != sh[1] - 1:
            output = output or (data[point_new[0], point_new[1] + 1] == -1)
        return output and data[point_new[0], point_new[1]] == 0

    def neighborhood_of_point_2(self, point, data):
        data_shape = data.shape
        neighborhood = []
        # add all sides to see if it is frontier (index check is needed so the program can run)
        if point[0] != 0:
            neighborhood.append([point[0] - 1, point[1]])
        if point[1] != 0:
            neighborhood.append([point[0], point[1] - 1])
        if point[0] != data_shape[0] - 1:
            neighborhood.append([point[0] + 1, point[1]])
        if point[1] != data_shape[1] - 1:
            neighborhood.append([point[0], point[1] + 1])
        if point[0] != 0 and point[1] != 0:
            neighborhood.append([point[0] - 1, point[1] - 1])
        if point[0] != 0 and point[1] != data_shape[1] - 1:
            neighborhood.append([point[0] - 1, point[1] + 1])
        if point[0] != data_shape[0] - 1 and point[1] != 0:
            neighborhood.append([point[0] + 1, point[1] - 1])
        if point[0] != data_shape[0] - 1 and point[1] != data_shape[1] - 1:
            neighborhood.append([point[0] + 1, point[1] + 1])
        return neighborhood

    def neighborhood_of_point(self, point, data):
        data_shape = data.shape
        neighborhood = []
        # add all sides to see if it is frontier (index check is needed so the program can run)
        if point[0] != 0:
            neighborhood.append([point[0] - 1, point[1]])
        if point[1] != 0:
            neighborhood.append([point[0], point[1] - 1])
        if point[0] != data_shape[0] - 1:
            neighborhood.append([point[0] + 1, point[1]])
        if point[1] != data_shape[1] - 1:
            neighborhood.append([point[0], point[1] + 1])
        return neighborhood

    def computeWFD(self):
        frontiers = []
        # obtaining the robots coordinates
        self.getRobotCoordinates()
        self.grid_robot_radius = np.floor(self.robot_radius / self.grid_resolution)
        # mask of the robot to inflate obstacles
        self.robot_mask = np.ones((3 + 2 * self.robot_grid, 3 + 2 * self.robot_grid), dtype=bool)
        # to store the occupancy grid
        data = np.array(self.grid_data).reshape((self.grid_height, self.grid_width))

        # inflating the frontier
        data_mask = np.zeros((self.grid_height, self.grid_width), dtype=bool)
        data_mask_2 = np.zeros((self.grid_height, self.grid_width))
        data_mask_2[data < 0] = -1
        data_mask[data > self.grid_threshold] = True
        data_mask = morphology.binary_dilation(data_mask, structure=self.robot_mask, iterations=1)
        data[data_mask == True] = 1
        data[data_mask == False] = 0
        data[data_mask_2 < 0] = -1

        data_mask = np.zeros((self.grid_height, self.grid_width), dtype=bool)
        data_mask_2 = np.zeros((self.grid_height, self.grid_width))
        data_mask[data < 0] = True
        data_mask = morphology.binary_dilation(data_mask, structure=self.robot_mask, iterations=1)
        data[data_mask == True] = -1
        data = data.T

        # the WFD algorithm
        queue_m = []
        queue_closed_m = []
        queue_closed_f = []
        width = self.grid_width
        height = self.grid_height
        all_cells = list(itertools.product(range(width), range(height)))
        queue_closed_m_d = {}
        queue_open_m_d = {}
        queue_closed_f_d = {}
        queue_open_f_d = {}

        for cell in all_cells:
            queue_closed_m_d[cell] = False
            queue_open_m_d[cell] = False
            queue_closed_f_d[cell] = False
            queue_open_f_d[cell] = False
        pose = self.robotPositionGrid
        startPosition = pose

        queue_m.append(pose)
        queue_open_m_d[pose] = True

        while queue_m:

            p = queue_m.pop(0)
            if queue_closed_m_d[tuple(p)]:
                continue
            if self.if_frontier_present(p, data):
                queue_f = []
                NewFrontier = []
                queue_f.append(p)

                queue_open_f_d[tuple(p)] = True

                while queue_f:
                    q = queue_f.pop(0)
                    if queue_closed_m_d[tuple(q)] or queue_closed_f_d[tuple(q)]:
                        continue
                    if self.if_frontier_present(q, data):
                        NewFrontier.append(q)
                        for w in self.neighborhood_of_point_2(q, data):
                            if (not queue_closed_m_d[tuple(w)]) and (not queue_closed_f_d[tuple(w)]) and ( not queue_open_f_d[tuple(w)]) and (data[int(w[0]), int(w[1])] == 0):
                                queue_f.append(w)
                                queue_open_f_d[tuple(w)] = True
                    queue_closed_f.append(q)
                    queue_closed_f_d[tuple(q)] = True
                frontiers.append(NewFrontier)
                for frontier in NewFrontier:
                    queue_closed_m.append(frontier)
                    queue_closed_m_d[tuple(frontier)] = True
            for v in self.neighborhood_of_point_2(p, data):
                if (not queue_open_m_d[tuple(v)]) and (not queue_closed_m_d[tuple(v)]):
                    for neighbour in self.neighborhood_of_point(v, data):
                        if data[neighbour[0], neighbour[1]] == 0:
                            queue_m.append(v)
                            queue_open_m_d[tuple(v)] = True
                            break
            queue_closed_m.append(p)
            queue_closed_m_d[tuple(p)] = True

        rospy.logwarn("Found {} number of frontiers.".format(len(frontiers)))
        return frontiers

    def getRandomFrontier(self, request):
        frontiers = self.computeWFD()
        frontier = np.random.choice(frontiers)
        newFrontier = []
        for i in range(len(frontier)):
            item = frontier[i]
            newFrontier.append((item[0], item[1]))
        newFrontier.sort()
        frontierCenter =np.array(newFrontier[int(np.floor(len(frontier)/2))])
        pos = self.gridToMapCoordinates(frontierCenter)
        rospy.logwarn("Found random frontier at {}".format(pos))
        x, y = pos[0], pos[1]
        response = GenerateFrontierResponse(Pose2D(x, y, 0.0))

        # print("random frontier")
        # print(response)
        return response

    def getClosestFrontier(self, request):
        frontiers = self.computeWFD()
        if len(frontiers) == 0:
            response = GenerateFrontierResponse(Pose2D(0.0, 0.0, 1.0))
            return response
        best_dist = np.inf
        closest_frontier = None
        for frontier in frontiers:
            self.getRobotCoordinates()
            robPos = self.robotPositionGrid
            frontier.sort()
            frontier = np.array(frontier)
            frontier_dist = np.linalg.norm(frontier - robPos, axis=1).tolist()
            frontier_med = np.median(frontier_dist)
            frontierCenter = frontier[int(len(frontier) / 2)]
            if frontier_med < best_dist:
                best_dist = frontier_med
                closest_frontier = frontierCenter
                rospy.logwarn("Frontier: {}".format(frontierCenter))
        pos = self.gridToMapCoordinates(closest_frontier)
        rospy.logwarn("Found closest frontier at {}, {}".format(pos, frontierCenter))

        x, y = pos[0], pos[1]
        response = GenerateFrontierResponse(Pose2D(x, y, 0.0))

        # print("closest frontier")
        # print(response)
        return response

    def getRobotCoordinates(self):
        try:
            trans = self.tfBuffer.lookup_transform(self.mapFrame, self.robotFrame, rospy.Time(), rospy.Duration(0.5))
        except (tf2_ros.LookupException, tf2_ros.ConnectivityException, tf2_ros.ExtrapolationException):
            rospy.logwarn("Cannot get the robot position!")
            self.robotPosition = None
        else:
            self.robotPosition = 0
            pos = self.getRobotGridPosition(trans)
            self.robotPositionGrid = (int(pos[0]), int(pos[1]))
            self.robotPosition = (trans.transform.translation.x, trans.transform.translation.y)

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
            self.random_frontier_service = rospy.Service('get_random_frontier', GenerateFrontier, self.getRandomFrontier)
            self.closest_frontier_service = rospy.Service('get_closest_frontier', GenerateFrontier, self.getClosestFrontier)
            self.gridReady = True


if __name__ == "__main__":
    fe = FrontierExplorer()
    rospy.spin()
