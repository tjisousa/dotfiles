#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

if [[ "$(uname -s)" != "Darwin" ]]; then
  echo "This dotfiles repo is macOS-only." >&2
  exit 1
fi

SUDO_KEEPALIVE_PID=""

cleanup_sudo_keepalive() {
  if [[ -n "$SUDO_KEEPALIVE_PID" ]]; then
    kill "$SUDO_KEEPALIVE_PID" >/dev/null 2>&1 || true
  fi
}

interrupt_bootstrap() {
  cleanup_sudo_keepalive
  exit 130
}

terminate_bootstrap() {
  cleanup_sudo_keepalive
  exit 143
}

trap cleanup_sudo_keepalive EXIT
trap interrupt_bootstrap INT
trap terminate_bootstrap TERM

echo "Requesting administrator access once for bootstrap setup..."
if ! sudo -v; then
  echo "Could not validate administrator access. Bootstrap cannot continue." >&2
  exit 1
fi

while true; do
  sudo -n -v >/dev/null 2>&1 || exit
  sleep 60
done &
SUDO_KEEPALIVE_PID="$!"

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
