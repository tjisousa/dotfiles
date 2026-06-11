#!/usr/bin/env bash
set -euo pipefail

if command -v conda >/dev/null 2>&1; then
  echo "Conda is present on PATH, but this setup intentionally does not use it."
fi

node_versions=(
  22.15.0
  20.16.0
)

uv_tools=(
  claude-monitor
  data-formulator
  "streamtex[cli]"
  git+https://github.com/54yyyu/zotero-mcp.git
)

npm_global_packages=(
  @askjo/camofox-browser@1.11.2
  agent-browser@0.26.0
  corepack@0.34.6
  npm@10.9.8
)

pnpm_global_packages=(
  @cubic-dev-ai/cli@0.5.0
  degit@2.8.4
  turbo@2.5.8
  vibe-rules@0.3.91
)

bun_global_packages=(
  ralph-tui@0.7.0
)

if command -v fnm >/dev/null 2>&1; then
  for version in "${node_versions[@]}"; do
    fnm install "$version"
  done
  fnm default 22.15.0
else
  echo "fnm is missing. Run brew bundle first." >&2
fi

if command -v uv >/dev/null 2>&1; then
  echo "Installing uv tools by package name. Pin versions here when exact uv tool versions are captured."
  for tool in "${uv_tools[@]}"; do
    uv tool install "$tool"
  done
else
  echo "uv is missing. Run brew bundle first." >&2
fi

if command -v npm >/dev/null 2>&1; then
  npm install -g "${npm_global_packages[@]}"
fi

if command -v pnpm >/dev/null 2>&1; then
  pnpm add -g "${pnpm_global_packages[@]}"
fi

if command -v bun >/dev/null 2>&1; then
  bun add -g "${bun_global_packages[@]}"
fi
