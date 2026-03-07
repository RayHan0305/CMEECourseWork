# CMEE 2025 HPC exercises R code pro forma
# For neutral model cluster run

# good practice 
rm(list = ls())
graphics.off()

source("Code/rh925_HPC_2025_main.R")
source("Code/Demographic.R")

# Read job number from cluster
iter <- as.numeric(Sys.getenv("PBS_ARRAY_INDEX"))
if (is.na(iter)) stop("PBS_ARRAY_INDEX must be set on the cluster (array job).")

# Unique seed per job
set.seed(iter)

# Allocate community size: 25 jobs per size
if (iter >= 1 && iter <= 25) {
  size <- 500
} else if (iter >= 26 && iter <= 50) {
  size <- 1000
} else if (iter >= 51 && iter <= 75) {
  size <- 2500
} else if (iter >= 76 && iter <= 100) {
  size <- 5000
} else {
  stop("PBS_ARRAY_INDEX must be between 1 and 100.")
}

# Speciation rate
source("Code/Get_my_speciation_rate.R")
speciation_rate <- personal_speciation_rate

# Output filename (include iter to avoid overwrite)
dir.create("Data", showWarnings = FALSE, recursive = TRUE)
output_file_name <- paste0("Data/neutral_size_", size, "_iter_", sprintf("%03d", iter), ".rda")

# Time limit: 11.5 hours IN CODE, cluster requests 12 hours
wall_time <- 11.5 * 60  # minutes

neutral_cluster_run(
  speciation_rate = speciation_rate,
  size = size,
  wall_time = wall_time,
  interval_rich = 1,
  interval_oct  = size / 10,
  burn_in_generations = 8 * size,
  output_file_name = output_file_name
)