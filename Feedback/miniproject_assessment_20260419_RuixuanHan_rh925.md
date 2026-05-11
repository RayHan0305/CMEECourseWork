# MiniProject Assessment for Ruixuan Han

## Computing

### A1 — Project Organisation

The project is laid out clearly, with `code/`, `data/`, `results/`, `report/`, and `figures/` all present alongside `run_MiniProject.py`, which makes the submission easy to inspect and follow. The inclusion of both `README.md` and `.gitignore` is helpful, but the README stops at a structural overview and does not document Python version, dependencies, or what packages are used for, which weakens reproducibility on a clean machine. A more important deduction here is that `results/` contains four committed outputs — `best_model_by_curve.csv`, `model_metrics.csv`, `fitted_params.csv`, and `summary_tables.csv` — and the repository also includes generated figures and the compiled PDF; future submissions would benefit from keeping generated outputs out of version control unless there is a clear justification.

### A2 — Single-Script Reproducibility

#### Workflow & Solution Quality

`run_MiniProject.py` runs `code/data_prep.py`, `code/fit_models.py`, and `code/analysis_and_plots.py` successfully, writes the cleaned dataset and result CSVs, and then stops in `code/compile_report.py` because `texcount` is unavailable. That run state matters: the core analytical pipeline completed end-to-end, including data preparation, fitting, comparison, and figure generation, so the main reproducibility weakness sits in report compilation rather than in the modelling workflow itself. The entry script is concise and correctly checks that each stage exists before execution, but it currently fails hard on one missing external tool and does not separate essential report compilation dependencies from optional word-count tooling. A strong next step would be to make `compile_report.py` degrade gracefully when `texcount` is absent, document the required LaTeX tools explicitly in the README, and ask whether every non-core dependency is truly necessary for this submission so that unnecessary external requirements can be removed to improve reproducibility.

### A3 — Code Quality & Style

#### Script-level Technical Feedback

The codebase is well modularised for a MiniProject submission: `code/fit_models.py` separates `estimate_initial_params`, `fit_model`, and `fit_single_curve`, while `code/analysis_and_plots.py` breaks plotting and comparison into functions such as `compare_models`, `plot_representative_fits`, and `plot_summary_figures`. Across 820 lines of Python there are 29 function definitions, and the naming is consistently descriptive, which makes the workflow much easier to read than a single monolithic script. The main limitation is documentation density: 41 comment lines across the whole project gives a comment density of 0.05, so the code is readable but only lightly explained in places, especially in the longer files `code/analysis_and_plots.py` (339 lines) and `code/fit_models.py` (221 lines). A concrete improvement would be to add short docstrings or inline comments around the less obvious implementation choices, especially the starting-value heuristics and model-comparison steps in `estimate_initial_params` and `compare_models`.

### A4 — Model Fitting & Statistical Analysis

#### NLLS

The fitting strategy uses NLLS appropriately through `scipy.optimize.curve_fit`, with two explicit nonlinear candidate models, Logistic and Gompertz, fitted independently to each inferred curve. Starting values are not arbitrary: `estimate_initial_params` derives `K`, `N0`, `r`, and `t0` from observed minima, maxima, median time, and a log-slope estimate, and `fit_model` adds sensible parameter bounds plus `maxfev=20000`, which is good practice for this kind of nonlinear optimisation. Convergence is handled through `try`/`except`, failed fits are retained in the metrics output with a message, and model comparison is coherent through RSS, AIC, and BIC, matching the report’s summary that logistic won 176 curves and Gompertz 121. A concrete improvement would be to export or summarise failed-fit messages more prominently and report the starting-value rules and parameter bounds in a compact table so that the fitting decisions are easier to audit.

### A5 — Version Control & Workflow Discipline

The repository has 77 commits in total, but only 2 touch `MiniProject/`, and both are late-stage submission-style commits: `Add final MiniProject submission` and `Update MiniProject files and final report with some comments`. That pattern makes it hard to see iterative development of the analysis, even though the final project itself is substantial. Future work would benefit from smaller, more descriptive commits across data cleaning, fitting, plotting, and report drafting, so that the Git history reflects the actual progression of the project.

## Report

### B1 — Report Format & Presentation

The report meets most formal requirements well: it uses LaTeX `article` at 11pt, includes 1.5 spacing, continuous line numbers, a non-numeric bibliography style, and a compiled PDF is present. The body word count is comfortably within the 3500-word limit at 1829, although the abstract is somewhat long at about 256 words, and the report includes 7 display items, which is slightly above the target range of 4–6. The title-page information is present visually, but it is built manually rather than through `\title{}` and `\author{}`, which is not a major issue for presentation quality here. The main presentational refinement for future submissions would be to trim the figure set slightly and make each display item carry more of the narrative load.

### B2 — Introduction & Objectives

The introduction gives a clear biological lead-in to microbial population growth and explains why logistic and Gompertz models are worth comparing, so the reader understands the empirical question quickly. The three objectives are explicit and logically connected to the preceding discussion of sigmoidal growth forms, but the framing is more about microbial growth curves in general than about the required course-specific temperature-dependent metabolism and single-population growth grounding. The largest gap is the lack of visible engagement with the two relevant MQB chapter themes in the introduction, and the biological versus methodological objectives are not sharply separated. Future submissions would benefit from tying the question more directly to the course material on temperature dependence and population processes before narrowing to model comparison.

### B3 — Methods (including Computing Tools)

The Methods section is one of the stronger parts of the report. It describes the dataset provenance, curve-ID construction, cleaning rules, exclusion of short curves, explicit equations for both models, the NLLS fitting approach, and the use of AIC and BIC for comparison, all at an appropriate level of detail for reproduction. The `Computing tools` subsection is present and names `pandas`, `NumPy`, `SciPy`, `matplotlib`, bash, Git, and LaTeX, with brief justification for why Python was used as the single-language pipeline. The main improvement would be to state the fitting details even more explicitly in prose — especially parameter bounds, convergence handling, and how failed fits were recorded — so that the written methods mirror the code more completely.

### B4 — Results & Display Items

The Results section is clearly structured, moving from data overview to fitting performance and then to model comparison, which matches the project objectives well. There are 7 figures and all 7 have informative captions; the figures cover dataset structure, representative fits, overall model wins, AIC distributions, and temperature-specific model preference, so the reader can follow the analysis without needing to infer missing steps. One omission is a compact table for model comparison or fit success summaries, since the report relies entirely on figures despite discussing counts and success rates numerically in the text. A useful refinement would be to replace one figure with a concise comparison table showing fit success, win counts, and perhaps median AIC differences.

### B5 — Discussion, Conclusions & Abstract

The discussion returns to the main question effectively and interprets the logistic-versus-Gompertz result in biological terms, especially around monotonic asymptotic curves and the inability of either model to capture post-peak decline. Limitations are discussed concretely — mixed biomass units, uneven sampling across temperatures, restricted candidate model set, and one failed logistic fit — and the concluding message is clear. The main mark cap here comes from advanced methods: the discussion proposes broader candidate growth models such as Baranyi or Richards, but it does not engage with MLE, Bayesian inference, or machine learning, so it cannot reach the top band for this criterion under the rubric. The abstract is self-contained and informative, though slightly longer than ideal, and a stronger future discussion would explain what Bayesian hierarchical modelling or likelihood-based approaches could add biologically when curves vary across species, media, and temperature.

## Summary

Final classification (student-facing):

- Part A (Computing): Distinction
- Part B (Report): Distinction
- Overall: Distinction
