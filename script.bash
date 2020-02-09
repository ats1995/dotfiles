#!/bin/bash
#sudo apt install --yes \
#vim \
#stow \
#iperf3 \
#tree \
#ncdu \
#git \
#man

if [ ! -d ~/bak.dotfiles ]; then
    mkdir ~/bak.dotfiles
    echo 'created bak.dotfiles'
fi
declare -a arr=(".bashrc"
                ".bash_aliases"
                ".inputrc"
                ".screenrc"
                ".test"
                ".toprc"
                ".vimrc"
                ".vim"
                ".config/youtube-dl/config"
                )
for i in "${arr[@]}"
do
    if [ -L ~/$i ]; then
        rm ~/$i
        echo "removed symlink $i"
    fi
    if [ -f ~/$i ] ; then
        mv ~/$i ~/bak.dotfiles
        echo "moved file $i"
    elif [ -d ~/$i ] ; then
        mv ~/$i ~/bak.dotfiles
        echo "moved directory $i"
    fi
done
stow -d ~/dotfiles/ -t ~/ \
  bash \
  screen \
  top  \
  vim \
  youtube-dl
echo 'stowed dotfiles'
source ~/.bashrc
