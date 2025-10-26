rm(list=ls())
set.seed(42)
load("../data/KeyWestAnnualMeanTemperature.RData")

ls()

class(ats)

head(ats)

plot(ats)

# Compute observed correlation
cor(ats$Year, ats$Temp)
r <- cor(ats$Year, ats$Temp)

# Repeat the calculation
n <- 10000
# Preallocate vector
r_pre <- numeric(n)
for (i in 1:n) {
  shuffled_temp <- sample(ats$Temp, replace = FALSE)
  r_pre[i] <- cor(ats$Year, shuffled_temp)
}

# Compute p-value
p <- sum(r_pre >= r) / n

# Visualize
hist(r_pre, breaks = 40, main = "Permutation Test for Key West Temperature Trend",
     xlab = "Correlation Coefficient", col = "lightblue", border = "white")
abline(v = r, col = "red", lwd = 2)
legend("topright", legend = sprintf("Observed r = %.3f", r), col = "red", lwd = 2)

