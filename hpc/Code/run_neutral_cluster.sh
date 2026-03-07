#!/bin/bash
#PBS -N neutral_Q24
#PBS -l select=1:ncpus=1:mem=4gb
#PBS -l walltime=12:00:00
#PBS -o Log/
#PBS -e Log/

set -euo pipefail

cd "$PBS_O_WORKDIR"
mkdir -p Log Data

module purge
module load tools/prod
module load R/4.4.2-gfbf-2024a

echo "Using Rscript:"
which Rscript
Rscript --version

Rscript Code/rh925_HPC_2025_neutral_cluster_run.R
