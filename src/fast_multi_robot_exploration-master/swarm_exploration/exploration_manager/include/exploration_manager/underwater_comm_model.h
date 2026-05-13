#pragma once

#include <ros/ros.h>
#include <Eigen/Eigen>
#include <cmath>
#include <algorithm>

namespace fast_planner {

// UnderwaterCommModel:
// 将原来的硬阈值通信范围，改成连续通信质量衰减。
// quality = exp(-alpha * distance)
// 当 quality < min_quality 时产生惩罚。
class UnderwaterCommModel {
 public:
  UnderwaterCommModel() = default;

  void init(ros::NodeHandle& nh);

  double quality(double distance) const;

  double risk(double distance) const;

  double alpha() const { return alpha_; }
  double minQuality() const { return min_quality_; }

 private:
  double alpha_ = 0.05;
  double min_quality_ = 0.3;
};

}  // namespace fast_planner