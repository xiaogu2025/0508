#include <exploration_manager/auv_physics_model.h>

namespace fast_planner {

void AUVPhysicsModel::init(ros::NodeHandle& nh) {
  nh.param("auv_physics/min_turn_radius", min_turn_radius_, 3.0);
}

double AUVPhysicsModel::computeCurvature(
    const Eigen::Vector3d& p_prev,
    const Eigen::Vector3d& p_cur,
    const Eigen::Vector3d& p_next) const {
  Eigen::Vector3d v1 = p_cur - p_prev;
  Eigen::Vector3d v2 = p_next - p_cur;

  v1.z() = 0.0;
  v2.z() = 0.0;

  if (v1.norm() < 1e-6 || v2.norm() < 1e-6) return 0.0;

  double dot_val =
      std::max(-1.0, std::min(1.0, v1.normalized().dot(v2.normalized())));

  double angle = std::acos(dot_val);
  double arc_len = 0.5 * (v1.norm() + v2.norm());

  if (arc_len < 1e-6) return 0.0;

  return angle / arc_len;
}

bool AUVPhysicsModel::isTurnFeasible(
    const Eigen::Vector3d& p_prev,
    const Eigen::Vector3d& p_cur,
    const Eigen::Vector3d& p_next) const {
  double curvature = computeCurvature(p_prev, p_cur, p_next);
  double max_curvature = 1.0 / std::max(1e-6, min_turn_radius_);

  return curvature <= max_curvature;
}

}  // namespace fast_planner