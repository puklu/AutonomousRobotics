execute_process(COMMAND "/home/vivek/Documents/ROS/hw04/build/aro_frontier/aro_frontier/catkin_generated/python_distutils_install.sh" RESULT_VARIABLE res)

if(NOT res EQUAL 0)
  message(FATAL_ERROR "execute_process(/home/vivek/Documents/ROS/hw04/build/aro_frontier/aro_frontier/catkin_generated/python_distutils_install.sh) returned error code ")
endif()
