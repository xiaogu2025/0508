#pragma once

#include <ros/ros.h>
#include <Eigen/Eigen>
#include <cmath>
#include <algorithm>

namespace fast_planner {

// AUVPhysicsModel:
// 用于描述真实 AUV 的简单运动学约束。
// 第一版只实现“最小转弯半径 / 曲率惩罚”。
// 后续可以继续加入最大角速度、最大侧滑角、推进器限制等。
class AUVPhysicsModel {
 public:
  AUVPhysicsModel() = default;

  void init(ros::NodeHandle& nh);

  // 计算三点形成的近似曲率。
  // p_prev -> p_cur -> p_next 表示当前运动趋势到候选目标的转弯。
  double computeCurvature(
      const Eigen::Vector3d& p_prev,
      const Eigen::Vector3d& p_cur,
      const Eigen::Vector3d& p_next) const;

  // 如果曲率超过 1 / min_turn_radius，则给惩罚。
  double curvaturePenalty(
      const Eigen::Vector3d& p_prev,
      const Eigen::Vector3d& p_cur,
      const Eigen::Vector3d& p_next) const;

  double minTurnRadius() const { return min_turn_radius_; }

 private:
  double min_turn_radius_ = 3.0;   // AUV 最小转弯半径，单位 m
  double eps_ = 1e-6;
};

}  // namespace fast_planner