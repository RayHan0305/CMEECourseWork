# FYP Population Genomic Differentiation Analysis

This repository contains the analysis code, derived datasets and generated outputs for the FYP population-genomic differentiation project.

The analysis focuses on population differentiation in *Anopheles coluzzii* using 1 Mb windowed FST estimates on the X chromosome and chromosome arm 3R, with separate analyses of 0-fold and 4-fold coding sites.

## Repository structure

```text
code/
  exploratory_analysis.ipynb
  fst_scan.ipynb
  main_analysis.ipynb

data/
  derived FST datasets
  population and pair definitions
  scan windows
  usable-site counts
  selected sample metadata

results/
  RESULTS_SUMMARY.md
  tables/
  figures/

docs/
  GITHUB_UPLOAD_TUTORIAL.md
  DATA_NOTES.md
  RESULT_VALIDATION_NOTE.md
  NOTEBOOK_CHECKS.csv
  FILE_MANIFEST.csv