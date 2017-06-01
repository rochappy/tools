#!/bin/bash

# https://github.com/Homebrew/linuxbrew/wiki/Standalone-Installation#create-symlinks-for-gcc linux 安卓gcc 问题汇总

user=$1

if [ ! $1 ]; then
        echo "You must specify a user name."
        exit
fi

user_dir=/Users/$user

# Install ruby
rm -rf ~/.rvm
curl -L -sL https://get.rvm.io | bash -s stable --ruby

# Install Homebrew
rm -rf /usr/local/Cellar /usr/local/.git && brew cleanup
rm -rf /usr/local/Cellar /usr/local/.git && brew cleanup
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/linuxbrew/go/install)"
brew install wget

#Github caskroom/cask
#brew tap caskroom/cask

#install brew-cask
#brew install brew-cask

#update Over the wall
#brew update && brew upgrade brew-cask && brew cleanup
#brew cask install qlcolorcode qlmarkdown quicklook-json betterzipql
#brew cask install google-chrome sublime-text alfred

# Install git and zsh
#brew install git
curl -L https://raw.githubusercontent.com/rochappy/PTB/master/settings/.gitconfig > ~/.gitconfig

rm -rf ~/.oh-my-zsh
git clone https://github.com/robbyrussell/oh-my-zsh.git $user_dir/.oh-my-zsh

# Install vundle
rm ~/.vimrc
rm -rf ~/.vim/bundle/vundle
curl -L https://raw.github.com/rochappy/PTB/master/settings/.vimrc > ~/.vimrc
git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
vim +BundleInstall +qall

# Install node
rm -rf ~/.nvm
git clone https://github.com/creationix/nvm.git ~/.nvm
source ~/.nvm/nvm.sh

#nvm install
nvm install v6.0.0
nvm alias default v6.0.0

# npm install -g coffee-script
# npm install -g grunt-cli
# npm install -g gulp

# Download settings
rm ~/.zshrc
rm ~/.alias
curl -L https://raw.githubusercontent.com/rochappy/PTB/master/settings/roc.zsh-theme > ~/.oh-my-zsh/themes/roc.zsh-theme
curl -L https://raw.github.com/rochappy/PTB/master/settings/.zshrc > ~/.zshrc
curl -L https://raw.github.com/rochappy/PTB/master/settings/.alias > ~/.alias
curl -L https://raw.github.com/rochappy/PTB/master/settings/.npmrc > ~/.npmrc

# download iTerm color
mkdir -p ~/git
git clone https://github.com/mbadolato/iTerm2-Color-Schemes.git ~/git/iTerm2-Color-Schemes

# download App
#wget https://iterm2.com/downloads/stable/iTerm2_v2_0.zip
#wget https://cachefly.alfredapp.com/Alfred_2.4_279.zip
#wget http://bettertouchtool.net/BetterTouchTool.zip

# change owner
chown -Rf $user:$user $user_dir

chsh -s /bin/zsh $user
source ~/.zshrc
