#include <exploration_manager/underwater_frontier_evaluator.h>
#include <cmath>

namespace fast_planner {

void UnderwaterFrontierEvaluator::init(ros::NodeHandle& nh) {
  nh.param("underwater_ft/w_residual", w_residual_, 1.0);
  nh.param("underwater_ft/w_frontier", w_frontier_, 1.0);
  nh.param("underwater_ft/w_label", w_label_, 1.0);

  nh.param("underwater_ft/min_cluster_size", min_cluster_size_, 5.0);
  nh.param("underwater_ft/spread_norm", spread_norm_, 5.0);
}

double UnderwaterFrontierEvaluator::computeClusterSpread(
    const std::vector<Eigen::Vector3d>& cells) const {
  if (cells.empty()) return 0.0;

  Eigen::Vector3d centroid = Eigen::Vector3d::Zero();
  for (const auto& p : cells) centroid += p;
  centroid /= double(cells.size());

  double spread = 0.0;
  for (const auto& p : cells) {
    spread += (p - centroid).head(2).norm();
  }
  spread /= double(cells.size());

  return spread;
}

double UnderwaterFrontierEvaluator::computeResidualScore(
    const std::vector<Eigen::Vector3d>& cells) const {
  if (cells.empty()) return 0.0;

  const double n = static_cast<double>(cells.size());
  const double spread = computeClusterSpread(cells);

  // 简化解释：
  // 小而紧凑的 cluster 更像局部残留未知区域，更适合 Collector 清理。
  double compact_score = 1.0 / (1.0 + spread / std::max(1e-3, spread_norm_));
  double size_score = 1.0 / (1.0 + n / std::max(1.0, min_cluster_size_));

  return compact_score + size_score;
}

double UnderwaterFrontierEvaluator::computeFrontierScore(
    const std::vector<Eigen::Vector3d>& cells) const {
  if (cells.empty()) return 0.0;

  const double n = static_cast<double>(cells.size());
  const double spread = computeClusterSpread(cells);

  // 简化解释：
  // 大而分散的 cluster 更像主边界 frontier，更适合 Explorer 扩展。
  double size_score = std::log(1.0 + n);
  double spread_score = spread / std::max(1e-3, spread_norm_);

  return size_score + spread_score;
}

double UnderwaterFrontierEvaluator::targetBiasFromCells(
    const LABEL& label,
    const std::vector<Eigen::Vector3d>& cells,
    const ROLE& role) const {
  const double residual_score = computeResidualScore(cells);
  const double frontier_score = computeFrontierScore(cells);

  double label_bias = 0.0;

  if (role == ROLE::EXPLORER) {
    // Explorer 喜欢 FRONTIER，不喜欢 TRAIL
    label_bias = (label == LABEL::FRONTIER) ? -w_label_ : w_label_;
    return label_bias - w_frontier_ * frontier_score + w_residual_ * residual_score;
  }

  if (role == ROLE::GARBAGE_COLLECTOR) {
    // Collector 喜欢 TRAIL，不喜欢普通 FRONTIER
    label_bias = (label == LABEL::TRAIL) ? -w_label_ : w_label_;
    return label_bias - w_residual_ * residual_score + w_frontier_ * frontier_score;
  }

  return 0.0;
}

double UnderwaterFrontierEvaluator::targetBiasSimple(
    const LABEL& label,
    const Eigen::Vector3d& target_pos,
    const Eigen::Vector3d& ego_pos,
    const ROLE& role) const {
  double dist = (target_pos - ego_pos).head(2).norm();

  if (role == ROLE::EXPLORER) {
    double label_bias = (label == LABEL::FRONTIER) ? -w_label_ : w_label_;
    return label_bias + 0.05 * dist;
  }

  if (role == ROLE::GARBAGE_COLLECTOR) {
    double label_bias = (label == LABEL::TRAIL) ? -w_label_ : w_label_;
    return label_bias + 0.03 * dist;
  }

  return 0.0;
}

}  // namespace fast_planner