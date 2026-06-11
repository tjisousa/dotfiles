#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
failures=0
warnings=0

ok() {
  printf 'ok: %s\n' "$*"
}

warn() {
  warnings=$((warnings + 1))
  printf 'warn: %s\n' "$*" >&2
}

fail() {
  failures=$((failures + 1))
  printf 'fail: %s\n' "$*" >&2
}

has_command() {
  command -v "$1" >/dev/null 2>&1
}

check_command() {
  local command_name="$1"
  local required="${2:-false}"

  if has_command "$command_name"; then
    ok "command available: $command_name"
  elif [[ "$required" == true ]]; then
    fail "required command missing: $command_name"
  else
    warn "optional command missing: $command_name"
  fi
}

check_platform() {
  if [[ "$(uname -s)" == "Darwin" ]]; then
    ok "running on macOS"
  else
    fail "this dotfiles repo is macOS-only"
  fi
}

check_brew_bundle() {
  if ! has_command brew; then
    fail "Homebrew is missing"
    return
  fi

  if HOMEBREW_NO_AUTO_UPDATE=1 brew bundle check --file "$ROOT_DIR/Brewfile"; then
    ok "Brewfile dependencies are installed"
  else
    warn "Brewfile has missing dependencies; run ./scripts/bootstrap.sh"
  fi
}

check_shell_scripts() {
  if ! has_command shellcheck; then
    warn "shellcheck is missing; skipping shell lint"
    return
  fi

  if shellcheck "$ROOT_DIR"/scripts/*.sh; then
    ok "shell scripts pass shellcheck"
  else
    fail "shellcheck found issues"
  fi
}

validate_jsonc_with_node() {
  local file="$1"

  node - "$file" <<'NODE'
const fs = require("fs");
const file = process.argv[2];
const input = fs.readFileSync(file, "utf8");
let output = "";
let inString = false;
let escaped = false;

for (let index = 0; index < input.length; index += 1) {
  const char = input[index];
  const next = input[index + 1];

  if (escaped) {
    output += char;
    escaped = false;
    continue;
  }

  if (inString && char === "\\") {
    output += char;
    escaped = true;
    continue;
  }

  if (char === "\"") {
    inString = !inString;
    output += char;
    continue;
  }

  if (!inString && char === "/" && next === "/") {
    while (index < input.length && input[index] !== "\n") {
      index += 1;
    }
    output += "\n";
    continue;
  }

  output += char;
}

JSON.parse(output);
NODE
}

check_json_files() {
  if ! has_command jq; then
    warn "jq is missing; skipping JSON validation"
    return
  fi

  local bad_json=0
  while IFS= read -r -d '' file; do
    if ! jq empty "$file" >/dev/null; then
      fail "invalid JSON: ${file#"$ROOT_DIR"/}"
      bad_json=$((bad_json + 1))
    fi
  done < <(find "$ROOT_DIR" -name '*.json' -not -path "$ROOT_DIR/.git/*" -not -path "$ROOT_DIR/home/.cursor/argv.json" -print0)

  if [[ "$bad_json" -eq 0 ]]; then
    ok "JSON files are valid"
  fi

  if [[ -f "$ROOT_DIR/home/.cursor/argv.json" ]]; then
    if has_command node; then
      if validate_jsonc_with_node "$ROOT_DIR/home/.cursor/argv.json"; then
        ok "Cursor argv JSONC is valid"
      else
        fail "invalid JSONC: home/.cursor/argv.json"
      fi
    else
      warn "node is missing; skipping Cursor argv JSONC validation"
    fi
  fi
}

check_link_health() {
  local linked=0
  local missing=0
  local divergent=0
  local source

  while IFS= read -r -d '' source; do
    local relative="${source#"$ROOT_DIR/home"/}"
    local target="$HOME/$relative"

    case "$relative" in
      .DS_Store|*/.DS_Store|*.template)
        continue
        ;;
    esac

    if [[ -L "$target" && "$(readlink "$target")" == "$source" ]]; then
      linked=$((linked + 1))
    elif [[ -e "$target" || -L "$target" ]]; then
      divergent=$((divergent + 1))
    else
      missing=$((missing + 1))
    fi
  done < <(find "$ROOT_DIR/home" -type f -print0)

  ok "symlinked files: $linked"
  if [[ "$divergent" -gt 0 ]]; then
    warn "home targets already exist but are not linked: $divergent"
  fi
  if [[ "$missing" -gt 0 ]]; then
    warn "home targets are not linked yet: $missing"
  fi
}

check_cursor() {
  if ! has_command cursor; then
    warn "Cursor CLI is missing; skipping Cursor checks"
    return
  fi

  ok "Cursor CLI is available"

  if [[ -x "$HOME/.superset/hooks/cursor-hook.sh" ]]; then
    ok "Superset Cursor hook is executable"
  else
    warn "Superset Cursor hook missing; ./scripts/cursor-config.sh will write empty hooks"
  fi
}

check_app_store() {
  if has_command mas; then
    ok "mas is available for App Store restore"
  else
    warn "mas is missing; run ./scripts/bootstrap.sh before ./scripts/app-store-apps.sh"
  fi
}

check_platform
check_command git true
check_command rg false
check_command jq false
check_command shellcheck false
check_command fnm false
check_command uv false
check_command npm false
check_command pnpm false
check_command bun false
check_command cursor false
check_command mas false
check_brew_bundle
check_shell_scripts
check_json_files
check_link_health
check_cursor
check_app_store

printf '\nDoctor finished with %s warning(s), %s failure(s).\n' "$warnings" "$failures"

if [[ "$failures" -gt 0 ]]; then
  exit 1
fi
