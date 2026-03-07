# install.packages("devtools")
devtools::install_github("MITEcology/feasibility_analysis")

library(feasibilityR)

#First we can generate some random matrices
matA <- generate_inte_rand(4, 1, 1, "norm", 0) ## Generate a random matrix of nA=4 species following a normal distribution with mean=1 and sd=1
matB <- generate_inte_gs(4, 1, 1, "norm", 0) ## Generate a globally stable random matrix of nB=4 species following a normal distribution with mean=1 and sd=1
matC <- generate_inte_rand(4, 1, 1, "half-norm", 0)  ## Generate a random matrix of nC=4 species following a half-normal distribution with mean=1 and sd=1. This is equivalent to a purely competition community.
nA <- nrow(matA) ## total number of species in community A
nB <- nrow(matA) ## total number of species in community B
nC <- nrow(matA) ## total number of species in community C

#Now we are ready to calculate feasibilty at the community level
feasibility_community(matA) ## This is the feasibility of the community A with nA=4 species. This measure cannot be conmpared across communities with different number of species.
feasibility_community(matA,raw=FALSE) ## This is the species-specific feasibility of the community A with nA=4 species. This measure can be compared across communities with different number of species.
feasibility_community(matA) * (2) ## This is the probabilty of feasibility of the community A with nA=4 species.
feasibility_community(matC) * (2^nC) ## This is the probabilty of feasibility of the community C (purely compettition) with nC=4 species.

#We can calculate other properties of the feasibilty at the community level taking as a reference point the center or any other location inside the feasibility domain.
## The center of the feasibility domain is the location where all species have the same biomass (density). However, the r vector does not need to be the same for all species.
cA <- matA %*% rep(1, nA) ## This is the center of the feasibility domain: r = A N*, where N* is 1 (or any constant) for all species.
rA <- matA %*% c(runif(4, 0, 1)) ## This is a random direction of the r-vector.
feasibility_asymmetry(matA) ## This estimates the irregularity of the feasiblity domain of the community A with 4 species. The larger the outcome, the larger the assymetry
feasibility_resistance_full(matA, rA) ## This is a distance from a a given r-vector to all possible borders of the feasibility domain. The larger the outcome, the larger the resistance
feasibility_resistance_partial(matA, rA) ## This is a distance from a a given r-vector to all possible vertices of the feasibility domain. The larger the outcome, the larger the resistance
feasibility_recovery(matA, rA, type = "full") ## This is the largest eigenvalue of the interaction matrix A (notice is negative)
feasibility_recovery(matA, rA, type = "part") ## This is the second smallest eigenvalue of the interaction matrix A (notice is negative)

#We can now calculate the overlap between two communities with the same number of species
feasibility_overlap(matA, matB) ## Matrices need to have the same dimension

#We can now calculate the different feasibility regions within a pool of n species
feasibility_partition(matB) ## The feasibility of all the 2^nB possible combinations.
feasibility_species(matB, sp = 2) ## The sum of feasibility regions whith species i=2.
feasibility_contribution(matB, sp = 2) ## This estimates the contribution of species i=2 to the feasiblity of the entire community nB=4. Otcomes above (resp. below) 1 mean a positive (resp. negative) contribution
feasibility_invasion(matB, inv = 1) ## This estimates the proabability that species i=2 can invade the community nB-1.
