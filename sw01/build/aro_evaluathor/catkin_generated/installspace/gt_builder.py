#!/usr/bin/env python3
import rospy
import lxml.etree as ET
import numpy as np
import rospkg
import os
from nav_msgs.msg import OccupancyGrid, Odometry
import roslaunch
import cv2
from uuid import uuid4
from aro_evaluathor.utils import showMap


class GTBuilder():

    def __init__(self):
        rospack = rospkg.RosPack()
        self.aro_sim_pkg = rospack.get_path("aro_sim")
        self.aro_eval_pkg = rospack.get_path("aro_evaluathor")
        self.robotCFGPath = os.path.join(self.aro_sim_pkg, "urdf/turtlebot3_burger_rgbd.gazebo.xacro")

        self.oldRobotCFGValues = {}

        self.mapImage = None
        self.mapName = rospy.get_param("~map_name", "unknown" + uuid4().hex)
        self.spawnArgs = rospy.get_param("~spawn_args", "default")
        self.sim_launch = None

        # self.mapListener = rospy.Subscriber("/odom", Odometry, self.odom_cb, queue_size=1)

        self.mapListener = rospy.Subscriber("/occupancy", OccupancyGrid, self.mapUpdate_cb, queue_size=1)

    def activateGTMode(self):
        # parse robot config
        tree = ET.parse(self.robotCFGPath)
        root = tree.getroot()

        # switch odom source to world
        odomSrc = next(root.iter("odometrySource"))
        self.oldRobotCFGValues["odometrySource"] = odomSrc.text
        odomSrc.text = "world"

        # turn off lidar noise
        lidar = next(sens for sens in root.iter("sensor") if "lds" in sens.attrib["name"])
        updateRate = lidar.find("update_rate")
        self.oldRobotCFGValues["update_rate"] = updateRate.text
        updateRate.text = "10"

        noise = next(lidar.iter("noise"))
        noise_mean = noise.find("mean")
        self.oldRobotCFGValues["mean"] = noise_mean.text
        noise_mean.text = "0.0"

        noise_stdev = noise.find("stddev")
        self.oldRobotCFGValues["stddev"] = noise_stdev.text
        noise_stdev.text = "0.0"

        with open(self.robotCFGPath, "w") as file:
            tree.write(file, xml_declaration=True)

    def deactivateGTMode(self):
        # parse robot config
        tree = ET.parse(self.robotCFGPath)
        root = tree.getroot()

        # switch odom source to back to encoder (possibly)
        odomSrc = next(root.iter("odometrySource"))
        odomSrc.text = self.oldRobotCFGValues["odometrySource"]
        # odomSrc.append(ET.Comment("world"))

        # turn off lidar noise
        lidar = next(sens for sens in root.iter("sensor") if "lds" in sens.attrib["name"])
        lidar.find("update_rate").text = self.oldRobotCFGValues["update_rate"]

        noise = next(lidar.iter("noise"))
        noise.find("mean").text = self.oldRobotCFGValues["mean"]
        noise.find("stddev").text = self.oldRobotCFGValues["stddev"]

        with open(self.robotCFGPath, "w") as file:
            tree.write(file, xml_declaration=True)

    def mapUpdate_cb(self, msg):
        msg = rospy.wait_for_message("/occupancy", OccupancyGrid)
        self.mapInfo = msg.info
        try:
            self.mapImage = np.reshape(msg.data, (self.mapInfo.height, self.mapInfo.width))
            key = showMap(self.mapImage, "map of {}".format(self.mapName))
            if key == ord("q"):
                self.sim_launch.shutdown()
            elif key == ord("r"):
                self.restart()

        except Exception as e:
            rospy.logerr(e)

    def restart(self):
        if self.sim_launch is not None:
            self.sim_launch.shutdown()

        # Launch the simulator
        uuid = roslaunch.rlutil.get_or_generate_uuid(None, False)
        roslaunch.configure_logging(uuid)
        launch_command = ["aro_sim", "turtlebot3.launch", "world:={}".format(self.mapName)]
        if "default" not in self.spawnArgs:
            launch_command += ["spawn_args:=-x {} -y {} -z 0.0".format(*self.spawnArgs.split(" "))]

        print(self.spawnArgs)
        print(launch_command)
        sim_launch_file = roslaunch.rlutil.resolve_launch_arguments(launch_command)[0]
        sim_launch_args = launch_command[2:]
        launch_files = [(sim_launch_file, sim_launch_args)]
        self.sim_launch = roslaunch.parent.ROSLaunchParent(uuid, launch_files)
        rospy.loginfo(self.sim_launch.roslaunch_files)
        self.sim_launch.start()
        rospy.loginfo("ARO SIM launched.")

    def run(self):
        self.activateGTMode()
        self.restart()

        odom_msg = rospy.wait_for_message("/odom", Odometry)
        pos = odom_msg.pose.pose.position
        self.initPose = np.r_[pos.x, pos.y, pos.z]

        try:
            rospy.spin()  # spin
        except Exception as e:
            rospy.logfatal(e)
        finally:
            # save the map
            fileName = os.path.join(self.aro_eval_pkg, "maps", self.mapName + ".txt")
            if os.path.exists(fileName):  # backup the old map if one exists
                os.rename(fileName, os.path.join(self.aro_eval_pkg, "old_maps", self.mapName + "_" + uuid4().hex + ".txt"))

            meta = np.c_["0,1,0", np.r_[self.mapInfo.origin.position.x, self.mapInfo.origin.position.y, self.mapInfo.origin.position.z],
                         np.r_[self.mapInfo.origin.orientation.x, self.mapInfo.origin.orientation.y, self.mapInfo.origin.orientation.z, self.mapInfo.origin.orientation.w],
                         self.initPose,
                         self.mapInfo.resolution]
            meta = np.pad(meta, (0, self.mapImage.shape[1] - meta.shape[0]), "constant", constant_values=-1e-98)
            alldata = np.concatenate((self.mapImage, meta[np.newaxis]))

            np.savetxt(fileName, alldata)
            cv2.destroyAllWindows()
            self.sim_launch.shutdown()  # stop the simulator
            self.deactivateGTMode()  # revert changes to the XML


if __name__ == "__main__":
    rospy.init_node("gt_builder")

    gtBuilder = GTBuilder()
    gtBuilder.run()
