#!/usr/bin/env python2
import rospy
from std_msgs.msg import String
from my_package1.msg import Position


def callback(data):
    rospy.loginfo("%s x: %f y: %f", data.message, data.x, data.y)


def listener():
    rospy.init_node("Subscriber_node", anonymous=True)
    sub = rospy.Subscriber("talking_topic", Position, callback)
    rospy.spin()


if __name__ == '__main__':
    try:
        listener()
    except rospy.ROSInterruptException:
        pass
