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
alias lg="lazygit --use-config-file $HOME/.config/lazygit/config.yml"
alias ld="lazydocker"
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

export VISUAL=nvim
export EDITOR="$VISUAL"

ssho () { ssh -t "$1" "$2" "export TERM=xterm-256color; bash -l"; }

export PROMPT='%F{cyan}%n%f@%F{green}%m:%F{yellow}%~%f$ '
export JDTLS_JVM_ARGS="-javaagent:$HOME/.local/share/nvim/mason/packages/jdtls/lombok.jar"

export CLICOLOR=1

# Rust
source "$HOME/.cargo/env"

# SSH Keys
function sshKeys {
    ssh-add --apple-use-keychain "$HOME/.ssh/github_access"
    ssh-add --apple-use-keychain "$HOME/.ssh/github_signing"
    ssh-add --apple-use-keychain "$HOME/.ssh/arch_linux"
}

export PATH="$PATH:$HOME/.dotnet/tools"

export FZF_DEFAULT_OPTS="
    --color=fg:#908caa,bg:#191724,hl:#ebbcba
    --color=fg+:#e0def4,bg+:#26233a,hl+:#ebbcba
    --color=border:#403d52,header:#31748f,gutter:#191724
    --color=spinner:#f6c177,info:#9ccfd8,separator:#403d52
    --color=pointer:#c4a7e7,marker:#eb6f92,prompt:#908caa"
