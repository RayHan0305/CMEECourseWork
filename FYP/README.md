# FYP population-genomic differentiation analysis

This repository contains the three main notebooks, the derived datasets required to reproduce the downstream analysis, and a set of generated tables and figures.

## Repository structure

```text
code/
  exploratory_supervisor_requests_fixed.ipynb
  final_fst_scan.ipynb
  final_thesis_analysis.ipynb

data/
  FST_selected6pairs_1Mb_3R_X_full_scan_minN50.csv
  site_counts_1Mb_windows_3R_X_existing_counts.csv
  selected_samples_exact.csv
  selected_4populations_summary.csv
  selected_6pairs.csv
  scan_windows_1Mb_from_CEN_3R_X.csv
  ...

results/
  RESULTS_SUMMARY.md
  tables/
  figures/

docs/
  GITHUB_UPLOAD_TUTORIAL.md
  DATA_NOTES.md
```

## What each notebook does

`exploratory_supervisor_requests_fixed.ipynb` contains the earlier exploratory analyses requested during supervision.

`final_fst_scan.ipynb` defines the final four populations, six population pairs, X/3R 1 Mb windows, and 0-fold/4-fold site classes, then calculates the final MalariaGEN FST scan with checkpointing.

`final_thesis_analysis.ipynb` starts from the completed FST CSV and reproduces the focal-X, background, QC, statistical and secondary-peak analyses.

## Important environment note

The genotype-level `final_fst_scan.ipynb` was written for `malariagen_data` 15.x, which requires Python <3.13. A Python 3.10–3.12 environment is therefore needed for a fresh genotype-level rerun.

The downstream analysis can be reproduced from the archived CSV files without accessing raw MalariaGEN genotype data.

## Data policy

This repository contains code and derived analysis tables, not raw MalariaGEN genomic data. Access to source genomic data remains through MalariaGEN.

## Reproducing the final results

1. Put the repository in Google Drive or clone it locally.
2. If the complete FST CSV is already present, run `code/final_thesis_analysis.ipynb`.
3. To regenerate the genotype-level FST scan, first use a Python <3.13 environment with a compatible `malariagen_data` release, then run `code/final_fst_scan.ipynb`.
4. The analysis outputs are written to the final output `tables` and `figures` folders used by the notebook.
5. Compare regenerated outputs with the files under `results/`.

See `docs/GITHUB_UPLOAD_TUTORIAL.md` for upload instructions.
