# ========================
# HISTORY
# ========================
HISTFILE="${XDG_STATE_HOME:-$HOME/.local/state}/zsh/history"
HISTSIZE=10000
SAVEHIST=10000
mkdir -p "${HISTFILE:h}"
setopt autocd extendedglob nomatch HIST_IGNORE_DUPS SHARE_HISTORY APPEND_HISTORY

# ========================
# KEYBINDS
# ========================
bindkey -v
bindkey '^A' beginning-of-line
bindkey '^E' end-of-line
bindkey '^P' up-line-or-history
bindkey '^N' down-line-or-history

# ========================
# COMPLETION
# ========================
autoload -Uz compinit
compinit

# ========================
# FZF
# ========================
if command -v fzf >/dev/null 2>&1; then
  for fzf_dir in /usr/share/fzf /usr/share/fzf/shell /usr/share/doc/fzf/shell; do
    [ -f "$fzf_dir/key-bindings.zsh" ] && source "$fzf_dir/key-bindings.zsh"
    [ -f "$fzf_dir/completion.zsh" ] && source "$fzf_dir/completion.zsh"
  done

  export FZF_DEFAULT_OPTS="${FZF_DEFAULT_OPTS:---height=40% --layout=reverse --border}"
  if command -v fd >/dev/null 2>&1; then
    export FZF_CTRL_T_COMMAND="${FZF_CTRL_T_COMMAND:-fd --hidden --follow --exclude .git}"
    export FZF_ALT_C_COMMAND="${FZF_ALT_C_COMMAND:-fd --type d --hidden --follow --exclude .git}"
  else
    export FZF_CTRL_T_COMMAND="${FZF_CTRL_T_COMMAND:-find . -type f -o -type d 2>/dev/null}"
    export FZF_ALT_C_COMMAND="${FZF_ALT_C_COMMAND:-find . -type d 2>/dev/null}"
  fi
fi

# ========================
# ZOXIDE
# ========================
if command -v zoxide >/dev/null 2>&1; then
  eval "$(zoxide init zsh)"
  alias cd='z'
  alias cdi='zi'
fi

# ========================
# ENV
# ========================
export EDITOR="${EDITOR:-nvim}"
export VISUAL="${VISUAL:-$EDITOR}"
export GPG_TTY="$(tty)"

if grep -qi microsoft /proc/version 2>/dev/null; then
  export DOTFILES_IS_WSL=1
fi

if command -v java >/dev/null 2>&1; then
  export JAVA_HOME=$(readlink -f $(which java) | sed "s:/bin/java::")
fi


# ========================
# ALIASES
# ========================
alias ll='ls -lah'
alias la='ls -A'
alias l='ls -CF'

alias g='git'
alias k='kubectl'
alias tf='terraform'

alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gp='git push'

alias vi='nvim'
alias vim='nvim'

# ========================
# PROMPT (clean + modern)
# ========================
autoload -Uz colors && colors

setopt PROMPT_SUBST

PROMPT='%F{green}%n@%m%f %F{blue}%~%f %(?.%F{green}.%F{red})➜%f '

# ========================
# OPTIONAL: Git branch in prompt
# ========================
autoload -Uz vcs_info
precmd() { vcs_info }
zstyle ':vcs_info:git:*' formats ' (%b)'

PROMPT='%F{green}%n@%m%f %F{blue}%~%f${vcs_info_msg_0_} %(?.%F{green}.%F{red})➜%f '

# ========================
# QUALITY OF LIFE
# ========================
setopt CORRECT          # minor typo correction
setopt INTERACTIVE_COMMENTS

# ========================
# TMUX config for ZSH
# ========================
if [[ -o interactive ]] &&
  [ "${DOTFILES_AUTO_TMUX:-1}" = "1" ] &&
  [ -z "$TMUX" ] &&
  [ -z "$VSCODE_INJECTION" ] &&
  command -v tmux >/dev/null 2>&1; then
  tmux attach -t main || tmux new -s main
fi
