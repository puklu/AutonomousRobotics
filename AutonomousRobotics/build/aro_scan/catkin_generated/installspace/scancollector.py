#!/usr/bin/env python2
import rospy
from sensor_msgs.msg import LaserScan


def callback(data):
    new_range = []
    batch_length = rospy.get_param('batch_length', 10)
    for i in range(0, batch_length):
        print("i= "+str(i))
        if abs(data.angle_min) < 30 and abs(data.angle_max) < 30:
            rospy.loginfo("--- angle_min---")
            rospy.loginfo(data.angle_min)
            rospy.loginfo("--- angle_max---")
            rospy.loginfo(data.angle_max)
            rospy.loginfo("--- range_min---")
            rospy.loginfo(data.range_min)
            rospy.loginfo("--- range_max---")
            rospy.loginfo(data.range_max)
            rospy.loginfo("--- timestamp---")
            rospy.loginfo(data.header.stamp.to_sec())
            rospy.loginfo("--- global_parameter---")
            rospy.loginfo(rospy.get_param('batch_length', 10))
            rospy.loginfo("--- ranges---")
            for ranges in data.ranges:
                if data.range_min < ranges < data.range_max:
                    new_range.append(ranges)
        i += 1
    rospy.loginfo(len(new_range))


def listener():
    rospy.init_node("Subscriber_node", anonymous=True)
    sub = rospy.Subscriber("scan", LaserScan, callback)
    rospy.spin()


if __name__ == '__main__':
    try:
        listener()
    except rospy.ROSInterruptException:
        pass
