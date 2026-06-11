# Python

This setup intentionally uses `uv` only for Python tooling.

Included:

- `uv` from Homebrew
- `uvx` for standalone Python tools when needed
- `uv tool install` commands in `scripts/languages.sh`

Excluded on purpose:

- Conda
- Miniconda
- Mambaforge/Micromamba
- pyenv
- Poetry as a global environment manager

Oracle `uv tool` inventory:

```sh
uv tool install claude-monitor
uv tool install data-formulator
uv tool install "streamtex[cli]"
uv tool install git+https://github.com/54yyyu/zotero-mcp.git
```

Project-level Python should use:

```sh
uv init
uv add <package>
uv run <command>
```
