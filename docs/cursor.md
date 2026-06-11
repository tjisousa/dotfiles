# Cursor

Captured from this Mac:

- `~/Library/Application Support/Cursor/User/settings.json`
- `~/.cursor/argv.json`
- `~/.cursor/mcp.json`
- `~/.cursor/hooks.json`
- `~/.cursor/commands/*.md`
- `~/.cursor/plugins/*.json`
- `~/.cursor/skills-cursor/.cursor-managed-skills-manifest.json`
- Extension reinstall script: `scripts/cursor-extensions.sh`

Excluded:

- `History/`
- `workspaceStorage/`
- `globalStorage/`
- OAuth attempts
- AI tracking DB
- snapshots
- plans
- project-specific plugin assignments

Those excluded files contain local project state, generated databases, private history, and authentication material.

## Extensions

Oracle extension list:

| Extension | Version |
| --- | --- |
| `bradlc.vscode-tailwindcss` | `0.14.28` |
| `james-yu.latex-workshop` | `10.13.1` |
| `lucien-martijn.parquet-visualizer` | `0.31.1` |
| `oxc.oxc-vscode` | `1.57.0` |
| `pierrecomputer.pierre-theme` | `1.0.3` |
| `repreng.csv` | `1.3.0` |
| `rust-lang.rust-analyzer` | `0.3.2929` |
| `webpro.vscode-knip` | `2.1.6` |
| `yoavbls.pretty-ts-errors` | `0.8.7` |

Install them on a new Mac:

```sh
./scripts/cursor-extensions.sh
```

The script installs by extension ID, so it will usually pull current versions. Pinning exact versions would require storing VSIX artifacts, which this repo avoids.

## MCP And Hooks

The oracle has:

- `context7` remote MCP
- `pencil` local MCP via Cursor extension path
- Superset hooks under `~/.superset/hooks/cursor-hook.sh`

The local `pencil` server depends on the `highagency.pencildev` Cursor extension existing at the expected path. If that extension is missing on a new Mac, install it in Cursor before relying on this MCP entry.
