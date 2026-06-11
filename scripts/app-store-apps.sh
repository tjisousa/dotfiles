#!/usr/bin/env bash
set -euo pipefail

DRY_RUN=false

usage() {
  cat <<'EOF'
Usage: scripts/app-store-apps.sh [--dry-run]

Install personal App Store apps captured from the oracle machine.
This intentionally excludes work-managed Microsoft, MDM, and vendor apps.
EOF
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --dry-run)
      DRY_RUN=true
      shift
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      echo "Unknown option: $1" >&2
      usage >&2
      exit 2
      ;;
  esac
done

if ! command -v mas >/dev/null 2>&1; then
  echo "mas is missing. Run ./scripts/bootstrap.sh first." >&2
  exit 1
fi

apps=(
  "409183694 Keynote"
  "409201541 Pages"
  "409203825 Numbers"
  "408981434 iMovie"
  "497799835 Xcode"
  "682658836 GarageBand"
)

installed_ids="$(mas list | awk '{print $1}')"

for app in "${apps[@]}"; do
  app_id="${app%% *}"
  app_name="${app#* }"

  if grep -Fxq "$app_id" <<<"$installed_ids"; then
    echo "Already installed: $app_name"
    continue
  fi

  if [[ "$DRY_RUN" == true ]]; then
    echo "Would install: $app_name ($app_id)"
  else
    echo "Installing: $app_name ($app_id)"
    mas install "$app_id"
  fi
done

if [[ "$DRY_RUN" == true ]]; then
  echo "Dry run complete. No apps installed."
fi
