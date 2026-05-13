#pragma once

#include <ros/ros.h>
#include <Eigen/Eigen>
#include <cmath>

namespace fast_planner {

// OceanCurrentField:
// 第一版使用常量洋流 + 可选深度扰动。
// 目的：让目标选择考虑“顺流/逆流”的能耗差异。
class OceanCurrentField {
 public:
  OceanCurrentField() = default;

  void init(ros::NodeHandle& nh);

  Eigen::Vector3d queryCurrent(const Eigen::Vector3d& pos) const;

  // 计算从 cur_pos 指向 target_pos 时的逆流能耗惩罚。
  double currentEnergyPenalty(
      const Eigen::Vector3d& cur_pos,
      const Eigen::Vector3d& target_pos) const;

 private:
  bool enable_ = false;

  double current_x_ = 0.0;
  double current_y_ = 0.0;
  double current_z_ = 0.0;

  // 是否加入一个简单深度扰动项，模拟不同深度水流差异
  bool enable_depth_variation_ = false;
  double depth_variation_amp_ = 0.0;
  double depth_variation_freq_ = 0.1;
};

}  // namespace fast_planner