# generated from catkin/cmake/template/pkg.context.pc.in
CATKIN_PACKAGE_PREFIX = ""
PROJECT_PKG_CONFIG_INCLUDE_DIRS = "${prefix}/include".split(';') if "${prefix}/include" != "" else []
PROJECT_CATKIN_DEPENDS = "plan_env;path_searching;bspline;bspline_opt;active_perception;traj_utils;lkh_tsp_solver;lkh_mtsp_solver;plan_manage;message_runtime".replace(';', ' ')
PKG_CONFIG_LIBRARIES_WITH_PREFIX = "-lexploration_manager".split(';') if "-lexploration_manager" != "" else []
PROJECT_NAME = "exploration_manager"
PROJECT_SPACE_DIR = "/home/xiaogu/myproject/rosNavigation_ws/install"
PROJECT_VERSION = "0.0.0"
