#!/usr/bin/env python3

import shutil
import subprocess
from pathlib import Path

# Paths

PROJECT_ROOT = Path(__file__).resolve().parents[1]
REPORT_DIR = PROJECT_ROOT / "report"
TEX_FILE = REPORT_DIR / "MiniProject.tex"
PDF_FILE = REPORT_DIR / "MiniProject.pdf"

def check_latex_tools() -> None:
    """
    Check that the required external LaTeX tools are available.

    The report workflow depends on:
    - pdflatex
    - bibtex
    - texcount
    """
    missing = [tool for tool in ["pdflatex", "bibtex", "texcount"] if shutil.which(tool) is None]
    if missing:
        raise FileNotFoundError(
            f"Missing LaTeX tool(s): {', '.join(missing)}. "
            "Please ensure MiKTeX/TeX Live is installed and available on PATH."
        )


def run_command(cmd: list[str], tolerate_pdf_output: bool = False) -> None:
    """
    Run one external command in the report directory.

    Some MiKTeX setups return a non-zero exit code even when a PDF is
    produced successfully, so this function can optionally tolerate that.
    """
    print("Running:", " ".join(cmd))
    result = subprocess.run(cmd, cwd=REPORT_DIR)

    if result.returncode == 0:
        return

    if tolerate_pdf_output and PDF_FILE.exists():
        print(
            f"Warning: command returned exit code {result.returncode}, "
            f"but {PDF_FILE.name} was generated. Continuing."
        )
        return

    raise subprocess.CalledProcessError(result.returncode, cmd)


# Main workflow

def main() -> None:
    """Compile the LaTeX report and bibliography."""
    if not TEX_FILE.exists():
        print("No MiniProject.tex found. Skipping LaTeX compilation.")
        return

    check_latex_tools()
    print("Compiling LaTeX report...")

    # First LaTeX pass creates auxiliary files and word count
    run_command(
        ["pdflatex", "--shell-escape", "-interaction=nonstopmode", "MiniProject.tex"],
        tolerate_pdf_output=True,
    )

    # BibTeX resolves references
    run_command(["bibtex", "MiniProject"])

    # Final LaTeX passes resolve citations and cross-references
    run_command(
        ["pdflatex", "--shell-escape", "-interaction=nonstopmode", "MiniProject.tex"],
        tolerate_pdf_output=True,
    )
    run_command(
        ["pdflatex", "--shell-escape", "-interaction=nonstopmode", "MiniProject.tex"],
        tolerate_pdf_output=True,
    )

    if not PDF_FILE.exists():
        raise FileNotFoundError("Compilation finished but MiniProject.pdf was not found.")

    print("Report compilation complete.")
    print(f"PDF available at: {PDF_FILE}")


if __name__ == "__main__":
    main()