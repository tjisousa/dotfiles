# Cursor

Captured from this Mac:

- `~/Library/Application Support/Cursor/User/settings.json`
- `~/.cursor/argv.json`
- `~/.cursor/mcp.json.template`
- `~/.cursor/hooks.json.template`
- `~/.cursor/commands/*.md`
- `~/.cursor/plugins/*.json`
- `~/.cursor/skills-cursor/.cursor-managed-skills-manifest.json`
- Extension reinstall script: `scripts/cursor-extensions.sh`
- Local MCP/hooks generator: `scripts/cursor-config.sh`

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
- Superset hooks under `~/.superset/hooks/cursor-hook.sh`

Run:

```sh
./scripts/cursor-config.sh
```

The generator writes real `~/.cursor/mcp.json` and `~/.cursor/hooks.json` files after checking local dependencies. It always includes `context7` and writes empty hooks when the Superset hook is unavailable.
