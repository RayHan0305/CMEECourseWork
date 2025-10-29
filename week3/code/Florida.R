# Uses a permutation test on Key West annual mean temperature data.

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

# Permutation test
r_perm <- numeric(nperm)
for (i in 1:nperm) {
  # Randomly shuffle temperatures and recalc correlation
  r_perm[i] <- cor(ats$Year, sample(ats$Temp))
}

# Calculate empirical p-value
p_val <- mean(r_perm >= r_obs)

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

# Create short LaTeX report 
tex <- sprintf('
\\documentclass[a4paper,11pt]{article}
\\usepackage[margin=1.5cm]{geometry}
\\usepackage{graphicx}
\\usepackage{amsmath}
\\usepackage{booktabs}
\\usepackage{setspace}
\\usepackage{microtype}
\\pagenumbering{gobble}
\\begin{document}

\\begin{center}
\\Large\\textbf{Is Florida Getting Warmer?}\\\\[4pt]
\\normalsize Permutation Test on Key West Annual Mean Temperature (20th Century)
\\end{center}

\\vspace{0.5cm}

\\section*{1. Methods}
Annual mean temperatures recorded at Key West, Florida, were correlated with year. 
Let $r_{\\text{obs}}$ be the observed Pearson correlation coefficient:
\\[
r_{\\text{obs}} = %.4f
\\]
To test whether this correlation is greater than expected by chance, 
temperatures were randomly shuffled among years $N = %d$ times, and the correlation recalculated each time:
\\[
r_i = \\text{cor}(\\text{Year}, \\text{sample(Temp)})
\\]
The empirical p-value is computed as the fraction of permuted correlations greater than or equal to the observed one:
\\[
p = \\frac{\\sum (r_i \\ge r_{\\text{obs}})}{N} = %.4f
\\]

\\section*{2. Results}
The histogram below shows the distribution of correlation coefficients from the permutation test. 
The vertical red line marks the observed correlation $r_{\\text{obs}}$.

\\begin{center}
\\includegraphics[width=0.9\\textwidth]{Florida_histogram.pdf}
\\end{center}

\\vspace{0.3cm}
\\noindent
\\textbf{Observed correlation:} $r = %.4f$\\\\
\\textbf{Empirical p-value:} $p = %.4f$\\\\
\\textbf{Number of permutations:} $N = %d$

\\vfill
\\noindent\\textit{Generated automatically by Florida.R (R version %s).}
\\end{document}
', r_obs, nperm, p_val, r_obs, p_val, nperm, getRversion())

writeLines(tex, "../results/Florida_Report.tex")
cat("Saved: Florida_Report.tex\n")

# Compile report
if (nzchar(Sys.which("pdflatex"))) {
  system("pdflatex -interaction=nonstopmode -output-directory=../results ../results/Florida_Report.tex > /dev/null")
  cat("Compiled: Florida_Report.pdf\n")
} 

