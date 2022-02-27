#!/usr/bin/env python3
import rospy
import numpy as np
from std_msgs.msg import Float32MultiArray
from sensor_msgs.msg import LaserScan
from geometry_msgs.msg import Twist, Vector3
from gazebo_msgs.srv import DeleteLight


class Robocop():
    SERVICE_NAME = "/gazebo/delete_light"  # call this service to turn off the lights
    RUNTIME_LIMIT = rospy.Duration(30)  # time duration for which nodes should run

    def __init__(self):
        # initializing the node
        rospy.init_node('tutlebot', anonymous=True)
        self.rate = rospy.Rate(1)

        # registering listener for "/scan" topic & publisher for "/cmd_vel" topic (using arg "latch=True")
        self.sub = rospy.Subscriber('/scan', LaserScan, self.scan_cb)
        self.pub_cmd = rospy.Publisher('/cmd_vel', Twist, latch=True)

        # waiting till delete light service is up
        rospy.wait_for_service(self.SERVICE_NAME)

        # creating proxy for delete light service
        self.delete_light = rospy.ServiceProxy(self.SERVICE_NAME, DeleteLight)

        # storing the start time of the node
        self.start_time = rospy.Time.now()

        # speed and distance variables
        self.speed_limit_angular = 0.4
        self.speed_limit_slow = 0.2
        self.speed_limit_fast = 0.5
        self.first_distance_limit = 2.5  # must be between 1.5 and 3
        self.second_distance_limit = 0.7  # must be at-most 0.7
        self.backing_limit = 0.2

        # variable to send command to /cmd_vel
        self.move = Twist()

        # variables to calculate mean for laser scan data
        self.mean_distance = Float32MultiArray()
        self.new_range = None
        self.angle_corrected_range = None
        self.start_index = None
        self.end_index = None

        # variable to store the current time
        self.timestamp = None

        # runs full_stop after shutting down
        rospy.on_shutdown(self.full_stop)

    # method to calculate the mean distance between two angle values
    def calculate_mean_distance(self, start_angle, end_angle, msg):
        # variable to store the new valid ranges values
        self.new_range = []

        # finding the indices starting angle and ending angle for the ranges array
        self.start_index = int(np.floor((np.pi * start_angle / 180 - msg.angle_min) / msg.angle_increment))
        self.end_index = int(np.floor((np.pi * end_angle / 180 - msg.angle_min) / msg.angle_increment))

        # saving the values for indices that fall within start angle and end angle
        self.angle_corrected_range = msg.ranges[self.start_index: self.end_index]

        # print("angle corrected ranges")
        # print(self.angle_corrected_range)

        # from the values that fall only within start angle and end angle, saving only valid values of range to a new
        # list new_range
        for ranges in self.angle_corrected_range:
            if msg.range_min < ranges < msg.range_max:
                self.new_range.append(ranges)

        # print("new ranges")
        # print(self.new_range)

        # calculating the mean of the new ranges
        self.mean_distance = sum(self.new_range) / len(self.new_range)

        # print(self.mean_distance)

        return self.mean_distance

    # callback for the subscriber node
    def scan_cb(self, msg):
        # storing the current time
        self.timestamp = rospy.Time.now()

        # checking if it has been 30 secs since the node started
        if (self.timestamp - self.start_time) > self.RUNTIME_LIMIT:
            # call to delete the sunlight
            response = self.delete_light(light_name='sun')
            rospy.loginfo(str(response))

            # calling the full stop method to send 0 velocities to the bot
            self.full_stop()

            # shutting down the node
            rospy.signal_shutdown("Shutting down, time limit reached")

        # computing minimum distance for scan angles between -20 to 20 degrees
        rng_front = (self.calculate_mean_distance(0, 20, msg) + self.calculate_mean_distance(340, 360, msg)) / 2
        # computing minimum distance for scan angles between 160 and 200 degrees
        rng_back = self.calculate_mean_distance(160, 200, msg)

        # print("rng_front")
        # print(rng_front)
        # print("rng_back")
        # print(rng_back)

        # computing average distance of obstacles on the right (30-70 degrees to the right)
        rng_right = self.calculate_mean_distance(300, 340, msg)
        # print("rng_right")
        # print(rng_right)

        # computing average distance of obstacles on the left (30-70 degrees to the left)
        rng_left = self.calculate_mean_distance(20, 60, msg)
        # print("rng_left")
        # print(rng_left)

        # if the bot has reached within the first distance limit
        if rng_front < self.first_distance_limit:
            # if the bot has even reached within the second distance limit
            if rng_front < self.second_distance_limit:
                # stop the robot
                self.move.linear.x = 0.0
                rospy.loginfo("Movement stopped.")
                # if there is space in the back
                if rng_back > self.backing_limit:
                    # back up the bot
                    self.move.linear.x = -self.speed_limit_slow
                else:
                    # if there is no space in the back, then turn it
                    if rng_left > rng_right:
                        self.move.angular.z = -self.speed_limit_angular
                    else:
                        self.move.angular.z = self.speed_limit_angular

            else:
                # if it is not moving
                if self.move.linear.x == 0:
                    # move slowly forward
                    rospy.loginfo("Slowing down")
                    self.move.linear.x = self.speed_limit_slow
                    rospy.loginfo("Slow movement.")

            if rng_left > rng_right:
                # if not rotating left
                if self.move.angular.z <= 0:
                    # rotate left
                    self.move.angular.z = self.speed_limit_angular
                    rospy.loginfo("Started rotating left.")
            else:
                # if not rotating right
                if self.move.angular.z >= 0:
                    # rotate right
                    self.move.angular.z = -self.speed_limit_angular
                    rospy.loginfo("Started rotating right.")

        # if the bot is outside the first distance limit
        else:
            # if currently rotating
            if self.move.angular.z != 0:
                # stop rotation
                rospy.loginfo("Rotation stopped.")
                self.move.angular.z = 0

            # if not moving fast
            if self.move.linear.x < self.speed_limit_fast:
                # start moving fast
                rospy.loginfo("Speeding up down")
                self.move.linear.x = self.speed_limit_fast
                rospy.loginfo("Go!")

        # finally, publishing the move command to the topic
        self.pub_cmd.publish(self.move)

        # print("x-vel")
        # print(self.move.linear.x)
        # print("angular-vel")
        # print(self.move.angular.z)

    # method to stop the bot
    def full_stop(self):
        rospy.loginfo("Stopped.")
        self.pub_cmd.publish(
            Twist(
                linear=Vector3(x=0.0),
                angular=Vector3(z=0.0)
            )
        )


if __name__ == '__main__':
    rc = Robocop()
    rospy.spin()
