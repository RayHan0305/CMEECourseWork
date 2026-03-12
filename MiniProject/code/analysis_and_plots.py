#!/usr/bin/env python3
# -*- coding: utf-8 -*-

from __future__ import annotations

from pathlib import Path
from typing import List

import numpy as np
import pandas as pd
import matplotlib.pyplot as plt

PROJECT_ROOT = Path(__file__).resolve().parents[1]

DATA_DIR = PROJECT_ROOT / "data"
RESULTS_DIR = PROJECT_ROOT / "results"
FIGURES_DIR = PROJECT_ROOT / "figures"

EXPLORATORY_DIR = FIGURES_DIR / "exploratory"
FITTED_DIR = FIGURES_DIR / "fitted_curves"
SUMMARY_DIR = FIGURES_DIR / "summary"

CLEAN_DATA_FILE = DATA_DIR / "cleaned_growth_data.csv"
FITTED_PARAMS_FILE = RESULTS_DIR / "fitted_params.csv"
MODEL_METRICS_FILE = RESULTS_DIR / "model_metrics.csv"
BEST_MODEL_FILE = RESULTS_DIR / "best_model_by_curve.csv"
SUMMARY_TABLES_FILE = RESULTS_DIR / "summary_tables.csv"

RANDOM_SEED = 42
N_REPRESENTATIVE_CURVES = 9


def summarise_numeric(series: pd.Series) -> str:
    s = pd.to_numeric(series, errors="coerce").dropna()
    if s.empty:
        return "NA"
    return (
        f"n={len(s)}, mean={s.mean():.3f}, sd={s.std():.3f}, "
        f"min={s.min():.3f}, max={s.max():.3f}"
    )


def logistic_model(t: np.ndarray, K: float, r: float, N0: float) -> np.ndarray:
    return K / (1 + ((K - N0) / N0) * np.exp(-r * t))


def gompertz_model(t: np.ndarray, K: float, r: float, t0: float) -> np.ndarray:
    return K * np.exp(-np.exp(-r * (t - t0)))


def plot_sample_curves(df: pd.DataFrame, n_curves: int = 9) -> None:
    np.random.seed(RANDOM_SEED)
    curves = df["curve_id"].drop_duplicates().tolist()
    selected = np.random.choice(curves, size=min(n_curves, len(curves)), replace=False)

    ncols = 3
    nrows = int(np.ceil(len(selected) / ncols))
    fig, axes = plt.subplots(nrows, ncols, figsize=(13, 4 * nrows))
    axes = np.array(axes).reshape(-1)

    for i, (ax, curve_id) in enumerate(zip(axes, selected), start=1):
        sub = df[df["curve_id"] == curve_id]
        ax.scatter(sub["Time"], sub["PopBio"], s=18)
        ax.set_title(f"Curve {i}")
        ax.set_xlabel("Time (hours)")
        ax.set_ylabel("PopBio")

    for ax in axes[len(selected):]:
        ax.axis("off")

    plt.tight_layout()
    plt.savefig(EXPLORATORY_DIR / "sample_growth_curves.png", dpi=300)
    plt.close()


def exploratory_analysis(df: pd.DataFrame) -> pd.DataFrame:
    curve_counts = df.groupby("curve_id").size().rename("n_points").reset_index()

    summary = {
        "n_rows_cleaned": len(df),
        "n_curves": df["curve_id"].nunique(),
        "n_species": df["Species"].nunique(),
        "n_temperatures": df["Temp"].nunique(),
        "n_media": df["Medium"].nunique(),
        "time_units": ", ".join(sorted(df["Time_units"].dropna().unique().tolist())) if "Time_units" in df.columns else "NA",
        "popbio_units": ", ".join(sorted(df["PopBio_units"].dropna().unique().tolist())) if "PopBio_units" in df.columns else "NA",
        "time_summary": summarise_numeric(df["Time"]),
        "popbio_summary": summarise_numeric(df["PopBio"]),
        "curve_points_summary": summarise_numeric(curve_counts["n_points"]),
    }

    summary_df = pd.DataFrame({
        "metric": list(summary.keys()),
        "value": list(summary.values())
    })

    plt.figure(figsize=(7, 5))
    plt.hist(curve_counts["n_points"], bins=20)
    plt.xlabel("Points per curve")
    plt.ylabel("Frequency")
    plt.title("Distribution of points per growth curve")
    plt.tight_layout()
    plt.savefig(EXPLORATORY_DIR / "curve_point_distribution.png", dpi=300)
    plt.close()

    species_counts = df.groupby("Species")["curve_id"].nunique().sort_values(ascending=False).head(15)
    plt.figure(figsize=(10, 5))
    species_counts.plot(kind="bar")
    plt.ylabel("Number of curves")
    plt.title("Top species by number of curves")
    plt.tight_layout()
    plt.savefig(EXPLORATORY_DIR / "species_curve_counts.png", dpi=300)
    plt.close()

    temp_counts = df.groupby("Temp")["curve_id"].nunique().sort_index()
    plt.figure(figsize=(8, 5))
    temp_counts.plot(kind="bar")
    plt.ylabel("Number of curves")
    plt.title("Curves by temperature")
    plt.tight_layout()
    plt.savefig(EXPLORATORY_DIR / "temperature_curve_counts.png", dpi=300)
    plt.close()

    plot_sample_curves(df, n_curves=N_REPRESENTATIVE_CURVES)

    return summary_df


def compare_models(metrics_df: pd.DataFrame) -> tuple[pd.DataFrame, pd.DataFrame]:
    valid = metrics_df[metrics_df["success"] == True].copy()

    if valid.empty:
        return (
            pd.DataFrame(columns=["curve_id", "best_model", "best_aic"]),
            pd.DataFrame(columns=["metric", "value"])
        )

    best_idx = valid.groupby("curve_id")["aic"].idxmin()
    best_df = valid.loc[best_idx, [
        "curve_id", "Species", "Temp", "Medium", "Rep", "Citation",
        "PopBio_units", "model", "aic", "bic", "rss"
    ]].copy()

    best_df = best_df.rename(columns={
        "model": "best_model",
        "aic": "best_aic",
        "bic": "best_bic",
        "rss": "best_rss"
    })

    summary_records = [
        {"metric": "n_curve_fit_attempts", "value": metrics_df["curve_id"].nunique()},
        {"metric": "n_successfully_compared_curves", "value": best_df["curve_id"].nunique()},
    ]

    win_counts = best_df["best_model"].value_counts()
    for model_name, count in win_counts.items():
        summary_records.append({
            "metric": f"best_model_count_{model_name}",
            "value": count
        })

    success_rates = metrics_df.groupby("model")["success"].mean()
    for model_name, rate in success_rates.items():
        summary_records.append({
            "metric": f"success_rate_{model_name}",
            "value": round(float(rate), 4)
        })

    summary_df = pd.DataFrame(summary_records)
    return best_df, summary_df


def get_predictions(time_grid: np.ndarray, row: pd.Series) -> np.ndarray:
    if row["model"] == "logistic":
        return logistic_model(time_grid, row["K"], row["r"], row["N0"])
    elif row["model"] == "gompertz":
        return gompertz_model(time_grid, row["K"], row["r"], row["t0"])
    else:
        raise ValueError(f"Unknown model: {row['model']}")


def plot_representative_fits(df: pd.DataFrame, params_df: pd.DataFrame, best_df: pd.DataFrame) -> None:
    if best_df.empty:
        return

    np.random.seed(RANDOM_SEED)
    selected = np.random.choice(
        best_df["curve_id"].tolist(),
        size=min(N_REPRESENTATIVE_CURVES, len(best_df)),
        replace=False
    )

    ncols = 3
    nrows = int(np.ceil(len(selected) / ncols))
    fig, axes = plt.subplots(nrows, ncols, figsize=(13, 4 * nrows))
    axes = np.array(axes).reshape(-1)

    for i, (ax, curve_id) in enumerate(zip(axes, selected), start=1):
        sub = df[df["curve_id"] == curve_id]
        ax.scatter(sub["Time"], sub["PopBio"], s=18, label="Observed")

        time_grid = np.linspace(sub["Time"].min(), sub["Time"].max(), 200)
        fitted = params_df[params_df["curve_id"] == curve_id]

        for _, row in fitted.iterrows():
            preds = get_predictions(time_grid, row)
            ax.plot(time_grid, preds, label=row["model"])

        ax.set_title(f"Curve {i}")
        ax.set_xlabel("Time (hours)")
        ax.set_ylabel("PopBio")
        ax.legend(fontsize=8, loc="best")

    for ax in axes[len(selected):]:
        ax.axis("off")

    plt.tight_layout()
    plt.savefig(FITTED_DIR / "representative_curve_fits.png", dpi=300)
    plt.close()


def plot_summary_figures(metrics_df: pd.DataFrame, best_df: pd.DataFrame) -> None:
    valid = metrics_df[metrics_df["success"] == True].copy()

    if not valid.empty:
        labels = sorted(valid["model"].unique().tolist())
        data = [valid.loc[valid["model"] == m, "aic"].dropna().values for m in labels]

        plt.figure(figsize=(7, 5))
        plt.boxplot(data, tick_labels=labels)
        plt.ylabel("AIC")
        plt.title("AIC distribution by model")
        plt.tight_layout()
        plt.savefig(SUMMARY_DIR / "aic_distribution_by_model.png", dpi=300)
        plt.close()

    if not best_df.empty:
        counts = best_df["best_model"].value_counts()

        plt.figure(figsize=(6, 5))
        counts.plot(kind="bar")
        plt.ylabel("Number of curves")
        plt.title("Best-fitting model counts")
        plt.tight_layout()
        plt.savefig(SUMMARY_DIR / "best_model_counts.png", dpi=300)
        plt.close()

        temp_table = (
            best_df.groupby(["Temp", "best_model"])
            .size()
            .unstack(fill_value=0)
            .sort_index()
        )

        if not temp_table.empty:
            temp_prop = temp_table.div(temp_table.sum(axis=1), axis=0)

            plt.figure(figsize=(8, 5))
            temp_prop.plot(kind="bar", stacked=True)
            plt.ylabel("Proportion of curves")
            plt.title("Best model proportion by temperature")
            plt.tight_layout()
            plt.savefig(SUMMARY_DIR / "best_model_by_temperature.png", dpi=300)
            plt.close()


def save_summary_tables(summary_tables: List[pd.DataFrame]) -> None:
    combined_summary = pd.concat(summary_tables, ignore_index=True)
    combined_summary.to_csv(SUMMARY_TABLES_FILE, index=False)


def main() -> None:
    if not CLEAN_DATA_FILE.exists():
        raise FileNotFoundError(f"Cannot find {CLEAN_DATA_FILE}. Run 01_data_prep.py first.")
    if not FITTED_PARAMS_FILE.exists() or not MODEL_METRICS_FILE.exists():
        raise FileNotFoundError("Cannot find model fitting outputs. Run 02_fit_models.py first.")

    print("Loading cleaned data and model outputs...")
    clean_df = pd.read_csv(CLEAN_DATA_FILE)
    params_df = pd.read_csv(FITTED_PARAMS_FILE)
    metrics_df = pd.read_csv(MODEL_METRICS_FILE)

    print("Generating exploratory analysis...")
    exploratory_summary = exploratory_analysis(clean_df)

    print("Comparing models...")
    best_df, comparison_summary = compare_models(metrics_df)
    best_df.to_csv(BEST_MODEL_FILE, index=False)

    print("Making fitted and summary plots...")
    plot_representative_fits(clean_df, params_df, best_df)
    plot_summary_figures(metrics_df, best_df)

    print("Saving summary tables...")
    save_summary_tables([exploratory_summary, comparison_summary])

    print(f"Saved best model table to: {BEST_MODEL_FILE}")
    print(f"Saved summary tables to: {SUMMARY_TABLES_FILE}")


if __name__ == "__main__":
    main()