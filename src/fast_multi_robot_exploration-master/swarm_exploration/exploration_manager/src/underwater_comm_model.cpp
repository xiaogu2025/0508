#include <exploration_manager/underwater_comm_model.h>

namespace fast_planner {

void UnderwaterCommModel::init(ros::NodeHandle& nh) {
  nh.param("underwater_comm/alpha", alpha_, 0.05);
  nh.param("underwater_comm/min_quality", min_quality_, 0.3);
}

double UnderwaterCommModel::quality(double distance) const {
  return std::exp(-alpha_ * std::max(0.0, distance));
}

bool UnderwaterCommModel::isLinkFeasible(double distance) const {
  return quality(distance) >= min_quality_;
}

}  // namespace fast_planner