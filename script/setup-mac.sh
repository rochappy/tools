#!/bin/bash

# quote https://github.com/ysmood/Kit
# update: rochappy
user=$1

if [ ! $1 ]; then
        echo "You must specify a user name."
        exit
fi

user_dir=/Users/$user

# Install git and zsh
sudo apt-get install git zsh

ln -fs $user_dir/.zshrc /root/.zshrc
ln -fs $user_dir/.oh-my-zsh /root/.oh-my-zsh
ln -fs $user_dir/.vimrc /root/.vimrc
ln -fs $user_dir/.vim /root/.vim
ln -fs $user_dir/.nvm /root/.nvm

# Install vundle
rm -rf $user_dir/.vim/bundle/vundle
git clone https://github.com/gmarik/vundle.git $user_dir/.vim/bundle/vundle
vim +BundleInstall +qall

# Install node
rm -rf $user_dir/.nvm
git clone https://github.com/creationix/nvm.git $user_dir/.nvm
source $user_dir/.nvm/nvm.sh

#nvm install 0.10
nvm install 0.10
nvm alias default v0.10

# Install ruby
rm -rf $user_dir/.rvm
curl -# -sL https://get.rvm.io | bash -s stable --ruby

# Download settings
rm -rf $user_dir/.oh-my-zsh
git clone http://github.com/rochappy/oh-my-zsh $user_dir/.oh-my-zsh
curl -# https://raw.github.com/rochappy/PTB/master/settings/.zshrc > $user_dir/.zshrc
curl -# https://raw.github.com/rochappy/PTB/master/settings/.vimrc > $user_dir/.vimrc
echo '' > $user_dir/.bashrc

# change owner
chown -Rf $user:$user $user_dir

chsh -s /bin/zsh $user
source $user_dir/.zshrc
