#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Customize to your needs...
alias nvimtex="NVIM_LISTEN_ADDRESS=/tmp/nvimsocket nvim"
alias matlab="/Applications/MATLAB_R2019a.app/bin/matlab -nojvm -nodesktop"

autoload -Uz compinit
compinit
