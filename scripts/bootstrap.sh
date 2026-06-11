#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

if [[ "$(uname -s)" != "Darwin" ]]; then
  echo "This dotfiles repo is macOS-only." >&2
  exit 1
fi

if ! command -v brew >/dev/null 2>&1; then
  echo "Homebrew is not installed. Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

eval "$(/opt/homebrew/bin/brew shellenv 2>/dev/null || /usr/local/bin/brew shellenv)"

brew bundle --file "$ROOT_DIR/Brewfile"
"$ROOT_DIR/scripts/link.sh"

cat <<'MSG'

Base setup complete.

Optional next steps:
  ./scripts/doctor.sh
  ./scripts/languages.sh
  ./scripts/cursor-config.sh
  ./scripts/app-store-apps.sh --dry-run
  ./scripts/macos-defaults.sh
  ./scripts/raycast-defaults.sh

MSG
