#!/usr/bin/env python2
import rospy
from std_msgs.msg import String
from my_package1.msg import Position

def talk_to_me():
    pub = rospy.Publisher('talking_topic', Position, queue_size=10)
    rospy.init_node('publisher_node', anonymous=True)
    rate = rospy.Rate(1)
    rospy.loginfo("Publisher node started, now publishing messages")
    while not rospy.is_shutdown():
        msg = Position()
        msg.message = "Position is: "
        msg.x = 3.5
        msg.y = 1.2
        pub.publish(msg)
        rate.sleep()


if __name__ == '__main__':
    try:
        talk_to_me()
    except rospy.ROSInterruptException:
        pass
