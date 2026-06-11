#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SOURCE_DIR="$ROOT_DIR/home"
BACKUP_DIR="$HOME/.dotfiles-backup/$(date +%Y%m%d%H%M%S)"
DRY_RUN=false
ONLY_PATTERNS=()
SKIP_PATTERNS=()

usage() {
  cat <<'EOF'
Usage: scripts/link.sh [options]

Options:
  --dry-run          Print planned changes without touching the filesystem.
  --only PATH        Link only paths matching this relative path or prefix.
  --skip PATH        Skip paths matching this relative path or prefix.
  -h, --help         Show this help message.

Examples:
  scripts/link.sh --dry-run
  scripts/link.sh --only .zshrc --only .config/starship.toml
  scripts/link.sh --skip "Library/Application Support"
EOF
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --dry-run)
      DRY_RUN=true
      shift
      ;;
    --only)
      [[ $# -ge 2 ]] || {
        echo "--only requires a path argument" >&2
        exit 2
      }
      ONLY_PATTERNS+=("$2")
      shift 2
      ;;
    --skip)
      [[ $# -ge 2 ]] || {
        echo "--skip requires a path argument" >&2
        exit 2
      }
      SKIP_PATTERNS+=("$2")
      shift 2
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

matches_path() {
  local relative="$1"
  local pattern="$2"

  [[ "$relative" == "$pattern" || "$relative" == "$pattern/"* ]]
}

matches_any() {
  local relative="$1"
  shift

  local pattern
  for pattern in "$@"; do
    if matches_path "$relative" "$pattern"; then
      return 0
    fi
  done

  return 1
}

link_file() {
  local source="$1"
  local relative="${source#"$SOURCE_DIR"/}"
  local target="$HOME/$relative"

  case "$relative" in
    .DS_Store|*/.DS_Store)
      echo "Skipping Finder metadata: $relative"
      return
      ;;
    *.template)
      echo "Skipping template: $relative"
      return
      ;;
  esac

  if [[ "${#ONLY_PATTERNS[@]}" -gt 0 ]] && ! matches_any "$relative" "${ONLY_PATTERNS[@]}"; then
    echo "Skipping outside --only filters: $relative"
    return
  fi

  if [[ "${#SKIP_PATTERNS[@]}" -gt 0 ]] && matches_any "$relative" "${SKIP_PATTERNS[@]}"; then
    echo "Skipping by --skip filter: $relative"
    return
  fi

  if [[ -L "$target" && "$(readlink "$target")" == "$source" ]]; then
    echo "Already linked: $relative"
    return
  fi

  if [[ "$DRY_RUN" == true ]]; then
    if [[ -e "$target" || -L "$target" ]]; then
      echo "Would back up and link: $relative"
    else
      echo "Would link: $relative"
    fi
    return
  fi

  mkdir -p "$(dirname "$target")"

  if [[ -e "$target" || -L "$target" ]]; then
    mkdir -p "$BACKUP_DIR/$(dirname "$relative")"
    mv "$target" "$BACKUP_DIR/$relative"
    echo "Backed up: $relative"
  fi

  ln -s "$source" "$target"
  echo "Linked: $relative"
}

while IFS= read -r -d '' file; do
  link_file "$file"
done < <(find "$SOURCE_DIR" -type f -print0 | sort -z)

if [[ "$DRY_RUN" == true ]]; then
  echo "Dry run complete. No files changed."
elif [[ -d "${BACKUP_DIR}" ]]; then
  echo "Backups written to: $BACKUP_DIR"
fi
