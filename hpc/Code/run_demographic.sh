#!/bin/bash
#PBS -N demographic_Q3
#PBS -l walltime=03:00:00
#PBS -l select=1:ncpus=1:mem=4gb
#PBS -j oe
#PBS -o Log/

set -euo pipefail

cd "$PBS_O_WORKDIR"
mkdir -p Log Data

module purge
module load tools/prod
module load R/4.4.2-gfbf-2024a

echo "Using Rscript:"
which Rscript
Rscript --version

Rscript Code/rh925_HPC_2025_demographic_cluster.R
