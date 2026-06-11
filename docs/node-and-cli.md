# Node And CLI Tools

The oracle uses `fnm`.

Observed Node versions:

- `22.15.0` default
- `20.16.0`
- `system`

Global npm packages:

- `@askjo/camofox-browser@1.11.2`
- `agent-browser@0.26.0`
- `corepack@0.34.6`
- `npm@10.9.8`

Global pnpm packages:

- `@cubic-dev-ai/cli@0.5.0`
- `degit@2.8.4`
- `turbo@2.5.8`
- `vibe-rules@0.3.91`

Global Bun package:

- `ralph-tui@0.7.0`

Global `uv` tools are installed by package name because their exact initial versions were not captured in the first oracle snapshot. Pin them in `scripts/languages.sh` when exact versions or commits are known.

Recreate with:

```sh
./scripts/languages.sh
```
