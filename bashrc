
alias vi=vim
alias gitl="git log --all --decorate --oneline --graph"
alias la="ls -al --color=auto"
alias ls="ls --color=auto"
alias ranger='ranger --choosedir=$HOME/.rangerdir; LASTDIR=`cat $HOME/.rangerdir`; cd "$LASTDIR"'

export VISUAL=vim
export EDITOR="$VISUAL"

ssho () { ssh -t "$1" "$2" "export TERM=xterm-256color; bash -l"; }

export PS1="\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ "
