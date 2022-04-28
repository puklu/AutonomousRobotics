#!/usr/bin/env python2
import rospy
from sensor_msgs.msg import LaserScan
from std_msgs.msg import Float32MultiArray
import numpy as np
import matplotlib.pyplot as plt


class ScanCollector():

    def __init__(self):
        # Initializing the node
        rospy.init_node("Listener_node", anonymous=True)
        self.pub = rospy.Publisher('scan_filtered', Float32MultiArray, queue_size=10)

        # create the listener object and assign a class method as the callback
        rospy.Subscriber("scan", LaserScan, self.scan_callback)

        # retrieve the necessary parameters from the parameter server
        self.batch_length = rospy.get_param('/batch_length', 200)

    def scan_callback(self, data):
        new_range = []

        # finding the indices of -30 and 30 degrees angle for the ranges array
        minus_thirty_index = int(np.floor((-np.pi / 6 - data.angle_min) / data.angle_increment))
        plus_thirty_index = int(np.floor((np.pi / 6 - data.angle_min) / data.angle_increment))
        # print("minus_thirty_index=" + str(minus_thirty_index))
        # print("plus_thirty_index=" + str(plus_thirty_index))

        # saving the values for indices that fall within -30 and 30 degrees
        angle_corrected_range = data.ranges[minus_thirty_index: plus_thirty_index]
        # print(angle_corrected_range)

        # from the values that fall only with -30 and 30, saving only valid values of range to a new list new_range
        for ranges in angle_corrected_range:
            if data.range_min < ranges < data.range_max:
                new_range.append(ranges)

        # shutting down if the count of values has reached the batch length
        if len(msg.data) > self.batch_length:
            signal = "shutdown"
            rospy.signal_shutdown(signal)
        # else saving the mean to an array , also saving the timestamp
        else:
            msg.data.append(sum(new_range) / len(new_range))
            timestamp.append(data.header.stamp.to_sec())

        rospy.loginfo("--- timestamp---")
        rospy.loginfo(timestamp)
        rospy.loginfo("--- mean---")
        rospy.loginfo(msg.data)
        self.pub.publish(msg)


if __name__ == '__main__':
    msg = Float32MultiArray()
    timestamp = []
    sc = ScanCollector()
    rospy.spin()
    plt.plot(timestamp, msg.data)
    plt.xlabel('time(s)')
    plt.ylabel('distance(m)')
    plt.show()
