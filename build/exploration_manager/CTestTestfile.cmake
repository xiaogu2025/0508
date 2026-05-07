# CMake generated Testfile for 
# Source directory: /home/xiaogu/myproject/rosNavigation_ws/src/fast_multi_robot_exploration-master/swarm_exploration/exploration_manager
# Build directory: /home/xiaogu/myproject/rosNavigation_ws/build/exploration_manager
# 
# This file includes the relevant testing commands required for 
# testing this directory and lists subdirectories to be tested as well.
add_test(_ctest_exploration_manager_gtest_test_collaboration_cost "/home/xiaogu/myproject/rosNavigation_ws/build/exploration_manager/catkin_generated/env_cached.sh" "/usr/bin/python3" "/opt/ros/noetic/share/catkin/cmake/test/run_tests.py" "/home/xiaogu/myproject/rosNavigation_ws/build/exploration_manager/test_results/exploration_manager/gtest-test_collaboration_cost.xml" "--return-code" "/home/xiaogu/myproject/rosNavigation_ws/devel/.private/exploration_manager/lib/exploration_manager/test_collaboration_cost --gtest_output=xml:/home/xiaogu/myproject/rosNavigation_ws/build/exploration_manager/test_results/exploration_manager/gtest-test_collaboration_cost.xml")
set_tests_properties(_ctest_exploration_manager_gtest_test_collaboration_cost PROPERTIES  _BACKTRACE_TRIPLES "/opt/ros/noetic/share/catkin/cmake/test/tests.cmake;160;add_test;/opt/ros/noetic/share/catkin/cmake/test/gtest.cmake;98;catkin_run_tests_target;/opt/ros/noetic/share/catkin/cmake/test/gtest.cmake;37;_catkin_add_google_test;/home/xiaogu/myproject/rosNavigation_ws/src/fast_multi_robot_exploration-master/swarm_exploration/exploration_manager/CMakeLists.txt;100;catkin_add_gtest;/home/xiaogu/myproject/rosNavigation_ws/src/fast_multi_robot_exploration-master/swarm_exploration/exploration_manager/CMakeLists.txt;0;")
subdirs("gtest")
