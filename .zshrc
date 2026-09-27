HISTSIZE=10000000
HISTFILESIZE=10000000
SAVEHIST=10000000
setopt appendhistory

alias vi=nvim
alias enter=tmux-sessionizer
alias list=tmux-select
alias new=tmux-creator

alias curltime="curl -w \"@$HOME/.curl-format.txt\" -o /dev/null -s "

alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias dotfileslg='lg --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

alias dotfilesl="dotfiles log --all --decorate --oneline --graph"
alias dotfiless="dotfiles status"
alias dotfilesd="dotfiles diff"

alias gitl="git log --all --decorate --oneline --graph"
alias gits="git status"
alias gitd="git diff"

alias la="ls -al --color=auto"
alias ls="ls --color=auto"
alias ll="ls -l --color=auto"
alias lg="lazygit --use-config-file $HOME/.config/lazygit/config.yml"
alias ld="lazydocker"

alias ranger='ranger --choosedir=$HOME/.rangerdir; LASTDIR=`cat $HOME/.rangerdir`; cd "$LASTDIR"'
alias gitFormat='git show --diff-filter=AM --pretty="" --name-only HEAD | grep java$ | xargs java -jar ~/java/google-java-format-1.16.0-all-deps.jar -a -i && git show --diff-filter=AM --pretty="" --name-only HEAD | xargs git add'
alias javaFormat='find src/ -type f | grep java$ | xargs java -jar ~/java/google-java-format-1.16.0-all-deps.jar -a -i'

export VISUAL=nvim
export EDITOR="$VISUAL"

sshColor () { ssh -t "$1" "$2" "export TERM=xterm-256color; bash -l"; }

export PROMPT='%F{red}[%f%F{cyan}%n%f@%F{green}%m:%F{yellow}%~%f%F{red}]%f$ '
export JDTLS_JVM_ARGS="-javaagent:$HOME/.local/share/nvim/mason/packages/jdtls/lombok.jar"

export CLICOLOR=1

sshKeys () {
    echo "WARNING" # ctrl+c not working
    eval $(ssh-agent -s) # maybe can fail ssh-agent and ssh-add
    if ssh-add ~/.ssh/github_access && ssh-add ~/.ssh/github_signing && ssh-add ~/.ssh/thehouse; then
        _OLD_SSH_KEYS_PROMPT="${PROMPT:-}"
        PROMPT="(ssh-keys) ${PROMPT:-}"
        export PROMPT
    else
        eval $(ssh-agent -k)
    fi
}

sshKeysDeactivate () {
    eval $(ssh-agent -k) # maybe can fail ssh-agent
    if [ -n "${_OLD_SSH_KEYS_PROMPT:-}" ] ; then
        PROMPT="${_OLD_SSH_KEYS_PROMPT:-}"
        export PROMPT
        unset _OLD_SSH_KEYS_PROMPT
    fi
}

export PATH="$PATH:$HOME/.dotnet/tools"
export PATH="$PATH:$HOME/bin"
export PATH="$PATH:$HOME/go/bin"

export FZF_DEFAULT_OPTS="
    --color=fg:#5a93aa,bg:#152529,hl:#ebbcba
    --color=fg+:#6b9eb4,bg+:#2e3439,hl+:#ebbcba
    --color=border:#152529,header:#6a93aa,gutter:-1
    --color=spinner:#fda47f,info:#a1cdd8,separator:#152529
    --color=pointer:#ad6c7c,marker:#e85c51,prompt:#e6eaea"

source "$HOME/.cargo/env"
