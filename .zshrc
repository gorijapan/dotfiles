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

#export LANG=ja_JP.UTF-8
export EDITOR=vim


# brew api token
if [ -f ~/.brew_api_token ];then
    source ~/.brew_api_token
fi


HISTFILE=~/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000
setopt hist_ignore_dups     # ignore duplication command history list
setopt share_history        # share command history data

autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end

setopt auto_pushd


#autoload -Uz vcs_info
autoload -Uz add-zsh-hook
autoload -Uz chpwd_recent_dirs cdr
add-zsh-hook chpwd chpwd_recent_dirs

#zstyle ':vcs_info:*' formats '%F{green}(%s)-[%b]%f'
#zstyle ':vcs_info:*' actionformats '%F{red}(%s)-[%b|%a]%f'

#function _update_vcs_info_msg() {
#    LANG=en_US.UTF-8 vcs_info
#    RPROMPT="${vcs_info_msg_0_}"
#}
#add-zsh-hook precmd _update_vcs_info_msg
#

alias updatedb='sudo /usr/libexec/locate.updatedb'

#alias vi='/usr/local/bin/vim'
#alias vim='/usr/local/bin/vim'


#fpath=($HOME/.zsh/anyframe(N-/) $fpath)
#autoload -Uz anyframe-init
#anyframe-init

#bindkey '^x^r' anyframe-widget-put-history
#bindkey '^xb' anyframe-widget-cdr

function peco-snippets() {
    local item
    item=$(cat ~/.snippets | peco --query "$LBUFFER" )

    if [[ -z "$item" ]]; then
        return 1
    fi

    BUFFER="$item"
    CURSOR=$#BUFFER
    #zle accept-line
}
zle -N peco-snippets
bindkey '^x^s' peco-snippets


### Virtualenvwrapper
if [ -x "`which virtualenvwrapper.sh 2>/dev/null`" ]; then
    export WORKON_HOME=$HOME/.virtualenvs
    source `which virtualenvwrapper.sh`
fi

function peco-select-history() {
  local tac
  if which tac > /dev/null; then
    tac="tac"
  else
    tac="tail -r"
  fi
  BUFFER=$(\history -n 1 | eval $tac | peco)
  CURSOR=$#BUFFER
  zle clear-screen
}
zle -N peco-select-history
bindkey '^r' peco-select-history

if [ -d $HOME/.composer/vendor/bin ]; then
    export PATH=$HOME/.composer/vendor/bin:$PATH
fi
if [ -d $HOME/bin ]; then
    export PATH=$HOME/bin:$PATH
fi
