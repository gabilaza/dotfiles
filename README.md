# Dotfiles

## Installation
```bash
  cd $HOME
  echo ".dotfiles" >> .gitignore
  git clone --bare https://github.com/gabilaza/dotfiles.git $HOME/.dotfiles
  alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
  dotfiles checkout gbi-macos 2>&1 | grep -E "\s+\." | awk {'print $1'} | xargs -I{} mv {} {}.backup
  dotfiles checkout gbi-macos
  dotfiles config --local status.showUntrackedFiles no
```
