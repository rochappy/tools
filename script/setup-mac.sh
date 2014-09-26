#!/bin/bash

# quote https://github.com/ysmood/Kit
# update: rochappy
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
#ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"


# Install git and zsh
#brew install git
curl -L https://raw.githubusercontent.com/rochappy/PTB/master/settings/.gitconfig > ~/.gitconfig

rm -rf ~/.oh-my-zsh
curl -L http://install.ohmyz.sh | sh


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

#nvm install 0.10
nvm install 0.10
nvm alias default v0.10

# Download settings
rm ~/.zshrc
rm ~/.alias
rm -rf ~/.oh-my-zsh
git clone http://github.com/rochappy/oh-my-zsh ~/.oh-my-zsh
curl -L https://raw.github.com/rochappy/PTB/master/settings/.zshrc > ~/.zshrc
curl -L https://raw.github.com/rochappy/PTB/master/settings/.alias > ~/.alias

# change owner
chown -Rf $user:$user $user_dir

chsh -s /bin/zsh $user
source ~/.zshrc
