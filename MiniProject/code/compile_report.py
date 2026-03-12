#!/usr/bin/env python3
# -*- coding: utf-8 -*-

from __future__ import annotations

import shutil
import subprocess
from pathlib import Path

PROJECT_ROOT = Path(__file__).resolve().parents[1]
REPORT_DIR = PROJECT_ROOT / "report"
TEX_FILE = REPORT_DIR / "MiniProject.tex"


def check_latex_tools() -> None:
    missing = []
    for tool in ["pdflatex", "bibtex"]:
        if shutil.which(tool) is None:
            missing.append(tool)

    if missing:
        raise FileNotFoundError(
            f"Missing LaTeX tool(s): {', '.join(missing)}. "
            "Please install MiKTeX or TeX Live and make sure these commands are on PATH."
        )


def main() -> None:
    if not TEX_FILE.exists():
        print("No MiniProject.tex found. Skipping LaTeX compilation.")
        return

    check_latex_tools()
    print("Compiling LaTeX report...")

    commands = [
        ["pdflatex", "-interaction=nonstopmode", "MiniProject.tex"],
        ["bibtex", "MiniProject"],
        ["pdflatex", "-interaction=nonstopmode", "MiniProject.tex"],
        ["pdflatex", "-interaction=nonstopmode", "MiniProject.tex"],
    ]

    for cmd in commands:
        print("Running:", " ".join(cmd))
        subprocess.run(cmd, cwd=REPORT_DIR, check=True)

    print("Report compilation complete.")
    print(f"PDF should be available at: {REPORT_DIR / 'MiniProject.pdf'}")


if __name__ == "__main__":
    main()