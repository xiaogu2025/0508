# generated from genmsg/cmake/pkg-genmsg.cmake.em

message(STATUS "exploration_manager: 5 messages, 0 services")

set(MSG_I_FLAGS "-Iexploration_manager:/home/xiaogu/myproject/rosNavigation_ws/src/fast_multi_robot_exploration-master/swarm_exploration/exploration_manager/msg;-Igeometry_msgs:/opt/ros/noetic/share/geometry_msgs/cmake/../msg;-Istd_msgs:/opt/ros/noetic/share/std_msgs/cmake/../msg")

# Find all generators
find_package(gencpp REQUIRED)
find_package(geneus REQUIRED)
find_package(genlisp REQUIRED)
find_package(gennodejs REQUIRED)
find_package(genpy REQUIRED)

add_custom_target(exploration_manager_generate_messages ALL)

# verify that message/service dependencies have not changed since configure



get_filename_component(_filename "/home/xiaogu/myproject/rosNavigation_ws/src/fast_multi_robot_exploration-master/swarm_exploration/exploration_manager/msg/DroneState.msg" NAME_WE)
add_custom_target(_exploration_manager_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "exploration_manager" "/home/xiaogu/myproject/rosNavigation_ws/src/fast_multi_robot_exploration-master/swarm_exploration/exploration_manager/msg/DroneState.msg" "geometry_msgs/Point"
)

get_filename_component(_filename "/home/xiaogu/myproject/rosNavigation_ws/src/fast_multi_robot_exploration-master/swarm_exploration/exploration_manager/msg/PairOpt.msg" NAME_WE)
add_custom_target(_exploration_manager_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "exploration_manager" "/home/xiaogu/myproject/rosNavigation_ws/src/fast_multi_robot_exploration-master/swarm_exploration/exploration_manager/msg/PairOpt.msg" "geometry_msgs/Point"
)

get_filename_component(_filename "/home/xiaogu/myproject/rosNavigation_ws/src/fast_multi_robot_exploration-master/swarm_exploration/exploration_manager/msg/PairOptResponse.msg" NAME_WE)
add_custom_target(_exploration_manager_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "exploration_manager" "/home/xiaogu/myproject/rosNavigation_ws/src/fast_multi_robot_exploration-master/swarm_exploration/exploration_manager/msg/PairOptResponse.msg" ""
)

get_filename_component(_filename "/home/xiaogu/myproject/rosNavigation_ws/src/fast_multi_robot_exploration-master/swarm_exploration/exploration_manager/msg/HGrid.msg" NAME_WE)
add_custom_target(_exploration_manager_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "exploration_manager" "/home/xiaogu/myproject/rosNavigation_ws/src/fast_multi_robot_exploration-master/swarm_exploration/exploration_manager/msg/HGrid.msg" "geometry_msgs/Point"
)

get_filename_component(_filename "/home/xiaogu/myproject/rosNavigation_ws/src/fast_multi_robot_exploration-master/swarm_exploration/exploration_manager/msg/GridTour.msg" NAME_WE)
add_custom_target(_exploration_manager_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "exploration_manager" "/home/xiaogu/myproject/rosNavigation_ws/src/fast_multi_robot_exploration-master/swarm_exploration/exploration_manager/msg/GridTour.msg" "geometry_msgs/Point"
)

#
#  langs = gencpp;geneus;genlisp;gennodejs;genpy
#

### Section generating for lang: gencpp
### Generating Messages
_generate_msg_cpp(exploration_manager
  "/home/xiaogu/myproject/rosNavigation_ws/src/fast_multi_robot_exploration-master/swarm_exploration/exploration_manager/msg/DroneState.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/exploration_manager
)
_generate_msg_cpp(exploration_manager
  "/home/xiaogu/myproject/rosNavigation_ws/src/fast_multi_robot_exploration-master/swarm_exploration/exploration_manager/msg/PairOpt.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/exploration_manager
)
_generate_msg_cpp(exploration_manager
  "/home/xiaogu/myproject/rosNavigation_ws/src/fast_multi_robot_exploration-master/swarm_exploration/exploration_manager/msg/PairOptResponse.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/exploration_manager
)
_generate_msg_cpp(exploration_manager
  "/home/xiaogu/myproject/rosNavigation_ws/src/fast_multi_robot_exploration-master/swarm_exploration/exploration_manager/msg/HGrid.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/exploration_manager
)
_generate_msg_cpp(exploration_manager
  "/home/xiaogu/myproject/rosNavigation_ws/src/fast_multi_robot_exploration-master/swarm_exploration/exploration_manager/msg/GridTour.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/exploration_manager
)

### Generating Services

### Generating Module File
_generate_module_cpp(exploration_manager
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/exploration_manager
  "${ALL_GEN_OUTPUT_FILES_cpp}"
)

add_custom_target(exploration_manager_generate_messages_cpp
  DEPENDS ${ALL_GEN_OUTPUT_FILES_cpp}
)
add_dependencies(exploration_manager_generate_messages exploration_manager_generate_messages_cpp)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/xiaogu/myproject/rosNavigation_ws/src/fast_multi_robot_exploration-master/swarm_exploration/exploration_manager/msg/DroneState.msg" NAME_WE)
add_dependencies(exploration_manager_generate_messages_cpp _exploration_manager_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/xiaogu/myproject/rosNavigation_ws/src/fast_multi_robot_exploration-master/swarm_exploration/exploration_manager/msg/PairOpt.msg" NAME_WE)
add_dependencies(exploration_manager_generate_messages_cpp _exploration_manager_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/xiaogu/myproject/rosNavigation_ws/src/fast_multi_robot_exploration-master/swarm_exploration/exploration_manager/msg/PairOptResponse.msg" NAME_WE)
add_dependencies(exploration_manager_generate_messages_cpp _exploration_manager_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/xiaogu/myproject/rosNavigation_ws/src/fast_multi_robot_exploration-master/swarm_exploration/exploration_manager/msg/HGrid.msg" NAME_WE)
add_dependencies(exploration_manager_generate_messages_cpp _exploration_manager_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/xiaogu/myproject/rosNavigation_ws/src/fast_multi_robot_exploration-master/swarm_exploration/exploration_manager/msg/GridTour.msg" NAME_WE)
add_dependencies(exploration_manager_generate_messages_cpp _exploration_manager_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(exploration_manager_gencpp)
add_dependencies(exploration_manager_gencpp exploration_manager_generate_messages_cpp)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS exploration_manager_generate_messages_cpp)

### Section generating for lang: geneus
### Generating Messages
_generate_msg_eus(exploration_manager
  "/home/xiaogu/myproject/rosNavigation_ws/src/fast_multi_robot_exploration-master/swarm_exploration/exploration_manager/msg/DroneState.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/exploration_manager
)
_generate_msg_eus(exploration_manager
  "/home/xiaogu/myproject/rosNavigation_ws/src/fast_multi_robot_exploration-master/swarm_exploration/exploration_manager/msg/PairOpt.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/exploration_manager
)
_generate_msg_eus(exploration_manager
  "/home/xiaogu/myproject/rosNavigation_ws/src/fast_multi_robot_exploration-master/swarm_exploration/exploration_manager/msg/PairOptResponse.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/exploration_manager
)
_generate_msg_eus(exploration_manager
  "/home/xiaogu/myproject/rosNavigation_ws/src/fast_multi_robot_exploration-master/swarm_exploration/exploration_manager/msg/HGrid.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/exploration_manager
)
_generate_msg_eus(exploration_manager
  "/home/xiaogu/myproject/rosNavigation_ws/src/fast_multi_robot_exploration-master/swarm_exploration/exploration_manager/msg/GridTour.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/exploration_manager
)

### Generating Services

### Generating Module File
_generate_module_eus(exploration_manager
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/exploration_manager
  "${ALL_GEN_OUTPUT_FILES_eus}"
)

add_custom_target(exploration_manager_generate_messages_eus
  DEPENDS ${ALL_GEN_OUTPUT_FILES_eus}
)
add_dependencies(exploration_manager_generate_messages exploration_manager_generate_messages_eus)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/xiaogu/myproject/rosNavigation_ws/src/fast_multi_robot_exploration-master/swarm_exploration/exploration_manager/msg/DroneState.msg" NAME_WE)
add_dependencies(exploration_manager_generate_messages_eus _exploration_manager_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/xiaogu/myproject/rosNavigation_ws/src/fast_multi_robot_exploration-master/swarm_exploration/exploration_manager/msg/PairOpt.msg" NAME_WE)
add_dependencies(exploration_manager_generate_messages_eus _exploration_manager_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/xiaogu/myproject/rosNavigation_ws/src/fast_multi_robot_exploration-master/swarm_exploration/exploration_manager/msg/PairOptResponse.msg" NAME_WE)
add_dependencies(exploration_manager_generate_messages_eus _exploration_manager_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/xiaogu/myproject/rosNavigation_ws/src/fast_multi_robot_exploration-master/swarm_exploration/exploration_manager/msg/HGrid.msg" NAME_WE)
add_dependencies(exploration_manager_generate_messages_eus _exploration_manager_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/xiaogu/myproject/rosNavigation_ws/src/fast_multi_robot_exploration-master/swarm_exploration/exploration_manager/msg/GridTour.msg" NAME_WE)
add_dependencies(exploration_manager_generate_messages_eus _exploration_manager_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(exploration_manager_geneus)
add_dependencies(exploration_manager_geneus exploration_manager_generate_messages_eus)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS exploration_manager_generate_messages_eus)

### Section generating for lang: genlisp
### Generating Messages
_generate_msg_lisp(exploration_manager
  "/home/xiaogu/myproject/rosNavigation_ws/src/fast_multi_robot_exploration-master/swarm_exploration/exploration_manager/msg/DroneState.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/exploration_manager
)
_generate_msg_lisp(exploration_manager
  "/home/xiaogu/myproject/rosNavigation_ws/src/fast_multi_robot_exploration-master/swarm_exploration/exploration_manager/msg/PairOpt.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/exploration_manager
)
_generate_msg_lisp(exploration_manager
  "/home/xiaogu/myproject/rosNavigation_ws/src/fast_multi_robot_exploration-master/swarm_exploration/exploration_manager/msg/PairOptResponse.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/exploration_manager
)
_generate_msg_lisp(exploration_manager
  "/home/xiaogu/myproject/rosNavigation_ws/src/fast_multi_robot_exploration-master/swarm_exploration/exploration_manager/msg/HGrid.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/exploration_manager
)
_generate_msg_lisp(exploration_manager
  "/home/xiaogu/myproject/rosNavigation_ws/src/fast_multi_robot_exploration-master/swarm_exploration/exploration_manager/msg/GridTour.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/exploration_manager
)

### Generating Services

### Generating Module File
_generate_module_lisp(exploration_manager
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/exploration_manager
  "${ALL_GEN_OUTPUT_FILES_lisp}"
)

add_custom_target(exploration_manager_generate_messages_lisp
  DEPENDS ${ALL_GEN_OUTPUT_FILES_lisp}
)
add_dependencies(exploration_manager_generate_messages exploration_manager_generate_messages_lisp)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/xiaogu/myproject/rosNavigation_ws/src/fast_multi_robot_exploration-master/swarm_exploration/exploration_manager/msg/DroneState.msg" NAME_WE)
add_dependencies(exploration_manager_generate_messages_lisp _exploration_manager_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/xiaogu/myproject/rosNavigation_ws/src/fast_multi_robot_exploration-master/swarm_exploration/exploration_manager/msg/PairOpt.msg" NAME_WE)
add_dependencies(exploration_manager_generate_messages_lisp _exploration_manager_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/xiaogu/myproject/rosNavigation_ws/src/fast_multi_robot_exploration-master/swarm_exploration/exploration_manager/msg/PairOptResponse.msg" NAME_WE)
add_dependencies(exploration_manager_generate_messages_lisp _exploration_manager_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/xiaogu/myproject/rosNavigation_ws/src/fast_multi_robot_exploration-master/swarm_exploration/exploration_manager/msg/HGrid.msg" NAME_WE)
add_dependencies(exploration_manager_generate_messages_lisp _exploration_manager_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/xiaogu/myproject/rosNavigation_ws/src/fast_multi_robot_exploration-master/swarm_exploration/exploration_manager/msg/GridTour.msg" NAME_WE)
add_dependencies(exploration_manager_generate_messages_lisp _exploration_manager_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(exploration_manager_genlisp)
add_dependencies(exploration_manager_genlisp exploration_manager_generate_messages_lisp)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS exploration_manager_generate_messages_lisp)

### Section generating for lang: gennodejs
### Generating Messages
_generate_msg_nodejs(exploration_manager
  "/home/xiaogu/myproject/rosNavigation_ws/src/fast_multi_robot_exploration-master/swarm_exploration/exploration_manager/msg/DroneState.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/exploration_manager
)
_generate_msg_nodejs(exploration_manager
  "/home/xiaogu/myproject/rosNavigation_ws/src/fast_multi_robot_exploration-master/swarm_exploration/exploration_manager/msg/PairOpt.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/exploration_manager
)
_generate_msg_nodejs(exploration_manager
  "/home/xiaogu/myproject/rosNavigation_ws/src/fast_multi_robot_exploration-master/swarm_exploration/exploration_manager/msg/PairOptResponse.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/exploration_manager
)
_generate_msg_nodejs(exploration_manager
  "/home/xiaogu/myproject/rosNavigation_ws/src/fast_multi_robot_exploration-master/swarm_exploration/exploration_manager/msg/HGrid.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/exploration_manager
)
_generate_msg_nodejs(exploration_manager
  "/home/xiaogu/myproject/rosNavigation_ws/src/fast_multi_robot_exploration-master/swarm_exploration/exploration_manager/msg/GridTour.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/exploration_manager
)

### Generating Services

### Generating Module File
_generate_module_nodejs(exploration_manager
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/exploration_manager
  "${ALL_GEN_OUTPUT_FILES_nodejs}"
)

add_custom_target(exploration_manager_generate_messages_nodejs
  DEPENDS ${ALL_GEN_OUTPUT_FILES_nodejs}
)
add_dependencies(exploration_manager_generate_messages exploration_manager_generate_messages_nodejs)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/xiaogu/myproject/rosNavigation_ws/src/fast_multi_robot_exploration-master/swarm_exploration/exploration_manager/msg/DroneState.msg" NAME_WE)
add_dependencies(exploration_manager_generate_messages_nodejs _exploration_manager_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/xiaogu/myproject/rosNavigation_ws/src/fast_multi_robot_exploration-master/swarm_exploration/exploration_manager/msg/PairOpt.msg" NAME_WE)
add_dependencies(exploration_manager_generate_messages_nodejs _exploration_manager_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/xiaogu/myproject/rosNavigation_ws/src/fast_multi_robot_exploration-master/swarm_exploration/exploration_manager/msg/PairOptResponse.msg" NAME_WE)
add_dependencies(exploration_manager_generate_messages_nodejs _exploration_manager_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/xiaogu/myproject/rosNavigation_ws/src/fast_multi_robot_exploration-master/swarm_exploration/exploration_manager/msg/HGrid.msg" NAME_WE)
add_dependencies(exploration_manager_generate_messages_nodejs _exploration_manager_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/xiaogu/myproject/rosNavigation_ws/src/fast_multi_robot_exploration-master/swarm_exploration/exploration_manager/msg/GridTour.msg" NAME_WE)
add_dependencies(exploration_manager_generate_messages_nodejs _exploration_manager_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(exploration_manager_gennodejs)
add_dependencies(exploration_manager_gennodejs exploration_manager_generate_messages_nodejs)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS exploration_manager_generate_messages_nodejs)

### Section generating for lang: genpy
### Generating Messages
_generate_msg_py(exploration_manager
  "/home/xiaogu/myproject/rosNavigation_ws/src/fast_multi_robot_exploration-master/swarm_exploration/exploration_manager/msg/DroneState.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/exploration_manager
)
_generate_msg_py(exploration_manager
  "/home/xiaogu/myproject/rosNavigation_ws/src/fast_multi_robot_exploration-master/swarm_exploration/exploration_manager/msg/PairOpt.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/exploration_manager
)
_generate_msg_py(exploration_manager
  "/home/xiaogu/myproject/rosNavigation_ws/src/fast_multi_robot_exploration-master/swarm_exploration/exploration_manager/msg/PairOptResponse.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/exploration_manager
)
_generate_msg_py(exploration_manager
  "/home/xiaogu/myproject/rosNavigation_ws/src/fast_multi_robot_exploration-master/swarm_exploration/exploration_manager/msg/HGrid.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/exploration_manager
)
_generate_msg_py(exploration_manager
  "/home/xiaogu/myproject/rosNavigation_ws/src/fast_multi_robot_exploration-master/swarm_exploration/exploration_manager/msg/GridTour.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/exploration_manager
)

### Generating Services

### Generating Module File
_generate_module_py(exploration_manager
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/exploration_manager
  "${ALL_GEN_OUTPUT_FILES_py}"
)

add_custom_target(exploration_manager_generate_messages_py
  DEPENDS ${ALL_GEN_OUTPUT_FILES_py}
)
add_dependencies(exploration_manager_generate_messages exploration_manager_generate_messages_py)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/xiaogu/myproject/rosNavigation_ws/src/fast_multi_robot_exploration-master/swarm_exploration/exploration_manager/msg/DroneState.msg" NAME_WE)
add_dependencies(exploration_manager_generate_messages_py _exploration_manager_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/xiaogu/myproject/rosNavigation_ws/src/fast_multi_robot_exploration-master/swarm_exploration/exploration_manager/msg/PairOpt.msg" NAME_WE)
add_dependencies(exploration_manager_generate_messages_py _exploration_manager_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/xiaogu/myproject/rosNavigation_ws/src/fast_multi_robot_exploration-master/swarm_exploration/exploration_manager/msg/PairOptResponse.msg" NAME_WE)
add_dependencies(exploration_manager_generate_messages_py _exploration_manager_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/xiaogu/myproject/rosNavigation_ws/src/fast_multi_robot_exploration-master/swarm_exploration/exploration_manager/msg/HGrid.msg" NAME_WE)
add_dependencies(exploration_manager_generate_messages_py _exploration_manager_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/xiaogu/myproject/rosNavigation_ws/src/fast_multi_robot_exploration-master/swarm_exploration/exploration_manager/msg/GridTour.msg" NAME_WE)
add_dependencies(exploration_manager_generate_messages_py _exploration_manager_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(exploration_manager_genpy)
add_dependencies(exploration_manager_genpy exploration_manager_generate_messages_py)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS exploration_manager_generate_messages_py)



if(gencpp_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/exploration_manager)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/exploration_manager
    DESTINATION ${gencpp_INSTALL_DIR}
  )
endif()
if(TARGET geometry_msgs_generate_messages_cpp)
  add_dependencies(exploration_manager_generate_messages_cpp geometry_msgs_generate_messages_cpp)
endif()

if(geneus_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/exploration_manager)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/exploration_manager
    DESTINATION ${geneus_INSTALL_DIR}
  )
endif()
if(TARGET geometry_msgs_generate_messages_eus)
  add_dependencies(exploration_manager_generate_messages_eus geometry_msgs_generate_messages_eus)
endif()

if(genlisp_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/exploration_manager)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/exploration_manager
    DESTINATION ${genlisp_INSTALL_DIR}
  )
endif()
if(TARGET geometry_msgs_generate_messages_lisp)
  add_dependencies(exploration_manager_generate_messages_lisp geometry_msgs_generate_messages_lisp)
endif()

if(gennodejs_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/exploration_manager)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/exploration_manager
    DESTINATION ${gennodejs_INSTALL_DIR}
  )
endif()
if(TARGET geometry_msgs_generate_messages_nodejs)
  add_dependencies(exploration_manager_generate_messages_nodejs geometry_msgs_generate_messages_nodejs)
endif()

if(genpy_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/exploration_manager)
  install(CODE "execute_process(COMMAND \"/usr/bin/python3\" -m compileall \"${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/exploration_manager\")")
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/exploration_manager
    DESTINATION ${genpy_INSTALL_DIR}
  )
endif()
if(TARGET geometry_msgs_generate_messages_py)
  add_dependencies(exploration_manager_generate_messages_py geometry_msgs_generate_messages_py)
endif()
