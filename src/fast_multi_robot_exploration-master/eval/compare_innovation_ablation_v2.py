#!/usr/bin/env python3
# -*- coding: utf-8 -*-

# 命令
# python3 ~/myproject/rosNavigation_ws/scripts/compare_innovation_ablation_v2.py \
#   --root ~/myproject/rosNavigation_ws/eval_logs \
#   --exps A0,A1,A2 \
#   --runs run1,run2,run3


"""
compare_innovation_ablation_v2.py

用于汇总 A0/A1/A2/A3 多次实验结果，支持读取 run1、run2、run3，以及更多 run*。

默认读取目录结构：
  ~/myproject/rosNavigation_ws/eval_logs/
    A0/run1/planning_eval_drone_1.csv
    A0/run1/planning_eval_drone_2.csv
    A0/run2/planning_eval_drone_1.csv
    A1/run1/planning_eval_drone_1.csv
    ...

兼容：
  planning_eval.csv
  planning_eval_drone_*.csv

常用命令：
  python3 compare_innovation_ablation_v2.py \
    --root ~/myproject/rosNavigation_ws/eval_logs \
    --runs run1,run2,run3

输出：
  ablation_drone_detail.csv
  ablation_run_summary.csv
  ablation_exp_summary.csv
  innovation_report.md
  plots/*.png
"""

import argparse
import csv
import math
import os
from pathlib import Path
from statistics import stdev
from collections import defaultdict


DEFAULT_EXPS = ["A0", "A1", "A2", "A3"]


def to_float(x, default=0.0):
    try:
        if x is None or x == "":
            return default
        return float(x)
    except Exception:
        return default


def to_int(x, default=0):
    try:
        if x is None or x == "":
            return default
        return int(float(x))
    except Exception:
        return default


def safe_mean(values, default=0.0):
    vals = []
    for v in values:
        if v is None:
            continue
        if isinstance(v, float) and math.isnan(v):
            continue
        vals.append(v)
    if not vals:
        return default
    return sum(vals) / len(vals)


def safe_std(values, default=0.0):
    vals = []
    for v in values:
        if v is None:
            continue
        if isinstance(v, float) and math.isnan(v):
            continue
        vals.append(v)
    if len(vals) <= 1:
        return default
    return stdev(vals)


def read_csv_rows(path):
    rows = []
    with open(path, "r", encoding="utf-8", errors="ignore") as f:
        reader = csv.DictReader(f)
        for r in reader:
            rows.append(r)
    return rows


def parse_list_arg(text, default_values):
    if text is None or str(text).strip() == "":
        return default_values
    items = [x.strip() for x in str(text).split(",") if x.strip()]
    return items if items else default_values


def find_log_files(root, exp, runs=None):
    """
    runs:
      None 或 []：读取该 exp 下所有 run*
      ["run1","run2","run3"]：只读取这些 run
    """
    exp_dir = root / exp
    if not exp_dir.exists():
        return []

    run_dirs = []
    if runs:
        for r in runs:
            d = exp_dir / r
            if d.exists():
                run_dirs.append(d)
            else:
                print(f"[WARN] {exp}/{r} 不存在：{d}")
    else:
        run_dirs = sorted([p for p in exp_dir.glob("run*") if p.is_dir()])

    files = []
    for d in run_dirs:
        files.extend(sorted(d.glob("planning_eval_drone_*.csv")))
        files.extend(sorted(d.glob("planning_eval.csv")))

    # 去重
    out = []
    seen = set()
    for f in files:
        s = str(f.resolve())
        if s not in seen:
            out.append(f)
            seen.add(s)
    return out


def get_run_name(path):
    try:
        return path.parent.name
    except Exception:
        return "run_unknown"


def get_drone_id_from_path_or_row(path, first_row):
    if first_row.get("drone_id", "") != "":
        return str(first_row.get("drone_id"))

    name = path.stem
    # planning_eval_drone_3 -> 3
    if "drone_" in name:
        return name.split("drone_")[-1]
    return name


def summarize_drone_file(path):
    rows = read_csv_rows(path)
    if not rows:
        return None

    first = rows[0]
    last = rows[-1]

    drone_id = get_drone_id_from_path_or_row(path, first)

    times = [to_float(r.get("time")) for r in rows]
    total_time = max(times) - min(times) if times else 0.0

    travel_dist = to_float(last.get("travel_dist"))
    plan_steps = len(rows)
    success_rate = safe_mean([to_float(r.get("success")) for r in rows])

    # frontier/trail 残留变化
    first_frontier = to_int(first.get("num_frontier"))
    last_frontier = to_int(last.get("num_frontier"))
    first_trail = to_int(first.get("num_trail"))
    last_trail = to_int(last.get("num_trail"))
    first_unlabeled = to_int(first.get("num_unlabeled"))
    last_unlabeled = to_int(last.get("num_unlabeled"))

    first_remaining = first_frontier + first_trail + first_unlabeled
    last_remaining = last_frontier + last_trail + last_unlabeled

    frontier_drop = first_frontier - last_frontier
    trail_drop = first_trail - last_trail
    unlabeled_drop = first_unlabeled - last_unlabeled
    remaining_drop = first_remaining - last_remaining

    trail_cleanup_ratio = trail_drop / max(1, first_trail)
    remaining_cleanup_ratio = remaining_drop / max(1, first_remaining)

    # 目标冲突/通信风险
    duplicate_rate = safe_mean([1.0 if to_int(r.get("duplicate_target_count")) > 0 else 0.0 for r in rows])
    comm_risk_rate = safe_mean([1.0 if to_int(r.get("comm_risk_count")) > 0 else 0.0 for r in rows])

    duplicate_count_mean = safe_mean([to_int(r.get("duplicate_target_count")) for r in rows])
    comm_risk_count_mean = safe_mean([to_int(r.get("comm_risk_count")) for r in rows])

    # 角色
    role_after = [r.get("role_after", "") for r in rows]
    role_before = [r.get("role_before", "") for r in rows]

    explorer_ratio = safe_mean([1.0 if x == "EXPLORER" else 0.0 for x in role_after])
    collector_ratio = safe_mean([1.0 if x == "COLLECTOR" else 0.0 for x in role_after])
    unknown_ratio = safe_mean([1.0 if x == "UNKNOWN" else 0.0 for x in role_after])

    role_adjust_rate = safe_mean([1.0 if b != a else 0.0 for b, a in zip(role_before, role_after)])

    role_switch_count = 0
    prev = None
    for x in role_after:
        if prev is not None and x != prev:
            role_switch_count += 1
        prev = x

    # 规划来源
    plan_sources = [r.get("plan_source", "") for r in rows]
    greedy_ratio = safe_mean([1.0 if x == "greedy" else 0.0 for x in plan_sources])
    trail_tour_ratio = safe_mean([1.0 if x in ("trail_tour", "single_trail") else 0.0 for x in plan_sources])
    explorer_plan_ratio = safe_mean([1.0 if x == "explorer" else 0.0 for x in plan_sources])
    none_plan_ratio = safe_mean([1.0 if x in ("", "none") else 0.0 for x in plan_sources])

    # 选中目标类型
    selected_labels = [r.get("selected_label", "") for r in rows]
    selected_frontier_ratio = safe_mean([1.0 if x == "FRONTIER" else 0.0 for x in selected_labels])
    selected_trail_ratio = safe_mean([1.0 if x == "TRAIL" else 0.0 for x in selected_labels])
    selected_unlabeled_ratio = safe_mean([1.0 if x == "UNLABELED" else 0.0 for x in selected_labels])

    # 代价项
    mean_base_cost = safe_mean([to_float(r.get("base_cost")) for r in rows])
    mean_ft_cost = safe_mean([to_float(r.get("ft_cost")) for r in rows])
    mean_high_order_cost = safe_mean([to_float(r.get("high_order_cost")) for r in rows])
    mean_total_extra_cost = safe_mean([to_float(r.get("total_extra_cost")) for r in rows])

    mean_s_explorer = safe_mean([to_float(r.get("S_explorer")) for r in rows])
    mean_s_collector = safe_mean([to_float(r.get("S_collector")) for r in rows])

    mean_j_competition = safe_mean([to_float(r.get("J_competition")) for r in rows])
    mean_j_comm = safe_mean([to_float(r.get("J_comm")) for r in rows])
    mean_j_redundant = safe_mean([to_float(r.get("J_redundant_cleanup")) for r in rows])

    return {
        "file": str(path),
        "drone_id": str(drone_id),
        "total_time": total_time,
        "travel_dist": travel_dist,
        "plan_steps": plan_steps,
        "success_rate": success_rate,

        "first_frontier": first_frontier,
        "last_frontier": last_frontier,
        "first_trail": first_trail,
        "last_trail": last_trail,
        "first_unlabeled": first_unlabeled,
        "last_unlabeled": last_unlabeled,
        "first_remaining": first_remaining,
        "last_remaining": last_remaining,

        "frontier_drop": frontier_drop,
        "trail_drop": trail_drop,
        "unlabeled_drop": unlabeled_drop,
        "remaining_drop": remaining_drop,
        "trail_cleanup_ratio": trail_cleanup_ratio,
        "remaining_cleanup_ratio": remaining_cleanup_ratio,

        "duplicate_rate": duplicate_rate,
        "comm_risk_rate": comm_risk_rate,
        "duplicate_count_mean": duplicate_count_mean,
        "comm_risk_count_mean": comm_risk_count_mean,

        "explorer_ratio": explorer_ratio,
        "collector_ratio": collector_ratio,
        "unknown_ratio": unknown_ratio,
        "role_adjust_rate": role_adjust_rate,
        "role_switch_count": role_switch_count,

        "greedy_ratio": greedy_ratio,
        "trail_tour_ratio": trail_tour_ratio,
        "explorer_plan_ratio": explorer_plan_ratio,
        "none_plan_ratio": none_plan_ratio,

        "selected_frontier_ratio": selected_frontier_ratio,
        "selected_trail_ratio": selected_trail_ratio,
        "selected_unlabeled_ratio": selected_unlabeled_ratio,

        "mean_base_cost": mean_base_cost,
        "mean_ft_cost": mean_ft_cost,
        "mean_high_order_cost": mean_high_order_cost,
        "mean_total_extra_cost": mean_total_extra_cost,

        "mean_s_explorer": mean_s_explorer,
        "mean_s_collector": mean_s_collector,

        "mean_j_competition": mean_j_competition,
        "mean_j_comm": mean_j_comm,
        "mean_j_redundant": mean_j_redundant,
    }


def aggregate_run(drone_summaries):
    if not drone_summaries:
        return None

    # 对一次 run：
    # 时间：取所有 drone 的最大运行时间
    # 距离/步数：所有 drone 求和
    out = {
        "num_drones_logged": len(drone_summaries),
        "total_time": max(d["total_time"] for d in drone_summaries),
        "total_travel_dist": sum(d["travel_dist"] for d in drone_summaries),
        "total_plan_steps": sum(d["plan_steps"] for d in drone_summaries),
    }

    # 其他指标：多机取均值
    keys_mean = [
        "success_rate",
        "last_frontier",
        "last_trail",
        "last_unlabeled",
        "last_remaining",
        "frontier_drop",
        "trail_drop",
        "unlabeled_drop",
        "remaining_drop",
        "trail_cleanup_ratio",
        "remaining_cleanup_ratio",
        "duplicate_rate",
        "comm_risk_rate",
        "duplicate_count_mean",
        "comm_risk_count_mean",
        "explorer_ratio",
        "collector_ratio",
        "unknown_ratio",
        "role_adjust_rate",
        "role_switch_count",
        "greedy_ratio",
        "trail_tour_ratio",
        "explorer_plan_ratio",
        "none_plan_ratio",
        "selected_frontier_ratio",
        "selected_trail_ratio",
        "selected_unlabeled_ratio",
        "mean_base_cost",
        "mean_ft_cost",
        "mean_high_order_cost",
        "mean_total_extra_cost",
        "mean_s_explorer",
        "mean_s_collector",
        "mean_j_competition",
        "mean_j_comm",
        "mean_j_redundant",
    ]

    for k in keys_mean:
        out[k] = safe_mean([d.get(k, 0.0) for d in drone_summaries])

    return out


def write_csv(path, rows, fieldnames):
    path.parent.mkdir(parents=True, exist_ok=True)
    with open(path, "w", newline="", encoding="utf-8") as f:
        writer = csv.DictWriter(f, fieldnames=fieldnames)
        writer.writeheader()
        for r in rows:
            writer.writerow({k: r.get(k, "") for k in fieldnames})


def pct_change_improvement(new, old, lower_is_better=True):
    """
    返回“改善百分比”。
    lower_is_better=True:
      old=100, new=90 -> +10%
      old=100, new=110 -> -10%
    lower_is_better=False:
      old=100, new=110 -> +10%
    """
    if old is None or abs(old) < 1e-9:
        return 0.0
    raw = (new - old) / abs(old) * 100.0
    return -raw if lower_is_better else raw


def compare_metric(exp_summary, exp_new, exp_old, metric, lower_is_better=True):
    if exp_new not in exp_summary or exp_old not in exp_summary:
        return None
    new = exp_summary[exp_new].get(metric, 0.0)
    old = exp_summary[exp_old].get(metric, 0.0)
    return pct_change_improvement(new, old, lower_is_better=lower_is_better)


def verdict_from_score(score):
    if score is None:
        return "无法判断"
    if score >= 5.0:
        return "明显改善"
    if score >= 1.0:
        return "小幅改善"
    if score > -1.0:
        return "基本持平"
    if score > -5.0:
        return "小幅变差"
    return "明显变差"


def fmt(x, nd=3):
    if x is None:
        return "NA"
    try:
        return f"{float(x):.{nd}f}"
    except Exception:
        return str(x)


def generate_report(root, exp_summary, run_rows):
    lines = []
    lines.append("# A0-A3 多 run 消融实验评价报告\n\n")
    lines.append("## 实验组含义\n\n")
    lines.append("- **A0**：原始 FAME baseline\n")
    lines.append("- **A1**：A0 + 创新点1，Frontier–Trail 不确定性评分\n")
    lines.append("- **A2**：A1 + 创新点2，通信-能量-不确定性角色切换\n")
    lines.append("- **A3**：A2 + 创新点3，超图高阶协同目标分配\n\n")

    lines.append("## 已读取 run\n\n")
    lines.append("| exp | runs |\n")
    lines.append("| --- | --- |\n")
    by_exp_runs = defaultdict(list)
    for r in run_rows:
        by_exp_runs[r["exp"]].append(r["run"])
    for exp in DEFAULT_EXPS:
        runs = sorted(set(by_exp_runs.get(exp, [])))
        lines.append(f"| {exp} | {', '.join(runs) if runs else '无'} |\n")

    lines.append("\n## 各组核心指标均值\n\n")
    header = [
        "exp", "num_runs", "time", "dist", "last_trail",
        "last_remaining", "dup_rate", "comm_rate",
        "role_adjust", "ft_cost", "ho_cost"
    ]
    lines.append("| " + " | ".join(header) + " |\n")
    lines.append("| " + " | ".join(["---"] * len(header)) + " |\n")
    for exp in DEFAULT_EXPS:
        if exp not in exp_summary:
            continue
        s = exp_summary[exp]
        lines.append(
            "| " + " | ".join([
                exp,
                str(int(s.get("num_runs", 0))),
                fmt(s.get("total_time")),
                fmt(s.get("total_travel_dist")),
                fmt(s.get("last_trail")),
                fmt(s.get("last_remaining")),
                fmt(s.get("duplicate_rate")),
                fmt(s.get("comm_risk_rate")),
                fmt(s.get("role_adjust_rate")),
                fmt(s.get("mean_ft_cost")),
                fmt(s.get("mean_high_order_cost")),
            ]) + " |\n"
        )

    lines.append("\n## 创新点1评价：A1 相比 A0\n\n")
    if "A0" in exp_summary and "A1" in exp_summary:
        c_trail = compare_metric(exp_summary, "A1", "A0", "last_trail", True)
        c_remaining = compare_metric(exp_summary, "A1", "A0", "last_remaining", True)
        c_time = compare_metric(exp_summary, "A1", "A0", "total_time", True)
        ft_nonzero = abs(exp_summary["A1"].get("mean_ft_cost", 0.0)) > 1e-6
        score = safe_mean([c_trail, c_remaining, c_time])
        lines.append(f"- `last_trail` 改善幅度：{fmt(c_trail, 2)}%\n")
        lines.append(f"- `last_remaining` 改善幅度：{fmt(c_remaining, 2)}%\n")
        lines.append(f"- `total_time` 改善幅度：{fmt(c_time, 2)}%\n")
        lines.append(f"- A1 平均 `ft_cost`：{fmt(exp_summary['A1'].get('mean_ft_cost'))}，")
        lines.append("非零，说明创新点1参与决策。\n" if ft_nonzero else "接近 0，需要检查 `use_ft_score` 是否真正生效。\n")
        lines.append(f"- 综合判断：**{verdict_from_score(score)}**。\n")
    else:
        lines.append("- 缺少 A0 或 A1 日志，无法评价创新点1。\n")

    lines.append("\n## 创新点2评价：A2 相比 A1\n\n")
    if "A1" in exp_summary and "A2" in exp_summary:
        c_comm = compare_metric(exp_summary, "A2", "A1", "comm_risk_rate", True)
        c_time = compare_metric(exp_summary, "A2", "A1", "total_time", True)
        c_dist = compare_metric(exp_summary, "A2", "A1", "total_travel_dist", True)
        role_adjust = exp_summary["A2"].get("role_adjust_rate", 0.0)
        score = safe_mean([c_comm, c_time, c_dist])
        lines.append(f"- `comm_risk_rate` 改善幅度：{fmt(c_comm, 2)}%\n")
        lines.append(f"- `total_time` 改善幅度：{fmt(c_time, 2)}%\n")
        lines.append(f"- `total_travel_dist` 改善幅度：{fmt(c_dist, 2)}%\n")
        lines.append(f"- A2 `role_adjust_rate`：{fmt(role_adjust)}，表示水下角色选择器改变原始角色的比例。\n")
        if role_adjust <= 1e-6:
            lines.append("- 注意：`role_adjust_rate` 接近 0，说明创新点2可能没有真正改变角色；需要检查 `use_underwater_role` 或角色分数参数。\n")
        lines.append(f"- 综合判断：**{verdict_from_score(score)}**。\n")
    else:
        lines.append("- 缺少 A1 或 A2 日志，无法评价创新点2。\n")

    lines.append("\n## 创新点3评价：A3 相比 A2\n\n")
    if "A2" in exp_summary and "A3" in exp_summary:
        c_dup = compare_metric(exp_summary, "A3", "A2", "duplicate_rate", True)
        c_comm = compare_metric(exp_summary, "A3", "A2", "comm_risk_rate", True)
        c_time = compare_metric(exp_summary, "A3", "A2", "total_time", True)
        ho_nonzero = abs(exp_summary["A3"].get("mean_high_order_cost", 0.0)) > 1e-6
        score = safe_mean([c_dup, c_comm, c_time])
        lines.append(f"- `duplicate_rate` 改善幅度：{fmt(c_dup, 2)}%\n")
        lines.append(f"- `comm_risk_rate` 改善幅度：{fmt(c_comm, 2)}%\n")
        lines.append(f"- `total_time` 改善幅度：{fmt(c_time, 2)}%\n")
        lines.append(f"- A3 平均 `high_order_cost`：{fmt(exp_summary['A3'].get('mean_high_order_cost'))}，")
        lines.append("非零，说明创新点3参与决策。\n" if ho_nonzero else "接近 0，需要检查 `use_hypergraph_coord` 是否真正生效。\n")
        lines.append(
            f"- A3 平均 `J_competition/J_comm/J_redundant_cleanup`："
            f"{fmt(exp_summary['A3'].get('mean_j_competition'))} / "
            f"{fmt(exp_summary['A3'].get('mean_j_comm'))} / "
            f"{fmt(exp_summary['A3'].get('mean_j_redundant'))}\n"
        )
        lines.append(f"- 综合判断：**{verdict_from_score(score)}**。\n")
        lines.append("\n注意：A3-A2 只能证明“加入高阶协同是否有效”，还不能严格证明“超图高阶优于 pairwise”。后续最好再加 `A2_pairwise` 对照。\n")
    else:
        lines.append("- 缺少 A2 或 A3 日志，无法评价创新点3。\n")

    lines.append("\n## 建议\n\n")
    lines.append("1. 每组最好至少跑 run1/run2/run3，避免单次随机性影响结论。\n")
    lines.append("2. 如果 A1/A2/A3 总时间变差，但目标重复率或残留 trail 明显降低，可以调小 `w_ft_score` 或 `w_high_order`。\n")
    lines.append("3. 如果 `mean_ft_cost` 或 `mean_high_order_cost` 为 0，先检查 launch 开关和 C++ 接入位置。\n")

    report_path = root / "innovation_report.md"
    with open(report_path, "w", encoding="utf-8") as f:
        f.writelines(lines)
    return report_path


def make_plots(root, exp_summary):
    try:
        import matplotlib.pyplot as plt
    except Exception:
        return None

    plots_dir = root / "plots"
    plots_dir.mkdir(parents=True, exist_ok=True)

    metrics = [
        ("total_time", "Exploration Time"),
        ("total_travel_dist", "Total Travel Distance"),
        ("last_trail", "Final Trail Count"),
        ("last_remaining", "Final Remaining Count"),
        ("duplicate_rate", "Duplicate Target Rate"),
        ("comm_risk_rate", "Communication Risk Rate"),
        ("role_adjust_rate", "Role Adjustment Rate"),
        ("mean_ft_cost", "Mean FT Cost"),
        ("mean_high_order_cost", "Mean High-order Cost"),
    ]

    xs = [e for e in DEFAULT_EXPS if e in exp_summary]
    for metric, title in metrics:
        ys = [exp_summary[e].get(metric, 0.0) for e in xs]
        plt.figure()
        plt.bar(xs, ys)
        plt.title(title)
        plt.xlabel("Experiment")
        plt.ylabel(metric)
        plt.tight_layout()
        plt.savefig(plots_dir / f"{metric}.png", dpi=200)
        plt.close()

    return plots_dir


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument(
        "--root",
        default=os.path.expanduser("~/myproject/rosNavigation_ws/eval_logs"),
        help="eval_logs 根目录"
    )
    parser.add_argument(
        "--exps",
        default="A0,A1,A2,A3",
        help="要读取的实验组，逗号分隔，例如 A0,A1,A2,A3"
    )
    parser.add_argument(
        "--runs",
        default="",
        help="要读取的 run，逗号分隔，例如 run1,run2,run3。留空则读取所有 run*"
    )
    args = parser.parse_args()

    root = Path(args.root).expanduser().resolve()
    root.mkdir(parents=True, exist_ok=True)

    exps = parse_list_arg(args.exps, DEFAULT_EXPS)
    runs = parse_list_arg(args.runs, [])

    drone_rows = []
    run_groups = defaultdict(list)

    print(f"[INFO] root = {root}")
    print(f"[INFO] exps = {exps}")
    print(f"[INFO] runs = {runs if runs else 'all run*'}")

    for exp in exps:
        files = find_log_files(root, exp, runs=runs)
        if not files:
            print(f"[WARN] 未找到 {exp} 的日志文件")
            continue

        print(f"[INFO] {exp}: found {len(files)} csv files")
        for f in files:
            s = summarize_drone_file(f)
            if s is None:
                print(f"[WARN] 空文件或读取失败：{f}")
                continue
            run = get_run_name(f)
            s["exp"] = exp
            s["run"] = run
            drone_rows.append(s)
            run_groups[(exp, run)].append(s)

    if not drone_rows:
        print("[ERROR] 没有找到任何有效 planning_eval csv。")
        return

    # drone 级明细
    drone_keys = []
    for r in drone_rows:
        for k in r.keys():
            if k not in drone_keys:
                drone_keys.append(k)
    drone_fieldnames = ["exp", "run"] + [k for k in drone_keys if k not in ("exp", "run")]
    drone_detail_path = root / "ablation_drone_detail.csv"
    write_csv(drone_detail_path, drone_rows, drone_fieldnames)

    # run 级汇总
    run_rows = []
    for (exp, run), items in sorted(run_groups.items()):
        r = aggregate_run(items)
        if r is None:
            continue
        r["exp"] = exp
        r["run"] = run
        run_rows.append(r)

    if not run_rows:
        print("[ERROR] 没有有效 run 汇总。")
        return

    run_keys = []
    for r in run_rows:
        for k in r.keys():
            if k not in run_keys:
                run_keys.append(k)
    run_fieldnames = ["exp", "run"] + [k for k in run_keys if k not in ("exp", "run")]
    run_summary_path = root / "ablation_run_summary.csv"
    write_csv(run_summary_path, run_rows, run_fieldnames)

    # exp 级均值和标准差
    exp_rows = []
    exp_summary = {}
    metrics = [k for k in run_keys if k not in ("exp", "run")]

    for exp in exps:
        rows = [r for r in run_rows if r["exp"] == exp]
        if not rows:
            continue

        out = {"exp": exp, "num_runs": len(rows)}
        for m in metrics:
            vals = [to_float(r.get(m)) for r in rows]
            out[m] = safe_mean(vals)
            out[m + "_std"] = safe_std(vals)
        exp_rows.append(out)
        exp_summary[exp] = out

    exp_keys = []
    for r in exp_rows:
        for k in r.keys():
            if k not in exp_keys:
                exp_keys.append(k)

    exp_fieldnames = ["exp", "num_runs"] + [k for k in exp_keys if k not in ("exp", "num_runs")]
    exp_summary_path = root / "ablation_exp_summary.csv"
    write_csv(exp_summary_path, exp_rows, exp_fieldnames)

    report_path = generate_report(root, exp_summary, run_rows)
    plots_dir = make_plots(root, exp_summary)

    print("\n================ 输出文件 ================")
    print(f"Drone 明细: {drone_detail_path}")
    print(f"Run 汇总  : {run_summary_path}")
    print(f"Exp 汇总  : {exp_summary_path}")
    print(f"中文报告  : {report_path}")
    if plots_dir:
        print(f"图像目录  : {plots_dir}")
    else:
        print("图像目录  : 未生成，可能未安装 matplotlib")

    print("\n================ 快速结果 ================")
    for exp in exps:
        if exp not in exp_summary:
            continue
        s = exp_summary[exp]
        print(
            f"{exp}: "
            f"runs={int(s.get('num_runs', 0))}, "
            f"time={s.get('total_time', 0):.3f}, "
            f"dist={s.get('total_travel_dist', 0):.3f}, "
            f"trail={s.get('last_trail', 0):.3f}, "
            f"remain={s.get('last_remaining', 0):.3f}, "
            f"dup={s.get('duplicate_rate', 0):.3f}, "
            f"comm={s.get('comm_risk_rate', 0):.3f}, "
            f"ft={s.get('mean_ft_cost', 0):.3f}, "
            f"ho={s.get('mean_high_order_cost', 0):.3f}"
        )


if __name__ == "__main__":
    main()
