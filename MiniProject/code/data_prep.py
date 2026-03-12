#!/usr/bin/env python3

from pathlib import Path
import pandas as pd

# Paths and constants

# Project root = MiniProject/
PROJECT_ROOT = Path(__file__).resolve().parents[1]

DATA_DIR = PROJECT_ROOT / "data"
RESULTS_DIR = PROJECT_ROOT / "results"
FIGURES_DIR = PROJECT_ROOT / "figures"
REPORT_DIR = PROJECT_ROOT / "report"

EXPLORATORY_DIR = FIGURES_DIR / "exploratory"
FITTED_DIR = FIGURES_DIR / "fitted_curves"
SUMMARY_DIR = FIGURES_DIR / "summary"

RAW_DATA_FILE = DATA_DIR / "logistic_growth_data.csv"
CLEAN_DATA_FILE = DATA_DIR / "cleaned_growth_data.csv"

# Minimum number of observations required to keep a curve
MIN_POINTS_PER_CURVE = 5

def create_directories() -> None:
    """Create all project output folders if they do not already exist."""
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
    """
    Build a unique identifier for each growth curve.

    In this dataset, a single curve is defined by the combination of:
    Citation + Species + Temp + Medium + Rep
    """
    required = ["Citation", "Species", "Temp", "Medium", "Rep"]
    missing = [col for col in required if col not in df.columns]
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
    """
    Clean the raw growth dataset and keep only curves suitable for model fitting.

    Main steps:
    1. Drop the extra index-like column if present
    2. Convert key fields to numeric
    3. Remove missing and biologically invalid records
    4. Standardise text columns
    5. Create curve IDs and sort by time
    6. Filter out curves with too few points
    """
    df = df.copy()

    # Remove the extra column exported from the source file
    if "X" in df.columns:
        df = df.drop(columns=["X"])

    # Convert columns that should be numeric
    for col in ["Time", "PopBio", "Temp", "Rep"]:
        df[col] = pd.to_numeric(df[col], errors="coerce")

    # Remove missing values from fields required for fitting
    df = df.dropna(subset=["Time", "PopBio", "Species", "Medium", "Citation"])

    # Keep only biologically meaningful values
    df = df[df["Time"] >= 0]
    df = df[df["PopBio"] > 0]

    # Clean text fields so IDs are consistent
    for col in ["Time_units", "PopBio_units", "Species", "Medium", "Citation"]:
        df[col] = df[col].astype(str).str.strip()

    # Build curve IDs and sort records within each curve
    df = make_curve_id(df)
    df = df.sort_values(["curve_id", "Time"]).reset_index(drop=True)

    # Keep only curves with enough data points for stable fitting
    counts = df.groupby("curve_id").size()
    valid_curves = counts[counts >= MIN_POINTS_PER_CURVE].index
    df = df[df["curve_id"].isin(valid_curves)].copy()

    return df

# Main workflow

def main() -> None:
    """Run the data preparation step."""
    print("Creating directories...")
    create_directories()

    if not RAW_DATA_FILE.exists():
        raise FileNotFoundError(f"Cannot find {RAW_DATA_FILE}")

    print("Loading raw data...")
    raw_df = pd.read_csv(RAW_DATA_FILE)

    print("Cleaning data...")
    clean_df = clean_growth_data(raw_df)

    # Save cleaned dataset for downstream scripts
    clean_df.to_csv(CLEAN_DATA_FILE, index=False)

    print(f"Saved cleaned data to: {CLEAN_DATA_FILE}")
    print(f"Cleaned rows: {len(clean_df)}")
    print(f"Number of curves: {clean_df['curve_id'].nunique()}")


if __name__ == "__main__":
    main()