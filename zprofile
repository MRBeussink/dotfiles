#!/bin/zsh

# Default programs
export EDITOR="nvim"
export TERMINAL="iTerm2"
export BROWSER="brave"

# clean up ~
# export ZDOTDIR="${XDG_CONFIG_HOME:-$HOME/.config}/zsh"

#mkcd () {
	#mkdir -p -- "$1" &&
	#  cd -P -- "$1"
#}

export PATH="$HOME/bin:$PATH"
export PATH="/usr/local/sbin:$PATH"

export PATH="$HOME/.cargo/bin:$PATH"
#export NVM_DIR=~/dev/.nvm
source $(brew --prefix nvm)/nvm.sh
