export EDITOR=vi

alias ll='ls -lah'
alias g='git'

autoload -Uz compinit
compinit

PROMPT='%F{green}%n@%m%f:%F{blue}%~%f$ '

export GPG_TTY=$(tty)
