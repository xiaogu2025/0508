#include <exploration_manager/underwater_role_selector.h>
#include <cmath>

namespace fast_planner {

void UnderwaterRoleSelector::init(ros::NodeHandle& nh) {
  nh.param("underwater_role/region_size", region_size_, 8.0);
  nh.param("underwater_role/comm_decay", comm_decay_, 20.0);

  nh.param("underwater_role/w_frontier", w_frontier_, 1.0);
  nh.param("underwater_role/w_trail", w_trail_, 1.0);
  nh.param("underwater_role/w_comm", w_comm_, 1.0);

  nh.param("underwater_role/switch_margin", switch_margin_, 0.2);
}

double UnderwaterRoleSelector::computeCommRisk(
    const Eigen::Vector3d& ego_pos,
    int ego_id,
    const std::vector<DroneState>& swarm_states) const {
  if (swarm_states.size() <= 1) return 0.0;

  double min_dist = 1e9;

  for (int i = 0; i < static_cast<int>(swarm_states.size()); ++i) {
    // 这里保守处理：如果你的 drone_id 是从 1 开始编号，可以改成 ego_id - 1 == i
    if (i == ego_id || i == ego_id - 1) continue;

    double d = (ego_pos - swarm_states[i].pos_).norm();
    min_dist = std::min(min_dist, d);
  }

  if (min_dist > 1e8) return 1.0;

  double comm_quality = std::exp(-min_dist / std::max(1e-3, comm_decay_));
  double comm_risk = 1.0 - comm_quality;

  return std::min(1.0, std::max(0.0, comm_risk));
}

void UnderwaterRoleSelector::countNearbyFrontiers(
    const Eigen::Vector3d& ego_pos,
    const std::list<Frontier>& frontiers,
    int& n_frontier,
    int& n_trail) const {
  n_frontier = 0;
  n_trail = 0;

  for (const auto& ftr : frontiers) {
    double d = (ego_pos - ftr.average_).head(2).norm();
    if (d > region_size_) continue;

    if (ftr.label_ == LABEL::FRONTIER) ++n_frontier;
    else if (ftr.label_ == LABEL::TRAIL) ++n_trail;
  }
}

ROLE UnderwaterRoleSelector::refineRole(
    const ROLE& original_role,
    const Eigen::Vector3d& ego_pos,
    int ego_id,
    const std::vector<DroneState>& swarm_states,
    const std::list<Frontier>& frontiers,
    double* s_explorer,
    double* s_collector) const {
  int n_frontier = 0;
  int n_trail = 0;
  countNearbyFrontiers(ego_pos, frontiers, n_frontier, n_trail);

  double comm_risk = computeCommRisk(ego_pos, ego_id, swarm_states);

  // Explorer：更喜欢附近有 FRONTIER，同时通信风险不能太高
  double S_exp = w_frontier_ * static_cast<double>(n_frontier)
               - w_comm_ * comm_risk;

  // Collector：更喜欢附近有 TRAIL，通信风险影响略小
  double S_col = w_trail_ * static_cast<double>(n_trail)
               - 0.5 * w_comm_ * comm_risk;

  if (s_explorer) *s_explorer = S_exp;
  if (s_collector) *s_collector = S_col;

  if (S_col > S_exp + switch_margin_) {
    return ROLE::GARBAGE_COLLECTOR;
  }

  if (S_exp > S_col + switch_margin_) {
    return ROLE::EXPLORER;
  }

  // 分数差不多时，保持原角色，减少频繁抖动
  return original_role;
}

}  // namespace fast_planner