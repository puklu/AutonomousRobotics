# generated from genmsg/cmake/pkg-genmsg.cmake.em

message(STATUS "aro_msgs: 8 messages, 2 services")

set(MSG_I_FLAGS "-Iaro_msgs:/home/vivek/Documents/ROS/hw04/src/aro_frontier/aro_msgs/msg;-Iaro_msgs:/home/vivek/Documents/ROS/hw04/devel/share/aro_msgs/msg;-Istd_msgs:/opt/ros/noetic/share/std_msgs/cmake/../msg;-Igeometry_msgs:/opt/ros/noetic/share/geometry_msgs/cmake/../msg;-Iactionlib_msgs:/opt/ros/noetic/share/actionlib_msgs/cmake/../msg")

# Find all generators
find_package(gencpp REQUIRED)
find_package(geneus REQUIRED)
find_package(genlisp REQUIRED)
find_package(gennodejs REQUIRED)
find_package(genpy REQUIRED)

add_custom_target(aro_msgs_generate_messages ALL)

# verify that message/service dependencies have not changed since configure



get_filename_component(_filename "/home/vivek/Documents/ROS/hw04/src/aro_frontier/aro_msgs/msg/Path.msg" NAME_WE)
add_custom_target(_aro_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "aro_msgs" "/home/vivek/Documents/ROS/hw04/src/aro_frontier/aro_msgs/msg/Path.msg" "geometry_msgs/Point:geometry_msgs/Quaternion:std_msgs/Header:geometry_msgs/Pose:geometry_msgs/PoseStamped"
)

get_filename_component(_filename "/home/vivek/Documents/ROS/hw04/devel/share/aro_msgs/msg/FollowPathAction.msg" NAME_WE)
add_custom_target(_aro_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "aro_msgs" "/home/vivek/Documents/ROS/hw04/devel/share/aro_msgs/msg/FollowPathAction.msg" "actionlib_msgs/GoalID:aro_msgs/FollowPathGoal:geometry_msgs/Point:aro_msgs/FollowPathActionGoal:geometry_msgs/Quaternion:aro_msgs/FollowPathActionFeedback:std_msgs/Header:geometry_msgs/Pose:geometry_msgs/Pose2D:geometry_msgs/PoseStamped:actionlib_msgs/GoalStatus:aro_msgs/FollowPathFeedback:aro_msgs/FollowPathActionResult:aro_msgs/FollowPathResult"
)

get_filename_component(_filename "/home/vivek/Documents/ROS/hw04/devel/share/aro_msgs/msg/FollowPathActionGoal.msg" NAME_WE)
add_custom_target(_aro_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "aro_msgs" "/home/vivek/Documents/ROS/hw04/devel/share/aro_msgs/msg/FollowPathActionGoal.msg" "actionlib_msgs/GoalID:aro_msgs/FollowPathGoal:geometry_msgs/Point:geometry_msgs/Quaternion:std_msgs/Header:geometry_msgs/Pose:geometry_msgs/PoseStamped"
)

get_filename_component(_filename "/home/vivek/Documents/ROS/hw04/devel/share/aro_msgs/msg/FollowPathActionResult.msg" NAME_WE)
add_custom_target(_aro_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "aro_msgs" "/home/vivek/Documents/ROS/hw04/devel/share/aro_msgs/msg/FollowPathActionResult.msg" "actionlib_msgs/GoalID:std_msgs/Header:geometry_msgs/Pose2D:actionlib_msgs/GoalStatus:aro_msgs/FollowPathResult"
)

get_filename_component(_filename "/home/vivek/Documents/ROS/hw04/devel/share/aro_msgs/msg/FollowPathActionFeedback.msg" NAME_WE)
add_custom_target(_aro_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "aro_msgs" "/home/vivek/Documents/ROS/hw04/devel/share/aro_msgs/msg/FollowPathActionFeedback.msg" "actionlib_msgs/GoalID:std_msgs/Header:geometry_msgs/Pose2D:actionlib_msgs/GoalStatus:aro_msgs/FollowPathFeedback"
)

get_filename_component(_filename "/home/vivek/Documents/ROS/hw04/devel/share/aro_msgs/msg/FollowPathGoal.msg" NAME_WE)
add_custom_target(_aro_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "aro_msgs" "/home/vivek/Documents/ROS/hw04/devel/share/aro_msgs/msg/FollowPathGoal.msg" "geometry_msgs/Point:geometry_msgs/Quaternion:std_msgs/Header:geometry_msgs/Pose:geometry_msgs/PoseStamped"
)

get_filename_component(_filename "/home/vivek/Documents/ROS/hw04/devel/share/aro_msgs/msg/FollowPathResult.msg" NAME_WE)
add_custom_target(_aro_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "aro_msgs" "/home/vivek/Documents/ROS/hw04/devel/share/aro_msgs/msg/FollowPathResult.msg" "geometry_msgs/Pose2D"
)

get_filename_component(_filename "/home/vivek/Documents/ROS/hw04/devel/share/aro_msgs/msg/FollowPathFeedback.msg" NAME_WE)
add_custom_target(_aro_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "aro_msgs" "/home/vivek/Documents/ROS/hw04/devel/share/aro_msgs/msg/FollowPathFeedback.msg" "geometry_msgs/Pose2D"
)

get_filename_component(_filename "/home/vivek/Documents/ROS/hw04/src/aro_frontier/aro_msgs/srv/GenerateFrontier.srv" NAME_WE)
add_custom_target(_aro_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "aro_msgs" "/home/vivek/Documents/ROS/hw04/src/aro_frontier/aro_msgs/srv/GenerateFrontier.srv" "geometry_msgs/Pose2D"
)

get_filename_component(_filename "/home/vivek/Documents/ROS/hw04/src/aro_frontier/aro_msgs/srv/PlanPath.srv" NAME_WE)
add_custom_target(_aro_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "aro_msgs" "/home/vivek/Documents/ROS/hw04/src/aro_frontier/aro_msgs/srv/PlanPath.srv" "geometry_msgs/Pose2D"
)

#
#  langs = gencpp;geneus;genlisp;gennodejs;genpy
#

### Section generating for lang: gencpp
### Generating Messages
_generate_msg_cpp(aro_msgs
  "/home/vivek/Documents/ROS/hw04/src/aro_frontier/aro_msgs/msg/Path.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Pose.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/PoseStamped.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/aro_msgs
)
_generate_msg_cpp(aro_msgs
  "/home/vivek/Documents/ROS/hw04/devel/share/aro_msgs/msg/FollowPathAction.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalID.msg;/home/vivek/Documents/ROS/hw04/devel/share/aro_msgs/msg/FollowPathGoal.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg;/home/vivek/Documents/ROS/hw04/devel/share/aro_msgs/msg/FollowPathActionGoal.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/home/vivek/Documents/ROS/hw04/devel/share/aro_msgs/msg/FollowPathActionFeedback.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Pose.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Pose2D.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/PoseStamped.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalStatus.msg;/home/vivek/Documents/ROS/hw04/devel/share/aro_msgs/msg/FollowPathFeedback.msg;/home/vivek/Documents/ROS/hw04/devel/share/aro_msgs/msg/FollowPathActionResult.msg;/home/vivek/Documents/ROS/hw04/devel/share/aro_msgs/msg/FollowPathResult.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/aro_msgs
)
_generate_msg_cpp(aro_msgs
  "/home/vivek/Documents/ROS/hw04/devel/share/aro_msgs/msg/FollowPathActionGoal.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalID.msg;/home/vivek/Documents/ROS/hw04/devel/share/aro_msgs/msg/FollowPathGoal.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Pose.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/PoseStamped.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/aro_msgs
)
_generate_msg_cpp(aro_msgs
  "/home/vivek/Documents/ROS/hw04/devel/share/aro_msgs/msg/FollowPathActionResult.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalID.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Pose2D.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalStatus.msg;/home/vivek/Documents/ROS/hw04/devel/share/aro_msgs/msg/FollowPathResult.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/aro_msgs
)
_generate_msg_cpp(aro_msgs
  "/home/vivek/Documents/ROS/hw04/devel/share/aro_msgs/msg/FollowPathActionFeedback.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalID.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Pose2D.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalStatus.msg;/home/vivek/Documents/ROS/hw04/devel/share/aro_msgs/msg/FollowPathFeedback.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/aro_msgs
)
_generate_msg_cpp(aro_msgs
  "/home/vivek/Documents/ROS/hw04/devel/share/aro_msgs/msg/FollowPathGoal.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Pose.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/PoseStamped.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/aro_msgs
)
_generate_msg_cpp(aro_msgs
  "/home/vivek/Documents/ROS/hw04/devel/share/aro_msgs/msg/FollowPathResult.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Pose2D.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/aro_msgs
)
_generate_msg_cpp(aro_msgs
  "/home/vivek/Documents/ROS/hw04/devel/share/aro_msgs/msg/FollowPathFeedback.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Pose2D.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/aro_msgs
)

### Generating Services
_generate_srv_cpp(aro_msgs
  "/home/vivek/Documents/ROS/hw04/src/aro_frontier/aro_msgs/srv/GenerateFrontier.srv"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Pose2D.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/aro_msgs
)
_generate_srv_cpp(aro_msgs
  "/home/vivek/Documents/ROS/hw04/src/aro_frontier/aro_msgs/srv/PlanPath.srv"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Pose2D.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/aro_msgs
)

### Generating Module File
_generate_module_cpp(aro_msgs
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/aro_msgs
  "${ALL_GEN_OUTPUT_FILES_cpp}"
)

add_custom_target(aro_msgs_generate_messages_cpp
  DEPENDS ${ALL_GEN_OUTPUT_FILES_cpp}
)
add_dependencies(aro_msgs_generate_messages aro_msgs_generate_messages_cpp)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/vivek/Documents/ROS/hw04/src/aro_frontier/aro_msgs/msg/Path.msg" NAME_WE)
add_dependencies(aro_msgs_generate_messages_cpp _aro_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/vivek/Documents/ROS/hw04/devel/share/aro_msgs/msg/FollowPathAction.msg" NAME_WE)
add_dependencies(aro_msgs_generate_messages_cpp _aro_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/vivek/Documents/ROS/hw04/devel/share/aro_msgs/msg/FollowPathActionGoal.msg" NAME_WE)
add_dependencies(aro_msgs_generate_messages_cpp _aro_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/vivek/Documents/ROS/hw04/devel/share/aro_msgs/msg/FollowPathActionResult.msg" NAME_WE)
add_dependencies(aro_msgs_generate_messages_cpp _aro_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/vivek/Documents/ROS/hw04/devel/share/aro_msgs/msg/FollowPathActionFeedback.msg" NAME_WE)
add_dependencies(aro_msgs_generate_messages_cpp _aro_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/vivek/Documents/ROS/hw04/devel/share/aro_msgs/msg/FollowPathGoal.msg" NAME_WE)
add_dependencies(aro_msgs_generate_messages_cpp _aro_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/vivek/Documents/ROS/hw04/devel/share/aro_msgs/msg/FollowPathResult.msg" NAME_WE)
add_dependencies(aro_msgs_generate_messages_cpp _aro_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/vivek/Documents/ROS/hw04/devel/share/aro_msgs/msg/FollowPathFeedback.msg" NAME_WE)
add_dependencies(aro_msgs_generate_messages_cpp _aro_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/vivek/Documents/ROS/hw04/src/aro_frontier/aro_msgs/srv/GenerateFrontier.srv" NAME_WE)
add_dependencies(aro_msgs_generate_messages_cpp _aro_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/vivek/Documents/ROS/hw04/src/aro_frontier/aro_msgs/srv/PlanPath.srv" NAME_WE)
add_dependencies(aro_msgs_generate_messages_cpp _aro_msgs_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(aro_msgs_gencpp)
add_dependencies(aro_msgs_gencpp aro_msgs_generate_messages_cpp)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS aro_msgs_generate_messages_cpp)

### Section generating for lang: geneus
### Generating Messages
_generate_msg_eus(aro_msgs
  "/home/vivek/Documents/ROS/hw04/src/aro_frontier/aro_msgs/msg/Path.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Pose.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/PoseStamped.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/aro_msgs
)
_generate_msg_eus(aro_msgs
  "/home/vivek/Documents/ROS/hw04/devel/share/aro_msgs/msg/FollowPathAction.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalID.msg;/home/vivek/Documents/ROS/hw04/devel/share/aro_msgs/msg/FollowPathGoal.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg;/home/vivek/Documents/ROS/hw04/devel/share/aro_msgs/msg/FollowPathActionGoal.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/home/vivek/Documents/ROS/hw04/devel/share/aro_msgs/msg/FollowPathActionFeedback.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Pose.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Pose2D.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/PoseStamped.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalStatus.msg;/home/vivek/Documents/ROS/hw04/devel/share/aro_msgs/msg/FollowPathFeedback.msg;/home/vivek/Documents/ROS/hw04/devel/share/aro_msgs/msg/FollowPathActionResult.msg;/home/vivek/Documents/ROS/hw04/devel/share/aro_msgs/msg/FollowPathResult.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/aro_msgs
)
_generate_msg_eus(aro_msgs
  "/home/vivek/Documents/ROS/hw04/devel/share/aro_msgs/msg/FollowPathActionGoal.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalID.msg;/home/vivek/Documents/ROS/hw04/devel/share/aro_msgs/msg/FollowPathGoal.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Pose.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/PoseStamped.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/aro_msgs
)
_generate_msg_eus(aro_msgs
  "/home/vivek/Documents/ROS/hw04/devel/share/aro_msgs/msg/FollowPathActionResult.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalID.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Pose2D.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalStatus.msg;/home/vivek/Documents/ROS/hw04/devel/share/aro_msgs/msg/FollowPathResult.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/aro_msgs
)
_generate_msg_eus(aro_msgs
  "/home/vivek/Documents/ROS/hw04/devel/share/aro_msgs/msg/FollowPathActionFeedback.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalID.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Pose2D.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalStatus.msg;/home/vivek/Documents/ROS/hw04/devel/share/aro_msgs/msg/FollowPathFeedback.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/aro_msgs
)
_generate_msg_eus(aro_msgs
  "/home/vivek/Documents/ROS/hw04/devel/share/aro_msgs/msg/FollowPathGoal.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Pose.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/PoseStamped.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/aro_msgs
)
_generate_msg_eus(aro_msgs
  "/home/vivek/Documents/ROS/hw04/devel/share/aro_msgs/msg/FollowPathResult.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Pose2D.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/aro_msgs
)
_generate_msg_eus(aro_msgs
  "/home/vivek/Documents/ROS/hw04/devel/share/aro_msgs/msg/FollowPathFeedback.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Pose2D.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/aro_msgs
)

### Generating Services
_generate_srv_eus(aro_msgs
  "/home/vivek/Documents/ROS/hw04/src/aro_frontier/aro_msgs/srv/GenerateFrontier.srv"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Pose2D.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/aro_msgs
)
_generate_srv_eus(aro_msgs
  "/home/vivek/Documents/ROS/hw04/src/aro_frontier/aro_msgs/srv/PlanPath.srv"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Pose2D.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/aro_msgs
)

### Generating Module File
_generate_module_eus(aro_msgs
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/aro_msgs
  "${ALL_GEN_OUTPUT_FILES_eus}"
)

add_custom_target(aro_msgs_generate_messages_eus
  DEPENDS ${ALL_GEN_OUTPUT_FILES_eus}
)
add_dependencies(aro_msgs_generate_messages aro_msgs_generate_messages_eus)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/vivek/Documents/ROS/hw04/src/aro_frontier/aro_msgs/msg/Path.msg" NAME_WE)
add_dependencies(aro_msgs_generate_messages_eus _aro_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/vivek/Documents/ROS/hw04/devel/share/aro_msgs/msg/FollowPathAction.msg" NAME_WE)
add_dependencies(aro_msgs_generate_messages_eus _aro_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/vivek/Documents/ROS/hw04/devel/share/aro_msgs/msg/FollowPathActionGoal.msg" NAME_WE)
add_dependencies(aro_msgs_generate_messages_eus _aro_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/vivek/Documents/ROS/hw04/devel/share/aro_msgs/msg/FollowPathActionResult.msg" NAME_WE)
add_dependencies(aro_msgs_generate_messages_eus _aro_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/vivek/Documents/ROS/hw04/devel/share/aro_msgs/msg/FollowPathActionFeedback.msg" NAME_WE)
add_dependencies(aro_msgs_generate_messages_eus _aro_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/vivek/Documents/ROS/hw04/devel/share/aro_msgs/msg/FollowPathGoal.msg" NAME_WE)
add_dependencies(aro_msgs_generate_messages_eus _aro_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/vivek/Documents/ROS/hw04/devel/share/aro_msgs/msg/FollowPathResult.msg" NAME_WE)
add_dependencies(aro_msgs_generate_messages_eus _aro_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/vivek/Documents/ROS/hw04/devel/share/aro_msgs/msg/FollowPathFeedback.msg" NAME_WE)
add_dependencies(aro_msgs_generate_messages_eus _aro_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/vivek/Documents/ROS/hw04/src/aro_frontier/aro_msgs/srv/GenerateFrontier.srv" NAME_WE)
add_dependencies(aro_msgs_generate_messages_eus _aro_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/vivek/Documents/ROS/hw04/src/aro_frontier/aro_msgs/srv/PlanPath.srv" NAME_WE)
add_dependencies(aro_msgs_generate_messages_eus _aro_msgs_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(aro_msgs_geneus)
add_dependencies(aro_msgs_geneus aro_msgs_generate_messages_eus)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS aro_msgs_generate_messages_eus)

### Section generating for lang: genlisp
### Generating Messages
_generate_msg_lisp(aro_msgs
  "/home/vivek/Documents/ROS/hw04/src/aro_frontier/aro_msgs/msg/Path.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Pose.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/PoseStamped.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/aro_msgs
)
_generate_msg_lisp(aro_msgs
  "/home/vivek/Documents/ROS/hw04/devel/share/aro_msgs/msg/FollowPathAction.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalID.msg;/home/vivek/Documents/ROS/hw04/devel/share/aro_msgs/msg/FollowPathGoal.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg;/home/vivek/Documents/ROS/hw04/devel/share/aro_msgs/msg/FollowPathActionGoal.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/home/vivek/Documents/ROS/hw04/devel/share/aro_msgs/msg/FollowPathActionFeedback.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Pose.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Pose2D.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/PoseStamped.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalStatus.msg;/home/vivek/Documents/ROS/hw04/devel/share/aro_msgs/msg/FollowPathFeedback.msg;/home/vivek/Documents/ROS/hw04/devel/share/aro_msgs/msg/FollowPathActionResult.msg;/home/vivek/Documents/ROS/hw04/devel/share/aro_msgs/msg/FollowPathResult.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/aro_msgs
)
_generate_msg_lisp(aro_msgs
  "/home/vivek/Documents/ROS/hw04/devel/share/aro_msgs/msg/FollowPathActionGoal.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalID.msg;/home/vivek/Documents/ROS/hw04/devel/share/aro_msgs/msg/FollowPathGoal.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Pose.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/PoseStamped.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/aro_msgs
)
_generate_msg_lisp(aro_msgs
  "/home/vivek/Documents/ROS/hw04/devel/share/aro_msgs/msg/FollowPathActionResult.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalID.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Pose2D.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalStatus.msg;/home/vivek/Documents/ROS/hw04/devel/share/aro_msgs/msg/FollowPathResult.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/aro_msgs
)
_generate_msg_lisp(aro_msgs
  "/home/vivek/Documents/ROS/hw04/devel/share/aro_msgs/msg/FollowPathActionFeedback.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalID.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Pose2D.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalStatus.msg;/home/vivek/Documents/ROS/hw04/devel/share/aro_msgs/msg/FollowPathFeedback.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/aro_msgs
)
_generate_msg_lisp(aro_msgs
  "/home/vivek/Documents/ROS/hw04/devel/share/aro_msgs/msg/FollowPathGoal.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Pose.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/PoseStamped.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/aro_msgs
)
_generate_msg_lisp(aro_msgs
  "/home/vivek/Documents/ROS/hw04/devel/share/aro_msgs/msg/FollowPathResult.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Pose2D.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/aro_msgs
)
_generate_msg_lisp(aro_msgs
  "/home/vivek/Documents/ROS/hw04/devel/share/aro_msgs/msg/FollowPathFeedback.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Pose2D.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/aro_msgs
)

### Generating Services
_generate_srv_lisp(aro_msgs
  "/home/vivek/Documents/ROS/hw04/src/aro_frontier/aro_msgs/srv/GenerateFrontier.srv"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Pose2D.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/aro_msgs
)
_generate_srv_lisp(aro_msgs
  "/home/vivek/Documents/ROS/hw04/src/aro_frontier/aro_msgs/srv/PlanPath.srv"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Pose2D.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/aro_msgs
)

### Generating Module File
_generate_module_lisp(aro_msgs
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/aro_msgs
  "${ALL_GEN_OUTPUT_FILES_lisp}"
)

add_custom_target(aro_msgs_generate_messages_lisp
  DEPENDS ${ALL_GEN_OUTPUT_FILES_lisp}
)
add_dependencies(aro_msgs_generate_messages aro_msgs_generate_messages_lisp)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/vivek/Documents/ROS/hw04/src/aro_frontier/aro_msgs/msg/Path.msg" NAME_WE)
add_dependencies(aro_msgs_generate_messages_lisp _aro_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/vivek/Documents/ROS/hw04/devel/share/aro_msgs/msg/FollowPathAction.msg" NAME_WE)
add_dependencies(aro_msgs_generate_messages_lisp _aro_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/vivek/Documents/ROS/hw04/devel/share/aro_msgs/msg/FollowPathActionGoal.msg" NAME_WE)
add_dependencies(aro_msgs_generate_messages_lisp _aro_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/vivek/Documents/ROS/hw04/devel/share/aro_msgs/msg/FollowPathActionResult.msg" NAME_WE)
add_dependencies(aro_msgs_generate_messages_lisp _aro_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/vivek/Documents/ROS/hw04/devel/share/aro_msgs/msg/FollowPathActionFeedback.msg" NAME_WE)
add_dependencies(aro_msgs_generate_messages_lisp _aro_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/vivek/Documents/ROS/hw04/devel/share/aro_msgs/msg/FollowPathGoal.msg" NAME_WE)
add_dependencies(aro_msgs_generate_messages_lisp _aro_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/vivek/Documents/ROS/hw04/devel/share/aro_msgs/msg/FollowPathResult.msg" NAME_WE)
add_dependencies(aro_msgs_generate_messages_lisp _aro_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/vivek/Documents/ROS/hw04/devel/share/aro_msgs/msg/FollowPathFeedback.msg" NAME_WE)
add_dependencies(aro_msgs_generate_messages_lisp _aro_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/vivek/Documents/ROS/hw04/src/aro_frontier/aro_msgs/srv/GenerateFrontier.srv" NAME_WE)
add_dependencies(aro_msgs_generate_messages_lisp _aro_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/vivek/Documents/ROS/hw04/src/aro_frontier/aro_msgs/srv/PlanPath.srv" NAME_WE)
add_dependencies(aro_msgs_generate_messages_lisp _aro_msgs_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(aro_msgs_genlisp)
add_dependencies(aro_msgs_genlisp aro_msgs_generate_messages_lisp)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS aro_msgs_generate_messages_lisp)

### Section generating for lang: gennodejs
### Generating Messages
_generate_msg_nodejs(aro_msgs
  "/home/vivek/Documents/ROS/hw04/src/aro_frontier/aro_msgs/msg/Path.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Pose.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/PoseStamped.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/aro_msgs
)
_generate_msg_nodejs(aro_msgs
  "/home/vivek/Documents/ROS/hw04/devel/share/aro_msgs/msg/FollowPathAction.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalID.msg;/home/vivek/Documents/ROS/hw04/devel/share/aro_msgs/msg/FollowPathGoal.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg;/home/vivek/Documents/ROS/hw04/devel/share/aro_msgs/msg/FollowPathActionGoal.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/home/vivek/Documents/ROS/hw04/devel/share/aro_msgs/msg/FollowPathActionFeedback.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Pose.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Pose2D.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/PoseStamped.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalStatus.msg;/home/vivek/Documents/ROS/hw04/devel/share/aro_msgs/msg/FollowPathFeedback.msg;/home/vivek/Documents/ROS/hw04/devel/share/aro_msgs/msg/FollowPathActionResult.msg;/home/vivek/Documents/ROS/hw04/devel/share/aro_msgs/msg/FollowPathResult.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/aro_msgs
)
_generate_msg_nodejs(aro_msgs
  "/home/vivek/Documents/ROS/hw04/devel/share/aro_msgs/msg/FollowPathActionGoal.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalID.msg;/home/vivek/Documents/ROS/hw04/devel/share/aro_msgs/msg/FollowPathGoal.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Pose.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/PoseStamped.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/aro_msgs
)
_generate_msg_nodejs(aro_msgs
  "/home/vivek/Documents/ROS/hw04/devel/share/aro_msgs/msg/FollowPathActionResult.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalID.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Pose2D.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalStatus.msg;/home/vivek/Documents/ROS/hw04/devel/share/aro_msgs/msg/FollowPathResult.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/aro_msgs
)
_generate_msg_nodejs(aro_msgs
  "/home/vivek/Documents/ROS/hw04/devel/share/aro_msgs/msg/FollowPathActionFeedback.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalID.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Pose2D.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalStatus.msg;/home/vivek/Documents/ROS/hw04/devel/share/aro_msgs/msg/FollowPathFeedback.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/aro_msgs
)
_generate_msg_nodejs(aro_msgs
  "/home/vivek/Documents/ROS/hw04/devel/share/aro_msgs/msg/FollowPathGoal.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Pose.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/PoseStamped.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/aro_msgs
)
_generate_msg_nodejs(aro_msgs
  "/home/vivek/Documents/ROS/hw04/devel/share/aro_msgs/msg/FollowPathResult.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Pose2D.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/aro_msgs
)
_generate_msg_nodejs(aro_msgs
  "/home/vivek/Documents/ROS/hw04/devel/share/aro_msgs/msg/FollowPathFeedback.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Pose2D.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/aro_msgs
)

### Generating Services
_generate_srv_nodejs(aro_msgs
  "/home/vivek/Documents/ROS/hw04/src/aro_frontier/aro_msgs/srv/GenerateFrontier.srv"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Pose2D.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/aro_msgs
)
_generate_srv_nodejs(aro_msgs
  "/home/vivek/Documents/ROS/hw04/src/aro_frontier/aro_msgs/srv/PlanPath.srv"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Pose2D.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/aro_msgs
)

### Generating Module File
_generate_module_nodejs(aro_msgs
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/aro_msgs
  "${ALL_GEN_OUTPUT_FILES_nodejs}"
)

add_custom_target(aro_msgs_generate_messages_nodejs
  DEPENDS ${ALL_GEN_OUTPUT_FILES_nodejs}
)
add_dependencies(aro_msgs_generate_messages aro_msgs_generate_messages_nodejs)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/vivek/Documents/ROS/hw04/src/aro_frontier/aro_msgs/msg/Path.msg" NAME_WE)
add_dependencies(aro_msgs_generate_messages_nodejs _aro_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/vivek/Documents/ROS/hw04/devel/share/aro_msgs/msg/FollowPathAction.msg" NAME_WE)
add_dependencies(aro_msgs_generate_messages_nodejs _aro_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/vivek/Documents/ROS/hw04/devel/share/aro_msgs/msg/FollowPathActionGoal.msg" NAME_WE)
add_dependencies(aro_msgs_generate_messages_nodejs _aro_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/vivek/Documents/ROS/hw04/devel/share/aro_msgs/msg/FollowPathActionResult.msg" NAME_WE)
add_dependencies(aro_msgs_generate_messages_nodejs _aro_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/vivek/Documents/ROS/hw04/devel/share/aro_msgs/msg/FollowPathActionFeedback.msg" NAME_WE)
add_dependencies(aro_msgs_generate_messages_nodejs _aro_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/vivek/Documents/ROS/hw04/devel/share/aro_msgs/msg/FollowPathGoal.msg" NAME_WE)
add_dependencies(aro_msgs_generate_messages_nodejs _aro_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/vivek/Documents/ROS/hw04/devel/share/aro_msgs/msg/FollowPathResult.msg" NAME_WE)
add_dependencies(aro_msgs_generate_messages_nodejs _aro_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/vivek/Documents/ROS/hw04/devel/share/aro_msgs/msg/FollowPathFeedback.msg" NAME_WE)
add_dependencies(aro_msgs_generate_messages_nodejs _aro_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/vivek/Documents/ROS/hw04/src/aro_frontier/aro_msgs/srv/GenerateFrontier.srv" NAME_WE)
add_dependencies(aro_msgs_generate_messages_nodejs _aro_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/vivek/Documents/ROS/hw04/src/aro_frontier/aro_msgs/srv/PlanPath.srv" NAME_WE)
add_dependencies(aro_msgs_generate_messages_nodejs _aro_msgs_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(aro_msgs_gennodejs)
add_dependencies(aro_msgs_gennodejs aro_msgs_generate_messages_nodejs)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS aro_msgs_generate_messages_nodejs)

### Section generating for lang: genpy
### Generating Messages
_generate_msg_py(aro_msgs
  "/home/vivek/Documents/ROS/hw04/src/aro_frontier/aro_msgs/msg/Path.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Pose.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/PoseStamped.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/aro_msgs
)
_generate_msg_py(aro_msgs
  "/home/vivek/Documents/ROS/hw04/devel/share/aro_msgs/msg/FollowPathAction.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalID.msg;/home/vivek/Documents/ROS/hw04/devel/share/aro_msgs/msg/FollowPathGoal.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg;/home/vivek/Documents/ROS/hw04/devel/share/aro_msgs/msg/FollowPathActionGoal.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/home/vivek/Documents/ROS/hw04/devel/share/aro_msgs/msg/FollowPathActionFeedback.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Pose.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Pose2D.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/PoseStamped.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalStatus.msg;/home/vivek/Documents/ROS/hw04/devel/share/aro_msgs/msg/FollowPathFeedback.msg;/home/vivek/Documents/ROS/hw04/devel/share/aro_msgs/msg/FollowPathActionResult.msg;/home/vivek/Documents/ROS/hw04/devel/share/aro_msgs/msg/FollowPathResult.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/aro_msgs
)
_generate_msg_py(aro_msgs
  "/home/vivek/Documents/ROS/hw04/devel/share/aro_msgs/msg/FollowPathActionGoal.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalID.msg;/home/vivek/Documents/ROS/hw04/devel/share/aro_msgs/msg/FollowPathGoal.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Pose.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/PoseStamped.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/aro_msgs
)
_generate_msg_py(aro_msgs
  "/home/vivek/Documents/ROS/hw04/devel/share/aro_msgs/msg/FollowPathActionResult.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalID.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Pose2D.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalStatus.msg;/home/vivek/Documents/ROS/hw04/devel/share/aro_msgs/msg/FollowPathResult.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/aro_msgs
)
_generate_msg_py(aro_msgs
  "/home/vivek/Documents/ROS/hw04/devel/share/aro_msgs/msg/FollowPathActionFeedback.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalID.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Pose2D.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalStatus.msg;/home/vivek/Documents/ROS/hw04/devel/share/aro_msgs/msg/FollowPathFeedback.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/aro_msgs
)
_generate_msg_py(aro_msgs
  "/home/vivek/Documents/ROS/hw04/devel/share/aro_msgs/msg/FollowPathGoal.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Pose.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/PoseStamped.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/aro_msgs
)
_generate_msg_py(aro_msgs
  "/home/vivek/Documents/ROS/hw04/devel/share/aro_msgs/msg/FollowPathResult.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Pose2D.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/aro_msgs
)
_generate_msg_py(aro_msgs
  "/home/vivek/Documents/ROS/hw04/devel/share/aro_msgs/msg/FollowPathFeedback.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Pose2D.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/aro_msgs
)

### Generating Services
_generate_srv_py(aro_msgs
  "/home/vivek/Documents/ROS/hw04/src/aro_frontier/aro_msgs/srv/GenerateFrontier.srv"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Pose2D.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/aro_msgs
)
_generate_srv_py(aro_msgs
  "/home/vivek/Documents/ROS/hw04/src/aro_frontier/aro_msgs/srv/PlanPath.srv"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Pose2D.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/aro_msgs
)

### Generating Module File
_generate_module_py(aro_msgs
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/aro_msgs
  "${ALL_GEN_OUTPUT_FILES_py}"
)

add_custom_target(aro_msgs_generate_messages_py
  DEPENDS ${ALL_GEN_OUTPUT_FILES_py}
)
add_dependencies(aro_msgs_generate_messages aro_msgs_generate_messages_py)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/vivek/Documents/ROS/hw04/src/aro_frontier/aro_msgs/msg/Path.msg" NAME_WE)
add_dependencies(aro_msgs_generate_messages_py _aro_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/vivek/Documents/ROS/hw04/devel/share/aro_msgs/msg/FollowPathAction.msg" NAME_WE)
add_dependencies(aro_msgs_generate_messages_py _aro_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/vivek/Documents/ROS/hw04/devel/share/aro_msgs/msg/FollowPathActionGoal.msg" NAME_WE)
add_dependencies(aro_msgs_generate_messages_py _aro_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/vivek/Documents/ROS/hw04/devel/share/aro_msgs/msg/FollowPathActionResult.msg" NAME_WE)
add_dependencies(aro_msgs_generate_messages_py _aro_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/vivek/Documents/ROS/hw04/devel/share/aro_msgs/msg/FollowPathActionFeedback.msg" NAME_WE)
add_dependencies(aro_msgs_generate_messages_py _aro_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/vivek/Documents/ROS/hw04/devel/share/aro_msgs/msg/FollowPathGoal.msg" NAME_WE)
add_dependencies(aro_msgs_generate_messages_py _aro_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/vivek/Documents/ROS/hw04/devel/share/aro_msgs/msg/FollowPathResult.msg" NAME_WE)
add_dependencies(aro_msgs_generate_messages_py _aro_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/vivek/Documents/ROS/hw04/devel/share/aro_msgs/msg/FollowPathFeedback.msg" NAME_WE)
add_dependencies(aro_msgs_generate_messages_py _aro_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/vivek/Documents/ROS/hw04/src/aro_frontier/aro_msgs/srv/GenerateFrontier.srv" NAME_WE)
add_dependencies(aro_msgs_generate_messages_py _aro_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/vivek/Documents/ROS/hw04/src/aro_frontier/aro_msgs/srv/PlanPath.srv" NAME_WE)
add_dependencies(aro_msgs_generate_messages_py _aro_msgs_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(aro_msgs_genpy)
add_dependencies(aro_msgs_genpy aro_msgs_generate_messages_py)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS aro_msgs_generate_messages_py)



if(gencpp_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/aro_msgs)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/aro_msgs
    DESTINATION ${gencpp_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_cpp)
  add_dependencies(aro_msgs_generate_messages_cpp std_msgs_generate_messages_cpp)
endif()
if(TARGET geometry_msgs_generate_messages_cpp)
  add_dependencies(aro_msgs_generate_messages_cpp geometry_msgs_generate_messages_cpp)
endif()
if(TARGET actionlib_msgs_generate_messages_cpp)
  add_dependencies(aro_msgs_generate_messages_cpp actionlib_msgs_generate_messages_cpp)
endif()

if(geneus_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/aro_msgs)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/aro_msgs
    DESTINATION ${geneus_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_eus)
  add_dependencies(aro_msgs_generate_messages_eus std_msgs_generate_messages_eus)
endif()
if(TARGET geometry_msgs_generate_messages_eus)
  add_dependencies(aro_msgs_generate_messages_eus geometry_msgs_generate_messages_eus)
endif()
if(TARGET actionlib_msgs_generate_messages_eus)
  add_dependencies(aro_msgs_generate_messages_eus actionlib_msgs_generate_messages_eus)
endif()

if(genlisp_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/aro_msgs)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/aro_msgs
    DESTINATION ${genlisp_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_lisp)
  add_dependencies(aro_msgs_generate_messages_lisp std_msgs_generate_messages_lisp)
endif()
if(TARGET geometry_msgs_generate_messages_lisp)
  add_dependencies(aro_msgs_generate_messages_lisp geometry_msgs_generate_messages_lisp)
endif()
if(TARGET actionlib_msgs_generate_messages_lisp)
  add_dependencies(aro_msgs_generate_messages_lisp actionlib_msgs_generate_messages_lisp)
endif()

if(gennodejs_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/aro_msgs)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/aro_msgs
    DESTINATION ${gennodejs_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_nodejs)
  add_dependencies(aro_msgs_generate_messages_nodejs std_msgs_generate_messages_nodejs)
endif()
if(TARGET geometry_msgs_generate_messages_nodejs)
  add_dependencies(aro_msgs_generate_messages_nodejs geometry_msgs_generate_messages_nodejs)
endif()
if(TARGET actionlib_msgs_generate_messages_nodejs)
  add_dependencies(aro_msgs_generate_messages_nodejs actionlib_msgs_generate_messages_nodejs)
endif()

if(genpy_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/aro_msgs)
  install(CODE "execute_process(COMMAND \"/usr/bin/python3\" -m compileall \"${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/aro_msgs\")")
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/aro_msgs
    DESTINATION ${genpy_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_py)
  add_dependencies(aro_msgs_generate_messages_py std_msgs_generate_messages_py)
endif()
if(TARGET geometry_msgs_generate_messages_py)
  add_dependencies(aro_msgs_generate_messages_py geometry_msgs_generate_messages_py)
endif()
if(TARGET actionlib_msgs_generate_messages_py)
  add_dependencies(aro_msgs_generate_messages_py actionlib_msgs_generate_messages_py)
endif()
