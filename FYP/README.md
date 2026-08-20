# MSc Research Project – Anopheles coluzzii FST analysis

This folder contains the code used for my MSc research project:

**Genomic differentiation among West African Anopheles coluzzii populations: a Nigeria-associated high-FST region on the X chromosome**

## Computational environment

All analysis code was written and executed in Google Colab.

The analysis used Python and the `malariagen-data` API to access the MalariaGEN Ag3 resource.

## Main analysis notebook

`Coluzzii_FST_Final.ipynb`

The notebook includes:

- selection of 2022 female Anopheles coluzzii populations;
- population-size filtering with n >= 50;
- geographic-distance calculations;
- pairwise FST analysis for X and 3R;
- separate analysis of 0-fold and 4-fold coding sites;
- background differentiation analyses;
- focal X-region analysis;
- secondary peak screening;
- statistical tests;
- gene annotation and figure generation.

## Data availability

Genomic data were accessed from the MalariaGEN Ag3 resource through the `malariagen-data` Python API.

Raw MalariaGEN genomic data are not redistributed in this repository.

## Reproducibility

The notebook was designed for Google Colab. Long-running FST calculations use checkpoint files to reduce memory use and allow interrupted analyses to resume.

## Author
Ruixuan Han  
Imperial College London  
rh925@ic.ac.uk
