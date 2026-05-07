# generated from genmsg/cmake/pkg-genmsg.cmake.em

message(STATUS "lkh_tsp_solver: 0 messages, 1 services")

set(MSG_I_FLAGS "-Istd_msgs:/opt/ros/noetic/share/std_msgs/cmake/../msg")

# Find all generators
find_package(gencpp REQUIRED)
find_package(geneus REQUIRED)
find_package(genlisp REQUIRED)
find_package(gennodejs REQUIRED)
find_package(genpy REQUIRED)

add_custom_target(lkh_tsp_solver_generate_messages ALL)

# verify that message/service dependencies have not changed since configure



get_filename_component(_filename "/home/xiaogu/myproject/rosNavigation_ws/src/fast_multi_robot_exploration-master/swarm_exploration/utils/lkh_tsp_solver/srv/SolveTSP.srv" NAME_WE)
add_custom_target(_lkh_tsp_solver_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "lkh_tsp_solver" "/home/xiaogu/myproject/rosNavigation_ws/src/fast_multi_robot_exploration-master/swarm_exploration/utils/lkh_tsp_solver/srv/SolveTSP.srv" ""
)

#
#  langs = gencpp;geneus;genlisp;gennodejs;genpy
#

### Section generating for lang: gencpp
### Generating Messages

### Generating Services
_generate_srv_cpp(lkh_tsp_solver
  "/home/xiaogu/myproject/rosNavigation_ws/src/fast_multi_robot_exploration-master/swarm_exploration/utils/lkh_tsp_solver/srv/SolveTSP.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/lkh_tsp_solver
)

### Generating Module File
_generate_module_cpp(lkh_tsp_solver
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/lkh_tsp_solver
  "${ALL_GEN_OUTPUT_FILES_cpp}"
)

add_custom_target(lkh_tsp_solver_generate_messages_cpp
  DEPENDS ${ALL_GEN_OUTPUT_FILES_cpp}
)
add_dependencies(lkh_tsp_solver_generate_messages lkh_tsp_solver_generate_messages_cpp)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/xiaogu/myproject/rosNavigation_ws/src/fast_multi_robot_exploration-master/swarm_exploration/utils/lkh_tsp_solver/srv/SolveTSP.srv" NAME_WE)
add_dependencies(lkh_tsp_solver_generate_messages_cpp _lkh_tsp_solver_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(lkh_tsp_solver_gencpp)
add_dependencies(lkh_tsp_solver_gencpp lkh_tsp_solver_generate_messages_cpp)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS lkh_tsp_solver_generate_messages_cpp)

### Section generating for lang: geneus
### Generating Messages

### Generating Services
_generate_srv_eus(lkh_tsp_solver
  "/home/xiaogu/myproject/rosNavigation_ws/src/fast_multi_robot_exploration-master/swarm_exploration/utils/lkh_tsp_solver/srv/SolveTSP.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/lkh_tsp_solver
)

### Generating Module File
_generate_module_eus(lkh_tsp_solver
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/lkh_tsp_solver
  "${ALL_GEN_OUTPUT_FILES_eus}"
)

add_custom_target(lkh_tsp_solver_generate_messages_eus
  DEPENDS ${ALL_GEN_OUTPUT_FILES_eus}
)
add_dependencies(lkh_tsp_solver_generate_messages lkh_tsp_solver_generate_messages_eus)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/xiaogu/myproject/rosNavigation_ws/src/fast_multi_robot_exploration-master/swarm_exploration/utils/lkh_tsp_solver/srv/SolveTSP.srv" NAME_WE)
add_dependencies(lkh_tsp_solver_generate_messages_eus _lkh_tsp_solver_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(lkh_tsp_solver_geneus)
add_dependencies(lkh_tsp_solver_geneus lkh_tsp_solver_generate_messages_eus)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS lkh_tsp_solver_generate_messages_eus)

### Section generating for lang: genlisp
### Generating Messages

### Generating Services
_generate_srv_lisp(lkh_tsp_solver
  "/home/xiaogu/myproject/rosNavigation_ws/src/fast_multi_robot_exploration-master/swarm_exploration/utils/lkh_tsp_solver/srv/SolveTSP.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/lkh_tsp_solver
)

### Generating Module File
_generate_module_lisp(lkh_tsp_solver
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/lkh_tsp_solver
  "${ALL_GEN_OUTPUT_FILES_lisp}"
)

add_custom_target(lkh_tsp_solver_generate_messages_lisp
  DEPENDS ${ALL_GEN_OUTPUT_FILES_lisp}
)
add_dependencies(lkh_tsp_solver_generate_messages lkh_tsp_solver_generate_messages_lisp)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/xiaogu/myproject/rosNavigation_ws/src/fast_multi_robot_exploration-master/swarm_exploration/utils/lkh_tsp_solver/srv/SolveTSP.srv" NAME_WE)
add_dependencies(lkh_tsp_solver_generate_messages_lisp _lkh_tsp_solver_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(lkh_tsp_solver_genlisp)
add_dependencies(lkh_tsp_solver_genlisp lkh_tsp_solver_generate_messages_lisp)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS lkh_tsp_solver_generate_messages_lisp)

### Section generating for lang: gennodejs
### Generating Messages

### Generating Services
_generate_srv_nodejs(lkh_tsp_solver
  "/home/xiaogu/myproject/rosNavigation_ws/src/fast_multi_robot_exploration-master/swarm_exploration/utils/lkh_tsp_solver/srv/SolveTSP.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/lkh_tsp_solver
)

### Generating Module File
_generate_module_nodejs(lkh_tsp_solver
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/lkh_tsp_solver
  "${ALL_GEN_OUTPUT_FILES_nodejs}"
)

add_custom_target(lkh_tsp_solver_generate_messages_nodejs
  DEPENDS ${ALL_GEN_OUTPUT_FILES_nodejs}
)
add_dependencies(lkh_tsp_solver_generate_messages lkh_tsp_solver_generate_messages_nodejs)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/xiaogu/myproject/rosNavigation_ws/src/fast_multi_robot_exploration-master/swarm_exploration/utils/lkh_tsp_solver/srv/SolveTSP.srv" NAME_WE)
add_dependencies(lkh_tsp_solver_generate_messages_nodejs _lkh_tsp_solver_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(lkh_tsp_solver_gennodejs)
add_dependencies(lkh_tsp_solver_gennodejs lkh_tsp_solver_generate_messages_nodejs)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS lkh_tsp_solver_generate_messages_nodejs)

### Section generating for lang: genpy
### Generating Messages

### Generating Services
_generate_srv_py(lkh_tsp_solver
  "/home/xiaogu/myproject/rosNavigation_ws/src/fast_multi_robot_exploration-master/swarm_exploration/utils/lkh_tsp_solver/srv/SolveTSP.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/lkh_tsp_solver
)

### Generating Module File
_generate_module_py(lkh_tsp_solver
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/lkh_tsp_solver
  "${ALL_GEN_OUTPUT_FILES_py}"
)

add_custom_target(lkh_tsp_solver_generate_messages_py
  DEPENDS ${ALL_GEN_OUTPUT_FILES_py}
)
add_dependencies(lkh_tsp_solver_generate_messages lkh_tsp_solver_generate_messages_py)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/xiaogu/myproject/rosNavigation_ws/src/fast_multi_robot_exploration-master/swarm_exploration/utils/lkh_tsp_solver/srv/SolveTSP.srv" NAME_WE)
add_dependencies(lkh_tsp_solver_generate_messages_py _lkh_tsp_solver_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(lkh_tsp_solver_genpy)
add_dependencies(lkh_tsp_solver_genpy lkh_tsp_solver_generate_messages_py)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS lkh_tsp_solver_generate_messages_py)



if(gencpp_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/lkh_tsp_solver)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/lkh_tsp_solver
    DESTINATION ${gencpp_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_cpp)
  add_dependencies(lkh_tsp_solver_generate_messages_cpp std_msgs_generate_messages_cpp)
endif()

if(geneus_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/lkh_tsp_solver)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/lkh_tsp_solver
    DESTINATION ${geneus_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_eus)
  add_dependencies(lkh_tsp_solver_generate_messages_eus std_msgs_generate_messages_eus)
endif()

if(genlisp_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/lkh_tsp_solver)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/lkh_tsp_solver
    DESTINATION ${genlisp_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_lisp)
  add_dependencies(lkh_tsp_solver_generate_messages_lisp std_msgs_generate_messages_lisp)
endif()

if(gennodejs_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/lkh_tsp_solver)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/lkh_tsp_solver
    DESTINATION ${gennodejs_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_nodejs)
  add_dependencies(lkh_tsp_solver_generate_messages_nodejs std_msgs_generate_messages_nodejs)
endif()

if(genpy_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/lkh_tsp_solver)
  install(CODE "execute_process(COMMAND \"/usr/bin/python3\" -m compileall \"${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/lkh_tsp_solver\")")
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/lkh_tsp_solver
    DESTINATION ${genpy_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_py)
  add_dependencies(lkh_tsp_solver_generate_messages_py std_msgs_generate_messages_py)
endif()
