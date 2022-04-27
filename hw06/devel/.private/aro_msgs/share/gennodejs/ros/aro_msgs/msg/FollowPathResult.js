// Auto-generated. Do not edit!

// (in-package aro_msgs.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;
let geometry_msgs = _finder('geometry_msgs');

//-----------------------------------------------------------

class FollowPathResult {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.finalPosition = null;
    }
    else {
      if (initObj.hasOwnProperty('finalPosition')) {
        this.finalPosition = initObj.finalPosition
      }
      else {
        this.finalPosition = new geometry_msgs.msg.Pose2D();
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type FollowPathResult
    // Serialize message field [finalPosition]
    bufferOffset = geometry_msgs.msg.Pose2D.serialize(obj.finalPosition, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type FollowPathResult
    let len;
    let data = new FollowPathResult(null);
    // Deserialize message field [finalPosition]
    data.finalPosition = geometry_msgs.msg.Pose2D.deserialize(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    return 24;
  }

  static datatype() {
    // Returns string type for a message object
    return 'aro_msgs/FollowPathResult';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '9ed511beb5c491291b59853d2626b761';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    # ====== DO NOT MODIFY! AUTOGENERATED FROM AN ACTION DEFINITION ======
    geometry_msgs/Pose2D finalPosition
    
    ================================================================================
    MSG: geometry_msgs/Pose2D
    # Deprecated
    # Please use the full 3D pose.
    
    # In general our recommendation is to use a full 3D representation of everything and for 2D specific applications make the appropriate projections into the plane for their calculations but optimally will preserve the 3D information during processing.
    
    # If we have parallel copies of 2D datatypes every UI and other pipeline will end up needing to have dual interfaces to plot everything. And you will end up with not being able to use 3D tools for 2D use cases even if they're completely valid, as you'd have to reimplement it with different inputs and outputs. It's not particularly hard to plot the 2D pose or compute the yaw error for the Pose message and there are already tools and libraries that can do this for you.
    
    
    # This expresses a position and orientation on a 2D manifold.
    
    float64 x
    float64 y
    float64 theta
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new FollowPathResult(null);
    if (msg.finalPosition !== undefined) {
      resolved.finalPosition = geometry_msgs.msg.Pose2D.Resolve(msg.finalPosition)
    }
    else {
      resolved.finalPosition = new geometry_msgs.msg.Pose2D()
    }

    return resolved;
    }
};

module.exports = FollowPathResult;