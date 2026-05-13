#pragma once

#include <ros/ros.h>
#include <Eigen/Eigen>
#include <list>
#include <vector>

#include <active_perception/frontier_finder.h>
#include <exploration_manager/role_assigner.h>

#include <memory>
#include <string>
#include <algorithm>
#include <cmath>

#include <exploration_manager/path_regularizer.h>
#include <exploration_manager/underwater_frontier_evaluator.h>

#include <exploration_manager/auv_physics_model.h>
#include <exploration_manager/ocean_current_field.h>
#include <exploration_manager/underwater_comm_model.h>

namespace fast_planner {

// ================= Dynamic Hypergraph Definition =================
//
// 目的：显式定义“超边”。
// 这样超图模块不再只是几个散乱 cost，而是可以构建：
// 1) 目标竞争超边
// 2) 通信风险超边
// 3) trail 重复清理超边
// 4) 轨迹耦合超边：路径交叉 + 大转角
enum class HyperEdgeType {
  FRONTIER_COMPETITION = 0,
  COMMUNICATION = 1,
  TRAIL_CLEANUP = 2,
  TRAJECTORY_COUPLING = 3
};

// 每个候选目标都会生成若干条 HyperEdgeInfo。
// head_robot_id 是当前 ego robot，tail_robot_ids 是影响它的其它机器人。
// 这对应 HMAGAT 的 singleton head + multi-node tail 思想。
struct HyperEdgeInfo {
  HyperEdgeType type;

  int head_robot_id = -1;
  std::vector<int> tail_robot_ids;

  Eigen::Vector3d target_pos = Eigen::Vector3d::Zero();
  LABEL target_label = LABEL::UNLABELED;

  // 每条超边的特征
  double competition = 0.0;          // 多机器人竞争同一目标
  double comm_risk = 0.0;            // 通信断链风险
  double redundant_cleanup = 0.0;    // 多个 collector 重复清 trail
  double path_cross = 0.0;           // 候选路径与历史路径交叉
  double large_turn = 0.0;           // 当前方向到候选目标方向的大转角

  double curvature = 0.0;       // AUV 最小转弯半径约束
  double current_energy = 0.0;  // 洋流能耗
  double comm_quality_risk = 0.0; // 连续水声通信风险

  // 预留：后面可以把创新点1的 FT-score 也显式作为超边特征
  double frontier_score = 0.0;
  double trail_score = 0.0;

  // rule-attention 结果
  double raw_cost = 0.0;
  double attention = 0.0;
  double weighted_cost = 0.0;
};

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
  
  void setAUVPhysicsModel(const std::shared_ptr<AUVPhysicsModel>& model) {
  auv_physics_model_ = model;
  }

  void setOceanCurrentField(const std::shared_ptr<OceanCurrentField>& field) {
    ocean_current_field_ = field;
  }

  void setUnderwaterCommModel(const std::shared_ptr<UnderwaterCommModel>& model) {
    underwater_comm_model_ = model;
  }

  // 让超图模块能访问路径正则器。
  // 目的：把“大转角、路径交叉”纳入 trajectory coupling hyperedge。
  void setPathRegularizer(const std::shared_ptr<PathRegularizer>& reg) {
    path_regularizer_ = reg;
  }

  // 让超图模块能访问 Frontier-Trail 评分器。
  // 第一版可以先不用，后面可以把 FT-score 纳入 hyperedge feature。
  void setFrontierEvaluator(const std::shared_ptr<UnderwaterFrontierEvaluator>& eval) {
    ft_evaluator_ = eval;
  }

  // 新版目标级超图代价：
  // 比旧版 highOrderTargetCost 多了 cur_pos/cur_vel/cur_yaw，
  // 因此可以把路径交叉和大转角也放进超图。
  double hypergraphTargetCost(
      int ego_id,
      const Eigen::Vector3d& cur_pos,
      const Eigen::Vector3d& cur_vel,
      const Eigen::Vector3d& cur_yaw,
      const Eigen::Vector3d& target_pos,
      const LABEL& target_label);

  // 新版 transition cost，主要给 findTourOfTrails() 用。
  double hypergraphTransitionCost(
      int ego_id,
      const Eigen::Vector3d& prev_pos,
      const Eigen::Vector3d& from_pos,
      const Eigen::Vector3d& to_pos,
      const LABEL& target_label);

  // 日志用：获取上一次构建出的超边
  const std::vector<HyperEdgeInfo>& getLastHyperEdges() const {
    return last_edges_;
  }

  int lastNumHyperEdges() const {
    return static_cast<int>(last_edges_.size());
  }

  double lastTrajectoryCost() const { return last_trajectory_cost_; }

  double lastCompetitionCost() const { return last_competition_cost_; }
  double lastCommCost() const { return last_comm_cost_; }
  double lastRedundantCleanupCost() const { return last_redundant_cleanup_cost_; }

  double lastCurvatureCost() const { return last_curvature_cost_; }
  double lastCurrentEnergyCost() const { return last_current_energy_cost_; }

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

    // 构建当前候选目标对应的动态超图
  void buildTargetHypergraph(
      int ego_id,
      const Eigen::Vector3d& cur_pos,
      const Eigen::Vector3d& cur_vel,
      const Eigen::Vector3d& cur_yaw,
      const Eigen::Vector3d& target_pos,
      const LABEL& target_label);

  // 对 last_edges_ 做 rule-attention 聚合，得到最终高阶协同代价
  double computeRuleAttentionCost();

  // 工具函数：把 enum 转成字符串，方便日志
  std::string edgeTypeToString(const HyperEdgeType& type) const;

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

  std::shared_ptr<PathRegularizer> path_regularizer_;
  std::shared_ptr<UnderwaterFrontierEvaluator> ft_evaluator_;

  std::vector<HyperEdgeInfo> last_edges_;

  std::shared_ptr<AUVPhysicsModel> auv_physics_model_;
  std::shared_ptr<OceanCurrentField> ocean_current_field_;
  std::shared_ptr<UnderwaterCommModel> underwater_comm_model_;

  double w_curvature_ = 1.0;
  double w_current_energy_ = 1.0;
  double w_comm_quality_ = 1.0;

  double last_curvature_cost_ = 0.0;
  double last_current_energy_cost_ = 0.0;

  // 新增超图参数
  double w_path_cross_ = 1.0;
  double w_large_turn_ = 1.0;
  double attention_temperature_ = 1.0;

  // 日志缓存
  double last_trajectory_cost_ = 0.0;
};

}  // namespace fast_planner