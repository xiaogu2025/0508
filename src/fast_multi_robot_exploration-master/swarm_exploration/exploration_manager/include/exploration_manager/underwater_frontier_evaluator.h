#pragma once

#include <ros/ros.h>
#include <Eigen/Eigen>
#include <vector>

#include <active_perception/frontier_finder.h>
#include <exploration_manager/role_assigner.h>

namespace fast_planner {

class UnderwaterFrontierEvaluator {
public:
  UnderwaterFrontierEvaluator() = default;

  void init(ros::NodeHandle& nh);

  // 用于 explorerPlan：输入一个前方 cluster 的 cells
  double targetBiasFromCells(
      const LABEL& label,
      const std::vector<Eigen::Vector3d>& cells,
      const ROLE& role) const;

  // 用于 greedyPlan：只有 label 和位置时的简化版本
  double targetBiasSimple(
      const LABEL& label,
      const Eigen::Vector3d& target_pos,
      const Eigen::Vector3d& ego_pos,
      const ROLE& role) const;

  double computeClusterSpread(const std::vector<Eigen::Vector3d>& cells) const;
  double computeResidualScore(const std::vector<Eigen::Vector3d>& cells) const;
  double computeFrontierScore(const std::vector<Eigen::Vector3d>& cells) const;

private:
  double w_residual_ = 1.0;
  double w_frontier_ = 1.0;
  double w_label_ = 1.0;

  double min_cluster_size_ = 5.0;
  double spread_norm_ = 5.0;
};

}  // namespace fast_planner