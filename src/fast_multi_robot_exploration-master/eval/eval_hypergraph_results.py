#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import argparse
import os
import glob
import math
import pandas as pd
import matplotlib.pyplot as plt


def ensure_dir(path):
    os.makedirs(path, exist_ok=True)


def safe_mean(df, col, default=0.0):
    if col not in df.columns or len(df) == 0:
        return default
    return float(df[col].fillna(0).mean())


def safe_last(df, col, default=0.0):
    if col not in df.columns or len(df) == 0:
        return default
    return df[col].iloc[-1]


def active_rate(df, col, eps=1e-6):
    if col not in df.columns or len(df) == 0:
        return 0.0
    return float((df[col].fillna(0).abs() > eps).mean())


def df_to_md(df):
    if df is None or len(df) == 0:
        return "No data."
    try:
        return df.to_markdown(index=False)
    except Exception:
        return "\n```\n" + df.to_string(index=False) + "\n```\n"


def read_one_csv(csv_path):
    df = pd.read_csv(csv_path)
    if len(df) == 0:
        return None

    total_time = float(df["time"].iloc[-1] - df["time"].iloc[0]) if "time" in df.columns else 0.0
    plan_steps = len(df)
    travel_dist = float(safe_last(df, "travel_dist", 0.0))

    final_frontier = int(safe_last(df, "num_frontier", 0))
    final_trail = int(safe_last(df, "num_trail", 0))
    final_unlabeled = int(safe_last(df, "num_unlabeled", 0))
    final_remaining = final_frontier + final_trail + final_unlabeled

    if "role_after" in df.columns:
        explorer_ratio = float((df["role_after"] == "EXPLORER").mean())
        collector_ratio = float((df["role_after"] == "COLLECTOR").mean())
    else:
        explorer_ratio = 0.0
        collector_ratio = 0.0

    if "role_before" in df.columns and "role_after" in df.columns:
        role_adjust_rate = float((df["role_before"] != df["role_after"]).mean())
        role_switch_count = int((df["role_after"] != df["role_after"].shift(1)).sum() - 1)
        role_switch_count = max(0, role_switch_count)
    else:
        role_adjust_rate = 0.0
        role_switch_count = 0

    if "selected_label" in df.columns:
        frontier_selected_ratio = float((df["selected_label"] == "FRONTIER").mean())
        trail_selected_ratio = float((df["selected_label"] == "TRAIL").mean())
    else:
        frontier_selected_ratio = 0.0
        trail_selected_ratio = 0.0

    if "plan_source" in df.columns:
        greedy_ratio = float((df["plan_source"] == "greedy").mean())
        trail_tour_ratio = float(
            ((df["plan_source"] == "trail_tour") |
             (df["plan_source"] == "single_trail")).mean()
        )
    else:
        greedy_ratio = 0.0
        trail_tour_ratio = 0.0

    return {
        "csv": csv_path,
        "total_time": total_time,
        "plan_steps": plan_steps,
        "travel_dist": travel_dist,
        "final_frontier": final_frontier,
        "final_trail": final_trail,
        "final_unlabeled": final_unlabeled,
        "final_remaining": final_remaining,

        "success_rate": safe_mean(df, "success", 0.0),

        "duplicate_rate": active_rate(df, "duplicate_target_count"),
        "comm_risk_rate": active_rate(df, "comm_risk_count"),
        "mean_duplicate_count": safe_mean(df, "duplicate_target_count", 0.0),
        "mean_comm_risk_count": safe_mean(df, "comm_risk_count", 0.0),

        "explorer_ratio": explorer_ratio,
        "collector_ratio": collector_ratio,
        "role_adjust_rate": role_adjust_rate,
        "role_switch_count": role_switch_count,

        "frontier_selected_ratio": frontier_selected_ratio,
        "trail_selected_ratio": trail_selected_ratio,
        "greedy_ratio": greedy_ratio,
        "trail_tour_ratio": trail_tour_ratio,

        "mean_base_cost": safe_mean(df, "base_cost", 0.0),
        "mean_ft_cost": safe_mean(df, "ft_cost", 0.0),
        "ft_active_rate": active_rate(df, "ft_cost"),

        "mean_high_order_cost": safe_mean(df, "high_order_cost", 0.0),
        "high_order_active_rate": active_rate(df, "high_order_cost"),

        "mean_num_hyperedges": safe_mean(df, "num_hyperedges", 0.0),
        "hyperedge_active_rate": active_rate(df, "num_hyperedges"),

        "mean_trajectory_edge_cost": safe_mean(df, "trajectory_edge_cost", 0.0),
        "trajectory_edge_active_rate": active_rate(df, "trajectory_edge_cost"),

        "mean_J_competition": safe_mean(df, "J_competition", 0.0),
        "mean_J_comm": safe_mean(df, "J_comm", 0.0),
        "mean_J_redundant_cleanup": safe_mean(df, "J_redundant_cleanup", 0.0),

        # 兼容旧版本字段
        "mean_path_cross_cost": safe_mean(df, "path_cross_cost", 0.0),
        "mean_large_turn_cost": safe_mean(df, "large_turn_cost", 0.0),
        "mean_path_reg_cost": safe_mean(df, "path_reg_cost", 0.0),

        "path_cross_active_rate": active_rate(df, "path_cross_cost"),
        "large_turn_active_rate": active_rate(df, "large_turn_cost"),
        "path_reg_active_rate": active_rate(df, "path_reg_cost"),

        "mean_S_explorer": safe_mean(df, "S_explorer", 0.0),
        "mean_S_collector": safe_mean(df, "S_collector", 0.0),
    }


def collect_logs(root, exps=None, runs=None):
    rows = []

    if exps is None:
        exps = sorted([
            d for d in os.listdir(root)
            if os.path.isdir(os.path.join(root, d))
        ])

    for exp in exps:
        exp_dir = os.path.join(root, exp)
        if not os.path.isdir(exp_dir):
            print("[WARN] missing exp:", exp_dir)
            continue

        if runs is None:
            run_names = sorted([
                d for d in os.listdir(exp_dir)
                if os.path.isdir(os.path.join(exp_dir, d))
            ])
        else:
            run_names = runs

        for run in run_names:
            run_dir = os.path.join(exp_dir, run)
            if not os.path.isdir(run_dir):
                print("[WARN] missing run:", run_dir)
                continue

            files = sorted(glob.glob(os.path.join(run_dir, "planning_eval_drone_*.csv")))
            if not files:
                one_file = os.path.join(run_dir, "planning_eval.csv")
                if os.path.exists(one_file):
                    files = [one_file]

            if not files:
                print("[WARN] no csv found:", run_dir)
                continue

            for f in files:
                item = read_one_csv(f)
                if item is None:
                    continue

                base = os.path.basename(f)
                drone = "unknown"
                if "drone_" in base:
                    drone = base.replace("planning_eval_drone_", "").replace(".csv", "")

                item["exp"] = exp
                item["run"] = run
                item["drone"] = drone
                rows.append(item)

    return pd.DataFrame(rows)


def summarize(detail):
    numeric_cols = detail.select_dtypes(include=["number"]).columns.tolist()

    run_summary = detail.groupby(["exp", "run"])[numeric_cols].mean().reset_index()
    exp_mean = run_summary.groupby("exp")[numeric_cols].mean().reset_index()
    exp_std = run_summary.groupby("exp")[numeric_cols].std().reset_index()

    exp_summary = exp_mean.copy()
    for c in numeric_cols:
        std_map = dict(zip(exp_std["exp"], exp_std[c]))
        exp_summary[c + "_std"] = exp_summary["exp"].map(std_map)

    return run_summary, exp_mean, exp_summary


def plot_bar(exp_mean, metric, ylabel, out_dir, lower_is_better=True):
    if metric not in exp_mean.columns:
        return

    df = exp_mean[["exp", metric]].copy()
    df = df.sort_values("exp")

    plt.figure(figsize=(8, 5))
    plt.bar(df["exp"], df[metric])
    plt.xlabel("Experiment")
    plt.ylabel(ylabel)
    title = metric
    if lower_is_better:
        title += "  (lower is better)"
    else:
        title += "  (higher is better)"
    plt.title(title)
    plt.xticks(rotation=30, ha="right")
    plt.tight_layout()

    out_path = os.path.join(out_dir, f"{metric}.png")
    plt.savefig(out_path, dpi=200)
    plt.close()


def plot_all(exp_mean, out_dir):
    plot_dir = os.path.join(out_dir, "plots")
    ensure_dir(plot_dir)

    metrics = [
        ("total_time", "Total exploration time", True),
        ("travel_dist", "Total travel distance", True),
        ("final_remaining", "Final remaining frontier+trail+unlabeled", True),
        ("final_trail", "Final trail number", True),

        ("duplicate_rate", "Duplicate target rate", True),
        ("comm_risk_rate", "Communication risk rate", True),

        ("role_adjust_rate", "Role adjustment rate", False),
        ("collector_ratio", "Collector ratio", False),
        ("explorer_ratio", "Explorer ratio", False),

        ("mean_ft_cost", "Mean FT-score cost", False),
        ("ft_active_rate", "FT-score active rate", False),

        ("mean_high_order_cost", "Mean hypergraph cost", False),
        ("high_order_active_rate", "Hypergraph active rate", False),
        ("mean_num_hyperedges", "Mean number of hyperedges", False),
        ("mean_trajectory_edge_cost", "Mean trajectory hyperedge cost", False),

        ("mean_J_competition", "Mean competition edge cost", False),
        ("mean_J_comm", "Mean communication edge cost", False),
        ("mean_J_redundant_cleanup", "Mean redundant cleanup edge cost", False),

        ("mean_path_cross_cost", "Old path cross cost", False),
        ("mean_large_turn_cost", "Old large turn cost", False),
        ("mean_path_reg_cost", "Old path regularizer cost", False),
    ]

    for metric, ylabel, lower in metrics:
        plot_bar(exp_mean, metric, ylabel, plot_dir, lower_is_better=lower)


def compare_against_baseline(exp_mean, baseline="A0"):
    if baseline not in list(exp_mean["exp"]):
        return pd.DataFrame()

    base_row = exp_mean[exp_mean["exp"] == baseline].iloc[0]
    rows = []

    for _, row in exp_mean.iterrows():
        exp = row["exp"]
        item = {"exp": exp}

        for metric in ["total_time", "travel_dist", "final_remaining",
                       "duplicate_rate", "comm_risk_rate"]:
            if metric in exp_mean.columns:
                b = float(base_row[metric])
                v = float(row[metric])
                item[metric] = v
                if abs(b) > 1e-9:
                    item[metric + "_improve_pct"] = (b - v) / abs(b) * 100.0
                else:
                    item[metric + "_improve_pct"] = 0.0

        rows.append(item)

    return pd.DataFrame(rows)


def write_report(exp_mean, compare_df, out_path):
    lines = []
    lines.append("# Hypergraph Exploration Evaluation Report\n")

    lines.append("## 1. Overall Performance\n")
    cols = [
        "exp", "total_time", "travel_dist", "final_remaining",
        "final_frontier", "final_trail", "success_rate"
    ]
    lines.append(df_to_md(exp_mean[[c for c in cols if c in exp_mean.columns]]))

    lines.append("\n## 2. Innovation 1: Frontier-Trail Score\n")
    cols = [
        "exp", "mean_ft_cost", "ft_active_rate",
        "frontier_selected_ratio", "trail_selected_ratio", "final_trail"
    ]
    lines.append(df_to_md(exp_mean[[c for c in cols if c in exp_mean.columns]]))
    lines.append(
        "\n评价：如果 A1/A3_HyperEdge 的 ft_active_rate > 0，说明创新点1已经生效；"
        "如果 final_trail 下降，说明 trail 清理更有效。\n"
    )

    lines.append("\n## 3. Innovation 2: Role Selector\n")
    cols = [
        "exp", "role_adjust_rate", "role_switch_count",
        "explorer_ratio", "collector_ratio", "mean_S_explorer", "mean_S_collector"
    ]
    lines.append(df_to_md(exp_mean[[c for c in cols if c in exp_mean.columns]]))
    lines.append(
        "\n评价：role_adjust_rate 越大，说明水下角色选择器越频繁修正原始角色；"
        "如果切换次数过多，可能说明角色不稳定。\n"
    )

    lines.append("\n## 4. Innovation 3: Dynamic Hypergraph\n")
    cols = [
        "exp", "mean_high_order_cost", "high_order_active_rate",
        "mean_num_hyperedges", "hyperedge_active_rate",
        "mean_trajectory_edge_cost", "trajectory_edge_active_rate",
        "duplicate_rate", "comm_risk_rate"
    ]
    lines.append(df_to_md(exp_mean[[c for c in cols if c in exp_mean.columns]]))
    lines.append(
        "\n评价：mean_num_hyperedges > 0 表示超图被真正构建；"
        "mean_trajectory_edge_cost > 0 表示大转角/路径交叉已经进入轨迹耦合超边。\n"
    )

    lines.append("\n## 5. Comparison Against A0\n")
    if compare_df is not None and len(compare_df) > 0:
        lines.append(df_to_md(compare_df))
    else:
        lines.append("No A0 baseline found.")

    lines.append("\n## 6. Simple Conclusion\n")
    if "A3_HyperEdge" in list(exp_mean["exp"]):
        row = exp_mean[exp_mean["exp"] == "A3_HyperEdge"].iloc[0]
        lines.append(f"- A3_HyperEdge total_time = {row.get('total_time', 0):.3f}")
        lines.append(f"- A3_HyperEdge travel_dist = {row.get('travel_dist', 0):.3f}")
        lines.append(f"- A3_HyperEdge mean_num_hyperedges = {row.get('mean_num_hyperedges', 0):.3f}")
        lines.append(f"- A3_HyperEdge trajectory_edge_cost = {row.get('mean_trajectory_edge_cost', 0):.3f}")
        lines.append(
            "\n如果 mean_num_hyperedges 为 0，说明超图没有接入；"
            "如果 trajectory_edge_cost 为 0，说明轨迹耦合超边没有触发或没有写入日志。"
        )

    with open(out_path, "w", encoding="utf-8") as f:
        f.write("\n".join(lines))


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument(
        "--root",
        default="/home/xiaogu/myproject/rosNavigation_ws/eval_logs",
        help="eval_logs root directory"
    )
    parser.add_argument(
        "--exps",
        default="A0,A1,A2,A3,A3_old,A3_PR_both,A3_HyperEdge",
        help="comma separated experiment names"
    )
    parser.add_argument(
        "--runs",
        default="",
        help="comma separated run names, empty means auto detect"
    )
    parser.add_argument(
        "--out_dir",
        default="",
        help="output directory"
    )
    args = parser.parse_args()

    root = os.path.expanduser(args.root)
    exps = [x.strip() for x in args.exps.split(",") if x.strip()]
    runs = [x.strip() for x in args.runs.split(",") if x.strip()]
    runs = runs if runs else None

    out_dir = args.out_dir if args.out_dir else os.path.join(root, "eval_summary")
    ensure_dir(out_dir)

    detail = collect_logs(root, exps=exps, runs=runs)

    if detail.empty:
        print("[ERROR] No valid logs found.")
        print("Check your path:", root)
        return

    run_summary, exp_mean, exp_summary = summarize(detail)
    compare_df = compare_against_baseline(exp_mean, baseline="A0")

    detail_path = os.path.join(out_dir, "drone_detail.csv")
    run_path = os.path.join(out_dir, "run_summary.csv")
    exp_path = os.path.join(out_dir, "exp_mean.csv")
    exp_std_path = os.path.join(out_dir, "exp_summary_mean_std.csv")
    compare_path = os.path.join(out_dir, "compare_against_A0.csv")
    report_path = os.path.join(out_dir, "innovation_report.md")

    detail.to_csv(detail_path, index=False)
    run_summary.to_csv(run_path, index=False)
    exp_mean.to_csv(exp_path, index=False)
    exp_summary.to_csv(exp_std_path, index=False)
    compare_df.to_csv(compare_path, index=False)

    plot_all(exp_mean, out_dir)
    write_report(exp_mean, compare_df, report_path)

    print("\n========== Saved ==========")
    print("Drone detail :", detail_path)
    print("Run summary  :", run_path)
    print("Exp mean     :", exp_path)
    print("Exp std      :", exp_std_path)
    print("Compare A0   :", compare_path)
    print("Report       :", report_path)
    print("Plots        :", os.path.join(out_dir, "plots"))

    print("\n========== Key Results ==========")
    key_cols = [
        "exp", "total_time", "travel_dist", "final_remaining",
        "duplicate_rate", "comm_risk_rate",
        "mean_ft_cost", "role_adjust_rate",
        "mean_high_order_cost", "mean_num_hyperedges",
        "mean_trajectory_edge_cost"
    ]
    key_cols = [c for c in key_cols if c in exp_mean.columns]
    print(exp_mean[key_cols].round(4).to_string(index=False))


if __name__ == "__main__":
    main()