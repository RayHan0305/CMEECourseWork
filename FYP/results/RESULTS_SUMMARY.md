# Results summary

This folder contains results regenerated from the archived completed six-pair FST scan using the analysis logic in `code/final_thesis_analysis.ipynb`.

## Dataset checks

- Successful FST rows: 588
- Population pairs: 6
- X windows: 24
- 3R windows: 25
- Focal X interval: X:13,393,109–17,393,108
- Focal windows per pair: 4
- Background X windows after focal exclusion: 20
- 3R windows retained in background: 25

## Population-pair effects in the background

- 3R 0-fold: χ²=19.6228, raw p=0.00147065, FDR p=0.00147065.
- 3R 4-fold: χ²=37.6109, raw p=4.51696e-07, FDR p=9.03392e-07.
- X 0-fold: χ²=29.6165, raw p=1.7546e-05, FDR p=2.33947e-05.
- X 4-fold: χ²=57.8605, raw p=3.36088e-11, FDR p=1.34435e-10.

## Paired background comparisons

- X vs 3R — 0-fold: mean difference=-0.000152770, raw p=0.6875, FDR p=0.6875.
- X vs 3R — 4-fold: mean difference=-0.001252997, raw p=0.15625, FDR p=0.208333.
- 0-fold vs 4-fold — X: mean difference=0.000520414, raw p=0.03125, FDR p=0.125.
- 0-fold vs 4-fold — 3R: mean difference=-0.000579813, raw p=0.09375, FDR p=0.1875.

## Focal X interval

- NG_Gombe vs BF_BanaVil: mean FST0=0.101761, mean FST4=0.077157.
- NG_Gombe vs GN_Siguiri: mean FST0=0.101278, mean FST4=0.070742.
- NG_Gombe vs ML_Faladje: mean FST0=0.087945, mean FST4=0.070377.
- BF_BanaVil vs GN_Siguiri: mean FST0=0.000579, mean FST4=0.001164.
- BF_BanaVil vs ML_Faladje: mean FST0=0.001134, mean FST4=0.001152.
- GN_Siguiri vs ML_Faladje: mean FST0=0.000056, mean FST4=0.000078.

The pair-level 0-fold versus 4-fold comparison within the focal interval used only the three Nigeria-containing comparisons:
- mean FST0−FST4 difference = 0.024236573
- Wilcoxon raw p = 0.25

## Site-count QC

- Pair-window rows: 294
- Rows with <1000 usable 0-fold sites: 6
- Rows with <1000 usable 4-fold sites: 18
- Windows are flagged for QC rather than automatically removed.

## Secondary differentiation landscape

- Robust outlier observations: 83
- Unique 1 Mb windows containing at least one robust outlier: 27
- Within-pair multi-window clusters: 16
- Consensus secondary regions: 22
- Nigeria-recurrent 2-of-3 / non-Nigeria 0-of-3 window-site signals: 0
- Nigeria-recurrent 3-of-3 / non-Nigeria 0-of-3 window-site signals: 0
- Robust outlier observations with <1000 usable sites: 3

## Interpretation boundary

These outputs describe differentiation. High FST or a robust outlier flag is not, by itself, proof of positive selection. The focal X region is best described as a localised, recurrent, Nigeria-associated differentiation signal.


## Secondary-region grouping note

The broader secondary-region count uses the original v3.6 thesis rule: robust windows are grouped separately by chromosome and site class, and only windows separated by no more than 50 kb are merged. This gives 22 broader secondary regions, matching the final thesis result.
