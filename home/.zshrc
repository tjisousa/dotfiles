# Cache brew prefix (faster than calling brew --prefix multiple times)
if command -v brew >/dev/null 2>&1; then
  typeset -gx BREW_PREFIX="${BREW_PREFIX:-$(brew --prefix 2>/dev/null)}"
fi

# History configuration (set early for better performance)
HISTFILE="$HOME/.zsh_history"
HISTSIZE=10000
SAVEHIST=10000
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_FIND_NO_DUPS
setopt SHARE_HISTORY
setopt APPEND_HISTORY

# Search history with arrow keys
bindkey '^[[A' history-search-backward
bindkey '^[[B' history-search-forward

# FNM (Fast Node Manager)
if command -v fnm >/dev/null 2>&1; then
  eval "$(fnm env --use-on-cd)"
  export FNM_VERSION_FILE_STRATEGY="local"
  export FNM_LOGLEVEL="info"
  export FNM_NODE_DIST_MIRROR="https://nodejs.org/dist"
  export FNM_COREPACK_ENABLED="false"
  export FNM_RESOLVE_ENGINES="true"
  case "$(uname -m)" in
    arm64) export FNM_ARCH="arm64" ;;
    x86_64) export FNM_ARCH="x64" ;;
  esac
fi

# pnpm
export PNPM_HOME="$HOME/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac

alias avenv='source .venv/bin/activate'

# Completion system
fpath=("$HOME/.zsh/completions" $fpath)
autoload -Uz compinit
if [[ -n "${ZDOTDIR:-$HOME}/.zcompdump"(#qN.mh+24) ]]; then
  compinit -C
else
  compinit
fi
{ zcompile "${ZDOTDIR:-$HOME}/.zcompdump" } &!

setopt AUTO_PARAM_SLASH
unsetopt AUTO_REMOVE_SLASH
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*' menu select
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*:cd:*' tag-order local-directories directory-stack path-directories
zstyle ':completion:*:*:cd:*:*' file-sort modification
zstyle ':completion:*' special-dirs true
zstyle ':completion:*' squeeze-slashes true

[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"

if [[ -n "${BREW_PREFIX:-}" ]]; then
  [[ -f "$BREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh" ]] &&
    source "$BREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
  [[ -f "$BREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]] &&
    source "$BREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
fi

if command -v starship >/dev/null 2>&1; then
  eval "$(starship init zsh)"
fi

export PATH="$HOME/.cubic/bin:$PATH"

# >>> ara cli (managed by Ara Desktop) >>>
case ":$PATH:" in
  *":$HOME/.local/bin:"*) ;;
  *) export PATH="$HOME/.local/bin:$PATH" ;;
esac
# <<< ara cli (managed by Ara Desktop) <<<
