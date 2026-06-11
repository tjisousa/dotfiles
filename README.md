# Tiago's macOS Dotfiles

macOS-only dotfiles generated from this Mac as the oracle.

This repo captures:

- Homebrew taps, formulae, casks, and fonts in `Brewfile`
- zsh, Starship, Git, Ghostty, SSH includes, GitHub CLI, OpenCode, and Mole config
- Cursor settings, MCP/hooks config, custom commands, plugin inventory, and extension reinstall script
- Raycast selected defaults and installed extension inventory
- macOS defaults sampled from this machine
- language tooling with `uv` only for Python

It deliberately excludes:

- SSH keys, known hosts, keychains, npm/GitHub/Stripe/Zotero tokens
- Raycast encrypted databases and analytics/cache state
- Cursor workspace history, AI tracking DB, snapshots, OAuth attempts, and global storage
- Conda, Miniconda, Mamba, pyenv, and Poetry-as-manager setup

## Use On A New Mac

Review first:

```sh
less Brewfile
less scripts/bootstrap.sh
less scripts/link.sh
```

Then run the pieces you want:

```sh
./scripts/bootstrap.sh
./scripts/languages.sh
./scripts/cursor-extensions.sh
./scripts/macos-defaults.sh
./scripts/raycast-defaults.sh
```

`bootstrap.sh` installs Homebrew if missing, runs `brew bundle`, and symlinks files from `home/` into your real home directory. It backs up existing files before replacing them.

## Current Oracle

- macOS: `26.3.1` (`25D2128`)
- Architecture: Apple Silicon (`arm64`)
- Homebrew: `/opt/homebrew/bin/brew`, version `5.1.15`
- Shell: `/bin/zsh`
- Node manager: `fnm`
- Python tool manager: `uv`
- Vercel CLI on this Mac: `53.1.0`

The installed Vercel CLI is behind the current recommended CLI. Upgrade when you are ready with `npm i -g vercel@latest` or `pnpm add -g vercel@latest`.
