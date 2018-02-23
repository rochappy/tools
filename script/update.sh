#!/bin/sh

echo "\n"
for dir in $(ls -d */)
do
  cd $dir
  if [ -d ".git" ]; then
    echo "\033[36m目录${dir%/*}:\033[0m"
    echo "\033[33m********** 更新开始 ********** \033[0m"
    git stash clear
    git stash
    git pull --rebase
    git stash pop
    echo "\033[33m********** 更新结束 ********** \033[0m"
    echo "\n"
  fi
  cd ..
done