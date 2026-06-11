# Tiago's macOS Dotfiles

macOS-only dotfiles generated from this Mac as the oracle.

This repo captures:

- Homebrew taps, formulae, casks, and fonts in `Brewfile`
- zsh, Starship, Git, Ghostty, SSH includes, GitHub CLI, OpenCode, and Mole config
- Cursor settings, MCP/hooks config, custom commands, and plugin inventory
- Raycast selected defaults and installed extension inventory
- macOS defaults sampled from this machine
- language tooling with `uv` only for Python

It deliberately excludes:

- SSH keys, known hosts, keychains, npm/GitHub/Stripe/Zotero tokens
- Raycast encrypted databases and analytics/cache state
- Cursor workspace history, AI tracking DB, snapshots, OAuth attempts, and global storage
- Conda, Miniconda, Mamba, pyenv, and Poetry-as-manager setup

## Use On A New Mac

Review what will be installed and linked:

```sh
less Brewfile
less scripts/bootstrap.sh
less scripts/link.sh
```

Preview the dotfile links:

```sh
./scripts/link.sh --dry-run
```

Install the base setup:

```sh
./scripts/bootstrap.sh
./scripts/doctor.sh
```

`bootstrap.sh` installs Homebrew if missing, runs `brew bundle`, and symlinks files from `home/` into your real home directory. Existing files are moved into `~/.dotfiles-backup/<timestamp>` before replacement. `link.sh` also supports `--only` and `--skip` filters for partial restores.

Run optional setup pieces as needed:

```sh
./scripts/languages.sh
./scripts/cursor-config.sh
./scripts/app-store-apps.sh --dry-run
./scripts/macos-defaults.sh
./scripts/raycast-defaults.sh
```

`cursor-config.sh` writes `~/.cursor/mcp.json` and `~/.cursor/hooks.json` from safe local checks. It includes `context7` and writes empty hooks when the Superset hook is not present.

`app-store-apps.sh` uses `mas` to install personal Apple App Store apps. Run it without `--dry-run` after signing into the Mac App Store.

## Refresh From This Mac

Refresh safe inventory snapshots with:

```sh
./scripts/snapshot.sh --all
```

The snapshot script is whitelist-based. It refreshes Homebrew, Raycast extension inventory, selected defaults, and App Store inventory, but does not copy auth databases, keychains, tokens, SSH keys, Cursor workspace/global storage, or Raycast encrypted state.

## Current Oracle

- macOS: `26.3.1` (`25D2128`)
- Architecture: Apple Silicon (`arm64`)
- Homebrew: `/opt/homebrew/bin/brew`, version `5.1.15`
- Shell: `/bin/zsh`
- Node manager: `fnm`
- Python tool manager: `uv`
- Vercel CLI on this Mac: `53.1.0`

The installed Vercel CLI is behind the current recommended CLI. Upgrade when you are ready with `npm i -g vercel@latest` or `pnpm add -g vercel@latest`.
