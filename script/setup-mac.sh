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
rm -rf $user_dir/.rvm
curl -# -sL https://get.rvm.io | bash -s stable --ruby
echo "install .rvm done"

# Install Homebrew
rm -rf /usr/local/Cellar /usr/local/.git && brew cleanup
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
echo "install Homebrew done"

# Install git and zsh

brew install git
curl -# https://raw.githubusercontent.com/rochappy/PTB/master/settings/.gitconfig > ~/.gitconfig
curl -L http://install.ohmyz.sh | sh
echo "install git and oh-my-zsh done"

# Install vundle
rm -rf $user_dir/.vim/bundle/vundle
git clone https://github.com/gmarik/vundle.git $user_dir/.vim/bundle/vundle
vim +BundleInstall +qall
echo 'vim bundle done'

# Install node
rm -rf $user_dir/.nvm
git clone https://github.com/creationix/nvm.git $user_dir/.nvm
source $user_dir/.nvm/nvm.sh
echo 'nvm install done'


#nvm install 0.10
nvm install 0.10
nvm alias default v0.10

# Download settings
rm -rf $user_dir/.oh-my-zsh
rm ~/.zshrc
rm ~/.vimrc
rm ~/.alias
git clone http://github.com/rochappy/oh-my-zsh $user_dir/.oh-my-zsh
curl -# https://raw.github.com/rochappy/PTB/master/settings/.zshrc > $user_dir/.zshrc
curl -# https://raw.github.com/rochappy/PTB/master/settings/.vimrc > $user_dir/.vimrc
curl -# https://raw.github.com/rochappy/PTB/master/settings/.alias > $user_dir/.alias
echo '' > $user_dir/.bashrc




# download
mkdir -p ~/git
git clone https://github.com/mbadolato/iTerm2-Color-Schemes.git ~/git/iTerm2-Color-Schemes 

curl -o iTerm2_v2_0.zip 'https://iterm2.com/downloads/stable/iTerm2_v2_0.zip'

# change owner
chown -Rf $user:$user $user_dir

chsh -s /bin/zsh $user
source $user_dir/.zshrc
