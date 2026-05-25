#include <exploration_manager/hypergraph_coordinator.h>
#include <cmath>

namespace fast_planner {

void HypergraphCoordinator::init(ros::NodeHandle& nh) {
  nh.param("hypergraph/target_radius", target_radius_, 5.0);
  nh.param("hypergraph/comm_range", comm_range_, 25.0);

  nh.param("hypergraph/w_competition", w_competition_, 1.0);
  nh.param("hypergraph/w_comm", w_comm_, 1.0);
  nh.param("hypergraph/w_redundant_cleanup", w_redundant_cleanup_, 1.0);

  // 新增：trajectory coupling hyperedge 的内部权重
  // 注意：这里不是 method/w_path_regularizer；
  // method/w_high_order 是外层总权重，这里是超图内部某条边的特征权重。
  nh.param("hypergraph/w_path_cross", w_path_cross_, 1.0);
  nh.param("hypergraph/w_large_turn", w_large_turn_, 1.0);

  // nh.param("hypergraph/w_curvature", w_curvature_, 1.0);
  // nh.param("hypergraph/w_current_energy", w_current_energy_, 1.0);
  // nh.param("hypergraph/w_comm_quality", w_comm_quality_, 1.0);

  // attention_temperature 越小，越偏向最大风险超边；
  // 越大，各超边越平均。
  nh.param("hypergraph/attention_temperature", attention_temperature_, 1.0);
}

std::string HypergraphCoordinator::edgeTypeToString(const HyperEdgeType& type) const {
  switch (type) {
    case HyperEdgeType::FRONTIER_COMPETITION:
      return "FRONTIER_COMPETITION";
    case HyperEdgeType::COMMUNICATION:
      return "COMMUNICATION";
    case HyperEdgeType::TRAIL_CLEANUP:
      return "TRAIL_CLEANUP";
    case HyperEdgeType::TRAJECTORY_COUPLING:
      return "TRAJECTORY_COUPLING";
    default:
      return "UNKNOWN";
  }
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
    if (i == ego_id - 1) continue;

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
    if (i == ego_id - 1) continue;

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
    if (i == ego_id - 1) continue;

    if (swarm_states_[i].role_ != ROLE::GARBAGE_COLLECTOR) continue;

    double d_goal = (swarm_states_[i].goal_pos_ - target_pos).norm();
    if (d_goal < target_radius_) {
      ++nearby_collectors;
    }
  }

  return static_cast<double>(nearby_collectors);
}

void HypergraphCoordinator::buildTargetHypergraph(
    int ego_id,
    const Eigen::Vector3d& cur_pos,
    const Eigen::Vector3d& cur_vel,
    const Eigen::Vector3d& cur_yaw,
    const Eigen::Vector3d& target_pos,
    const LABEL& target_label) {
  // 每评估一个候选目标，都重新构建一次该目标对应的局部动态超图
  last_edges_.clear();
  last_trajectory_cost_ = 0.0;

  // ============================================================
  // Hyperedge 1: Frontier / target competition
  // tail: 可能竞争同一目标的其它机器人
  // head: 当前 ego robot
  // 目的：避免多个机器人抢同一 frontier/trail。
  // ============================================================
  HyperEdgeInfo e_comp;
  e_comp.type = HyperEdgeType::FRONTIER_COMPETITION;
  e_comp.head_robot_id = ego_id;
  e_comp.target_pos = target_pos;
  e_comp.target_label = target_label;

  for (int i = 0; i < static_cast<int>(swarm_states_.size()); ++i) {
    if (i == ego_id - 1) continue;

    double d_goal = (swarm_states_[i].goal_pos_ - target_pos).norm();
    if (d_goal < target_radius_) {
      e_comp.tail_robot_ids.push_back(i);
    }
  }

  e_comp.competition = static_cast<double>(e_comp.tail_robot_ids.size());
  e_comp.raw_cost = w_competition_ * e_comp.competition;
  last_edges_.push_back(e_comp);

  // ============================================================
  // Hyperedge 2: Communication risk
  // tail: 与 ego 可能断连的机器人
  // head: 当前 ego robot
  // 目的：候选目标如果让 ego 远离群体，增加代价。
  // ============================================================
  HyperEdgeInfo e_comm;
  e_comm.type = HyperEdgeType::COMMUNICATION;
  e_comm.head_robot_id = ego_id;
  e_comm.target_pos = target_pos;
  e_comm.target_label = target_label;

  // 旧版
  
  for (int i = 0; i < static_cast<int>(swarm_states_.size()); ++i) {
    if (i == ego_id - 1) continue;

    double d = (target_pos - swarm_states_[i].pos_).norm();
    if (d > comm_range_) {
      e_comm.tail_robot_ids.push_back(i);
    }
  }

  e_comm.comm_risk = static_cast<double>(e_comm.tail_robot_ids.size());
  e_comm.raw_cost = w_comm_ * e_comm.comm_risk;

  last_edges_.push_back(e_comm);

  // ============================================================
  // Hyperedge 3: Trail redundant cleanup
  // 只对 TRAIL 目标生效。
  // tail: 正在清理相近 trail 的其它 collector
  // head: 当前 ego robot
  // 目的：避免多个 collector 重复清理同一区域。
  // ============================================================
  if (target_label == LABEL::TRAIL) {
    HyperEdgeInfo e_trail;
    e_trail.type = HyperEdgeType::TRAIL_CLEANUP;
    e_trail.head_robot_id = ego_id;
    e_trail.target_pos = target_pos;
    e_trail.target_label = target_label;

    for (int i = 0; i < static_cast<int>(swarm_states_.size()); ++i) {
      if (i == ego_id - 1) continue;
      if (swarm_states_[i].role_ != ROLE::GARBAGE_COLLECTOR) continue;

      double d_goal = (swarm_states_[i].goal_pos_ - target_pos).norm();
      if (d_goal < target_radius_) {
        e_trail.tail_robot_ids.push_back(i);
      }
    }

    e_trail.redundant_cleanup = static_cast<double>(e_trail.tail_robot_ids.size());
    e_trail.raw_cost = w_redundant_cleanup_ * e_trail.redundant_cleanup;
    last_edges_.push_back(e_trail);
  }

  // ============================================================
  // Hyperedge 4: Trajectory coupling
  // tail: 历史路径/当前运动趋势/候选目标
  // head: 当前 ego robot
  // 目的：把路径交叉、大转角纳入超图，而不是作为外部补丁。
  // ============================================================
  if (path_regularizer_) {
    HyperEdgeInfo e_path;
    e_path.type = HyperEdgeType::TRAJECTORY_COUPLING;
    e_path.head_robot_id = ego_id;
    e_path.target_pos = target_pos;
    e_path.target_label = target_label;


    e_path.path_cross =path_regularizer_->computePathCrossPenalty(cur_pos, target_pos);
    e_path.large_turn =path_regularizer_->computeLargeTurnPenalty(cur_pos, target_pos, cur_vel, cur_yaw);
    // e_path.curvature =
    //     path_regularizer_->computeTransitionTurnPenalty(cur_pos - cur_vel, cur_pos, target_pos);

    // AUV 最小转弯半径 / 曲率约束
    // 保留路径交叉和大转角作为“轨迹耦合超边”的协同偏好。
    // 注意：这不是 AUV 最小转弯半径硬约束。
    // AUV 最小转弯半径在 FameExplorationManager::satisfyTurnRadiusConstraint() 里过滤。
    e_path.raw_cost =
        w_path_cross_ * e_path.path_cross +
        w_large_turn_ * e_path.large_turn;

    last_trajectory_cost_ = e_path.raw_cost;

    // Deprecated in hard-constraint version:
    // e_path.curvature = ...
    // e_path.current_energy = ...
    // last_curvature_cost_ = ...
    // last_current_energy_cost_ = ...

    last_edges_.push_back(e_path);
  }
}

double HypergraphCoordinator::computeRuleAttentionCost() {
  if (last_edges_.empty()) return 0.0;

  // 1. 先计算 softmax 分母。
  // 注意：这里用 raw_cost 做 attention score。
  // raw_cost 越大，说明这个超边风险越大，越应该被关注。
  std::vector<double> logits;
  logits.reserve(last_edges_.size());

  double max_logit = -1e9;
  for (const auto& e : last_edges_) {
    double logit = e.raw_cost / std::max(1e-6, attention_temperature_);
    logits.push_back(logit);
    max_logit = std::max(max_logit, logit);
  }

  double denom = 0.0;
  for (double& logit : logits) {
    logit = std::exp(logit - max_logit);
    denom += logit;
  }

  // 2. attention 聚合。
  // 这一步对应“超边级注意力”：不同超边对最终目标代价贡献不同。
  double total_cost = 0.0;
  for (size_t i = 0; i < last_edges_.size(); ++i) {
    double alpha = logits[i] / std::max(1e-6, denom);

    last_edges_[i].attention = alpha;
    last_edges_[i].weighted_cost = alpha * last_edges_[i].raw_cost;

    total_cost += last_edges_[i].weighted_cost;
  }

  return total_cost;
}

double HypergraphCoordinator::hypergraphTargetCost(
    int ego_id,
    const Eigen::Vector3d& cur_pos,
    const Eigen::Vector3d& cur_vel,
    const Eigen::Vector3d& cur_yaw,
    const Eigen::Vector3d& target_pos,
    const LABEL& target_label) {
  // 先构图，再聚合。
  buildTargetHypergraph(
      ego_id, cur_pos, cur_vel, cur_yaw, target_pos, target_label);

  double cost = computeRuleAttentionCost();

  // 为了兼容你原来的 eval logger，仍然更新这几个 last_xxx。
  last_competition_cost_ = 0.0;
  last_comm_cost_ = 0.0;
  last_redundant_cleanup_cost_ = 0.0;

  for (const auto& e : last_edges_) {
    if (e.type == HyperEdgeType::FRONTIER_COMPETITION) {
      last_competition_cost_ = e.raw_cost;
    } else if (e.type == HyperEdgeType::COMMUNICATION) {
      last_comm_cost_ = e.raw_cost;
    } else if (e.type == HyperEdgeType::TRAIL_CLEANUP) {
      last_redundant_cleanup_cost_ = e.raw_cost;
    }
  }

  return cost;
}

double HypergraphCoordinator::hypergraphTransitionCost(
    int ego_id,
    const Eigen::Vector3d& prev_pos,
    const Eigen::Vector3d& from_pos,
    const Eigen::Vector3d& to_pos,
    const LABEL& target_label) {
  // trail tour 中没有当前速度/yaw，这里用 from-prev 近似当前运动方向。
  Eigen::Vector3d approx_vel = from_pos - prev_pos;
  approx_vel.z() = 0.0;

  double yaw_angle = std::atan2(approx_vel.y(), approx_vel.x());
  Eigen::Vector3d approx_yaw(yaw_angle, 0.0, 0.0);

  buildTargetHypergraph(
      ego_id, from_pos, approx_vel, approx_yaw, to_pos, target_label);

  return computeRuleAttentionCost();
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


