execute_process(COMMAND "/home/vivek/Documents/ROS/sw01/build/aro_evaluathor/catkin_generated/python_distutils_install.sh" RESULT_VARIABLE res)

if(NOT res EQUAL 0)
  message(FATAL_ERROR "execute_process(/home/vivek/Documents/ROS/sw01/build/aro_evaluathor/catkin_generated/python_distutils_install.sh) returned error code ")
endif()