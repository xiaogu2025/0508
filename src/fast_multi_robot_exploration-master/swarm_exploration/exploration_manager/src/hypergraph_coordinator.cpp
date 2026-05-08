#include <exploration_manager/hypergraph_coordinator.h>
#include <cmath>

namespace fast_planner {

void HypergraphCoordinator::init(ros::NodeHandle& nh) {
  nh.param("hypergraph/target_radius", target_radius_, 5.0);
  nh.param("hypergraph/comm_range", comm_range_, 25.0);

  nh.param("hypergraph/w_competition", w_competition_, 1.0);
  nh.param("hypergraph/w_comm", w_comm_, 1.0);
  nh.param("hypergraph/w_redundant_cleanup", w_redundant_cleanup_, 1.0);
}

void HypergraphCoordinator::updateContext(
    int ego_id,
    const std::vector<DroneState>& swarm_states,
    const std::list<Frontier>& frontiers) {
  ego_id_ = ego_id;
  swarm_states_ = swarm_states;
  frontiers_ = frontiers;
}

double HypergraphCoordinator::computeCompetitionCost(
    int ego_id,
    const Eigen::Vector3d& target_pos) const {
  int competitors = 0;

  for (int i = 0; i < static_cast<int>(swarm_states_.size()); ++i) {
    if (i == ego_id || i == ego_id - 1) continue;

    double d_goal = (swarm_states_[i].goal_pos_ - target_pos).norm();
    if (d_goal < target_radius_) {
      ++competitors;
    }
  }

  return std::max(0, competitors);
}

double HypergraphCoordinator::computeGroupCommCost(
    int ego_id,
    const Eigen::Vector3d& target_pos) const {
  if (swarm_states_.size() <= 1) return 0.0;

  int disconnected_count = 0;

  for (int i = 0; i < static_cast<int>(swarm_states_.size()); ++i) {
    if (i == ego_id || i == ego_id - 1) continue;

    double d = (target_pos - swarm_states_[i].pos_).norm();
    if (d > comm_range_) {
      ++disconnected_count;
    }
  }

  return static_cast<double>(disconnected_count);
}

double HypergraphCoordinator::computeRedundantTrailCleanupCost(
    int ego_id,
    const Eigen::Vector3d& target_pos,
    const LABEL& target_label) const {
  if (target_label != LABEL::TRAIL) return 0.0;

  int nearby_collectors = 0;

  for (int i = 0; i < static_cast<int>(swarm_states_.size()); ++i) {
    if (i == ego_id || i == ego_id - 1) continue;

    if (swarm_states_[i].role_ != ROLE::GARBAGE_COLLECTOR) continue;

    double d_goal = (swarm_states_[i].goal_pos_ - target_pos).norm();
    if (d_goal < target_radius_) {
      ++nearby_collectors;
    }
  }

  return static_cast<double>(nearby_collectors);
}

double HypergraphCoordinator::highOrderTargetCost(
    int ego_id,
    const Eigen::Vector3d& target_pos,
    const LABEL& target_label) const {
  last_competition_cost_ = computeCompetitionCost(ego_id, target_pos);
  last_comm_cost_ = computeGroupCommCost(ego_id, target_pos);
  last_redundant_cleanup_cost_ =
      computeRedundantTrailCleanupCost(ego_id, target_pos, target_label);

  return w_competition_ * last_competition_cost_
       + w_comm_ * last_comm_cost_
       + w_redundant_cleanup_ * last_redundant_cleanup_cost_;
}

double HypergraphCoordinator::highOrderTransitionCost(
    int ego_id,
    const Eigen::Vector3d& from,
    const Eigen::Vector3d& to,
    const LABEL& label) const {
  // 这里第一版只对目标 to 做高阶协同评估。
  // 后面如果想更复杂，可以加入 from->to 的群体通道拥挤风险。
  return highOrderTargetCost(ego_id, to, label);
}

}  // namespace fast_planner


