#pragma once

#include <ros/ros.h>
#include <Eigen/Eigen>
#include <list>
#include <vector>

#include <active_perception/frontier_finder.h>
#include <exploration_manager/role_assigner.h>

namespace fast_planner {

class UnderwaterRoleSelector {
public:
  UnderwaterRoleSelector() = default;

  void init(ros::NodeHandle& nh);

  ROLE refineRole(
      const ROLE& original_role,
      const Eigen::Vector3d& ego_pos,
      int ego_id,
      const std::vector<DroneState>& swarm_states,
      const std::list<Frontier>& frontiers,
      double* s_explorer = nullptr,
      double* s_collector = nullptr) const;

private:
  double computeCommRisk(
      const Eigen::Vector3d& ego_pos,
      int ego_id,
      const std::vector<DroneState>& swarm_states) const;

  void countNearbyFrontiers(
      const Eigen::Vector3d& ego_pos,
      const std::list<Frontier>& frontiers,
      int& n_frontier,
      int& n_trail) const;

private:
  double region_size_ = 8.0;
  double comm_decay_ = 20.0;

  double w_frontier_ = 1.0;
  double w_trail_ = 1.0;
  double w_comm_ = 1.0;

  double switch_margin_ = 0.2;
};

}  // namespace fast_planner