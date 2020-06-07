#!/bin/bash
#sudo apt install --yes \
#vim \
#stow \
#iperf3 \
#tree \
#ncdu \
#git \
#dnsutlis \
#stow \
#man

DATE=$(date "+%Y-%m-%d_%H%M%S-%Z")

if [ ! -d ~/bak.dotfiles ]; then
    mkdir ~/bak.dotfiles
    echo 'created bak.dotfiles'
fi
declare -a arr=(".bashrc"
                ".bash_aliases"
                ".inputrc"
                ".screenrc"
                ".toprc"
                ".vimrc"
                ".vim"
                ".digrc"
                ".config/youtube-dl/config"
                )
for i in "${arr[@]}"
do
    if [ -L ~/$i ]; then
        rm ~/$i
        echo "removed symlink $i"
    elif [ -f ~/$i ] ; then
        mv ~/$i ~/bak.dotfiles
        echo "moved file $i"
    fi
done
stow -d ~/dotfiles/ -t ~/ \
  bash \
  screen \
  top  \
  vim \
  dig \
  youtube-dl
echo 'stowed dotfiles'
source ~/.bashrc
