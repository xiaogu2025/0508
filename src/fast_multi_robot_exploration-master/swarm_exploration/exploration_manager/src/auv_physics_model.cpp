#include <exploration_manager/auv_physics_model.h>

namespace fast_planner {

void AUVPhysicsModel::init(ros::NodeHandle& nh) {
  nh.param("auv_physics/min_turn_radius", min_turn_radius_, 3.0);
}

double AUVPhysicsModel::computeCurvature(
    const Eigen::Vector3d& p_prev,
    const Eigen::Vector3d& p_cur,
    const Eigen::Vector3d& p_next) const {
  Eigen::Vector3d a = p_cur - p_prev;
  Eigen::Vector3d b = p_next - p_cur;

  a.z() = 0.0;
  b.z() = 0.0;

  if (a.norm() < eps_ || b.norm() < eps_) {
    return 0.0;
  }

  Eigen::Vector3d an = a.normalized();
  Eigen::Vector3d bn = b.normalized();

  double dot_val = std::max(-1.0, std::min(1.0, an.dot(bn)));
  double angle = std::acos(dot_val);

  // 用两段平均长度近似转弯尺度。
  double length = 0.5 * (a.norm() + b.norm());
  if (length < eps_) return 0.0;

  // 近似曲率：转角 / 路径长度
  return angle / length;
}

double AUVPhysicsModel::curvaturePenalty(
    const Eigen::Vector3d& p_prev,
    const Eigen::Vector3d& p_cur,
    const Eigen::Vector3d& p_next) const {
  double curvature = computeCurvature(p_prev, p_cur, p_next);
  double max_curvature = 1.0 / std::max(min_turn_radius_, eps_);

  if (curvature <= max_curvature) {
    return 0.0;
  }

  double excess = curvature - max_curvature;
  return excess * excess;
}

}  // namespace fast_planner