#include <exploration_manager/path_regularizer.h>
#include <cmath>
#include <algorithm>

namespace fast_planner {

void PathRegularizer::init(ros::NodeHandle& nh) {
  nh.param("path_regularizer/enable_path_cross_penalty",
           enable_path_cross_penalty_, true);
  nh.param("path_regularizer/enable_large_turn_penalty",
           enable_large_turn_penalty_, true);

  nh.param("path_regularizer/w_path_cross", w_path_cross_, 5.0);
  nh.param("path_regularizer/w_large_turn", w_large_turn_, 3.0);

  nh.param("path_regularizer/turn_angle_threshold_deg",
           turn_angle_threshold_deg_, 120.0);
  nh.param("path_regularizer/history_min_dist",
           history_min_dist_, 0.5);
  nh.param("path_regularizer/max_history_size",
           max_history_size_, 300);
  nh.param("path_regularizer/skip_recent_segments",
           skip_recent_segments_, 5);
}

void PathRegularizer::updateHistory(const Eigen::Vector3d& cur_pos) {
  if (history_path_.empty()) {
    history_path_.push_back(cur_pos);
    return;
  }

  if ((cur_pos - history_path_.back()).norm() < history_min_dist_) {
    return;
  }

  history_path_.push_back(cur_pos);

  while (static_cast<int>(history_path_.size()) > max_history_size_) {
    history_path_.pop_front();
  }
}

double PathRegularizer::cross2D(
    const Eigen::Vector2d& a,
    const Eigen::Vector2d& b,
    const Eigen::Vector2d& c) const {
  Eigen::Vector2d ab = b - a;
  Eigen::Vector2d ac = c - a;
  return ab.x() * ac.y() - ab.y() * ac.x();
}

bool PathRegularizer::segmentIntersect2D(
    const Eigen::Vector2d& a,
    const Eigen::Vector2d& b,
    const Eigen::Vector2d& c,
    const Eigen::Vector2d& d) const {
  double c1 = cross2D(a, b, c);
  double c2 = cross2D(a, b, d);
  double c3 = cross2D(c, d, a);
  double c4 = cross2D(c, d, b);

  // 严格相交判断。这里不处理共线重叠，避免太敏感。
  return (c1 * c2 < 0.0) && (c3 * c4 < 0.0);
}

double PathRegularizer::computePathCrossPenalty(
    const Eigen::Vector3d& cur_pos,
    const Eigen::Vector3d& target_pos) const {
  if (!enable_path_cross_penalty_) return 0.0;
  if (history_path_.size() < 3) return 0.0;

  Eigen::Vector2d a(cur_pos.x(), cur_pos.y());
  Eigen::Vector2d b(target_pos.x(), target_pos.y());

  int cross_count = 0;

  int valid_end = static_cast<int>(history_path_.size()) - 1 - skip_recent_segments_;
  if (valid_end <= 1) return 0.0;

  for (int i = 0; i < valid_end; ++i) {
    Eigen::Vector2d c(history_path_[i].x(), history_path_[i].y());
    Eigen::Vector2d d(history_path_[i + 1].x(), history_path_[i + 1].y());

    if (segmentIntersect2D(a, b, c, d)) {
      ++cross_count;
    }
  }

  return w_path_cross_ * static_cast<double>(cross_count);
}

double PathRegularizer::computeLargeTurnPenalty(
    const Eigen::Vector3d& cur_pos,
    const Eigen::Vector3d& target_pos,
    const Eigen::Vector3d& cur_vel,
    const Eigen::Vector3d& cur_yaw) const {
  if (!enable_large_turn_penalty_) return 0.0;

  Eigen::Vector3d target_dir = target_pos - cur_pos;
  target_dir.z() = 0.0;

  if (target_dir.norm() < 1e-3) return 0.0;
  target_dir.normalize();

  Eigen::Vector3d current_dir;

  // 优先用速度方向；速度太小时，用 yaw 朝向。
  Eigen::Vector3d vel_xy = cur_vel;
  vel_xy.z() = 0.0;

  if (vel_xy.norm() > 0.2) {
    current_dir = vel_xy.normalized();
  } else {
    current_dir = Eigen::Vector3d(std::cos(cur_yaw[0]), std::sin(cur_yaw[0]), 0.0);
  }

  double dot_val = current_dir.dot(target_dir);
  dot_val = std::max(-1.0, std::min(1.0, dot_val));

  double angle = std::acos(dot_val);
  double threshold = turn_angle_threshold_deg_ * M_PI / 180.0;

  if (angle <= threshold) return 0.0;

  // 超过 120° 的部分才惩罚，越大惩罚越强
  double excess = angle - threshold;
  return w_large_turn_ * excess * excess;
}

double PathRegularizer::computeTransitionTurnPenalty(
    const Eigen::Vector3d& prev_pos,
    const Eigen::Vector3d& from_pos,
    const Eigen::Vector3d& to_pos) const {
  if (!enable_large_turn_penalty_) return 0.0;

  Eigen::Vector3d dir1 = from_pos - prev_pos;
  Eigen::Vector3d dir2 = to_pos - from_pos;

  dir1.z() = 0.0;
  dir2.z() = 0.0;

  if (dir1.norm() < 1e-3 || dir2.norm() < 1e-3) return 0.0;

  dir1.normalize();
  dir2.normalize();

  double dot_val = dir1.dot(dir2);
  dot_val = std::max(-1.0, std::min(1.0, dot_val));

  double angle = std::acos(dot_val);
  double threshold = turn_angle_threshold_deg_ * M_PI / 180.0;

  if (angle <= threshold) return 0.0;

  double excess = angle - threshold;
  return w_large_turn_ * excess * excess;
}

double PathRegularizer::computeTargetRegularization(
    const Eigen::Vector3d& cur_pos,
    const Eigen::Vector3d& target_pos,
    const Eigen::Vector3d& cur_vel,
    const Eigen::Vector3d& cur_yaw) const {
  double cross_penalty = computePathCrossPenalty(cur_pos, target_pos);
  double turn_penalty = computeLargeTurnPenalty(cur_pos, target_pos, cur_vel, cur_yaw);

  return cross_penalty + turn_penalty;
}

}  // namespace fast_planner