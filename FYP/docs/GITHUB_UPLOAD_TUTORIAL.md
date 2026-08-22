# GitHub upload tutorial

## Before uploading

The package is already organised for GitHub. Do not upload raw MalariaGEN genotype data, credentials, Google authentication files, API tokens, SSH keys or other secrets.

The three main notebooks are in `code/`. Derived datasets are in `data/`. Generated results are in `results/`.

## Upload using the GitHub website

1. Sign in to GitHub.
2. Open your repository, or create a new public repository.
3. Choose **Add file → Upload files**.
4. Open the extracted `FYP_GitHub_Complete` folder on your computer.
5. Drag the contents of the folder into the GitHub upload page. Upload the folders themselves (`code`, `data`, `results`, `docs`) plus `README.md`, `.gitignore`, and `requirements.txt`.
6. Wait until all files finish uploading.
7. Use a commit message such as `Add final FYP analysis code and derived results`.
8. Click **Commit changes**.
9. Open the repository after the commit and check that the three notebooks render correctly.

Do not upload the ZIP itself as the only repository file. Extract the ZIP first and upload its contents so the code and results can be browsed directly on GitHub.

## Upload using git

From a terminal opened inside the extracted folder:

```bash
git init
git add .
git commit -m "Add final FYP analysis code and derived results"
git branch -M main
git remote add origin YOUR_GITHUB_REPOSITORY_URL
git push -u origin main
```

If the repository already exists locally, omit `git init` and use the existing remote.

## Recommended final check

Confirm that GitHub shows:

- `code/exploratory_supervisor_requests_fixed.ipynb`
- `code/final_fst_scan.ipynb`
- `code/final_thesis_analysis.ipynb`
- the completed FST CSV under `data/`
- generated CSV tables under `results/tables/`
- generated PNG figures under `results/figures/`
- `results/RESULTS_SUMMARY.md`

## Re-running in Colab

The final FST scan requires a Python version compatible with `malariagen_data` 15.x. Python 3.13 is not compatible with those releases.

The FST scan is checkpointed. If Colab runs out of memory, use a small value for `FST_JOBS_PER_RUN`, restart the runtime, and rerun the notebook. The existing checkpoint allows completed jobs to be skipped.

The final downstream analysis does not need raw genotype data if the completed FST CSV and site-count CSV are already available.

## Linking the repository in the thesis

A concise Data availability statement can say:

> The analysis code and derived datasets generated in this project are archived in a public GitHub repository: [repository link]. Genomic data were accessed from the MalariaGEN Ag3 resource and are not redistributed in this repository.
