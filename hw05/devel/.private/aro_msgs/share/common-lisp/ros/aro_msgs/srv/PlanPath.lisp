; Auto-generated. Do not edit!


(cl:in-package aro_msgs-srv)


;//! \htmlinclude PlanPath-request.msg.html

(cl:defclass <PlanPath-request> (roslisp-msg-protocol:ros-message)
  ((start
    :reader start
    :initarg :start
    :type geometry_msgs-msg:Pose2D
    :initform (cl:make-instance 'geometry_msgs-msg:Pose2D))
   (goal
    :reader goal
    :initarg :goal
    :type geometry_msgs-msg:Pose2D
    :initform (cl:make-instance 'geometry_msgs-msg:Pose2D)))
)

(cl:defclass PlanPath-request (<PlanPath-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <PlanPath-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'PlanPath-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name aro_msgs-srv:<PlanPath-request> is deprecated: use aro_msgs-srv:PlanPath-request instead.")))

(cl:ensure-generic-function 'start-val :lambda-list '(m))
(cl:defmethod start-val ((m <PlanPath-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader aro_msgs-srv:start-val is deprecated.  Use aro_msgs-srv:start instead.")
  (start m))

(cl:ensure-generic-function 'goal-val :lambda-list '(m))
(cl:defmethod goal-val ((m <PlanPath-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader aro_msgs-srv:goal-val is deprecated.  Use aro_msgs-srv:goal instead.")
  (goal m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <PlanPath-request>) ostream)
  "Serializes a message object of type '<PlanPath-request>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'start) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'goal) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <PlanPath-request>) istream)
  "Deserializes a message object of type '<PlanPath-request>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'start) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'goal) istream)
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<PlanPath-request>)))
  "Returns string type for a service object of type '<PlanPath-request>"
  "aro_msgs/PlanPathRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'PlanPath-request)))
  "Returns string type for a service object of type 'PlanPath-request"
  "aro_msgs/PlanPathRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<PlanPath-request>)))
  "Returns md5sum for a message object of type '<PlanPath-request>"
  "fbdf89b8655c8e7d5298541bcdc5e6da")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'PlanPath-request)))
  "Returns md5sum for a message object of type 'PlanPath-request"
  "fbdf89b8655c8e7d5298541bcdc5e6da")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<PlanPath-request>)))
  "Returns full string definition for message of type '<PlanPath-request>"
  (cl:format cl:nil "geometry_msgs/Pose2D start~%geometry_msgs/Pose2D goal~%~%================================================================================~%MSG: geometry_msgs/Pose2D~%# Deprecated~%# Please use the full 3D pose.~%~%# In general our recommendation is to use a full 3D representation of everything and for 2D specific applications make the appropriate projections into the plane for their calculations but optimally will preserve the 3D information during processing.~%~%# If we have parallel copies of 2D datatypes every UI and other pipeline will end up needing to have dual interfaces to plot everything. And you will end up with not being able to use 3D tools for 2D use cases even if they're completely valid, as you'd have to reimplement it with different inputs and outputs. It's not particularly hard to plot the 2D pose or compute the yaw error for the Pose message and there are already tools and libraries that can do this for you.~%~%~%# This expresses a position and orientation on a 2D manifold.~%~%float64 x~%float64 y~%float64 theta~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'PlanPath-request)))
  "Returns full string definition for message of type 'PlanPath-request"
  (cl:format cl:nil "geometry_msgs/Pose2D start~%geometry_msgs/Pose2D goal~%~%================================================================================~%MSG: geometry_msgs/Pose2D~%# Deprecated~%# Please use the full 3D pose.~%~%# In general our recommendation is to use a full 3D representation of everything and for 2D specific applications make the appropriate projections into the plane for their calculations but optimally will preserve the 3D information during processing.~%~%# If we have parallel copies of 2D datatypes every UI and other pipeline will end up needing to have dual interfaces to plot everything. And you will end up with not being able to use 3D tools for 2D use cases even if they're completely valid, as you'd have to reimplement it with different inputs and outputs. It's not particularly hard to plot the 2D pose or compute the yaw error for the Pose message and there are already tools and libraries that can do this for you.~%~%~%# This expresses a position and orientation on a 2D manifold.~%~%float64 x~%float64 y~%float64 theta~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <PlanPath-request>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'start))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'goal))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <PlanPath-request>))
  "Converts a ROS message object to a list"
  (cl:list 'PlanPath-request
    (cl:cons ':start (start msg))
    (cl:cons ':goal (goal msg))
))
;//! \htmlinclude PlanPath-response.msg.html

(cl:defclass <PlanPath-response> (roslisp-msg-protocol:ros-message)
  ((path
    :reader path
    :initarg :path
    :type (cl:vector geometry_msgs-msg:Pose2D)
   :initform (cl:make-array 0 :element-type 'geometry_msgs-msg:Pose2D :initial-element (cl:make-instance 'geometry_msgs-msg:Pose2D))))
)

(cl:defclass PlanPath-response (<PlanPath-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <PlanPath-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'PlanPath-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name aro_msgs-srv:<PlanPath-response> is deprecated: use aro_msgs-srv:PlanPath-response instead.")))

(cl:ensure-generic-function 'path-val :lambda-list '(m))
(cl:defmethod path-val ((m <PlanPath-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader aro_msgs-srv:path-val is deprecated.  Use aro_msgs-srv:path instead.")
  (path m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <PlanPath-response>) ostream)
  "Serializes a message object of type '<PlanPath-response>"
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'path))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'path))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <PlanPath-response>) istream)
  "Deserializes a message object of type '<PlanPath-response>"
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'path) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'path)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'geometry_msgs-msg:Pose2D))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<PlanPath-response>)))
  "Returns string type for a service object of type '<PlanPath-response>"
  "aro_msgs/PlanPathResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'PlanPath-response)))
  "Returns string type for a service object of type 'PlanPath-response"
  "aro_msgs/PlanPathResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<PlanPath-response>)))
  "Returns md5sum for a message object of type '<PlanPath-response>"
  "fbdf89b8655c8e7d5298541bcdc5e6da")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'PlanPath-response)))
  "Returns md5sum for a message object of type 'PlanPath-response"
  "fbdf89b8655c8e7d5298541bcdc5e6da")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<PlanPath-response>)))
  "Returns full string definition for message of type '<PlanPath-response>"
  (cl:format cl:nil "geometry_msgs/Pose2D[] path~%~%~%================================================================================~%MSG: geometry_msgs/Pose2D~%# Deprecated~%# Please use the full 3D pose.~%~%# In general our recommendation is to use a full 3D representation of everything and for 2D specific applications make the appropriate projections into the plane for their calculations but optimally will preserve the 3D information during processing.~%~%# If we have parallel copies of 2D datatypes every UI and other pipeline will end up needing to have dual interfaces to plot everything. And you will end up with not being able to use 3D tools for 2D use cases even if they're completely valid, as you'd have to reimplement it with different inputs and outputs. It's not particularly hard to plot the 2D pose or compute the yaw error for the Pose message and there are already tools and libraries that can do this for you.~%~%~%# This expresses a position and orientation on a 2D manifold.~%~%float64 x~%float64 y~%float64 theta~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'PlanPath-response)))
  "Returns full string definition for message of type 'PlanPath-response"
  (cl:format cl:nil "geometry_msgs/Pose2D[] path~%~%~%================================================================================~%MSG: geometry_msgs/Pose2D~%# Deprecated~%# Please use the full 3D pose.~%~%# In general our recommendation is to use a full 3D representation of everything and for 2D specific applications make the appropriate projections into the plane for their calculations but optimally will preserve the 3D information during processing.~%~%# If we have parallel copies of 2D datatypes every UI and other pipeline will end up needing to have dual interfaces to plot everything. And you will end up with not being able to use 3D tools for 2D use cases even if they're completely valid, as you'd have to reimplement it with different inputs and outputs. It's not particularly hard to plot the 2D pose or compute the yaw error for the Pose message and there are already tools and libraries that can do this for you.~%~%~%# This expresses a position and orientation on a 2D manifold.~%~%float64 x~%float64 y~%float64 theta~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <PlanPath-response>))
  (cl:+ 0
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'path) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <PlanPath-response>))
  "Converts a ROS message object to a list"
  (cl:list 'PlanPath-response
    (cl:cons ':path (path msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'PlanPath)))
  'PlanPath-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'PlanPath)))
  'PlanPath-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'PlanPath)))
  "Returns string type for a service object of type '<PlanPath>"
  "aro_msgs/PlanPath")