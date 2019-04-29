#!/usr/bin/env bash

################################### OH-MY-ZSH Settings ##########################################

ZSH=$HOME/.oh-my-zsh

ZSH_THEME="roc"

plugins=(git zsh-syntax-highlighting sublime node nvm web-search yum zsh_reload vundle urltools systemadmin osx go docker docker-alias python npm)

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

rp-show-hide()
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
	cat $HOME/.ssh/id_rsa.pub | pbcopy
	echo 'ssh public key copied.'
}

# A better way to ping.
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

rp-git-daemon()
{
	repo_root=$1
	port=$2
	repo_list=$3

	echo Listening port $port
	git daemon --export-all --enable=receive-pack --verbose --port=$port --base-path=$repo_root $repo_list
}

rp-svn-ignore()
{
	for f; do
	    d=`dirname "$f"`
	    b=`basename "$f"`
	    ignore=`svn pg svn:ignore "$d"`
	    if [ -n "$ignore" ]; then
	        ignore="$ignore
	"
	    fi
	    ignore="$ignore$b"
	    svn ps svn:ignore "$ignore" "$d"
	done
}

########################################## Personal Profile ##########################################

[[ -s "$HOME/.alias" ]] && source $HOME/.alias

export SVN_EDITOR=vim
export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
export PATH="$PATH:$HOME/.linuxbrew/bin:/usr/local/bin:/usr/bin:/bin"

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
