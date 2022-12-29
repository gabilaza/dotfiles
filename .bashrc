HISTSIZE=10000000
HISTFILESIZE=10000000

alias vi=nvim

alias gitl="git log --all --decorate --oneline --graph"

alias gits="git status"
alias gitd="git diff"
alias la="ls -al --color=auto"
alias ls="ls --color=auto"
alias ll="ls -l --color=auto"
alias lg="lazygit"
alias ranger='ranger --choosedir=$HOME/.rangerdir; LASTDIR=`cat $HOME/.rangerdir`; cd "$LASTDIR"'
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias gitFormat='git show --diff-filter=AM --pretty="" --name-only HEAD | grep java$ | xargs java -jar ~/java/google-java-format-1.16.0-all-deps.jar -a -i && git show --diff-filter=AM --pretty="" --name-only HEAD | xargs git add'
alias javaFormat='find src/ -type f | grep java$ | xargs java -jar ~/java/google-java-format-1.16.0-all-deps.jar -a -i'

export VISUAL=vim
export EDITOR="$VISUAL"

ssho () { ssh -t "$1" "$2" "export TERM=xterm-256color; bash -l"; }

export PS1="\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ "
export JDTLS_JVM_ARGS="-javaagent:$HOME/.local/share/nvim/mason/packages/jdtls/lombok.jar"

sshGithub () {
    echo "WARNING" # ctrl+c not working
    eval $(ssh-agent -s) # maybe can fail ssh-agent and ssh-add
    if ssh-add ~/.ssh/id_ed25519 && ssh-add ~/.ssh/sign_ed25519; then
        _OLD_SSH_GITHUB_PS1="${PS1:-}"
        PS1="(ssh-github) ${PS1:-}"
        export PS1
    else
        eval $(ssh-agent -k)
    fi
}

sshDeactivate() {
    eval $(ssh-agent -k) # maybe can fail ssh-agent
    if [ -n "${_OLD_SSH_GITHUB_PS1:-}" ] ; then
        PS1="${_OLD_SSH_GITHUB_PS1:-}"
        export PS1
        unset _OLD_SSH_GITHUB_PS1
    fi
}
