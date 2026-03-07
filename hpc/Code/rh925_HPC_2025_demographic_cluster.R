# CMEE 2025 HPC exercises R code pro forma
# For stochastic demographic model cluster run

rm(list = ls()) # good practice 
graphics.off()
source("Demographic.R") 
source("rh925_HPC_2025_main.R")

iter <- as.numeric(Sys.getenv("PBS_ARRAY_INDEX"))
if (is.na(iter)) stop("PBS_ARRAY_INDEX not found.")

set.seed(iter)

num_stages <- 4
simulation_length <- 120

growth_matrix <- matrix(
  c(0.1, 0.0, 0.0, 0.0,
    0.5, 0.4, 0.0, 0.0,
    0.0, 0.4, 0.7, 0.0,
    0.0, 0.0, 0.25, 0.4),
  nrow = 4, ncol = 4, byrow = TRUE
)

reproduction_matrix <- matrix(
  c(0.0, 0.0, 0.0, 2.6,
    0.0, 0.0, 0.0, 0.0,
    0.0, 0.0, 0.0, 0.0,
    0.0, 0.0, 0.0, 0.0),
  nrow = 4, ncol = 4, byrow = TRUE
)

clutch_distribution <- c(0.06, 0.08, 0.13, 0.15, 0.16, 0.18, 0.15, 0.06, 0.03)

state_initialise_adult <- function(num_stages, initial_size) {
  c(rep(0, num_stages - 1), initial_size)
}

state_initialise_spread <- function(num_stages, initial_size) {
  base <- floor(initial_size / num_stages)
  remainder <- initial_size - base * num_stages
  state <- rep(base, num_stages)
  if (remainder > 0) state[1:remainder] <- state[1:remainder] + 1
  state
}

if (iter >= 1 && iter <= 25) {
  initial_state <- state_initialise_adult(num_stages, 100)
  ic_label <- "100_adults"
} else if (iter >= 26 && iter <= 50) {
  initial_state <- state_initialise_adult(num_stages, 10)
  ic_label <- "10_adults"
} else if (iter >= 51 && iter <= 75) {
  initial_state <- state_initialise_spread(num_stages, 100)
  ic_label <- "100_spread"
} else if (iter >= 76 && iter <= 100) {
  initial_state <- state_initialise_spread(num_stages, 10)
  ic_label <- "10_spread"
} else {
  stop("iter out of range 1-100: ", iter)
}

dir.create("Data", showWarnings = FALSE, recursive = TRUE)
outfile <- sprintf("Data/demographic_%s_iter_%03d.rda", ic_label, iter)

n_reps <- 150
results <- vector("list", length = n_reps)

save_every <- 10

for (i in seq_len(n_reps)) {
  results[[i]] <- stochastic_simulation(
    initial_state = initial_state,
    growth_matrix = growth_matrix,
    reproduction_matrix = reproduction_matrix,
    clutch_distribution = clutch_distribution,
    simulation_length = simulation_length
  )
  
  if (i %% save_every == 0) {
    save(results, iter, ic_label, initial_state, simulation_length,
         growth_matrix, reproduction_matrix, clutch_distribution,
         file = outfile)
  }
}

save(results, iter, ic_label, initial_state, simulation_length,
     growth_matrix, reproduction_matrix, clutch_distribution,
     file = outfile)