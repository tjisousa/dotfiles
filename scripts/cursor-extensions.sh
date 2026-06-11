#!/usr/bin/env bash
set -euo pipefail

if ! command -v cursor >/dev/null 2>&1; then
  echo "Cursor CLI is missing. Install Cursor from Brewfile first." >&2
  exit 1
fi

extensions=(
  bradlc.vscode-tailwindcss
  james-yu.latex-workshop
  lucien-martijn.parquet-visualizer
  oxc.oxc-vscode
  pierrecomputer.pierre-theme
  repreng.csv
  rust-lang.rust-analyzer
  webpro.vscode-knip
  yoavbls.pretty-ts-errors
)

for extension in "${extensions[@]}"; do
  cursor --install-extension "$extension"
done

