#pragma once

#include <ros/ros.h>
#include <cmath>
#include <algorithm>

namespace fast_planner {

class UnderwaterCommModel {
 public:
  UnderwaterCommModel() = default;

  void init(ros::NodeHandle& nh);

  // 连续通信质量模型：q(d)=exp(-alpha*d)
  double quality(double distance) const;

  // 硬约束：质量低于阈值，不认为可通信
  bool isLinkFeasible(double distance) const;

 private:
  double alpha_ = 0.05;
  double min_quality_ = 0.3;
};

}  // namespace fast_planner