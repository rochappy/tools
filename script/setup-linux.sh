#!/bin/bash

user=$1

if [ ! $1 ]; then
        echo "You must specify a user name."
        exit
fi

user_dir=/home/$user

# Install ruby
# rm -rf $user_dir/.rvm
# curl -L -sL https://get.rvm.io | bash -s stable --ruby

# Install Homebrew
sh -c "$(curl -fsSL https://raw.githubusercontent.com/Linuxbrew/install/master/install.sh)"

# Install zsh
rm -rf $user_dir/.oh-my-zsh
git clone https://github.com/robbyrussell/oh-my-zsh.git $user_dir/.oh-my-zsh
git clone https://github.com/robbyrussell/oh-my-zsh.git $user_dir/.oh-my-zsh/plugins/zsh-syntax-highlighting

# Install vundle
rm $user_dir/.vimrc
rm -rf $user_dir/.vim/bundle/vundle
curl -L https://raw.github.com/rochappy/PTB/master/settings/.vimrc > $user_dir/.vimrc
git clone https://github.com/gmarik/vundle.git $user_dir/.vim/bundle/vundle
vim +BundleInstall +qall


# Install node
rm -rf $user_dir/.nvm
git clone https://github.com/creationix/nvm.git $user_dir/.nvm
source $user_dir/.nvm/nvm.sh

#nvm install node
nvm install node
nvm alias default node

npm install -g lodash pm2 colors

# Download settings
rm $user_dir/.zshrc
rm $user_dir/.alias
curl -L https://raw.githubusercontent.com/rochappy/PTB/master/settings/roc.zsh-theme > $user_dir/.oh-my-zsh/themes/roc.zsh-theme
curl -L https://raw.github.com/rochappy/PTB/master/settings/.zshrc > $user_dir/.zshrc
curl -L https://raw.github.com/rochappy/PTB/master/settings/.alias > $user_dir/.alias
curl -L https://raw.github.com/rochappy/PTB/master/settings/.npmrc > $user_dir/.npmrc
curl -L https://raw.githubusercontent.com/rochappy/PTB/master/settings/.gitconfig > $user_dir/.gitconfig

# change owner
chown -Rf $user:$user $user_dir

chsh -s /bin/zsh $user
chsh -s /bin/zsh root
source $user_dir/.zshrc
