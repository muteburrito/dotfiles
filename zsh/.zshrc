# ========================
# HISTORY
# ========================
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000
setopt autocd extendedglob nomatch HIST_IGNORE_DUPS SHARE_HISTORY

# ========================
# KEYBINDS
# ========================
bindkey -v

# ========================
# COMPLETION
# ========================
autoload -Uz compinit
compinit

# ========================
# FZF
# ========================
if command -v fzf >/dev/null 2>&1; then
  [ -f /usr/share/fzf/shell/key-bindings.zsh ] && source /usr/share/fzf/shell/key-bindings.zsh
  [ -f /usr/share/fzf/shell/completion.zsh ] && source /usr/share/fzf/shell/completion.zsh

  export FZF_DEFAULT_OPTS="--height=40% --layout=reverse --border"
  export FZF_CTRL_T_COMMAND="find . -type f -o -type d 2>/dev/null"
  export FZF_ALT_C_COMMAND="find . -type d 2>/dev/null"
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
export EDITOR=nvim
export GPG_TTY=$(tty)

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
# FZF (if installed)
# ========================
[ -f /usr/share/fzf/shell/key-bindings.zsh ] && source /usr/share/fzf/shell/key-bindings.zsh

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
if [ -z "$TMUX" ]; then
  tmux attach -t main || tmux new -s main
fi
