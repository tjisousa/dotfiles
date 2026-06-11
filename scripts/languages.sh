#!/usr/bin/env bash
set -euo pipefail

if command -v conda >/dev/null 2>&1; then
  echo "Conda is present on PATH, but this setup intentionally does not use it."
fi

if command -v fnm >/dev/null 2>&1; then
  fnm install 22.15.0
  fnm install 20.16.0
  fnm default 22.15.0
else
  echo "fnm is missing. Run brew bundle first." >&2
fi

if command -v uv >/dev/null 2>&1; then
  uv tool install claude-monitor
  uv tool install data-formulator
  uv tool install "streamtex[cli]"
  uv tool install git+https://github.com/54yyyu/zotero-mcp.git
else
  echo "uv is missing. Run brew bundle first." >&2
fi

if command -v npm >/dev/null 2>&1; then
  npm install -g @askjo/camofox-browser@1.11.2 agent-browser@0.26.0 corepack@0.34.6 npm@10.9.8
fi

if command -v pnpm >/dev/null 2>&1; then
  pnpm add -g @cubic-dev-ai/cli@^0.5.0 degit@^2.8.4 turbo@^2.5.8 vibe-rules@^0.3.91
fi

if command -v bun >/dev/null 2>&1; then
  bun add -g ralph-tui@^0.7.0
fi
