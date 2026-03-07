# CMEE 2025 HPC exercises R code main pro forma
# You don't HAVE to use this but it will be very helpful.
# If you opt to write everything yourself from scratch please ensure you use
# EXACTLY the same function and parameter names and beware that you may lose
# marks if it doesn't work properly because of not using the pro-forma.

name <- "ruixuan Han"
preferred_name <- "ray"
email <- "rh925@imperial.ac.uk"
username <- "rh925"

# Please remember *not* to clear the work space here, or anywhere in this file.
# If you do, it'll wipe out your username information that you entered just
# above, and when you use this file as a 'toolbox' as intended it'll also wipe
# away everything you're doing outside of the toolbox.  For example, it would
# wipe away any automarking code that may be running and that would be annoying!

# Section One: Stochastic demographic population model

# This function is called internally to calculate total population size.
sum_vect <- function(state, individuals_count) {
  sum(state * individuals_count)
}

# Question 0

state_initialise_adult <- function(num_stages,initial_size){
  c(rep(0, num_stages - 1), initial_size)
}

state_initialise_spread <- function(num_stages,initial_size){
  base <- floor(initial_size/num_stages)
  remainder <- initial_size-base*num_stages
  state <- rep(base, num_stages)
  
  if(remainder>0){
    state[1:remainder] <- state[1:remainder]+1
  }
  state
}

# Question 1
question_1 <- function(){
  source("Demographic.R")
  
  num_stages <- 4
  simulation_length <- 24
  
  growth_matrix <- matrix(c(0.1, 0.0, 0.0, 0.0,
                            0.5, 0.4, 0.0, 0.0,
                            0.0, 0.4, 0.7, 0.0,
                            0.0, 0.0, 0.25, 0.4),
                          nrow=4, ncol=4, byrow=TRUE)
  
  reproduction_matrix <- matrix(c(0.0, 0.0, 0.0, 2.6,
                                  0.0, 0.0, 0.0, 0.0,
                                  0.0, 0.0, 0.0, 0.0,
                                  0.0, 0.0, 0.0, 0.0),
                                nrow=4, ncol=4, byrow=TRUE)
  
  projection_matrix <- reproduction_matrix + growth_matrix
  
  # initial conditions
  init_adult  <- state_initialise_adult(num_stages = num_stages, initial_size = 100)
  init_spread <- state_initialise_spread(num_stages = num_stages, initial_size = 100)
  
  # returns population size time series
  ts_adult <- deterministic_simulation(initial_state = init_adult,
                                       simulation_length = simulation_length,
                                       projection_matrix = projection_matrix)
  
  ts_spread <- deterministic_simulation(initial_state = init_spread,
                                        simulation_length = simulation_length,
                                        projection_matrix = projection_matrix)
  
  png(filename="../Results/question_1.png", width = 600, height = 400)
  # plot your graph here
  plot(ts_adult, type = "l",
       xlab = "Time step", ylab = "Total population size",
       main = "Deterministic simulation (4 life stages, 24 steps)",
       col = 1)
  lines(ts_spread, col = 2)
  legend("topleft",
         legend = c("100 adults (final stage)", "100 spread across stages"),
         lty = 1, col = c(1, 2), bty = "n")
  
  Sys.sleep(0.1)
  dev.off()
  
  return(paste("The initial life-stage distribution mainly affects early population growth. ",
               "Starting with all individuals in the adult stage allows immediate reproduction, ",
               "leading to faster initial growth and transient fluctuations.When individuals are spread across life stages, ",
               "fewer are reproductive at the start, so early growth is slower and smoother. ",
               "Over time, both simulations converge towards similar growth patterns determined by the projection matrix, meaning the initial distribution has little effect on long-term population growth."
  ))
}

# Question 2
question_2 <- function(){
  source("Demographic.R")
  set.seed(1)
  
  num_stages <- 4
  simulation_length <- 24
  
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
  
  # initial conditions
  init_adult  <- state_initialise_adult(num_stages = num_stages, initial_size = 100)
  init_spread <- state_initialise_spread(num_stages = num_stages, initial_size = 100)
  
  # stochastic simulations
  ts_adult <- stochastic_simulation(
    initial_state = init_adult,
    growth_matrix = growth_matrix,
    reproduction_matrix = reproduction_matrix,
    clutch_distribution = clutch_distribution,
    simulation_length = simulation_length
  )
  
  ts_spread <- stochastic_simulation(
    initial_state = init_spread,
    growth_matrix = growth_matrix,
    reproduction_matrix = reproduction_matrix,
    clutch_distribution = clutch_distribution,
    simulation_length = simulation_length
  )
  png(filename="../Results/question_2.png", width = 600, height = 400)
  # plot your graph here
  plot(ts_adult, type = "l",
       xlab = "Time step", ylab = "Total population size",
       main = "Stochastic simulation (4 life stages, 24 steps)",
       col = 1)
  lines(ts_spread, col = 2)
  legend("topleft",
         legend = c("100 adults (final stage)", "100 spread across stages"),
         lty = 1, col = c(1, 2), bty = "n")
  
  Sys.sleep(0.1)
  dev.off()
  
  return(paste("Compared with the deterministic simulations in Question 1, the stochastic simulations are much less smooth. ",
               "The deterministic model updates population sizes using expected (average) survival, maturation and reproduction rates, ",
               "so the population changes smoothly from one time step to the next. ",
               "In contrast, the stochastic model treats survival, transitions and clutch sizes as random discrete events, ",
               "so births and deaths fluctuate around their expected values and can produce jagged trajectories. ",
               "This variability is strongest when the population is small, because random chance then has a larger proportional effect."
               ))
}

# Questions 3 and 4 involve writing code elsewhere to run your simulations on the cluster


# Question 5
question_5 <- function(){
  
  files <- list.files("../Data", pattern = "^demographic_.*_iter_\\d+\\.rda$", full.names = TRUE)
  
  # Map file -> interpretable label
  label_from_file <- function(f){
    if(grepl("100_adults", f)) return("adults, large population")
    if(grepl("10_adults", f))  return("adults, small population")
    if(grepl("100_spread", f)) return("mixed, large population")
    if(grepl("10_spread", f))  return("mixed, small population")
    return(NA_character_)
  }
  
  labels <- vapply(files, label_from_file, character(1))
  keep <- !is.na(labels)
  files <- files[keep]
  labels <- labels[keep]
  
  # Count extinctions
  tab <- setNames(rep(0, 4),
                  c("adults, large population",
                    "adults, small population",
                    "mixed, large population",
                    "mixed, small population"))
  tot <- tab
  
  for(k in seq_along(files)){
    load(files[k])  # expects object: results
    lab <- labels[k]
    
    # results is a list of 150 time series vectors
    extinct_vec <- vapply(results, function(ts) ts[length(ts)] == 0, logical(1))
    tab[lab] <- tab[lab] + sum(extinct_vec)
    tot[lab] <- tot[lab] + length(extinct_vec)
  }
  
  prop_extinct <- tab / tot
  
  png(filename="../Results/question_5.png", width=600, height=400)
  barplot(prop_extinct,
          ylab="Proportion extinct",
          xlab="Initial condition",
          main="Extinction probability across initial conditions",
          las=2)
  Sys.sleep(0.1)
  dev.off()
  
  worst <- names(which.max(prop_extinct))
  return(paste("The population most likely to go extinct was ", worst, ". ",
               "This is because it starts as the smallest population and is spread across life stages, so relatively few individuals are reproductive at the beginning. ",
               "With such a small starting population, demographic stochasticity (random variation in survival and reproduction) has a much larger proportional effect, making extinction more likely. ",
               "By contrast, large populations buffer these random fluctuations, and populations starting with many adults reproduce immediately, reducing extinction risk."
               ))
}

# Question 6
question_6 <- function(){
  
  source("Demographic.R")
  
  growth_matrix <- matrix(
    c(0.1, 0.0, 0.0, 0.0,
      0.5, 0.4, 0.0, 0.0,
      0.0, 0.4, 0.7, 0.0,
      0.0, 0.0, 0.25, 0.4),
    nrow=4, byrow=TRUE
  )
  reproduction_matrix <- matrix(
    c(0.0, 0.0, 0.0, 2.6,
      0.0, 0.0, 0.0, 0.0,
      0.0, 0.0, 0.0, 0.0,
      0.0, 0.0, 0.0, 0.0),
    nrow=4, byrow=TRUE
  )
  projection_matrix <- growth_matrix + reproduction_matrix
  
  num_stages <- 4
  simulation_length <- 120
  
  # Your initialisation functions (if not already defined globally)
  state_initialise_spread <- function(num_stages, initial_size){
    base <- floor(initial_size/num_stages)
    remainder <- initial_size - base*num_stages
    state <- rep(base, num_stages)
    if(remainder > 0) state[1:remainder] <- state[1:remainder] + 1
    state
  }
  
  # Helper: load a set of files and compute mean stochastic trend
  mean_trend_from_files <- function(files){
    sum_ts <- NULL
    n <- 0
    for(f in files){
      load(f)  # expects results list of 150 time series
      for(ts in results){
        if(is.null(sum_ts)){
          sum_ts <- rep(0, length(ts))
        }
        sum_ts <- sum_ts + ts
        n <- n + 1
      }
    }
    sum_ts / n
  }
  
  files_large_mixed <- list.files("../Data", pattern="^demographic_100_spread_iter_\\d+\\.rda$", full.names=TRUE)
  files_small_mixed <- list.files("../Data", pattern="^demographic_10_spread_iter_\\d+\\.rda$", full.names=TRUE)
  
  mean_large <- mean_trend_from_files(files_large_mixed)
  mean_small <- mean_trend_from_files(files_small_mixed)
  
  det_large <- deterministic_simulation(
    initial_state = state_initialise_spread(num_stages, 100),
    simulation_length = simulation_length,
    projection_matrix = projection_matrix
  )
  det_small <- deterministic_simulation(
    initial_state = state_initialise_spread(num_stages, 10),
    simulation_length = simulation_length,
    projection_matrix = projection_matrix
  )
  
  dev_large <- mean_large / det_large
  dev_small <- mean_small / det_small
  
  png(filename="../Results/question_6.png", width=600, height=400)
  
  plot(0:simulation_length, dev_large, type="l",
       xlab="Time step",
       ylab="Mean stochastic / deterministic",
       main="Deviation of stochastic mean trend from deterministic (mixed populations)",
       col="black",      # large population
       lwd=2,            # thicker line
       ylim=range(c(dev_large, dev_small), na.rm=TRUE))
  
  lines(0:simulation_length, dev_small,
        col="red",       # small population
        lwd=2)
  
  abline(h=1, lty=2, col="darkgrey")
  
  legend("topright",
         legend=c("Mixed, large population (100)",
                  "Mixed, small population (10)",
                  "Ratio = 1"),
         col=c("black","red","darkgrey"),
         lty=c(1,1,2),
         lwd=c(2,2,1),
         bty="n")
  
  Sys.sleep(0.1)
  dev.off()
  
  # Decide which is closer to deterministic on average
  mad_large <- mean(abs(dev_large - 1), na.rm=TRUE)
  mad_small <- mean(abs(dev_small - 1), na.rm=TRUE)
  
  if(mad_large < mad_small){
    return(paste("It is more appropriate to approximate the average behaviour with a deterministic model for the large mixed population. ",
                 "With more individuals, stochastic fluctuations average out and the mean trajectory stays closer to the deterministic expectation, ",
                 "whereas the small mixed population is strongly affected by demographic stochasticity and extinctions."
    ))
  } else {
    return("It is more appropriate to approximate the average behaviour with a deterministic model for the small mixed population.")
  }
}


# Section Two: Individual-based ecological neutral theory simulation 

# Question 7
species_richness <- function(community) {
  length(unique(community))
}


# Question 8
init_community_max <- function(size) {
  seq(1, size)
}


# Question 9
init_community_min <- function(size) {
  rep(1, size)
}
# Test
# species_richness(init_community_min(10))

# Question 10
choose_two <- function(max_value) {
  sample(1:max_value, size = 2, replace = FALSE)
}


# Question 11
neutral_step <- function(community) {
  # choose two different individuals
  idx <- choose_two(length(community))
  
  death <- idx[1]
  reproduce <- idx[2]
  
  # replace the dead individual with offspring of the reproducer
  community[death] <- community[reproduce]
  
  community
}


# Question 12
neutral_generation <- function(community) {
  x <- length(community)
  
  # number of neutral steps in one generation
  if (x %% 2 == 0) {
    n_steps <- x / 2
  } else {
    n_steps <- sample(c(floor(x / 2), ceiling(x / 2)), 1)
  }
  
  # apply neutral_step n_steps times
  for (i in 1:n_steps) {
    community <- neutral_step(community)
  }
  
  community
}


# Question 13
neutral_time_series <- function(community, duration) {
  # initialise vector to store species richness
  richness_ts <- numeric(duration + 1)
  
  # initial species richness
  richness_ts[1] <- species_richness(community)
  
  # run simulation for each generation
  for (t in 1:duration) {
    community <- neutral_generation(community)
    richness_ts[t + 1] <- species_richness(community)
  }
  
  richness_ts
}
# neutral_time_series(community = init_community_max(7),duration = 20)

# Question 14
question_14 <- function() {
  # initial condition: maximal diversity, size 100
  community <- init_community_max(100)
  
  # run for 200 generations
  richness_ts <- neutral_time_series(community = community, duration = 200)
  
  png(filename = "../Results/question_14.png", width = 600, height = 400)
  plot(
    0:200, richness_ts,
    type = "l",
    xlab = "Generation",
    ylab = "Species richness",
    main = "Neutral model: richness over time (N=100)"
  )
  dev.off()
  
  
  return(paste("The system will always converge to monodominance (species richness = 1) if you wait long enough, ",
               "because with no speciation the neutral drift eventually eliminates all but one species by random extinction."
               ))
}

# Question 15
neutral_step_speciation <- function(community, speciation_rate) {
  # choose two different individuals
  idx <- choose_two(length(community))
  death <- idx[1]
  reproduce <- idx[2]
  
  # decide whether speciation happens
  if (runif(1) < speciation_rate) {
    # assign a brand-new species number not currently used
    new_species <- max(community) + 1
    community[death] <- new_species
  } else {
    # normal neutral replacement
    community[death] <- community[reproduce]
  }
  
  community
}

# neutral_step_speciation(c(1,1,2),speciation_rate = 0.8)
# neutral_step_speciation(c(1,1,2),speciation_rate = 0.2)

# Question 16
neutral_generation_speciation <- function(community, speciation_rate) {
  x <- length(community)
  
  # number of neutral steps in one generation
  if (x %% 2 == 0) {
    n_steps <- x / 2
  } else {
    n_steps <- sample(c(floor(x / 2), ceiling(x / 2)), 1)
  }
  
  # apply speciation-neutral steps n_steps times
  for (i in 1:n_steps) {
    community <- neutral_step_speciation(community, speciation_rate)
  }
  
  community
}


# Question 17
neutral_time_series_speciation <- function(community, speciation_rate, duration) {
  
  # initialise vector to store species richness
  richness_ts <- numeric(duration + 1)
  
  # initial species richness
  richness_ts[1] <- species_richness(community)
  
  # run simulation for each generation
  for (t in 1:duration) {
    community <- neutral_generation_speciation(community, speciation_rate)
    richness_ts[t + 1] <- species_richness(community)
  }
  
  richness_ts
}


# Question 18
question_18 <- function() {
  speciation_rate <- 0.1
  size <- 100
  duration <- 200
  
  # two initial conditions
  comm_max <- init_community_max(size)
  comm_min <- init_community_min(size)
  
  # time series of richness
  ts_max <- neutral_time_series_speciation(comm_max, speciation_rate, duration)
  ts_min <- neutral_time_series_speciation(comm_min, speciation_rate, duration)
  
  # plot + save to Results
  png(filename = "../Results/question_18.png", width = 600, height = 400)
  
  plot(
    0:duration, ts_max,
    type = "l",
    col = "black",
    lwd = 2,
    xlab = "Generation",
    ylab = "Species richness",
    main = "Neutral model with speciation (N=100, speciation_rate=0.1)"
  )
  
  lines(0:duration, ts_min,
        col = "red",
        lwd = 2)
  
  legend("topright",
         legend = c("init_community_max", "init_community_min"),
         col = c("black","red"),
         lty = 1,
         lwd = 2,
         bty = "n")
  Sys.sleep(0.1)
  dev.off()
  
  return(paste("Initial conditions mainly affect the early dynamics.",
               "Richness declines from the maximum state and increases from the minimum state, ",
               "but both converge to a similar fluctuating equilibrium.",
               "This occurs because long-term richness is determined by the balance between speciation and neutral drift."
               ))
}

# Question 19
species_abundance <- function(community) {
  sort(as.numeric(table(community)), decreasing = TRUE)
}

# species_abundance(c(1,5,3,6,5,6,1,1))

# Question 20
octaves <- function(abundances) {
  # If no species (empty input), return empty integer vector
  if (length(abundances) == 0) return(integer(0))
  
  # octave class for each abundance: 1 for {1}, 2 for {2,3}, 3 for {4..7}, etc.
  octave_id <- floor(log(abundances, base = 2)) + 1
  
  # count species in each octave class (1..max)
  tabulate(octave_id, nbins = max(octave_id))
}

# Question 21
sum_vect <- function(x, y) {
  # find maximum length
  max_len <- max(length(x), length(y))
  
  # pad shorter vector(s) with zeros
  if (length(x) < max_len) {
    x <- c(x, rep(0, max_len - length(x)))
  }
  
  if (length(y) < max_len) {
    y <- c(y, rep(0, max_len - length(y)))
  }
  
  # return element-wise sum
  x + y
}

# sum_vect(c(1,3),c(1,0,5,2))

# Question 22
question_22 <- function() {
  # Parameters
  source("Get_my_speciation_rate.R")
  speciation_rate <- personal_speciation_rate
  size <- 100
  burn_in <- 200
  extra_gens <- 2000
  sample_every <- 20
  
  octave_vec <- function(comm) {
    octaves(species_abundance(comm))
  }
  
  # Run protocol for one initial condition and return mean octave vector
  mean_octaves <- function(comm) {
    # Burn-in
    for (g in 1:burn_in) {
      comm <- neutral_generation_speciation(comm, speciation_rate)
    }
    
    # Record at end of burn-in, then every 20 generations for 2000 generations
    total <- integer(0)
    n_rec <- 0
    
    total <- sum_vect(total, octave_vec(comm))
    n_rec <- n_rec + 1
    
    for (g in 1:extra_gens) {
      comm <- neutral_generation_speciation(comm, speciation_rate)
      if (g %% sample_every == 0) {
        total <- sum_vect(total, octave_vec(comm))
        n_rec <- n_rec + 1
      }
    }
    
    total / n_rec
  }
  
  # Two initial conditions
  comm_max <- init_community_max(size)
  comm_min <- init_community_min(size)
  
  mean_max <- mean_octaves(comm_max)
  mean_min <- mean_octaves(comm_min)
  
  # plot your graph here
  png(filename = "../Results/question_22.png", width = 600, height = 400)
  par(mfrow = c(1, 2), mar = c(5, 4, 4, 1) + 0.1)
  
  barplot(mean_max,
          xlab = "Octave class",
          ylab = "Mean number of species",
          main = "Max initial richness")
  
  barplot(mean_min,
          xlab = "Octave class",
          ylab = "Mean number of species",
          main = "Min initial richness")
  
  Sys.sleep(0.1)
  dev.off()
  
  return(paste("Both simulations produce very similar octave distributions after the burn-in period,",
               "showing that the long-term species abundance distribution is independent of the",
               "initial condition. This occurs because speciation introduces new species while",
               "neutral drift randomly removes species, leading to a stable equilibrium."
               ))
}

# Question 23
neutral_cluster_run <- function(speciation_rate,
                                size,
                                wall_time,
                                interval_rich,
                                interval_oct,
                                burn_in_generations,
                                output_file_name) {
  # Start with minimal diversity community
  community <- init_community_min(size)
  
  # Timing setup
  start_time <- proc.time()
  time_limit_sec <- wall_time * 60
  
  # Storage
  time_series <- numeric(0)        # richness values during burn-in only
  abundance_list <- list()         # octave vectors during entire run
  
  gen <- 0
  oct_i <- 0
  
  # Main loop: run until time limit reached
  repeat {
    # stop if time exceeded
    elapsed_sec <- as.numeric((proc.time() - start_time)[["elapsed"]])
    if (elapsed_sec >= time_limit_sec) break
    
    # advance one generation
    gen <- gen + 1
    community <- neutral_generation_speciation(community, speciation_rate)
    
    # record richness only during burn-in, every interval_rich generations
    if (gen <= burn_in_generations && (gen %% interval_rich == 0)) {
      time_series <- c(time_series, species_richness(community))
    }
    
    # record octave abundances for entire simulation, every interval_oct generations
    if (gen %% interval_oct == 0) {
      oct_i <- oct_i + 1
      abundance_list[[oct_i]] <- octaves(species_abundance(community))
    }
  }
  
  # total time actually used
  total_time <- as.numeric((proc.time() - start_time)[["elapsed"]])
  
  # Save outputs + all input parameters except output_file_name
  save(time_series,
       abundance_list,
       community,
       total_time,
       speciation_rate,
       size,
       wall_time,
       interval_rich,
       interval_oct,
       burn_in_generations,
       file = output_file_name)
  
  invisible(NULL)
}


# Questions 24 and 25 involve writing code elsewhere to run your simulations on
# the cluster

# Question 26 
process_neutral_cluster_results <- function() {
  
  combined_results <- list() #create your list output here to return
  
  files <- list.files("../Data", 
                      pattern="^neutral_size_\\d+_iter_\\d+\\.rda$", 
                      full.names=TRUE)
  
  if(length(files) == 0){
    stop("No neutral cluster output files found in current directory.")
  }
  
  sizes <- c(500, 1000, 2500, 5000)
  
  for(s in sizes){
    
    size_files <- files[grepl(paste0("neutral_size_", s, "_"), files)]
    
    total_octave <- integer(0)
    n_records <- 0
    
    for(f in size_files){
      
      load(f)  # loads abundance_list, burn_in_generations, interval_oct
      
      generations <- interval_oct * seq_along(abundance_list)
      keep <- generations > burn_in_generations
      
      post_burn_octaves <- abundance_list[keep]
      
      for(v in post_burn_octaves){
        total_octave <- sum_vect(total_octave, v)
        n_records <- n_records + 1
      }
    }
    
    combined_results[[paste0("size_", s)]] <- total_octave / n_records
  }
  
  # save results to an .rda file
  save(combined_results, file="../Results/processed_neutral_cluster_results.rda")
  
  return(combined_results)
}

plot_neutral_cluster_results <- function(){
  
  # load combined_results from your rda file
  load("../Results/processed_neutral_cluster_results.rda")
  
  png(filename="../Results/plot_neutral_cluster_results.png", width = 800, height = 600)
  
  par(mfrow=c(2,2), mar=c(5,4,4,1)+0.1)
  
  sizes <- c(500, 1000, 2500, 5000)
  
  for(s in sizes){
    
    v <- combined_results[[paste0("size_", s)]]
    
    barplot(v,
            xlab="Octave class",
            ylab="Mean number of species",
            main=paste("Community size =", s),
            col="steelblue")
  }
  
  Sys.sleep(0.1)
  dev.off()
  
  return(combined_results)
}


# Challenge questions - these are substantially harder and worth fewer marks.
# I suggest you only attempt these if you've done all the main questions. 

# Challenge question A
Challenge_A <- function(){
  
  # Load ggplot2
  if (!requireNamespace("ggplot2", quietly = TRUE)) {
    stop("Package 'ggplot2' is required. Please install it: install.packages('ggplot2')")
  }
  
  # Find all cluster output files
  files <- list.files("../Data/Data",
                      pattern = "^demographic_.*_iter_\\d+\\.rda$",
                      full.names = TRUE)
  if(length(files) == 0){
    stop("No demographic .rda files found in ../Data/Data/")
  }
  
  # Extract initial-condition label from filename
  get_label <- function(f){
    sub("^demographic_(.*)_iter_\\d+\\.rda$", "\\1", basename(f))
  }
  
  # Map to required initial_condition names
  label_to_condition <- function(lbl){
    if(lbl == "10_adults")   return("small adult")
    if(lbl == "100_adults")  return("large adult")
    if(lbl == "10_spread")   return("small mixed")
    if(lbl == "100_spread")  return("large mixed")
    return(lbl)
  }
  
  # Build the long-form data frame
  sim_id <- 0L
  df_list <- vector("list", length(files))
  
  for(fi in seq_along(files)){
    
    f <- files[fi]
    lbl <- get_label(f)
    ic  <- label_to_condition(lbl)
    
    e <- new.env(parent = emptyenv())
    load(f, envir = e)
    
    # Compatible with both 'results' and 'results_list'
    if(exists("results", envir = e)){
      res_list <- get("results", envir = e)
    } else if(exists("results_list", envir = e)){
      res_list <- get("results_list", envir = e)
    } else {
      stop("No results object found in file: ", f)
    }
    
    ts_mat <- do.call(rbind, lapply(res_list, function(x) as.numeric(x)))
    n_sims <- nrow(ts_mat)
    n_t <- ncol(ts_mat)
    time_steps <- 0:(n_t - 1)
    
    sim_ids <- (sim_id + 1L):(sim_id + n_sims)
    sim_id <- sim_id + n_sims
    
    df_list[[fi]] <- data.frame(
      simulation_number = rep(sim_ids, each = n_t),
      initial_condition = rep(ic, times = n_sims * n_t),
      time_step = rep(time_steps, times = n_sims),
      population_size = as.vector(t(ts_mat)),
      stringsAsFactors = FALSE
    )
  }
  
  population_size_df <- do.call(rbind, df_list)
  
  # For the plot instruction: colour=initial_state
  population_size_df$initial_state <- population_size_df$initial_condition
  
  # Save to global environment
  assign("population_size_df", population_size_df, envir = .GlobalEnv)
  
  # Save plot (use ggplot2 but write to a png device as in the template)
  png(filename="../Results/Challenge_A.png", width = 600, height = 400)
  
  p <- ggplot2::ggplot(population_size_df,
                       ggplot2::aes(x = time_step,
                                    y = population_size,
                                    group = simulation_number,
                                    colour = initial_state)) +
    ggplot2::geom_line(alpha = 0.1) +
    ggplot2::labs(title = "All stochastic population size time series",
                  x = "Time step",
                  y = "Population size",
                  colour = "Initial condition") +
    ggplot2::theme_bw()
  
  print(p)
  
  Sys.sleep(0.1)
  dev.off()
  
}

# Challenge question B
Challenge_B <- function() {
  
  # Parameters
  speciation_rate <- 0.1
  size <- 100
  burn_in <- 200
  extra_gens <- 2000
  duration <- burn_in + extra_gens
  
  # Number of replicate simulations per initial condition (adjust if needed)
  n_reps <- 50
  
  # 97.2% two-sided CI => alpha = 0.028, so z = qnorm(1 - 0.014)
  z <- qnorm(1 - 0.014)
  
  # Helper: run one replicate and return richness time series (length = duration + 1)
  run_one <- function(init_comm) {
    comm <- init_comm
    ts <- numeric(duration + 1)
    ts[1] <- species_richness(comm)
    
    for (g in seq_len(duration)) {
      comm <- neutral_generation_speciation(comm, speciation_rate)
      ts[g + 1] <- species_richness(comm)
    }
    ts
  }
  
  # Run replicates for max and min initial conditions
  # Store as matrices: rows = replicates, cols = time points
  set.seed(1)
  mat_max <- matrix(NA_real_, nrow = n_reps, ncol = duration + 1)
  mat_min <- matrix(NA_real_, nrow = n_reps, ncol = duration + 1)
  
  for (r in seq_len(n_reps)) {
    mat_max[r, ] <- run_one(init_community_max(size))
    mat_min[r, ] <- run_one(init_community_min(size))
  }
  
  # Mean and CI at each time step
  mean_max <- colMeans(mat_max)
  mean_min <- colMeans(mat_min)
  
  se_max <- apply(mat_max, 2, sd) / sqrt(n_reps)
  se_min <- apply(mat_min, 2, sd) / sqrt(n_reps)
  
  lower_max <- mean_max - z * se_max
  upper_max <- mean_max + z * se_max
  lower_min <- mean_min - z * se_min
  upper_min <- mean_min + z * se_min
  
  # Estimate equilibrium time:
  # first time point where mean is within ±5% of final mean and stays there for 100 generations
  estimate_equilibrium <- function(mean_ts, window = 100, tol = 0.05) {
    final_mean <- mean(mean_ts[(length(mean_ts) - window + 1):length(mean_ts)])
    low <- final_mean * (1 - tol)
    high <- final_mean * (1 + tol)
    
    for (t in seq_len(length(mean_ts) - window)) {
      segment <- mean_ts[t:(t + window - 1)]
      if (all(segment >= low & segment <= high)) {
        return(t - 1)  # convert index to generation (starts at 0)
      }
    }
    NA_integer_
  }
  
  eq_max <- estimate_equilibrium(mean_max)
  eq_min <- estimate_equilibrium(mean_min)
  eq_est <- suppressWarnings(max(eq_max, eq_min, na.rm = TRUE))
  if (!is.finite(eq_est)) eq_est <- NA_integer_
  
  # Plot
  png(filename="../Results/Challenge_B.png", width = 600, height = 400)
  
  time <- 0:duration
  ylim <- range(c(lower_max, upper_max, lower_min, upper_min), na.rm = TRUE)
  
  plot(time, mean_max, type = "l",
       xlab = "Generation",
       ylab = "Mean species richness",
       main = "Challenge B: Mean richness with 97.2% CI",
       ylim = ylim, col = 1)
  
  # CI as dashed lines
  lines(time, lower_max, col = 1, lty = 2)
  lines(time, upper_max, col = 1, lty = 2)
  
  lines(time, mean_min, col = 2)
  lines(time, lower_min, col = 2, lty = 2)
  lines(time, upper_min, col = 2, lty = 2)
  
  legend("topright",
         legend = c("init_community_max (mean)", "init_community_max (97.2% CI)",
                    "init_community_min (mean)", "init_community_min (97.2% CI)"),
         col = c(1, 1, 2, 2),
         lty = c(1, 2, 1, 2),
         bty = "n")
  
  Sys.sleep(0.1)
  dev.off()
  
  return(
    paste(
      "Using the mean richness time series and a stability criterion (within ±5% of the final mean for 100 generations),",
      "the system reaches dynamic equilibrium after approximately",
      eq_est, "generations."
    )
  )
}

# Challenge question C
Challenge_C <- function() {
  
  # Parameters
  speciation_rate <- 0.1
  size <- 100
  burn_in <- 200
  extra_gens <- 2000
  duration <- burn_in + extra_gens
  
  # Range of initial richness values to explore
  # (You can change step size if you want more/less lines)
  richness_values <- seq(1, 100, by = 10)
  
  # Replicates per richness value (adjust if needed)
  n_reps <- 20
  
  # Helper: random initial community where each individual is equally likely
  # to take any species identity from 1..R
  init_random_richness <- function(size, R) {
    sample.int(R, size = size, replace = TRUE)
  }
  
  # Helper: run one replicate and return richness time series
  run_one <- function(init_comm) {
    comm <- init_comm
    ts <- numeric(duration + 1)
    ts[1] <- species_richness(comm)
    for (g in seq_len(duration)) {
      comm <- neutral_generation_speciation(comm, speciation_rate)
      ts[g + 1] <- species_richness(comm)
    }
    ts
  }
  
  # For each initial richness, compute an averaged time series across replicates
  mean_series_list <- vector("list", length(richness_values))
  names(mean_series_list) <- paste0("R=", richness_values)
  
  set.seed(2)
  for (i in seq_along(richness_values)) {
    R0 <- richness_values[i]
    mat <- matrix(NA_real_, nrow = n_reps, ncol = duration + 1)
    
    for (r in seq_len(n_reps)) {
      init_comm <- init_random_richness(size, R0)
      mat[r, ] <- run_one(init_comm)
    }
    
    mean_series_list[[i]] <- colMeans(mat)
  }
  
  # Plot all averaged series on one graph
  png(filename="../Results/Challenge_C.png", width = 600, height = 400)
  
  time <- 0:duration
  all_vals <- unlist(mean_series_list, use.names = FALSE)
  
  plot(time, mean_series_list[[1]], type = "l",
       xlab = "Generation",
       ylab = "Mean species richness",
       main = "Challenge C: Mean richness for many initial richness values",
       ylim = range(all_vals, na.rm = TRUE),
       col = 1)
  
  if (length(mean_series_list) > 1) {
    for (i in 2:length(mean_series_list)) {
      lines(time, mean_series_list[[i]], col = 1)
    }
  }
  
  # Add a legend (may be crowded; optional)
  legend("topright",
         legend = names(mean_series_list),
         bty = "n",
         cex = 0.6)
  
  Sys.sleep(0.1)
  dev.off()
  
}

# Challenge question D
Challenge_D <- function() {
  
  # find all neutral cluster output files
  files <- list.files("../Data", pattern = "^neutral_size_.*_iter_\\d+\\.rda$", full.names = TRUE)
  if (length(files) == 0) stop("No neutral cluster .rda files found in ../Data")
  
  get_size <- function(f) {
    as.numeric(sub(".*neutral_size_([0-9]+)_iter_.*", "\\1", basename(f)))
  }
  
  sizes <- sort(unique(vapply(files, get_size, numeric(1))))
  sizes <- sizes[!is.na(sizes)]
  
  # store mean richness time series per size
  mean_ts_list <- list()
  burn_list <- list()
  stabilise_list <- list()
  
  for (s in sizes) {
    fset <- files[vapply(files, get_size, numeric(1)) == s]
    # load all time_series vectors for this size and average them
    ts_mat <- NULL
    
    for (f in fset) {
      e <- new.env(parent = emptyenv())
      load(f, envir = e)
      if (!exists("time_series", envir = e)) stop("time_series not found in: ", f)
      ts <- get("time_series", envir = e)
      ts <- as.numeric(ts)
      
      if (is.null(ts_mat)) {
        ts_mat <- matrix(ts, nrow = 1)
      } else {
        # pad to same length if needed
        maxlen <- max(ncol(ts_mat), length(ts))
        if (ncol(ts_mat) < maxlen) ts_mat <- cbind(ts_mat, rep(NA, nrow(ts_mat)))
        if (length(ts) < maxlen) ts <- c(ts, rep(NA, maxlen - length(ts)))
        ts_mat <- rbind(ts_mat, ts)
      }
      
      if (exists("burn_in_generations", envir = e)) {
        burn_list[[as.character(s)]] <- get("burn_in_generations", envir = e)
      } else {
        burn_list[[as.character(s)]] <- NA
      }
    }
    
    ts_mean <- colMeans(ts_mat, na.rm = TRUE)
    mean_ts_list[[as.character(s)]] <- ts_mean
    
    # estimate approximate stabilisation generation
    # Use a moving-window difference of local means.
    win <- max(10, floor(0.02 * length(ts_mean)))
    stab_idx <- NA_integer_
    if (length(ts_mean) > 2 * win) {
      mov <- rep(NA_real_, length(ts_mean))
      for (i in (win + 1):(length(ts_mean) - win)) {
        mov[i] <- mean(ts_mean[(i + 1):(i + win)], na.rm = TRUE) -
          mean(ts_mean[(i - win):(i - 1)], na.rm = TRUE)
      }
      thr <- 0.001 * max(ts_mean, na.rm = TRUE)
      idx <- which(abs(mov) < thr)
      if (length(idx) > 0) stab_idx <- idx[1]
    }
    stabilise_list[[as.character(s)]] <- stab_idx
  }
  
  png(filename = "../Results/Challenge_D.png", width = 800, height = 600)
  
  if (length(sizes) <= 4) {
    par(mfrow = c(2, 2), mar = c(4, 4, 3, 1) + 0.1)
  } else {
    par(mfrow = c(ceiling(length(sizes)/2), 2), mar = c(4, 4, 3, 1) + 0.1)
  }
  
  for (s in sizes) {
    ts_mean <- mean_ts_list[[as.character(s)]]
    gens <- seq_along(ts_mean)
    burn_g <- burn_list[[as.character(s)]]
    stab_g <- stabilise_list[[as.character(s)]]
    
    plot(gens, ts_mean, type = "l", col = "blue",
         xlab = "Generation (burn-in)",
         ylab = "Mean species richness",
         main = paste0("Mean richness during burn-in (size=", s, ")"))
    
    # show burn-in used on cluster
    if (!is.na(burn_g)) {
      abline(v = burn_g, lty = 2, col = "grey40")
    }
    
    # show approximate stabilisation
    if (!is.na(stab_g)) {
      abline(v = stab_g, lty = 2, col = "red")
      mtext(paste0("approx stabilise ~ gen ", stab_g), side = 3, line = -1, cex = 0.8)
    }
    
    legend("topleft", bty = "n",
           lty = c(1, 2, 2),
           col = c("blue", "grey40", "red"),
           legend = c("mean richness", "burn-in used (8*size)", "approx stabilise"))
  }
  
  Sys.sleep(0.1)
  dev.off()
  
  invisible(NULL)
}

# Challenge question E
Challenge_E <- function() {
  
  # coalescence simulator
  coalescence_abundances <- function(J, speciation_rate) {
    lineages <- rep(1, J)
    abundances <- numeric(0)
    N <- J
    
    # theta = v / (1-v)
    theta <- speciation_rate / (1 - speciation_rate)
    
    while (N > 1) {
      j <- sample.int(N, 1)
      randnum <- runif(1)
      
      if (randnum < (theta / (theta + N - 1))) {
        abundances <- c(abundances, lineages[j])
      } else {
        i <- sample(setdiff(seq_len(N), j), 1)
        lineages[i] <- lineages[i] + lineages[j]
      }
      
      lineages <- lineages[-j]
      N <- N - 1
    }
    
    abundances <- c(abundances, lineages[1])
    abundances
  }
  
  # load cluster results and build mean octave per size 
  files <- list.files("../Data", pattern = "^neutral_size_.*_iter_\\d+\\.rda$", full.names = TRUE)
  if (length(files) == 0) stop("No neutral cluster .rda files found in ../Data")
  
  get_size <- function(f) as.numeric(sub(".*neutral_size_([0-9]+)_iter_.*", "\\1", basename(f)))
  sizes <- sort(unique(vapply(files, get_size, numeric(1))))
  sizes <- sizes[!is.na(sizes)]
  
  # use speciation_rate from first file
  e0 <- new.env(parent=emptyenv())
  load(files[1], envir = e0)
  if (!exists("speciation_rate", envir = e0)) stop("speciation_rate not found in neutral .rda file.")
  v <- get("speciation_rate", envir = e0)
  
  cluster_mean_oct <- list()
  cluster_n_samples <- setNames(rep(0, length(sizes)), as.character(sizes))
  cluster_cpu_seconds <- 0
  
  for (s in sizes) {
    fset <- files[vapply(files, get_size, numeric(1)) == s]
    
    total <- integer(0)
    nrec <- 0
    
    for (f in fset) {
      e <- new.env(parent=emptyenv())
      load(f, envir = e)
      if (!exists("abundance_list", envir = e)) stop("abundance_list not found in: ", f)
      
      # count CPU time
      if (exists("total_time", envir = e)) cluster_cpu_seconds <- cluster_cpu_seconds + as.numeric(get("total_time", envir = e))
      
      alist <- get("abundance_list", envir = e)
      n_here <- length(alist)
      nrec <- nrec + n_here
      
      for (k in seq_len(n_here)) {
        total <- sum_vect(total, alist[[k]])
      }
    }
    
    cluster_n_samples[as.character(s)] <- nrec
    cluster_mean_oct[[as.character(s)]] <- total / nrec
  }
  
  # run coalescence and compute mean octave per size
  # We time n_test samples, then estimate CPU time for the full number of samples used by cluster.
  coal_mean_oct <- list()
  coal_per_sample_seconds <- setNames(rep(NA_real_, length(sizes)), as.character(sizes))
  
  for (s in sizes) {
    n_target <- cluster_n_samples[as.character(s)]
    n_test <- 1000
    
    t0 <- proc.time()[["elapsed"]]
    total <- integer(0)
    
    for (rep_i in 1:n_test) {
      abund <- coalescence_abundances(J = s, speciation_rate = v)
      total <- sum_vect(total, octaves(abund))
    }
    
    t1 <- proc.time()[["elapsed"]]
    elapsed <- max(1e-6, (t1 - t0))
    
    coal_per_sample_seconds[as.character(s)] <- elapsed / n_test
    coal_mean_oct[[as.character(s)]] <- total / n_test
  }
  
  # estimate total coalescence CPU seconds for "equivalent" number of samples as cluster
  coal_cpu_seconds_est <- 0
  for (s in sizes) {
    n_target <- cluster_n_samples[as.character(s)]
    per_samp <- coal_per_sample_seconds[as.character(s)]
    coal_cpu_seconds_est <- coal_cpu_seconds_est + per_samp * n_target
  }
  
  png(filename = "../Results/Challenge_E.png", width = 800, height = 600)
  par(mfrow = c(2, 2), mar = c(5, 4, 3, 1) + 0.1)
  
  for (s in sizes) {
    cl <- cluster_mean_oct[[as.character(s)]]
    co <- coal_mean_oct[[as.character(s)]]
    maxlen <- max(length(cl), length(co))
    if (length(cl) < maxlen) cl <- c(cl, rep(0, maxlen - length(cl)))
    if (length(co) < maxlen) co <- c(co, rep(0, maxlen - length(co)))
    
    mat <- rbind(cluster = cl, coalescence = co)
    
    barplot(mat, beside = TRUE,
            col = c("steelblue4", "tomato"), border = "grey10",
            main = paste0("Size = ", s, " (v=", signif(v, 3), ")"),
            xlab = "Octave class",
            ylab = "Mean number of species")
    legend("topright", bty = "n", fill = c("grey30", "grey80"),
           legend = c("cluster", "coalescence"))
  }
  
  Sys.sleep(0.1)
  dev.off()
  
  # return CPU-hours comparison text
  cluster_cpu_hours <- cluster_cpu_seconds / 3600
  coal_cpu_hours_est <- coal_cpu_seconds_est / 3600
  
  return(paste(
    "Estimated CPU hours: coalescence ~ ", round(coal_cpu_hours_est, 2),
    " CPU hours; cluster ~ ", round(cluster_cpu_hours, 2),
    " CPU hours. ",
    "The coalescence simulations reproduce the same general species abundance distribution pattern as the forward-time cluster simulations, ",
    "although some quantitative differences remain due to sampling variability. ",
    "Coalescence is much faster because it traces lineage mergers backward in time and directly samples the stationary abundance distribution, ",
    "rather than simulating every birth–death event and long burn-in period as required in the forward-time cluster simulations."
  ))
}

