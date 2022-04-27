# Install script for directory: /home/vivek/Documents/ROS/hw04/src/aro_frontier/aro_msgs

# Set the install prefix
if(NOT DEFINED CMAKE_INSTALL_PREFIX)
  set(CMAKE_INSTALL_PREFIX "/home/vivek/Documents/ROS/hw04/install")
endif()
string(REGEX REPLACE "/$" "" CMAKE_INSTALL_PREFIX "${CMAKE_INSTALL_PREFIX}")

# Set the install configuration name.
if(NOT DEFINED CMAKE_INSTALL_CONFIG_NAME)
  if(BUILD_TYPE)
    string(REGEX REPLACE "^[^A-Za-z0-9_]+" ""
           CMAKE_INSTALL_CONFIG_NAME "${BUILD_TYPE}")
  else()
    set(CMAKE_INSTALL_CONFIG_NAME "")
  endif()
  message(STATUS "Install configuration: \"${CMAKE_INSTALL_CONFIG_NAME}\"")
endif()

# Set the component getting installed.
if(NOT CMAKE_INSTALL_COMPONENT)
  if(COMPONENT)
    message(STATUS "Install component: \"${COMPONENT}\"")
    set(CMAKE_INSTALL_COMPONENT "${COMPONENT}")
  else()
    set(CMAKE_INSTALL_COMPONENT)
  endif()
endif()

# Install shared libraries without execute permission?
if(NOT DEFINED CMAKE_INSTALL_SO_NO_EXE)
  set(CMAKE_INSTALL_SO_NO_EXE "1")
endif()

# Is this installation the result of a crosscompile?
if(NOT DEFINED CMAKE_CROSSCOMPILING)
  set(CMAKE_CROSSCOMPILING "FALSE")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/aro_msgs/msg" TYPE FILE FILES "/home/vivek/Documents/ROS/hw04/src/aro_frontier/aro_msgs/msg/Path.msg")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/aro_msgs/srv" TYPE FILE FILES
    "/home/vivek/Documents/ROS/hw04/src/aro_frontier/aro_msgs/srv/GenerateFrontier.srv"
    "/home/vivek/Documents/ROS/hw04/src/aro_frontier/aro_msgs/srv/PlanPath.srv"
    )
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/aro_msgs/action" TYPE FILE FILES "/home/vivek/Documents/ROS/hw04/src/aro_frontier/aro_msgs/action/FollowPath.action")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/aro_msgs/msg" TYPE FILE FILES
    "/home/vivek/Documents/ROS/hw04/devel/share/aro_msgs/msg/FollowPathAction.msg"
    "/home/vivek/Documents/ROS/hw04/devel/share/aro_msgs/msg/FollowPathActionGoal.msg"
    "/home/vivek/Documents/ROS/hw04/devel/share/aro_msgs/msg/FollowPathActionResult.msg"
    "/home/vivek/Documents/ROS/hw04/devel/share/aro_msgs/msg/FollowPathActionFeedback.msg"
    "/home/vivek/Documents/ROS/hw04/devel/share/aro_msgs/msg/FollowPathGoal.msg"
    "/home/vivek/Documents/ROS/hw04/devel/share/aro_msgs/msg/FollowPathResult.msg"
    "/home/vivek/Documents/ROS/hw04/devel/share/aro_msgs/msg/FollowPathFeedback.msg"
    )
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/aro_msgs/cmake" TYPE FILE FILES "/home/vivek/Documents/ROS/hw04/build/aro_frontier/aro_msgs/catkin_generated/installspace/aro_msgs-msg-paths.cmake")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include" TYPE DIRECTORY FILES "/home/vivek/Documents/ROS/hw04/devel/include/aro_msgs")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/roseus/ros" TYPE DIRECTORY FILES "/home/vivek/Documents/ROS/hw04/devel/share/roseus/ros/aro_msgs")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/common-lisp/ros" TYPE DIRECTORY FILES "/home/vivek/Documents/ROS/hw04/devel/share/common-lisp/ros/aro_msgs")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/gennodejs/ros" TYPE DIRECTORY FILES "/home/vivek/Documents/ROS/hw04/devel/share/gennodejs/ros/aro_msgs")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  execute_process(COMMAND "/usr/bin/python3" -m compileall "/home/vivek/Documents/ROS/hw04/devel/lib/python3/dist-packages/aro_msgs")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/python3/dist-packages" TYPE DIRECTORY FILES "/home/vivek/Documents/ROS/hw04/devel/lib/python3/dist-packages/aro_msgs")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/pkgconfig" TYPE FILE FILES "/home/vivek/Documents/ROS/hw04/build/aro_frontier/aro_msgs/catkin_generated/installspace/aro_msgs.pc")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/aro_msgs/cmake" TYPE FILE FILES "/home/vivek/Documents/ROS/hw04/build/aro_frontier/aro_msgs/catkin_generated/installspace/aro_msgs-msg-extras.cmake")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/aro_msgs/cmake" TYPE FILE FILES
    "/home/vivek/Documents/ROS/hw04/build/aro_frontier/aro_msgs/catkin_generated/installspace/aro_msgsConfig.cmake"
    "/home/vivek/Documents/ROS/hw04/build/aro_frontier/aro_msgs/catkin_generated/installspace/aro_msgsConfig-version.cmake"
    )
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/aro_msgs" TYPE FILE FILES "/home/vivek/Documents/ROS/hw04/src/aro_frontier/aro_msgs/package.xml")
endif()

