#!/usr/bin/env python3
import rospy
import numpy as np
# TODO: import laser scan message
from std_msgs.msg import Float32MultiArray
from sensor_msgs.msg import LaserScan

from geometry_msgs.msg import Twist, Vector3
from gazebo_msgs.srv import DeleteLight


class Robocop():
    SERVICE_NAME = "/gazebo/delete_light"  # call this service to turn off the lights
    RUNTIME_LIMIT = None  # check out rospy.Duration and set this limit to 30 seconds

    def __init__(self):
        self.mean_distance = Float32MultiArray()
        # TODO: initialize the node
        rospy.init_node('tutlebot', anonymous=True)
        self.rate = rospy.Rate(1)

        # TODO: register listener for "/scan" topic & publisher for "/cmd_vel" topic (use arg "latch=True")
        self.sub = rospy.Subscriber('/scan', LaserScan, self.scan_cb)
        self.pub_cmd = rospy.Publisher('/cmd_vel', Twist, latch=True)

        # TODO: wait till the delete light service is up

        # TODO: create proxy for the delete light service
        # TODO: remember start time (something about rospy.Time...)
        # TODO: you are probably going to need to add some variables
        self.speed_limit_angular = 0.4
        self.speed_limit_slow = 0.2
        self.speed_limit_fast = 0.5
        self.first_distance_limit = 2.5  # must be between 1.5 and 3
        self.second_distance_limit = 0.7  # must be at-most 0.7
        self.backing_limit = 1

        self.move = Twist()
        self.new_range = None
        self.angle_corrected_range = None
        self.seventy_index = None
        self.thirty_index = None

        rospy.on_shutdown(self.full_stop)

        ###################################################################

    def calculate_mean_distance(self, start_angle, end_angle, msg):
        self.new_range = []

        # finding the indices of 30 and 70 degrees angle for the ranges array
        self.thirty_index = int(np.floor((-np.pi * start_angle / 6 - msg.angle_min) / msg.angle_increment))
        self.seventy_index = int(np.floor((np.pi * end_angle / 180 - msg.angle_min) / msg.angle_increment))

        # saving the values for indices that fall within 30 and 70 degrees
        self.angle_corrected_range = msg.ranges[self.thirty_index: self.seventy_index]

        # print("angle corrected ranges")
        # print(self.angle_corrected_range)

        # from the values that fall only within 30 and 70, saving only valid values of range to a new list new_range
        for ranges in self.angle_corrected_range:
            if msg.range_min < ranges < msg.range_max:
                self.new_range.append(ranges)

        # print("new ranges")
        # print(self.new_range)

        self.mean_distance = sum(self.new_range) / len(self.new_range)

        # print(self.mean_distance)

        return self.mean_distance
        ######################################################################

    def scan_cb(self, msg):
        # if None:  # <-- if (message timestamp - start timestamp) > self.RUNTIME_LIMIT
        #     # TODO unregister this listener
        #     # TODO: finis this line: response = <something>.call(light_name='sun')
        #     rospy.loginfo(str(response))  # printing response is good for debugging
        #     self.full_stop()

        # TODO: compute minimum distance for scan angles between -20 to 20 degrees
        # rng_front = self.calculate_mean_distance(340, 380, msg)

        rng_front = msg.ranges[0]
        rng_back = msg.ranges[int(np.floor(np.pi / msg.angle_increment - msg.angle_min))]
        # rng_back = self.calculate_mean_distance(160, 200, msg)

        print("rng_back")
        print(rng_back)

        # if rng_back < self.second_distance_limit:
        #     self.move.linear.x = self.speed_limit_fast
        #     self.move.angular.z = self.speed_limit_angular
        #     if rng_back == 0:
        #         while rng_front < self.second_distance_limit:
        #             self.move.angular.z = self.speed_limit_angular

        if rng_front < self.first_distance_limit:
            if rng_front < self.second_distance_limit:
                # TODO: stop the robot
                self.move.linear.x = 0.0
                self.move.angular.z = 0.0
                rospy.loginfo("Movement stopped.")

                # if rng_back > self.backing_limit:
                #     # if rng_front < self.second_distance_limit:
                #     self.move.linear.x = -self.speed_limit_slow
                #
                # # self.move.angular.z = self.speed_limit_angular

            else:
                if self.move.linear.x == 0:
                    # TODO: move slowly forward
                    rospy.loginfo("Slowing down")
                    self.move.linear.x = self.speed_limit_slow
                    # self.move.angular.z = self.speed_limit_angular
                    rospy.loginfo("Slow movement.")

            rng_right = self.calculate_mean_distance(290, 330, msg)
            # compute average distance of obstacles on the right (30-70 degrees to the right)
            rng_left = self.calculate_mean_distance(30, 70, msg)
            # None  # compute average distance of obstacles on the left (30-70 degrees to the left)

            if rng_left > rng_right:
                if self.move.angular.z >= 0:  # TODO: if not rotating left
                    # TODO: rotate left
                    self.move.angular.z = self.speed_limit_angular
                    rospy.loginfo("Started rotating left.")
            else:
                if self.move.angular.z <= 0:  # TODO: if not rotating right
                    # TODO: rotate right
                    self.move.angular.z = -self.speed_limit_angular
                    rospy.loginfo("Started rotating right.")
        else:
            if self.move.angular.z != 0:  # TODO: if currently rotating
                # TODO: stop rotation
                rospy.loginfo("Rotation stopped.")
                self.move.angular.z = 0

            if self.move.linear.x < self.speed_limit_fast:  # TODO: if not moving fast
                # TODO: start moving fast
                rospy.loginfo("Speeding up down")
                self.move.linear.x = self.speed_limit_fast
                rospy.loginfo("Go!")

        self.pub_cmd.publish(self.move)

        print("x-vel")
        print(self.move.linear.x)
        print("angular-vel")
        print(self.move.angular.z)

        if self.move.linear.x == 0:
            if rng_front == 0:
                self.move.linear.x = self.speed_limit_slow
            if rng_back == 0:
                self.move.linear.x = self.speed_limit_slow

    def full_stop(self):
        rospy.loginfo("Stopped.")
        # TODO: use your publisher to send commands to the robot
        self.pub_cmd.publish(
            Twist(
                linear=Vector3(x=0.0),
                angular=Vector3(z=0.0)
            )
        )


if __name__ == '__main__':
    rc = Robocop()
    rospy.spin()
