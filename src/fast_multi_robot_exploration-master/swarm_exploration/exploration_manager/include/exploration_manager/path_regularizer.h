#pragma once

#include <ros/ros.h>
#include <Eigen/Eigen>
#include <deque>
#include <vector>

namespace fast_planner {

class PathRegularizer {
public:
  PathRegularizer() = default;

  void init(ros::NodeHandle& nh);

  // 每次规划时，把当前真实位置记录进历史轨迹
  void updateHistory(const Eigen::Vector3d& cur_pos);

  // 总正则损失：路径交叉损失 + 大转角损失
  double computeTargetRegularization(
      const Eigen::Vector3d& cur_pos,
      const Eigen::Vector3d& target_pos,
      const Eigen::Vector3d& cur_vel,
      const Eigen::Vector3d& cur_yaw) const;

  // 单独计算：候选线段 cur_pos -> target_pos 是否与历史路径交叉
  double computePathCrossPenalty(
      const Eigen::Vector3d& cur_pos,
      const Eigen::Vector3d& target_pos) const;

  // 单独计算：当前方向到目标方向转角是否过大
  double computeLargeTurnPenalty(
      const Eigen::Vector3d& cur_pos,
      const Eigen::Vector3d& target_pos,
      const Eigen::Vector3d& cur_vel,
      const Eigen::Vector3d& cur_yaw) const;

  // 用于 findTourOfTrails() 中 trail->trail 转移
  double computeTransitionTurnPenalty(
      const Eigen::Vector3d& prev_pos,
      const Eigen::Vector3d& from_pos,
      const Eigen::Vector3d& to_pos) const;

private:
  bool segmentIntersect2D(
      const Eigen::Vector2d& a,
      const Eigen::Vector2d& b,
      const Eigen::Vector2d& c,
      const Eigen::Vector2d& d) const;

  double cross2D(
      const Eigen::Vector2d& a,
      const Eigen::Vector2d& b,
      const Eigen::Vector2d& c) const;

private:
  bool enable_path_cross_penalty_ = true;
  bool enable_large_turn_penalty_ = true;

  double w_path_cross_ = 5.0;
  double w_large_turn_ = 3.0;

  double turn_angle_threshold_deg_ = 120.0;
  double history_min_dist_ = 0.5;
  int max_history_size_ = 300;

  // 为避免刚刚走过的最近几段被误判为交叉，跳过最近 skip_recent_segments_ 段
  int skip_recent_segments_ = 5;

  std::deque<Eigen::Vector3d> history_path_;
};

}  // namespace fast_planner