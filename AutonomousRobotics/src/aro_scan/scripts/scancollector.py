#!/usr/bin/env python2
import rospy
from sensor_msgs.msg import LaserScan


def scan_callback(data):
    new_range = []

    # for i in range(0, batch_length):
    #     print("i= "+str(i))
    if abs(data.angle_min) < 30 and abs(data.angle_max) < 30:
        # rospy.loginfo("--- angle_min---")
        # rospy.loginfo(data.angle_min)
        # rospy.loginfo("--- angle_max---")
        # rospy.loginfo(data.angle_max)
        # rospy.loginfo("--- range_min---")
        # rospy.loginfo(data.range_min)
        # rospy.loginfo("--- range_max---")
        # rospy.loginfo(data.range_max)

        for ranges in data.ranges:
            if data.range_min < ranges < data.range_max:
                new_range.append(ranges)
        # i += 1
        mean.append((sum(new_range) / len(new_range)))
        timestamp.append(data.header.stamp.to_sec())
        rospy.loginfo("--- timestamp---")
        rospy.loginfo(timestamp)
    rospy.loginfo("--- mean---")
    rospy.loginfo(mean)


def listener():
    rospy.init_node("Listener_node", anonymous=True)
    sub = rospy.Subscriber("scan", LaserScan, scan_callback)
    # batch_length = rospy.get_param('batch_length', 10)
    rospy.spin()


if __name__ == '__main__':
    mean = []
    timestamp = []
    try:
        listener()
    except rospy.ROSInterruptException:
        pass
