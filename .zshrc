## Keybind
#
bindkey -v

## Prompt
#
RPROMPT="[%~]"

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
alias ls="ls -G"
