#!/usr/bin/env python3
# -*- coding: utf-8 -*-

from __future__ import annotations

import warnings
from pathlib import Path
from typing import Dict, Optional, Tuple, List

import numpy as np
import pandas as pd
from scipy.optimize import curve_fit
from scipy.stats import linregress

warnings.filterwarnings("ignore", category=RuntimeWarning)
warnings.filterwarnings("ignore", category=UserWarning)

PROJECT_ROOT = Path(__file__).resolve().parents[1]

DATA_DIR = PROJECT_ROOT / "data"
RESULTS_DIR = PROJECT_ROOT / "results"

CLEAN_DATA_FILE = DATA_DIR / "cleaned_growth_data.csv"
FITTED_PARAMS_FILE = RESULTS_DIR / "fitted_params.csv"
MODEL_METRICS_FILE = RESULTS_DIR / "model_metrics.csv"


def safe_log(x: np.ndarray, min_value: float = 1e-8) -> np.ndarray:
    return np.log(np.maximum(x, min_value))


def compute_aic(n: int, rss: float, k: int) -> float:
    if n <= 0 or rss <= 0:
        return np.nan
    return n * np.log(rss / n) + 2 * k


def compute_bic(n: int, rss: float, k: int) -> float:
    if n <= 0 or rss <= 0:
        return np.nan
    return n * np.log(rss / n) + k * np.log(n)


def logistic_model(t: np.ndarray, K: float, r: float, N0: float) -> np.ndarray:
    return K / (1 + ((K - N0) / N0) * np.exp(-r * t))


def gompertz_model(t: np.ndarray, K: float, r: float, t0: float) -> np.ndarray:
    return K * np.exp(-np.exp(-r * (t - t0)))


def estimate_initial_params(time: np.ndarray, pop: np.ndarray) -> Dict[str, Dict[str, float]]:
    K_start = max(pop) * 1.05
    N0_start = max(min(pop), 1e-6)

    if len(time) >= 2 and np.all(pop > 0):
        slope, _, _, _, _ = linregress(time, safe_log(pop))
        r_start = max(slope, 0.01)
    else:
        r_start = 0.05

    t0_start = np.median(time)

    return {
        "logistic": {"K": K_start, "r": r_start, "N0": N0_start},
        "gompertz": {"K": K_start, "r": r_start, "t0": t0_start},
    }


def fit_model(model_name: str, time: np.ndarray, pop: np.ndarray) -> Tuple[Optional[np.ndarray], Dict[str, object]]:
    starts = estimate_initial_params(time, pop)

    metrics = {
        "model": model_name,
        "success": False,
        "rss": np.nan,
        "aic": np.nan,
        "bic": np.nan,
        "n": len(pop),
        "k": np.nan,
        "message": ""
    }

    try:
        if model_name == "logistic":
            p0 = [starts["logistic"]["K"], starts["logistic"]["r"], starts["logistic"]["N0"]]
            bounds = ([1e-8, 1e-8, 1e-8], [np.inf, np.inf, np.inf])
            params, _ = curve_fit(
                logistic_model, time, pop, p0=p0, bounds=bounds, maxfev=20000
            )
            preds = logistic_model(time, *params)
            k = 3

        elif model_name == "gompertz":
            p0 = [starts["gompertz"]["K"], starts["gompertz"]["r"], starts["gompertz"]["t0"]]
            bounds = ([1e-8, 1e-8, min(time) - 100], [np.inf, np.inf, max(time) + 100])
            params, _ = curve_fit(
                gompertz_model, time, pop, p0=p0, bounds=bounds, maxfev=20000
            )
            preds = gompertz_model(time, *params)
            k = 3

        else:
            raise ValueError(f"Unknown model: {model_name}")

        rss = float(np.sum((pop - preds) ** 2))
        metrics.update({
            "success": True,
            "rss": rss,
            "aic": compute_aic(len(pop), rss, k),
            "bic": compute_bic(len(pop), rss, k),
            "k": k,
            "message": "OK"
        })
        return params, metrics

    except Exception as e:
        metrics["message"] = str(e)
        return None, metrics


def fit_single_curve(curve_df: pd.DataFrame) -> Tuple[List[Dict], List[Dict]]:
    curve_id = curve_df["curve_id"].iloc[0]
    time = curve_df["Time"].to_numpy(dtype=float)
    pop = curve_df["PopBio"].to_numpy(dtype=float)

    static_info = {
        "curve_id": curve_id,
        "Species": curve_df["Species"].iloc[0],
        "Temp": curve_df["Temp"].iloc[0],
        "Medium": curve_df["Medium"].iloc[0],
        "Rep": curve_df["Rep"].iloc[0],
        "Citation": curve_df["Citation"].iloc[0],
        "Time_units": curve_df["Time_units"].iloc[0] if "Time_units" in curve_df.columns else np.nan,
        "PopBio_units": curve_df["PopBio_units"].iloc[0] if "PopBio_units" in curve_df.columns else np.nan,
    }

    param_records = []
    metric_records = []

    for model_name in ["logistic", "gompertz"]:
        params, metrics = fit_model(model_name, time, pop)

        metric_record = {**static_info, **metrics}
        metric_records.append(metric_record)

        if params is not None:
            if model_name == "logistic":
                param_records.append({
                    **static_info,
                    "model": model_name,
                    "K": params[0],
                    "r": params[1],
                    "N0": params[2],
                    "t0": np.nan
                })
            else:
                param_records.append({
                    **static_info,
                    "model": model_name,
                    "K": params[0],
                    "r": params[1],
                    "N0": np.nan,
                    "t0": params[2]
                })

    return param_records, metric_records


def main() -> None:
    if not CLEAN_DATA_FILE.exists():
        raise FileNotFoundError(
            f"Cannot find {CLEAN_DATA_FILE}. Run 01_data_prep.py first."
        )

    print("Loading cleaned data...")
    df = pd.read_csv(CLEAN_DATA_FILE)

    all_params = []
    all_metrics = []

    print("Fitting models...")
    for _, curve_df in df.groupby("curve_id"):
        param_records, metric_records = fit_single_curve(curve_df)
        all_params.extend(param_records)
        all_metrics.extend(metric_records)

    params_df = pd.DataFrame(all_params)
    metrics_df = pd.DataFrame(all_metrics)

    params_df.to_csv(FITTED_PARAMS_FILE, index=False)
    metrics_df.to_csv(MODEL_METRICS_FILE, index=False)

    print(f"Saved fitted params to: {FITTED_PARAMS_FILE}")
    print(f"Saved model metrics to: {MODEL_METRICS_FILE}")


if __name__ == "__main__":
    main()