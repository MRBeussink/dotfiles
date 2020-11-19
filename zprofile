#!/bin/zsh

# Default programs
export EDITOR="nvim"
export TERMINAL="iTerm2"

# clean up ~
# export ZDOTDIR="${XDG_CONFIG_HOME:-$HOME/.config}/zsh"

# if command nvim
# then
#   alias vi="nvim"
#   alias vim="nvim"
#   alias v="nvim"
# fi

# if command trash
# then  
#   alias rm="trash"
# fi

export PATH="$HOME/bin:$PATH"
export PATH="/usr/local/sbin:$PATH"

export PATH="$HOME/.cargo/bin:$PATH"
#export NVM_DIR=~/dev/.nvm
source $(brew --prefix nvm)/nvm.sh

# Local config
[[ -f ~/.zprofile.local ]] && source ~/.zprofile.local

