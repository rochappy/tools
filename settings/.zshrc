#!/usr/bin/env bash

################################### OH-MY-ZSH Settings ##########################################

ZSH=$HOME/.oh-my-zsh

ZSH_THEME="roc"

plugins=(git zsh-syntax-highlighting sublime node nvm web-search yum zsh_reload vundle urltools systemadmin osx go docker docker-alias python pip pyenv npm react-native yarn)

if [[ -s $ZSH/oh-my-zsh.sh ]]; then
	source $ZSH/oh-my-zsh.sh
else
	autoload -U colors && colors
	echo "$bold_color$fg[red]Please visit 'https://github.com/robbyrussell/oh-my-zsh' and install oh-my-zsh."
fi


########################################## Env ##########################################

# Load NVM. Node version manager.
[[ -s "$HOME/.nvm/nvm.sh" ]] && source $HOME/.nvm/nvm.sh

# RVM
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source $HOME/.rvm/scripts/rvm


########################################## Functions ##########################################

rp-file-toggle()
{
	isVisible=$(defaults read com.apple.finder AppleShowAllFiles)

	# toggle visibility based on variables value
	if [[ $isVisible = FALSE ]]
	then
		defaults write com.apple.finder AppleShowAllFiles TRUE
	else
		defaults write com.apple.finder AppleShowAllFiles FALSE
	fi

	killall Finder
}

rp-key()
{
	cat $HOME/.ssh/id_rsa.pub && cat $HOME/.ssh/id_rsa.pub | pbcopy
	echo 'ssh public key copied.'
}

rp-ping()
{
	ret=$(python -c "
import urlparse
s = '$1'
if s.find('://') < 0:
  s = 'http://' + s
host = urlparse.urlparse(s).netloc
print(host)
")
	ping $ret
}

rp-proxy-open () {
  export HTTP_PROXY="http://127.0.0.1:1081"
  echo "http Proxy already open"
}

rp-proxy-close () {
  unset HTTP_PROXY
  echo "http Proxy closed"
}

########################################## Personal Profile ##########################################

[[ -s "$HOME/.alias" ]] && source $HOME/.alias
[[ -s "$HOME/.private.alias" ]] && source $HOME/.private.alias

export EDITOR=vim
export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
export PATH="$PATH:$HOME/.linuxbrew/bin:/usr/local/bin:/usr/bin:/bin"

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
