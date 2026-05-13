#include <exploration_manager/ocean_current_field.h>
#include <algorithm>

namespace fast_planner {

void OceanCurrentField::init(ros::NodeHandle& nh) {
  nh.param("ocean_current/enable", enable_, false);

  nh.param("ocean_current/current_x", current_x_, 0.0);
  nh.param("ocean_current/current_y", current_y_, 0.0);
  nh.param("ocean_current/current_z", current_z_, 0.0);

  nh.param("ocean_current/enable_depth_variation", enable_depth_variation_, false);
  nh.param("ocean_current/depth_variation_amp", depth_variation_amp_, 0.0);
  nh.param("ocean_current/depth_variation_freq", depth_variation_freq_, 0.1);
}

Eigen::Vector3d OceanCurrentField::queryCurrent(const Eigen::Vector3d& pos) const {
  if (!enable_) {
    return Eigen::Vector3d::Zero();
  }

  Eigen::Vector3d current(current_x_, current_y_, current_z_);

  if (enable_depth_variation_) {
    // 简单模拟：水流 x 方向随深度 z 轻微变化
    current.x() += depth_variation_amp_ * std::sin(depth_variation_freq_ * pos.z());
  }

  return current;
}

double OceanCurrentField::currentEnergyPenalty(
    const Eigen::Vector3d& cur_pos,
    const Eigen::Vector3d& target_pos) const {
  if (!enable_) return 0.0;

  Eigen::Vector3d dir = target_pos - cur_pos;
  dir.z() = 0.0;

  if (dir.norm() < 1e-6) return 0.0;
  dir.normalize();

  Eigen::Vector3d current = queryCurrent(cur_pos);
  current.z() = 0.0;

  if (current.norm() < 1e-6) return 0.0;

  Eigen::Vector3d current_dir = current.normalized();

  // dir 和 current_dir 反向时，说明逆流，惩罚大
  double against = std::max(0.0, -dir.dot(current_dir));

  return against * current.norm();
}

}  // namespace fast_planner