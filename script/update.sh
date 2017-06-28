#!/bin/sh
for dir in $(ls -d */)
do
  cd $dir
  echo "$dir 更新开始..."
  if [ -d ".git" ]; then
     git pull
     echo "$dir 更新完成！"
  elif [ -d ".svn" ]; then
     svn update
  fi
  cd ..
done
