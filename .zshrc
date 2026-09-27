HISTSIZE=10000000
HISTFILESIZE=10000000
SAVEHIST=10000000
setopt appendhistory

alias vi=nvim
alias enter=tmux-sessionizer
alias list=tmux-select
alias new=tmux-creator

alias curltime="curl -w \"@$HOME/.curl-format.txt\" -o /dev/null -s "

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
alias dotfileslg='lg --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

# export VISUAL=nvim
# export EDITOR="$VISUAL"

ssho () { ssh -t "$1" "$2" "export TERM=xterm-256color; bash -l"; }

export PROMPT='%F{red}[%f%F{cyan}%n%f@%F{green}%m:%F{yellow}%~%f%F{red}]%f$ '
export JDTLS_JVM_ARGS="-javaagent:$HOME/.local/share/nvim/mason/packages/jdtls/lombok.jar"

export CLICOLOR=1

# Rust
source "$HOME/.cargo/env"

# SSH Keys
function sshKeys {
    ssh-add --apple-use-keychain "$HOME/.ssh/github_access"
    ssh-add --apple-use-keychain "$HOME/.ssh/github_signing"
    # ssh-add --apple-use-keychain "$HOME/.ssh/arch_linux"
    # ssh-add --apple-use-keychain "$HOME/.ssh/id_rsa"
    ssh-add --apple-use-keychain "$HOME/.ssh/thehouse"
}

export PATH="$PATH:$HOME/.dotnet/tools"
export PATH="$PATH:$HOME/bin"
export PATH="$PATH:$HOME/go/bin"
export PATH="/opt/homebrew/opt/ruby/bin:$PATH"
export PATH="/opt/homebrew/lib/ruby/gems/3.3.0/bin:$PATH"
# export PATH="/opt/homebrew/opt/openjdk@17/bin:$PATH"
# export CPPFLAGS="-I/opt/homebrew/opt/openjdk@17/include"
export LDFLAGS="-L/opt/homebrew/opt/ruby/lib"
export CPPFLAGS="-I/opt/homebrew/opt/ruby/include"
export PKG_CONFIG_PATH="/opt/homebrew/opt/ruby/lib/pkgconfig"

export FZF_DEFAULT_OPTS="
    --color=fg:#5a93aa,bg:#152529,hl:#ebbcba
    --color=fg+:#6b9eb4,bg+:#2e3439,hl+:#ebbcba
    --color=border:#152529,header:#6a93aa,gutter:-1
    --color=spinner:#fda47f,info:#a1cdd8,separator:#152529
    --color=pointer:#ad6c7c,marker:#e85c51,prompt:#e6eaea"


# BEGIN opam configuration
# This is useful if you're using opam as it adds:
#   - the correct directories to the PATH
#   - auto-completion for the opam binary
# This section can be safely removed at any time if needed.
[[ ! -r '/Users/glaza/.opam/opam-init/init.zsh' ]] || source '/Users/glaza/.opam/opam-init/init.zsh' > /dev/null 2> /dev/null
# END opam configuration
