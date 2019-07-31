#!/bin/bash
sudo apt install --yes \
vim \
stow \
iperf3 \
tree \
ncdu \
git

if [ ! -d ~/bak.dotfiles ]; then
    mkdir ~/bak.dotfiles
    echo 'created bak.dotfiles'
fi
declare -a arr=(".bashrc"
                ".bash_aliases"
                ".inputrc"
                ".test"
                ".toprc"
                ".vimrc"
                ".vim"
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
top  \
vim
echo 'stowed dotfiles'
