#!/bin/bash

user=$1

if [ ! $1 ]; then
        echo "You must specify a user name."
        exit
fi

user_dir=/home/$user

# Install git and zsh
sudo apt-get install git zsh

# ln -fs $user_dir/.zshrc /root/.zshrc
# ln -fs $user_dir/.oh-my-zsh /root/.oh-my-zsh
# ln -fs $user_dir/.vimrc /root/.vimrc
# ln -fs $user_dir/.vim /root/.vim
# ln -fs $user_dir/.nvm /root/.nvm

# Install ruby
rm -rf $user_dir/.rvm
curl -L -sL https://get.rvm.io | bash -s stable --ruby

# Install Homebrew
rm -rf /usr/local/Cellar /usr/local/.git && brew cleanup
rm -rf /usr/local/Cellar /usr/local/.git && brew cleanup
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/linuxbrew/go/install)"
brew install wget

curl -L https://raw.githubusercontent.com/rochappy/PTB/master/settings/.gitconfig > $user_dir/.gitconfig

rm -rf $user_dir/.oh-my-zsh
git clone https://github.com/ysmood/oh-my-zsh.git $user_dir/.oh-my-zsh


# Install vundle
rm $user_dir/.vimrc
rm -rf $user_dir/.vim/bundle/vundle
curl -# https://raw.github.com/rochappy/PTB/master/settings/vimrc > $user_dir/.vimrc
git clone https://github.com/gmarik/vundle.git $user_dir/.vim/bundle/vundle
vim +BundleInstall +qall


# Install node
rm -rf $user_dir/.nvm
git clone https://github.com/creationix/nvm.git $user_dir/.nvm
source $user_dir/.nvm/nvm.sh

#nvm install 0.10
nvm install v4.6.0
nvm install v6.0.0
nvm alias default v4.6.0

npm install -g coffee-script
# npm install -g grunt-cli
npm install -g gulp

# Download settings
rm $user_dir/.zshrc
rm $user_dir/.alias
curl -L https://raw.githubusercontent.com/rochappy/PTB/master/settings/roc.zsh-theme > $user_dir/.oh-my-zsh/themes/roc.zsh-theme
curl -L https://raw.github.com/rochappy/PTB/master/settings/.zshrc > $user_dir/.zshrc
curl -L https://raw.github.com/rochappy/PTB/master/settings/.alias > $user_dir/.alias
curl -L https://raw.github.com/rochappy/PTB/master/settings/.npmrc > $user_dir/.npmrc

# change owner
chown -Rf $user:$user $user_dir

chsh -s /bin/zsh $user
chsh -s /bin/zsh root
source $user_dir/.zshrc
