#!/bin/bash

PACKINSTALL=""
installpackages () {
  SUDO=""
  if [[ $EUID -ne 0 ]]; then
    printf "Not running as root, trying sudo\n"
    SUDO="sudo"
  fi
  ${SUDO} apt update
  ${SUDO} apt install --yes \
  vim \
  stow \
  iperf3 \
  tree \
  ncdu \
  git \
  dnsutils \
  stow \
  man
}

while [ "$1" != "" ] ; do
  case $1 in
    -i) shift; PACKINSTALL="true";;
    -?) echo "Error: Invalid option '${1}'" && exit;;
  esac
  shift
done

if [ "${PACKINSTALL}" == "true" ]; then
  echo "Installing packages"
  installpackages 
else
  echo "Not installing packages"
fi

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
