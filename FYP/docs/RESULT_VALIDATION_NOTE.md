# Result validation note

The genotype-level FST scan itself was not rerun while building this GitHub package.

Instead, the package uses the completed archived six-pair FST scan generated during the project and reruns the downstream statistics, QC summaries and figures from that derived CSV.

The final thesis reports 83 robust secondary outlier observations, 27 unique 1-Mb windows and 22 broader secondary regions. The 22-region count uses the original v3.6 rule: robust windows are grouped separately by chromosome and site class, with windows separated by no more than 50 kb merged into the same secondary region.

This distinction is recorded here so the repository does not falsely claim that raw MalariaGEN genotype data were rerun during package assembly.
