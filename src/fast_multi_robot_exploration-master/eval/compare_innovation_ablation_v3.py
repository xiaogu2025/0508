#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
compare_innovation_ablation_v3.py

在 v2 基础上增强：
1) 支持 A0/A1/A2/A3/A3_old/A3_PR_turn/A3_PR_cross/A3_PR_both 等任意实验组；
2) 增加 PathRegularizer 评价：path_cross_cost / large_turn_cost / path_reg_cost；
3) 增加创新点激活率：ft_active_rate / high_order_active_rate / path_reg_active_rate；
4) 报告中同时评价：
   - 创新点1：A1 vs A0
   - 创新点2：A2 vs A1
   - 创新点3：A3 vs A2
   - 路径正则稳定项：A3_PR_* vs A3_old
5) 输出 CSV、Markdown 报告和柱状图。

典型命令：
  python3 compare_innovation_ablation_v3.py \
    --root ~/myproject/rosNavigation_ws/eval_logs \
    --exps A0,A1,A2,A3,A3_old,A3_PR_turn,A3_PR_cross,A3_PR_both \
    --runs run1,run2,run3

兼容文件：
  planning_eval.csv
  planning_eval_drone_*.csv
"""

import argparse
import csv
import math
import os
from pathlib import Path
from statistics import stdev
from collections import defaultdict


DEFAULT_EXPS = [
    "A0", "A1", "A2", "A3",
    "A3_old", "A3_PR_turn", "A3_PR_cross", "A3_PR_both"
]
EPS_ACTIVE = 1e-6


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
    exp_dir = root / exp
    if not exp_dir.exists():
        return []

    if runs:
        run_dirs = []
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

    out = []
    seen = set()
    for f in files:
        s = str(f.resolve())
        if s not in seen:
            out.append(f)
            seen.add(s)
    return out


def get_run_name(path):
    return path.parent.name if path and path.parent else "run_unknown"


def get_drone_id_from_path_or_row(path, first_row):
    if first_row.get("drone_id", "") != "":
        return str(first_row.get("drone_id"))
    name = path.stem
    if "drone_" in name:
        return name.split("drone_")[-1]
    return name


def col(rows, name, default=0.0):
    return [to_float(r.get(name), default) for r in rows]


def active_rate(rows, name):
    vals = col(rows, name)
    return safe_mean([1.0 if abs(v) > EPS_ACTIVE else 0.0 for v in vals])


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

    duplicate_rate = safe_mean([1.0 if to_int(r.get("duplicate_target_count")) > 0 else 0.0 for r in rows])
    comm_risk_rate = safe_mean([1.0 if to_int(r.get("comm_risk_count")) > 0 else 0.0 for r in rows])
    duplicate_count_mean = safe_mean([to_int(r.get("duplicate_target_count")) for r in rows])
    comm_risk_count_mean = safe_mean([to_int(r.get("comm_risk_count")) for r in rows])

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

    plan_sources = [r.get("plan_source", "") for r in rows]
    greedy_ratio = safe_mean([1.0 if x == "greedy" else 0.0 for x in plan_sources])
    trail_tour_ratio = safe_mean([1.0 if x in ("trail_tour", "single_trail") else 0.0 for x in plan_sources])
    explorer_plan_ratio = safe_mean([1.0 if x == "explorer" else 0.0 for x in plan_sources])
    none_plan_ratio = safe_mean([1.0 if x in ("", "none") else 0.0 for x in plan_sources])

    selected_labels = [r.get("selected_label", "") for r in rows]
    selected_frontier_ratio = safe_mean([1.0 if x == "FRONTIER" else 0.0 for x in selected_labels])
    selected_trail_ratio = safe_mean([1.0 if x == "TRAIL" else 0.0 for x in selected_labels])
    selected_unlabeled_ratio = safe_mean([1.0 if x == "UNLABELED" else 0.0 for x in selected_labels])

    # 原有代价项
    mean_base_cost = safe_mean(col(rows, "base_cost"))
    mean_ft_cost = safe_mean(col(rows, "ft_cost"))
    mean_high_order_cost = safe_mean(col(rows, "high_order_cost"))
    mean_total_extra_cost = safe_mean(col(rows, "total_extra_cost"))

    mean_s_explorer = safe_mean(col(rows, "S_explorer"))
    mean_s_collector = safe_mean(col(rows, "S_collector"))
    mean_j_competition = safe_mean(col(rows, "J_competition"))
    mean_j_comm = safe_mean(col(rows, "J_comm"))
    mean_j_redundant = safe_mean(col(rows, "J_redundant_cleanup"))

    # 新增：路径正则项。没有对应列时自动为 0，兼容旧日志。
    mean_path_cross_cost = safe_mean(col(rows, "path_cross_cost"))
    mean_large_turn_cost = safe_mean(col(rows, "large_turn_cost"))
    mean_path_reg_cost = safe_mean(col(rows, "path_reg_cost"))

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

        "mean_path_cross_cost": mean_path_cross_cost,
        "mean_large_turn_cost": mean_large_turn_cost,
        "mean_path_reg_cost": mean_path_reg_cost,

        "ft_active_rate": active_rate(rows, "ft_cost"),
        "high_order_active_rate": active_rate(rows, "high_order_cost"),
        "path_cross_active_rate": active_rate(rows, "path_cross_cost"),
        "large_turn_active_rate": active_rate(rows, "large_turn_cost"),
        "path_reg_active_rate": active_rate(rows, "path_reg_cost"),
    }


def aggregate_run(drone_summaries):
    if not drone_summaries:
        return None

    out = {
        "num_drones_logged": len(drone_summaries),
        "total_time": max(d["total_time"] for d in drone_summaries),
        "total_travel_dist": sum(d["travel_dist"] for d in drone_summaries),
        "total_plan_steps": sum(d["plan_steps"] for d in drone_summaries),
    }

    keys_mean = [
        "success_rate",
        "last_frontier", "last_trail", "last_unlabeled", "last_remaining",
        "frontier_drop", "trail_drop", "unlabeled_drop", "remaining_drop",
        "trail_cleanup_ratio", "remaining_cleanup_ratio",
        "duplicate_rate", "comm_risk_rate", "duplicate_count_mean", "comm_risk_count_mean",
        "explorer_ratio", "collector_ratio", "unknown_ratio", "role_adjust_rate", "role_switch_count",
        "greedy_ratio", "trail_tour_ratio", "explorer_plan_ratio", "none_plan_ratio",
        "selected_frontier_ratio", "selected_trail_ratio", "selected_unlabeled_ratio",
        "mean_base_cost", "mean_ft_cost", "mean_high_order_cost", "mean_total_extra_cost",
        "mean_s_explorer", "mean_s_collector",
        "mean_j_competition", "mean_j_comm", "mean_j_redundant",
        "mean_path_cross_cost", "mean_large_turn_cost", "mean_path_reg_cost",
        "ft_active_rate", "high_order_active_rate",
        "path_cross_active_rate", "large_turn_active_rate", "path_reg_active_rate",
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


def add_pair_report(lines, title, exp_new, exp_old, exp_summary, checks):
    lines.append(f"\n## {title}：{exp_new} 相比 {exp_old}\n\n")
    if exp_old not in exp_summary or exp_new not in exp_summary:
        lines.append(f"- 缺少 `{exp_old}` 或 `{exp_new}` 日志，无法评价。\n")
        return
    scores = []
    for metric, lower_is_better, desc in checks:
        c = compare_metric(exp_summary, exp_new, exp_old, metric, lower_is_better)
        scores.append(c)
        better_text = "越低越好" if lower_is_better else "越高越好"
        lines.append(f"- `{metric}`（{desc}，{better_text}）改善幅度：{fmt(c, 2)}%\n")
    score = safe_mean(scores)
    lines.append(f"- 综合判断：**{verdict_from_score(score)}**。\n")


def generate_report(root, exp_summary, run_rows, exps):
    lines = []
    lines.append("# 创新点与路径正则消融实验评价报告\n\n")

    lines.append("## 实验组含义\n\n")
    exp_desc = {
        "A0": "原始 FAME baseline",
        "A1": "A0 + 创新点1，Frontier–Trail 不确定性评分",
        "A2": "A1 + 创新点2，通信-能量-不确定性角色切换",
        "A3": "A2 + 创新点3，超图高阶协同目标分配",
        "A3_old": "完整 A3，但不开路径正则",
        "A3_PR_turn": "A3_old + 只开大转角惩罚",
        "A3_PR_cross": "A3_old + 只开路径交叉惩罚",
        "A3_PR_both": "A3_old + 同时开启大转角和路径交叉惩罚",
        "A3_PR": "A3_old + 路径正则",
        "A2_pairwise": "A2 + pairwise 协同对照",
        "A3_hyper": "A2 + hypergraph 高阶协同",
    }
    for e in exps:
        lines.append(f"- **{e}**：{exp_desc.get(e, '自定义实验组')}\n")

    lines.append("\n## 已读取 run\n\n")
    lines.append("| exp | runs |\n")
    lines.append("| --- | --- |\n")
    by_exp_runs = defaultdict(list)
    for r in run_rows:
        by_exp_runs[r["exp"]].append(r["run"])
    for exp in exps:
        runs = sorted(set(by_exp_runs.get(exp, [])))
        lines.append(f"| {exp} | {', '.join(runs) if runs else '无'} |\n")

    lines.append("\n## 各组核心指标均值\n\n")
    header = [
        "exp", "runs", "time", "dist", "last_trail", "last_remaining",
        "dup", "comm", "role_adj", "ft", "ho", "cross", "turn", "path_reg"
    ]
    lines.append("| " + " | ".join(header) + " |\n")
    lines.append("| " + " | ".join(["---"] * len(header)) + " |\n")
    for exp in exps:
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
                fmt(s.get("mean_path_cross_cost")),
                fmt(s.get("mean_large_turn_cost")),
                fmt(s.get("mean_path_reg_cost")),
            ]) + " |\n"
        )

    lines.append("\n## 模块激活率检查\n\n")
    lines.append("| exp | ft_active | ho_active | cross_active | turn_active | path_reg_active |\n")
    lines.append("| --- | --- | --- | --- | --- | --- |\n")
    for exp in exps:
        if exp not in exp_summary:
            continue
        s = exp_summary[exp]
        lines.append(
            f"| {exp} | {fmt(s.get('ft_active_rate'))} | {fmt(s.get('high_order_active_rate'))} | "
            f"{fmt(s.get('path_cross_active_rate'))} | {fmt(s.get('large_turn_active_rate'))} | "
            f"{fmt(s.get('path_reg_active_rate'))} |\n"
        )

    add_pair_report(
        lines, "创新点1评价", "A1", "A0", exp_summary,
        [
            ("last_trail", True, "最终残留 trail"),
            ("last_remaining", True, "最终剩余 frontier/trail/unlabeled"),
            ("total_time", True, "完成时间"),
        ],
    )
    if "A1" in exp_summary:
        lines.append(f"- A1 `mean_ft_cost={fmt(exp_summary['A1'].get('mean_ft_cost'))}`，`ft_active_rate={fmt(exp_summary['A1'].get('ft_active_rate'))}`。\n")

    add_pair_report(
        lines, "创新点2评价", "A2", "A1", exp_summary,
        [
            ("comm_risk_rate", True, "通信风险率"),
            ("total_time", True, "完成时间"),
            ("total_travel_dist", True, "总路径长度"),
        ],
    )
    if "A2" in exp_summary:
        lines.append(f"- A2 `role_adjust_rate={fmt(exp_summary['A2'].get('role_adjust_rate'))}`，越高说明水下角色选择器越常修正原始角色。\n")

    add_pair_report(
        lines, "创新点3评价", "A3", "A2", exp_summary,
        [
            ("duplicate_rate", True, "重复目标率"),
            ("comm_risk_rate", True, "通信风险率"),
            ("total_time", True, "完成时间"),
        ],
    )
    if "A3" in exp_summary:
        lines.append(
            f"- A3 `mean_high_order_cost={fmt(exp_summary['A3'].get('mean_high_order_cost'))}`，"
            f"`high_order_active_rate={fmt(exp_summary['A3'].get('high_order_active_rate'))}`。\n"
        )
        lines.append(
            f"- A3 `J_competition/J_comm/J_redundant` = "
            f"{fmt(exp_summary['A3'].get('mean_j_competition'))} / "
            f"{fmt(exp_summary['A3'].get('mean_j_comm'))} / "
            f"{fmt(exp_summary['A3'].get('mean_j_redundant'))}。\n"
        )

    # 路径正则评价：新加
    for pr_exp in ["A3_PR_turn", "A3_PR_cross", "A3_PR_both", "A3_PR"]:
        if pr_exp in exp_summary and "A3_old" in exp_summary:
            add_pair_report(
                lines, "路径正则稳定项评价", pr_exp, "A3_old", exp_summary,
                [
                    ("total_time", True, "完成时间"),
                    ("total_travel_dist", True, "总路径长度"),
                    ("last_remaining", True, "最终剩余量"),
                    ("duplicate_rate", True, "重复目标率"),
                    ("comm_risk_rate", True, "通信风险率"),
                ],
            )
            s = exp_summary[pr_exp]
            lines.append(
                f"- {pr_exp} `path_cross/large_turn/path_reg` = "
                f"{fmt(s.get('mean_path_cross_cost'))} / {fmt(s.get('mean_large_turn_cost'))} / {fmt(s.get('mean_path_reg_cost'))}，"
                f"激活率 = {fmt(s.get('path_reg_active_rate'))}。\n"
            )

    # pairwise vs hypergraph：如用户后续加该实验组，自动报告
    if "A2_pairwise" in exp_summary and "A3_hyper" in exp_summary:
        add_pair_report(
            lines, "高阶超图相对 pairwise 对照", "A3_hyper", "A2_pairwise", exp_summary,
            [
                ("duplicate_rate", True, "重复目标率"),
                ("comm_risk_rate", True, "通信风险率"),
                ("total_time", True, "完成时间"),
                ("total_travel_dist", True, "总路径长度"),
            ],
        )

    lines.append("\n## 调参建议\n\n")
    lines.append("- 如果 `total_time`、`total_travel_dist` 比 A0/A3_old 变差，同时 `mean_ft_cost` 或 `mean_high_order_cost` 很大，先降低 `method/w_ft_score`、`method/w_high_order`。\n")
    lines.append("- 如果 `path_reg_active_rate` 很高且时间变差，说明路径正则过强，降低 `method/w_path_regularizer`、`path_regularizer/w_path_cross`、`path_regularizer/w_large_turn`。\n")
    lines.append("- 如果 `path_reg_active_rate` 接近 0，说明交叉/大转角很少被触发，或者阈值太宽，可小幅降低 `turn_angle_threshold_deg` 或增大历史长度。\n")
    lines.append("- 如果 `duplicate_rate` 没下降，优先调大 `hypergraph/w_competition` 或增大 `hypergraph/target_radius`。\n")
    lines.append("- 如果 `comm_risk_rate` 没下降，优先调大 `hypergraph/w_comm` 或减小 `hypergraph/comm_range`。\n")

    report_path = root / "innovation_report.md"
    with open(report_path, "w", encoding="utf-8") as f:
        f.writelines(lines)
    return report_path


def make_plots(root, exp_summary, exps):
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
        ("mean_path_cross_cost", "Mean Path-cross Cost"),
        ("mean_large_turn_cost", "Mean Large-turn Cost"),
        ("mean_path_reg_cost", "Mean Path-regularizer Cost"),
        ("path_reg_active_rate", "Path Regularizer Active Rate"),
    ]

    xs = [e for e in exps if e in exp_summary]
    for metric, title in metrics:
        ys = [exp_summary[e].get(metric, 0.0) for e in xs]
        plt.figure(figsize=(max(6, len(xs) * 0.9), 4))
        plt.bar(xs, ys)
        plt.title(title)
        plt.xlabel("Experiment")
        plt.ylabel(metric)
        plt.xticks(rotation=25, ha="right")
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
        default="A0,A1,A2,A3,A3_old,A3_PR_turn,A3_PR_cross,A3_PR_both",
        help="要读取的实验组，逗号分隔"
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

    drone_keys = []
    for r in drone_rows:
        for k in r.keys():
            if k not in drone_keys:
                drone_keys.append(k)
    drone_fieldnames = ["exp", "run"] + [k for k in drone_keys if k not in ("exp", "run")]
    drone_detail_path = root / "ablation_drone_detail.csv"
    write_csv(drone_detail_path, drone_rows, drone_fieldnames)

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

    report_path = generate_report(root, exp_summary, run_rows, exps)
    plots_dir = make_plots(root, exp_summary, exps)

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
            f"ho={s.get('mean_high_order_cost', 0):.3f}, "
            f"cross={s.get('mean_path_cross_cost', 0):.3f}, "
            f"turn={s.get('mean_large_turn_cost', 0):.3f}, "
            f"path_reg={s.get('mean_path_reg_cost', 0):.3f}"
        )


if __name__ == "__main__":
    main()
