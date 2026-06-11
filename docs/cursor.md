# Cursor

Captured from this Mac:

- `~/Library/Application Support/Cursor/User/settings.json`
- `~/.cursor/argv.json`
- `~/.cursor/mcp.json.template`
- `~/.cursor/hooks.json.template`
- `~/.cursor/commands/*.md`
- `~/.cursor/plugins/*.json`
- `~/.cursor/skills-cursor/.cursor-managed-skills-manifest.json`
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

## MCP And Hooks

The oracle has:

- `context7` remote MCP
- Superset hooks under `~/.superset/hooks/cursor-hook.sh`

Run:

```sh
./scripts/cursor-config.sh
```

The generator writes real `~/.cursor/mcp.json` and `~/.cursor/hooks.json` files after checking local dependencies. It always includes `context7` and writes empty hooks when the Superset hook is unavailable.
