#!/usr/bin/env python3
# -*- coding: utf-8 -*-

from __future__ import annotations

import subprocess
import sys
from pathlib import Path

PROJECT_ROOT = Path(__file__).resolve().parent
CODE_DIR = PROJECT_ROOT / "code"

SCRIPTS = [
    CODE_DIR / "data_prep.py",
    CODE_DIR / "fit_models.py",
    CODE_DIR / "analysis_and_plots.py",
    CODE_DIR / "compile_report.py",
]

# texcount -inc -sum report/MiniProject.tex

def run_script(script_path: Path) -> None:
    print(f"\nRunning: {script_path.name}")
    subprocess.run([sys.executable, str(script_path)], check=True)


def main() -> None:
    for script in SCRIPTS:
        if not script.exists():
            raise FileNotFoundError(f"Missing script: {script}")
        run_script(script)

    print("\nMini project workflow finished successfully.")


if __name__ == "__main__":
    main()