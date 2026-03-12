#!/usr/bin/env python3
# -*- coding: utf-8 -*-

from __future__ import annotations

from pathlib import Path
import pandas as pd

PROJECT_ROOT = Path(__file__).resolve().parents[1]

DATA_DIR = PROJECT_ROOT / "data"
RESULTS_DIR = PROJECT_ROOT / "results"
FIGURES_DIR = PROJECT_ROOT / "figures"
REPORT_DIR = PROJECT_ROOT / "report"

EXPLORATORY_DIR = FIGURES_DIR / "exploratory"
FITTED_DIR = FIGURES_DIR / "fitted_curves"
SUMMARY_DIR = FIGURES_DIR / "summary"

RAW_DATA_FILE = DATA_DIR / "logistic_growth_data.csv"
RAW_META_FILE = DATA_DIR / "logistic_growth_meta_data.csv"
CLEAN_DATA_FILE = DATA_DIR / "cleaned_growth_data.csv"

MIN_POINTS_PER_CURVE = 5


def create_directories() -> None:
    for path in [
        DATA_DIR,
        RESULTS_DIR,
        FIGURES_DIR,
        REPORT_DIR,
        EXPLORATORY_DIR,
        FITTED_DIR,
        SUMMARY_DIR,
    ]:
        path.mkdir(parents=True, exist_ok=True)


def make_curve_id(df: pd.DataFrame) -> pd.DataFrame:
    required = ["Citation", "Species", "Temp", "Medium", "Rep"]
    missing = [c for c in required if c not in df.columns]
    if missing:
        raise ValueError(f"Missing required columns for curve_id: {missing}")

    df = df.copy()
    df["curve_id"] = (
        df["Citation"].astype(str).str.strip() + "__" +
        df["Species"].astype(str).str.strip() + "__" +
        df["Temp"].astype(str).str.strip() + "__" +
        df["Medium"].astype(str).str.strip() + "__" +
        df["Rep"].astype(str).str.strip()
    )
    return df


def clean_growth_data(df: pd.DataFrame) -> pd.DataFrame:
    df = df.copy()

    if "X" in df.columns:
        df = df.drop(columns=["X"])

    for col in ["Time", "PopBio", "Temp", "Rep"]:
        if col in df.columns:
            df[col] = pd.to_numeric(df[col], errors="coerce")

    df = df.dropna(subset=["Time", "PopBio", "Species", "Medium", "Citation"])
    df = df[df["Time"] >= 0]
    df = df[df["PopBio"] > 0]

    for col in ["Time_units", "PopBio_units", "Species", "Medium", "Citation"]:
        if col in df.columns:
            df[col] = df[col].astype(str).str.strip()

    df = make_curve_id(df)
    df = df.sort_values(["curve_id", "Time"]).reset_index(drop=True)

    counts = df.groupby("curve_id").size()
    valid_curves = counts[counts >= MIN_POINTS_PER_CURVE].index
    df = df[df["curve_id"].isin(valid_curves)].copy()

    return df


def main() -> None:
    print("Creating directories...")
    create_directories()

    if not RAW_DATA_FILE.exists():
        raise FileNotFoundError(f"Cannot find {RAW_DATA_FILE}")

    print("Loading raw data...")
    raw_df = pd.read_csv(RAW_DATA_FILE)

    print("Cleaning data...")
    clean_df = clean_growth_data(raw_df)

    clean_df.to_csv(CLEAN_DATA_FILE, index=False)

    print(f"Saved cleaned data to: {CLEAN_DATA_FILE}")
    print(f"Cleaned rows: {len(clean_df)}")
    print(f"Number of curves: {clean_df['curve_id'].nunique()}")


if __name__ == "__main__":
    main()