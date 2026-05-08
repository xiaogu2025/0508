#pragma once

#include <ros/ros.h>
#include <Eigen/Eigen>
#include <list>
#include <vector>

#include <active_perception/frontier_finder.h>
#include <exploration_manager/role_assigner.h>

namespace fast_planner {

class HypergraphCoordinator {
public:
  HypergraphCoordinator() = default;

  void init(ros::NodeHandle& nh);

  void updateContext(
      int ego_id,
      const std::vector<DroneState>& swarm_states,
      const std::list<Frontier>& frontiers);

  double highOrderTargetCost(
      int ego_id,
      const Eigen::Vector3d& target_pos,
      const LABEL& target_label) const;

  double highOrderTransitionCost(
      int ego_id,
      const Eigen::Vector3d& from,
      const Eigen::Vector3d& to,
      const LABEL& label) const;

  double lastCompetitionCost() const { return last_competition_cost_; }
  double lastCommCost() const { return last_comm_cost_; }
  double lastRedundantCleanupCost() const { return last_redundant_cleanup_cost_; }

private:
  double computeCompetitionCost(
      int ego_id,
      const Eigen::Vector3d& target_pos) const;

  double computeGroupCommCost(
      int ego_id,
      const Eigen::Vector3d& target_pos) const;

  double computeRedundantTrailCleanupCost(
      int ego_id,
      const Eigen::Vector3d& target_pos,
      const LABEL& target_label) const;

private:
  int ego_id_ = 0;

  std::vector<DroneState> swarm_states_;
  std::list<Frontier> frontiers_;

  double target_radius_ = 5.0;
  double comm_range_ = 25.0;

  double w_competition_ = 1.0;
  double w_comm_ = 1.0;
  double w_redundant_cleanup_ = 1.0;

  mutable double last_competition_cost_ = 0.0;
  mutable double last_comm_cost_ = 0.0;
  mutable double last_redundant_cleanup_cost_ = 0.0;
};

}  // namespace fast_planner