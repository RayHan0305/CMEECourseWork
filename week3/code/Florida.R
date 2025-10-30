# Uses a permutation test on Key West annual mean temperature data.
# Run this command to generate the latex result: pdflatex -output-directory=../results ../results/Florida_Report.tex

rm(list = ls())
  
load("../data/KeyWestAnnualMeanTemperature.RData")  

ls()

class(ats)

head(ats)  # preview first few rows

plot(ats)

# Calculate observed correlation
set.seed(1234)
nperm <- 10000  

r_obs <- cor(ats$Year, ats$Temp)
r_obs
# Permutation test
r_perm <- numeric(nperm)
for (i in 1:nperm) {
  # Randomly shuffle temperatures and recalc correlation
  r_perm[i] <- cor(ats$Year, sample(ats$Temp))
}

# Calculate empirical p-value
p_val <- mean(r_perm >= r_obs)
p_val

# Plot histogram
pdf("../results/Florida_histogram.pdf", width = 7, height = 5)
hist(r_perm,
     breaks = 30,
     main = "Is Florida Getting Warmer?\nPermutation Test",
     xlab = "Correlation Coefficient",
     col = "skyblue",
     border = "white")
abline(v = r_obs, col = "red", lwd = 3)
text(r_obs, 50, labels = sprintf("Observed r = %.3f", r_obs),
     pos = 4, col = "red")
dev.off()
