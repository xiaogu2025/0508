#pragma once

#include <ros/ros.h>
#include <Eigen/Eigen>
#include <cmath>
#include <algorithm>

namespace fast_planner {

class AUVPhysicsModel {
 public:
  AUVPhysicsModel() = default;

  void init(ros::NodeHandle& nh);

  double computeCurvature(
      const Eigen::Vector3d& p_prev,
      const Eigen::Vector3d& p_cur,
      const Eigen::Vector3d& p_next) const;

  // 硬约束：不满足最小转弯半径，候选目标不可选
  bool isTurnFeasible(
      const Eigen::Vector3d& p_prev,
      const Eigen::Vector3d& p_cur,
      const Eigen::Vector3d& p_next) const;

 private:
  double min_turn_radius_ = 3.0;
};

}  // namespace fast_planner