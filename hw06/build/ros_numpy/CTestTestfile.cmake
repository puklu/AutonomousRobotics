# CMake generated Testfile for 
# Source directory: /home/vivek/Documents/ROS/hw06/src/aro_hw06/ros_numpy
# Build directory: /home/vivek/Documents/ROS/hw06/build/ros_numpy
# 
# This file includes the relevant testing commands required for 
# testing this directory and lists subdirectories to be tested as well.
add_test(_ctest_ros_numpy_nosetests_test "/home/vivek/Documents/ROS/hw06/build/ros_numpy/catkin_generated/env_cached.sh" "/usr/bin/python3" "/opt/ros/noetic/share/catkin/cmake/test/run_tests.py" "/home/vivek/Documents/ROS/hw06/build/ros_numpy/test_results/ros_numpy/nosetests-test.xml" "--return-code" "\"/usr/bin/cmake\" -E make_directory /home/vivek/Documents/ROS/hw06/build/ros_numpy/test_results/ros_numpy" "/usr/bin/nosetests3 -P --process-timeout=60 --where=/home/vivek/Documents/ROS/hw06/src/aro_hw06/ros_numpy/test --with-xunit --xunit-file=/home/vivek/Documents/ROS/hw06/build/ros_numpy/test_results/ros_numpy/nosetests-test.xml")
set_tests_properties(_ctest_ros_numpy_nosetests_test PROPERTIES  _BACKTRACE_TRIPLES "/opt/ros/noetic/share/catkin/cmake/test/tests.cmake;160;add_test;/opt/ros/noetic/share/catkin/cmake/test/nosetests.cmake;83;catkin_run_tests_target;/home/vivek/Documents/ROS/hw06/src/aro_hw06/ros_numpy/CMakeLists.txt;182;catkin_add_nosetests;/home/vivek/Documents/ROS/hw06/src/aro_hw06/ros_numpy/CMakeLists.txt;0;")
subdirs("gtest")
