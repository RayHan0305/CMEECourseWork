# CMEE HPC Programming Exercises — 2025

**Student:** Ruixuan Han (rh925)  
**MSc Computational Methods in Ecology and Evolution — Imperial College London**

---

## Overview

This repository contains code, HPC job scripts, and analysis functions produced for the **CMEE HPC Programming Exercises (17–21 Nov 2025)**.

The coursework includes:

- Stochastic demographic population simulations (stage-structured model)
- Individual-based neutral ecological simulations (with and without speciation)
- Parallel simulations on Imperial's **CX3** HPC cluster (PBS array jobs)
- Post-processing and visualisation of cluster outputs
- Challenge analyses including equilibrium and coalescence simulations

---

## Directory structure
```
hpc/
├── Code/ # R scripts and cluster job scripts
├── Data/ # Simulation outputs from HPC (large; usually ignored by git)
├── Results/ # Figures generated from analysis (png)
├── Log/ # HPC job logs (OU/ER files; usually ignored by git)
├── hpc.Rproj
└── README.md
```

---

# Code Files

### Main script

`rh925_HPC_2025_main.R`

Contains all functions required for:

- Section 1 demographic model
- Section 2 neutral theory model
- Post-processing cluster results
- Challenge questions

Functions in this file produce all figures required for the assignment.

---

### Cluster simulation scripts

`rh925_HPC_2025_demographic_cluster.R`

Runs stochastic demographic simulations on the HPC cluster.

`rh925_HPC_2025_neutral_cluster.R`

Runs neutral theory simulations with speciation on the HPC cluster.

---

### Supporting scripts

`Demographic.R`

Provided code implementing deterministic and stochastic demographic models.

`Get_my_speciation_rate.R`

Loads the assigned speciation rate used for neutral model simulations.

---

# Shell scripts

Shell scripts are used to submit jobs to the cluster using PBS.

`run_demographic_cluster.sh`

Runs demographic simulations using an array job.

`run_neutral_cluster.sh`

Runs neutral simulations using an array job.

Example usage:

```bash
qsub -J 1-100 Code/run_neutral_cluster.sh
```
---

## How to run (local)

1) Open R in the project root (the folder containing `Code/`, `Results/`, etc.)
2) Source the main file:

```r
source("Code/rh925_HPC_2025_main.R")

## Author
Ruixuan Han
rh925@ic.ac.uk
