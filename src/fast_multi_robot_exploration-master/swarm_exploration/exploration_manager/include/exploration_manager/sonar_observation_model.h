#pragma once

#include <ros/ros.h>
#include <Eigen/Eigen>
#include <cmath>
#include <algorithm>

namespace fast_planner {

// SonarObservationModel
// 真实含义：模拟前视声纳/多波束声纳的有限观测扇区。
// 注意：这里不是 sonar_cost，不是软代价。
// 目标如果不在声纳 range + FOV 内，直接认为当前不可观测。
class SonarObservationModel {
 public:
  SonarObservationModel() = default;

  void init(ros::NodeHandle& nh);

  bool enabled() const { return enable_; }

  bool isTargetObservable(
      const Eigen::Vector3d& sensor_pos,
      const Eigen::Vector3d& sensor_yaw,
      const Eigen::Vector3d& target_pos) const;

 private:
  bool enable_ = false;

  double min_range_ = 0.5;
  double max_range_ = 12.0;

  double horizontal_fov_rad_ = M_PI / 2.0;  // default 90 deg
  double vertical_fov_rad_ = M_PI / 6.0;    // default 30 deg

  bool forward_only_ = true;
};

}  // namespace fast_planner