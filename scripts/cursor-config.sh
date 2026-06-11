#!/usr/bin/env bash
set -euo pipefail

CURSOR_DIR="${CURSOR_CONFIG_DIR:-$HOME/.cursor}"
BACKUP_DIR="$HOME/.dotfiles-backup/cursor-config-$(date +%Y%m%d%H%M%S)"
SUPERSET_CURSOR_HOOK="${SUPERSET_CURSOR_HOOK:-$HOME/.superset/hooks/cursor-hook.sh}"

json_escape() {
  local value="$1"
  value="${value//\\/\\\\}"
  value="${value//\"/\\\"}"
  printf '%s' "$value"
}

write_if_changed() {
  local target="$1"
  local temp_file="$2"
  local relative="${target#"$HOME"/}"

  mkdir -p "$(dirname "$target")"

  if [[ -f "$target" ]] && cmp -s "$temp_file" "$target"; then
    rm -f "$temp_file"
    echo "Already current: ~/$relative"
    return
  fi

  if [[ -e "$target" || -L "$target" ]]; then
    mkdir -p "$BACKUP_DIR/$(dirname "$relative")"
    mv "$target" "$BACKUP_DIR/$relative"
    echo "Backed up: ~/$relative"
  fi

  mv "$temp_file" "$target"
  echo "Wrote: ~/$relative"
}

write_mcp_config() {
  local target="$CURSOR_DIR/mcp.json"
  local temp_file
  temp_file="$(mktemp)"

  cat >"$temp_file" <<'EOF'
{
  "mcpServers": {
    "context7": {
      "url": "https://mcp.context7.com/mcp",
      "headers": {}
    }
  }
}
EOF

  write_if_changed "$target" "$temp_file"
}

write_hooks_config() {
  local target="$CURSOR_DIR/hooks.json"
  local temp_file
  temp_file="$(mktemp)"

  if [[ -x "$SUPERSET_CURSOR_HOOK" ]]; then
    local escaped_hook
    escaped_hook="$(json_escape "$SUPERSET_CURSOR_HOOK")"
    cat >"$temp_file" <<EOF
{
  "version": 1,
  "hooks": {
    "beforeSubmitPrompt": [
      {
        "command": "$escaped_hook Start"
      }
    ],
    "stop": [
      {
        "command": "$escaped_hook Stop"
      }
    ],
    "beforeShellExecution": [
      {
        "command": "$escaped_hook PermissionRequest"
      }
    ],
    "beforeMCPExecution": [
      {
        "command": "$escaped_hook PermissionRequest"
      }
    ]
  }
}
EOF
  else
    cat >"$temp_file" <<'EOF'
{
  "version": 1,
  "hooks": {}
}
EOF
    echo "Superset Cursor hook not found or not executable. Writing an empty hooks config." >&2
  fi

  write_if_changed "$target" "$temp_file"
}

write_mcp_config
write_hooks_config

if [[ -d "$BACKUP_DIR" ]]; then
  echo "Backups written to: $BACKUP_DIR"
fi
