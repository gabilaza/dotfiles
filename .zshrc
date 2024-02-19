HISTSIZE=10000000
HISTFILESIZE=10000000
SAVEHIST=10000000
setopt appendhistory

alias vi=nvim
alias enter=tmux-sessionizer

alias gitl="git log --all --decorate --oneline --graph"
alias curltime="curl -w \"@$HOME/.curl-format.txt\" -o /dev/null -s "

alias dotfilesl="dotfiles log --all --decorate --oneline --graph"
alias dotfiless="dotfiles status"
alias dotfilesd="dotfiles diff"

alias gits="git status"
alias gitd="git diff"
alias la="ls -al --color=auto"
alias ls="ls --color=auto"
alias ll="ls -l --color=auto"
alias lg="lazygit"
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

export VISUAL=vim
export EDITOR="$VISUAL"

ssho () { ssh -t "$1" "$2" "export TERM=xterm-256color; bash -l"; }

export PROMPT='%F{cyan}%n%f@%F{green}%m:%F{yellow}%~%f$ '
export JDTLS_JVM_ARGS="-javaagent:$HOME/.local/share/nvim/mason/packages/jdtls/lombok.jar"

