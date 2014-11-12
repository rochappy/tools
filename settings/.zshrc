#!/usr/bin/env bash
# Default zsh runcom.
# Oct 2012 y.s.
# update: rochappy

################################### OH-MY-ZSH Settings ##########################################

ZSH=$HOME/.oh-my-zsh

ZSH_THEME="roc"

plugins=(git zsh-syntax-highlighting bower cake coffee sublime)

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

# Add new path to environment path
ys-add-evn-path()
{
	PATH="$1:${PATH}"
	export PATH
}

# Toggle the visibility of hidden files.
ys-show-hide()
{
	# check if hidden files are visible and store result in a variable
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

# Copy the ssh public key.
ys-key()
{
	cat $HOME/.ssh/id_rsa.pub | pbcopy
	echo 'ssh public key copied.'
}

ys-copy()
{
	cat "$1" | pbcopy
	echo '>> copied.'
}

# Copy present working dir.
ys-pwd()
{
	pwd
	echo -n $PWD | pbcopy
}

# Return the specified ip address's geo info.
ys-ip()
{
	python -c "
import json, urllib2, urlparse
s = '$1'
if s.find('://') < 0:
  s = 'http://' + s
host = urlparse.urlparse(s).netloc
f = urllib2.urlopen('https://dazzlepod.com/ip/%s.json' % host)
s = f.read()
info = json.loads(s)
max_l = 0
for k in info:
  l = len(str(k))
  if max_l < l:
  	max_l = l
format = '%%%ds: %%s' % max_l
for k, v in info.iteritems():
  print(format % (k, v))
"
}

# A better way to ping.
ys-ping()
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

ys-git-daemon()
{
	repo_root=$1
	port=$2
	repo_list=$3

	echo Listening port $port
	git daemon --export-all --enable=receive-pack --verbose --port=$port --base-path=$repo_root $repo_list
}

########################################## Alias ##########################################

# Change directory to Desktop.
alias ys-d='cd ~/Desktop'

# Open with Sublime Text 2.
alias ys-b='st ~/.bash_profile'

# Generate a random password
alias ys-password='openssl rand -base64 32'

########################################## Personal Profile ##########################################

# Include personal bash profile.
[[ -s "$HOME/.bashrc" ]] && source $HOME/.bashrc
[[ -s "$HOME/.alias" ]] && source $HOME/.alias

export SVN_EDITOR=vim
export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
