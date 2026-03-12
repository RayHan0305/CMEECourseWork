# MiniProject

## Title
Logistic models more often outperform Gompertz models for empirical microbial growth curves

## Project overview
This mini project compares two non-linear population growth models, the logistic model and the Gompertz model, using the course-provided empirical Population Growth dataset. The workflow begins with raw data cleaning, then fits both models to individual microbial growth curves, compares model performance using model-selection criteria, generates summary figures and tables, and ends with a written report in LaTeX.

## Project structure
```text
MiniProject/
├── code/
│   ├── data_prep.py
│   ├── fit_models.py
│   ├── analysis_and_plots.py
│   └── compile_report.py
├── data/
│   ├── logistic_growth_data.csv
│   ├── logistic_growth_meta_data.csv
│   └── cleaned_growth_data.csv
├── results/
│   ├── fitted_params.csv
│   ├── model_metrics.csv
│   ├── best_model_by_curve.csv
│   └── summary_tables.csv
├── figures/
│   ├── exploratory/
│   ├── fitted_curves/
│   └── summary/
├── report/
│   ├── MiniProject.tex
│   ├── references.bib
│   └── MiniProject.pdf
├── .gitignore
├── README.md
└── run_MiniProject.py
```

## Author
Ruixuan Han  
Imperial College London  
rh925@ic.ac.uk