a <- TRUE
if (a == TRUE){
    print ("a is TRUE")
} else {
    print ("a is FALSE")
}

z <- runif(1)
if (z <= 0.5) {
    print ("Less than a half")
}

# 1:10 generates a sequence (seq(10))
# i, j is a temporary variable that stores the value of the number in that iteration of the loop
for (i in 1:10) {
    j <- i * i
    print(paste(i, "squared is", j ))
}

# random assortment of birds
for(species in c('Heliodoxa rubinoides', 'Boissonneaua jardini', 'Sula nebouxii')) {
    print(paste('The species is', species))
}

# loop using apre-exising vector
v1 <- c("a", "bc", "def")
for (i in v1) {
    print(i)
}

i <- 0
while (i < 10) {
    i <- i + 1
    print(i^2)    
}