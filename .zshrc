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
alias vi='nvim'
alias tvi="NVIM_LISTEN_ADDRESS=/tmp/nvimsocket nvim"
alias matlab="/Applications/MATLAB_R2020a.app/bin/matlab -nodesktop -sd /Users/l19/Documents/MATLAB"

autoload -Uz compinit
compinit -u

# dont distinguish uppercase from lower case at completion
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

setopt correct		# correct command

## Command history
#
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt hist_ignore_dups	# ignore duplication command history list
setopt share_history	# share command history data

## historical backward/forward search with linehead string binded to ^P/^N
#
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^p" history-beginning-search-backward-end
bindkey "^n" history-beginning-search-forward-end
bindkey "\\ep" history-beginning-search-backward-end
bindkey "\\en" history-beginning-search-forward-end


if [ -d ${HOME}/.nvm ]; then
  export NVM_DIR=~/.nvm
  [ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
  [ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && . "/usr/local/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion
fi

# export PYENV_ROOT="/usr/local/var/pyenv"
if which pyenv > /dev/null; then
  eval "$(pyenv init -)";
fi
if which pyenv-virtualenv-init > /dev/null; then
  eval "$(pyenv virtualenv-init -)";
fi
function gi() { curl -sLw n https://www.gitignore.io/api/$@ ;}
