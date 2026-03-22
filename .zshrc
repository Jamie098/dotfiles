export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"

zstyle ':omz:update' mode auto      # update automatically without asking
zstyle ':omz:update' frequency 1

plugins=(git)

source $ZSH/oh-my-zsh.sh

fastfetch
