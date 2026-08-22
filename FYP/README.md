# FYP Population Genomic Differentiation Analysis

This repository contains the analysis code, derived datasets, statistical outputs and figures for an MSc research project investigating population genomic differentiation in *Anopheles coluzzii*.

The project uses whole-genome data from the MalariaGEN Anopheles gambiae genomic surveillance Ag3 resource and focuses on patterns of genetic differentiation among four West African *Anopheles coluzzii* populations.

The main analysis compares population differentiation on the X chromosome and chromosome arm 3R using non-overlapping 1 Mb windows and separate estimates for 0-fold and 4-fold coding sites.

---

## Project overview

The main objectives of the analysis were to:

- quantify pairwise population differentiation using FST;
- compare differentiation between the X chromosome and chromosome arm 3R;
- compare 0-fold and 4-fold coding-site differentiation;
- identify a recurrent region of elevated differentiation on the X chromosome;
- compare Nigeria-containing and non-Nigeria population pairs;
- examine the genomic background after excluding the focal X region;
- identify additional secondary regions of unusually high differentiation;
- assess usable-site counts and other quality-control information;
- generate statistical summaries, figures and tables used in the final project.

FST should be interpreted as a measure of relative population differentiation. Elevated FST alone does not demonstrate positive selection.

---

## Study populations

The final analysis includes four *Anopheles coluzzii* populations collected in 2022:

| Population ID | Country | Sample size |
|---|---|---:|
| Nigeria_Gombe | Nigeria | 57 |
| BurkinaFaso_BanaVillage | Burkina Faso | 120 |
| Guinea_Siguiri_Dankakoro | Guinea | 81 |
| Mali_Faladje | Mali | 75 |

Only populations containing at least 50 samples were included in the final analysis.

All six possible pairwise population comparisons were analysed.

These are divided into:

- three comparisons containing Nigeria_Gombe;
- three comparisons not containing Nigeria_Gombe.

---

## Genomic data

Genomic data were obtained from the MalariaGEN Anopheles gambiae genomic surveillance Ag3 resource.

Only samples classified in the resource metadata as *Anopheles coluzzii* were retained for analysis.

The analysis uses:

- X chromosome;
- chromosome arm 3R;
- 0-fold coding sites;
- 4-fold coding sites;
- non-overlapping 1 Mb genomic windows.

The scan covers approximately the first 25 Mb from the centromeric end of each chromosome arm.

This gives:

- 24 windows on X;
- 25 windows on 3R.

---

## FST analysis

Pairwise FST was estimated for all six population comparisons.

The analysis was performed separately for:

- X, 0-fold sites;
- X, 4-fold sites;
- 3R, 0-fold sites;
- 3R, 4-fold sites.

The genotype-level analysis was implemented using the MalariaGEN Python API.

The final scan contains:

```text
6 population pairs
×
(24 X windows + 25 3R windows)
×
2 site classes
=
588 FST observations
```

Slightly negative FST estimates were retained rather than truncated to zero.

---

## Focal X region

A recurrent region of elevated differentiation was identified on the X chromosome.

The focal interval is:

```text
X:13,393,109–17,393,108
```

This region contains four consecutive 1 Mb windows.

The strongest differentiation is concentrated within the central two windows:

```text
X:14,393,109–16,393,108
```

The focal region shows strong differentiation in the three Nigeria-containing comparisons, while the corresponding non-Nigeria comparisons remain much closer to genomic background levels.

The focal X region is therefore treated as a localised, recurrent, Nigeria-associated differentiation signal.

This pattern is not interpreted as direct proof of positive selection.

---

## Background analysis

To examine whether the focal X signal reflects chromosome-wide differentiation or a localised feature, the four focal X windows were removed from the background analysis.

The background dataset therefore contains:

- 20 X windows per population pair;
- all 25 3R windows per population pair.

No 3R windows were removed as part of the focal-X exclusion.

The background analysis is used to compare:

- population-pair differentiation;
- X versus 3R differentiation;
- 0-fold versus 4-fold differentiation;
- Nigeria-containing versus non-Nigeria comparisons.

---

## Main background findings

Population-pair identity has a strong effect on background FST.

Nigeria-containing comparisons generally show higher background differentiation than non-Nigeria comparisons.

After removing the focal X region, however, the X chromosome is not generally more differentiated than 3R.

The paired X versus 3R tests show no significant overall X elevation after multiple-testing correction.

The 0-fold versus 4-fold patterns also differ between chromosomes:

- on X, 0-fold FST is generally higher than 4-fold FST;
- on 3R, the direction is reversed on average.

These site-class comparisons are therefore interpreted separately for X and 3R rather than as one genome-wide effect.

---

## Secondary differentiation landscape

A secondary scan was performed after excluding the focal X region.

For each:

```text
population pair × chromosome × site class
```

a robust local background threshold was defined using:

```text
median FST + 3 × scaled MAD
```

where MAD is the median absolute deviation.

This threshold is used as a descriptive method for identifying unusually differentiated windows relative to their local background.

It is not a formal selection test.

The secondary analysis identified:

- 83 robust outlier observations;
- 27 unique 1 Mb genomic windows containing at least one outlier;
- 22 broader secondary regions.

No secondary window showed the same strict pattern of recurrence observed at the focal X region across the three Nigeria-containing comparisons while being absent from all three non-Nigeria comparisons.

This supports the interpretation that the focal X signal is unusually recurrent and localised compared with the broader genomic landscape.

---

## Usable-site quality control

The number of usable sites was recorded separately for 0-fold and 4-fold analyses.

Windows containing fewer than 1000 usable sites were flagged for quality control.

These windows were not automatically removed from the analysis.

This allows potentially low-information windows to be identified while preserving the original FST scan.

---

## Repository structure

```text
FYP/
│
├── README.md
├── requirements.txt
│
├── code/
│   ├── exploratory_analysis.ipynb
│   ├── fst_scan.ipynb
│   └── thesis_analysis.ipynb
│
├── data/
│   ├── FST_selected6pairs_1Mb_3R_X_full_scan_minN50.csv
│   ├── compact_FST_selected6pairs_1Mb_3R_X_full_scan_minN50.csv
│   ├── peak_summary_selected6pairs_1Mb_3R_X_full_scan_minN50.csv
│   ├── selected_4populations_summary.csv
│   ├── selected_6pairs.csv
│   ├── selected_samples_exact.csv
│   ├── scan_windows_1Mb_from_CEN_3R_X.csv
│   ├── site_counts_1Mb_windows_3R_X_existing_counts.csv
│   └── all_6comparisons_1Mb_windows_FST4_FST0_site_counts.csv
│
├── results/
│   ├── RESULTS_SUMMARY.md
│   │
│   ├── tables/
│   │   ├── focal-region summaries
│   │   ├── background FST summaries
│   │   ├── statistical tests
│   │   ├── usable-site QC tables
│   │   └── secondary-region analyses
│   │
│   └── figures/
│       ├── full X scans
│       ├── full 3R scans
│       ├── background summaries
│       └── focal-region figures
│
└── docs/
    ├── DATA_NOTES.md
    ├── RESULT_VALIDATION_NOTE.md
    ├── NOTEBOOK_CHECKS.csv
    └── FILE_MANIFEST.csv
```

---

## Main notebooks

### `exploratory_analysis.ipynb`

Contains exploratory analyses used during development of the project.

This includes:

- population filtering;
- site-count inspection;
- preliminary FST comparisons;
- examination of genomic windows;
- evaluation of candidate regions;
- exploratory statistical summaries.

This notebook is retained to document the development of the analytical workflow.

---

### `fst_scan.ipynb`

Contains the genotype-level FST scan.

The notebook:

- loads the MalariaGEN Ag3 resource;
- selects the four final *Anopheles coluzzii* populations;
- constructs all six population pairs;
- defines 1 Mb windows on X and 3R;
- separates 0-fold and 4-fold sites;
- calculates pairwise FST;
- records usable-site counts;
- uses checkpointing to allow long computations to resume;
- exports the completed FST dataset.

This notebook requires access to the MalariaGEN Ag3 genomic resource.

---

### `thesis_analysis.ipynb`

Contains the downstream statistical and graphical analyses based on the completed FST dataset.

The notebook includes:

- FST data validation;
- conversion to paired 0-fold/4-fold tables;
- usable-site count integration;
- Nigeria-containing versus non-Nigeria classification;
- focal X-region analysis;
- background analysis;
- Friedman tests;
- paired Wilcoxon tests;
- X versus 3R comparisons;
- 0-fold versus 4-fold comparisons;
- Nigeria versus non-Nigeria background summaries;
- isolation-by-distance exploration;
- robust secondary-outlier detection;
- recurrence analysis;
- multi-window clustering;
- broader secondary-region summaries;
- quality-control tables;
- generation of figures and final result tables.

---

## Key output files

The main completed FST dataset is:

```text
data/FST_selected6pairs_1Mb_3R_X_full_scan_minN50.csv
```

The combined usable-site information is stored in:

```text
data/site_counts_1Mb_windows_3R_X_existing_counts.csv
```

The main downstream results are stored in:

```text
results/tables/
```

The generated figures are stored in:

```text
results/figures/
```

A concise numerical overview is available in:

```text
results/RESULTS_SUMMARY.md
```

---

## Reproducing the downstream analysis

The downstream analysis can be reproduced without redistributing the original raw MalariaGEN genomic data.

The completed FST and usable-site datasets are included under `data/`.

To reproduce the analysis:

1. Clone or download this repository.
2. Open:

```text
code/thesis_analysis.ipynb
```

3. Update the input and output paths if necessary.
4. Run the notebook from top to bottom.
5. Compare the generated tables and figures with the archived files under `results/`.

---

## Re-running the genotype-level FST scan

To reproduce the original FST calculations from the MalariaGEN resource, use:

```text
code/fst_scan.ipynb
```

This requires access to the MalariaGEN Ag3 data resource and a compatible Python environment.

The scan uses checkpoint files because genotype-level calculations can require substantial memory and runtime.

---

## Python environment

The genotype-level FST workflow was developed for a `malariagen_data` 15.x environment.

These versions require Python below 3.13.

A Python 3.10–3.12 environment is therefore recommended for a fresh genotype-level rerun.

Core Python packages used in the project include:

```text
malariagen_data
pandas
numpy
scipy
matplotlib
statsmodels
scikit-allel
```

The downstream analysis can be run directly from the completed CSV files without access to the raw genomic data.

---

## Data availability

This repository contains:

- analysis code;
- derived FST datasets;
- population metadata used by the analysis;
- usable-site counts;
- statistical result tables;
- figures generated by the project.

Raw MalariaGEN genomic data are not redistributed.

Genomic data were accessed through the MalariaGEN Ag3 resource.

---

## Interpretation and limitations

Several limitations should be considered when interpreting the results.

The final analysis includes only four populations, giving six pairwise population comparisons.

These comparisons are not statistically independent because the same populations occur in multiple pairs.

The use of 1 Mb windows provides a broad view of differentiation but limits fine-scale localisation of candidate variants.

FST is a relative measure of population differentiation and cannot by itself distinguish among possible causes such as:

- local adaptation;
- linked selection;
- demographic history;
- structural variation;
- allele-frequency differences;
- independent selective events.

The current analysis also focuses only on X and 3R and does not directly estimate nucleotide diversity, haplotypes, copy-number variation or structural variants.

The focal X region should therefore be interpreted as a strong candidate region for further investigation rather than as definitive evidence of a specific selective mechanism.

---

## Further analysis

Useful follow-up analyses would include:

1. examining allele-frequency and nucleotide-diversity patterns within the focal X region;
2. comparing haplotypes among Nigeria, Burkina Faso and Mali;
3. analysing copy-number and structural variation around candidate genes in the focal region;
4. increasing geographic and population sampling;
5. using finer genomic windows or variant-level analyses to localise the differentiation signal.

---

## Author

**Ruixuan Han**  
Imperial College London  
Email: **rh925@ic.ac.uk**
