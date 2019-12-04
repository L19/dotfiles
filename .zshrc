## Keybind
#
bindkey -v

## Prompt
#
autoload -Uz vcs_info
setopt prompt_subst
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' stagedstr "%F{yellow}!"
zstyle ':vcs_info:git:*' unstagedstr "%F{red}+"
zstyle ':vcs_info:*' formats "%F{green}%u%c[%b]%f"
zstyle ':vcs_info:*' actionformats '[%b|%a]'
precmd () { vcs_info }
PROMPT=[%~]'${vcs_info_msg_0_} '

#PROMPT=[%~]' '
RPROMPT=''
[ -n "${REMOTEHOST}${SSH_CONNECTION}" ] &&
  PROMPT="%F{white}${HOST%%.*}%f ${PROMPT}"

## Completion
#
autoload -U compinit
compinit

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

## Alias
#
case ${OSTYPE} in
  darwin*)
    alias ls="ls -G"
    alias ldiff="latexdiff-vc -e utf8 --git --flatten --force -d diff -r HEAD"
    alias matlab="/Applications/MATLAB_R2019a.app/bin/matlab -nodesktop -r \"startup;\""
    alias mvim="mvim --remote-tab-silent"
  ;;
  linux*)
    alias ls="ls --color=auto"
  ;;
esac

## pyenv
#
if [ -d ${HOME}/.pyenv ]; then
  eval "$(pyenv init -)"
fi

## nvm
#
if [ -d ${HOME}/.nvm ]; then
  source $(brew --prefix nvm)/nvm.sh
fi

