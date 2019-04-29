#!/bin/bash

user=$1

if [ ! $1 ]; then
  echo -n  "please enter user name: "
  read  user

  if [ ! $user ]; then
    echo "You must specify a user name."
    exit
  fi
fi

user_dir=/home/$user

cmd='yum'
if type apt-get >/dev/null 2>&1; then
  cmd='apt-get'
fi

if !(type git) >/dev/null 2>&1; then
  sudo $cmd install git
fi

if !(type zsh) >/dev/null 2>&1; then
  sudo $cmd install zsh
fi

# Install ruby
# rm -rf $user_dir/.rvm
# curl -L -sL https://get.rvm.io | bash -s stable --ruby

# Install Homebrew
# sh -c "$(curl -fsSL https://raw.githubusercontent.com/Linuxbrew/install/master/install.sh)"

# Install zsh
rm -rf $user_dir/.oh-my-zsh
git clone https://github.com/robbyrussell/oh-my-zsh.git $user_dir/.oh-my-zsh
git clone https://github.com/robbyrussell/oh-my-zsh.git $user_dir/.oh-my-zsh/plugins/zsh-syntax-highlighting
git clone https://github.com/rochappy/docker-alias.git $user_dir/.oh-my-zsh/plugins/docker-alias

# Install vundle
rm $user_dir/.vimrc
rm -rf $user_dir/.vim/bundle/vundle
curl -L https://raw.github.com/rochappy/tools/master/settings/.vimrc > $user_dir/.vimrc
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
curl -L https://raw.githubusercontent.com/rochappy/tools/master/settings/roc.zsh-theme > $user_dir/.oh-my-zsh/themes/roc.zsh-theme
curl -L https://raw.github.com/rochappy/tools/master/settings/.zshrc > $user_dir/.zshrc
curl -L https://raw.github.com/rochappy/tools/master/settings/.alias > $user_dir/.alias
curl -L https://raw.github.com/rochappy/tools/master/settings/.npmrc > $user_dir/.npmrc
curl -L https://raw.githubusercontent.com/rochappy/tools/master/settings/.gitconfig > $user_dir/.gitconfig

# change owner
chown -Rf $user:$user $user_dir

sudo chsh -s /bin/zsh $user
source $user_dir/.zshrc
