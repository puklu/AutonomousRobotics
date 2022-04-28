#!/usr/bin/env python3
import rospy
from nav_msgs.msg import OccupancyGrid


def republish(msg):
    msg.info.origin.position.x -= -0.7
    msg.info.origin.position.y -= 0.0
    publisher.publish(msg)


if __name__ == "__main__":
    rospy.init_node("map_fix")

    rospy.Subscriber("/occupancy_old", OccupancyGrid, republish, queue_size=1)
    publisher = rospy.Publisher("/occupancy", OccupancyGrid, queue_size=1)

    rospy.spin()
