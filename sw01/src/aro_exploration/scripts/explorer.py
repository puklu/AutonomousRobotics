#!/usr/bin/env python3
from __future__ import absolute_import, division, print_function
from geometry_msgs.msg import Pose, Pose2D, Quaternion, Transform
import numpy as np
import rospy
from tf.transformations import euler_from_quaternion, quaternion_from_euler


def slots(msg):
    """Return message attributes (slots) as list."""
    return [getattr(msg, var) for var in msg.__slots__]


def array(msg):
    """Return message attributes (slots) as array."""
    return np.array(slots(msg))


def pose2to3(pose2):
    """Convert Pose2D to Pose."""
    pose3 = Pose()
    pose3.position.x = pose2.x
    pose3.position.y = pose2.y
    rpy = 0.0, 0.0, pose2.theta
    q = quaternion_from_euler(*rpy)
    pose3.orientation = Quaternion(*q)
    return pose3


def tf3to2(tf):
    """Convert Transform to Pose2D."""
    pose2 = Pose2D()
    pose2.x = tf.translation.x
    pose2.y = tf.translation.y
    rpy = euler_from_quaternion(slots(tf.rotation))
    pose2.theta = rpy[2]
    return pose2


class Explorer(object):
    def __init__(self):
        # up to you
        pass


if __name__ == '__main__':
    rospy.init_node('explorer', log_level=rospy.INFO)
    node = Explorer()
    rospy.spin()
