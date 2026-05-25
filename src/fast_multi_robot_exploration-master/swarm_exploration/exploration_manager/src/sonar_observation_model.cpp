#include <exploration_manager/sonar_observation_model.h>

namespace fast_planner {

void SonarObservationModel::init(ros::NodeHandle& nh) {
  nh.param("sonar/enable", enable_, false);

  nh.param("sonar/min_range", min_range_, 0.5);
  nh.param("sonar/max_range", max_range_, 12.0);

  double h_fov_deg = 90.0;
  double v_fov_deg = 30.0;

  nh.param("sonar/horizontal_fov_deg", h_fov_deg, 90.0);
  nh.param("sonar/vertical_fov_deg", v_fov_deg, 30.0);
  nh.param("sonar/forward_only", forward_only_, true);

  horizontal_fov_rad_ = h_fov_deg * M_PI / 180.0;
  vertical_fov_rad_ = v_fov_deg * M_PI / 180.0;
}

bool SonarObservationModel::isTargetObservable(
    const Eigen::Vector3d& sensor_pos,
    const Eigen::Vector3d& sensor_yaw,
    const Eigen::Vector3d& target_pos) const {
  if (!enable_) return true;

  Eigen::Vector3d rel = target_pos - sensor_pos;
  double range = rel.norm();

  if (range < min_range_ || range > max_range_) {
    return false;
  }

  double yaw = sensor_yaw[0];

  Eigen::Vector3d forward(std::cos(yaw), std::sin(yaw), 0.0);
  Eigen::Vector3d right(-std::sin(yaw), std::cos(yaw), 0.0);
  Eigen::Vector3d up(0.0, 0.0, 1.0);

  double x = rel.dot(forward);
  double y = rel.dot(right);
  double z = rel.dot(up);

  if (forward_only_ && x <= 0.0) {
    return false;
  }

  double horizontal_angle = std::atan2(std::abs(y), std::max(1e-6, x));
  double vertical_angle =
      std::atan2(std::abs(z), std::max(1e-6, std::sqrt(x * x + y * y)));

  if (horizontal_angle > 0.5 * horizontal_fov_rad_) {
    return false;
  }

  if (vertical_angle > 0.5 * vertical_fov_rad_) {
    return false;
  }

  return true;
}

}  // namespace fast_planner