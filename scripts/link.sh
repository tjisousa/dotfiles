#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SOURCE_DIR="$ROOT_DIR/home"
BACKUP_DIR="$HOME/.dotfiles-backup/$(date +%Y%m%d%H%M%S)"

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

  mkdir -p "$(dirname "$target")"

  if [[ -L "$target" && "$(readlink "$target")" == "$source" ]]; then
    echo "Already linked: $relative"
    return
  fi

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

if [[ -d "${BACKUP_DIR}" ]]; then
  echo "Backups written to: $BACKUP_DIR"
fi
