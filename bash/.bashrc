# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# include files and directories staring with .
shopt -s dotglob

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=100000
HISTFILESIZE=500000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# Trims path im promt to include <number> of dirs
PROMPT_DIRTRIM=0

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

RESET="\[\017\]"
NORMAL="\[\033[0m\]"
RED="\[\033[31;1m\]"
YELLOW="\[\033[33;1m\]"
WHITE="\[\033[37;1m\]"
DIMWHITE="\[\033[37;2m\]"
GREEN="\[\033[32;1m\]"
DARK="\[\033[2m\]"
CYAN="\[\033[36;1m\]"
SMILEY="${DARK}:|${NORMAL}"
FROWNY="${RED}:\$${NORMAL}"
SELECT="if [ \$? = 0 ]; then echo \"${SMILEY}\"; else echo \"${FROWNY}\"; fi"

# Throw it all together 
#PS1="${RESET}${GREEN}\u${NORMAL}@${YELLOW}\h${NORMAL} \`${SELECT}\` "

if [ "$(hostname)" = 'hodepute' ]; then
#    PS1="${RESET}${GREEN}\u${NORMAL}@${GREEN}\h \[\033[2m\]\w ${NORMAL}\`${SELECT}\` "
    PS1="┌[${RESET}${GREEN}\u${NORMAL}@${GREEN}\h${NORMAL}:${GREEN}${DARK}\w${NORMAL}]─[\t]\n└─╼ \`${SELECT}\` "
elif [ "$(hostname)" = 'StudyPad' ]; then
    PS1="┌[${RESET}${RED}\u${NORMAL}@${RED}\h${NORMAL}:${GREEN}${DARK}\w${NORMAL}]─[\t]\n└─╼ \`${SELECT}\` "
elif [ "$(hostname)" = 'hjorne-skap' ]; then
    PS1="${RESET}${GREEN}\u${NORMAL}@${RED}\h \[\033[2m\]\w ${NORMAL}\`${SELECT}\` "
elif [ "$(hostname)" = 'localhost' ]; then # limbo
    PS1="${RESET}${GREEN}\u${NORMAL}@${CYAN}\h \[\033[2m\]\w ${NORMAL}\`${SELECT}\` "
elif [ "$(hostname)" = 'vuserv' ]; then
#    PS1="${RESET}${GREEN}\u${NORMAL}@${YELLOW}\h \[\033[2m\]\w ${NORMAL}\`${SELECT}\` "
    # Lawrence Systems' Toms prompt
    PS1="\[\033[0;31m\]\342\224\214\342\224\200\$([[ \$? != 0 ]] && echo \"[\[\033[0;31m\]\342\234\227\[\033[0;37m\]]\342\224\200\")[$(if [[ ${EUID} == 0 ]]; then echo '\[\033[01;31m\]root\[\033[01;33m\]@\[\033[01;96m\]\h'; else echo "${GREEN}\u${RESET}@${YELLOW}\h"; fi)\[\033[0;31m\]]\342\224\200[\t]\342\224\200[\[\033[0;32m\]\w\[\033[0;31m\]]\n\[\033[0;31m\]\342\224\224\342\224\200\342\224\200\342\225\274 \[\033[0m\]\[\e[01;33m\]\\$\[\e[0m\]"
#    PS1='┌[\u@\h][\w]\n└╼ \$ '
else
    PS1="┌[\u@\h:\w]─[\t]\n└─╼ \`${SELECT}\` "
fi

unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
#alias ll='ls -alF'
#alias la='ls -A'
#alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi
[ -r /home/atspad/.byobu/prompt ] && . /home/atspad/.byobu/prompt   #byobu-prompt#

# Write history after every command
PROMPT_COMMAND='history -a'
HISTTIMEFORMAT='%F %T'
# Change the file location because certain bash sessions truncate .bash_history file upon close.
# http://superuser.com/questions/575479/bash-history-truncated-to-500-lines-on-each-login
HISTFILE=~/.bashhist

fco()
{
    find $1 -type f -print | wc -l
}

dcmp()
{
    if [ $1 = rslsync ]
    then
        docker-compose -f ${HOME}/compose-rslsync/docker-compose.yml pull resilio-sync
      # Snapshot the containers volumes.
        docker-compose -f ${HOME}/compose-rslsync/docker-compose.yml up -d
    else
        echo 'Not a known service.'
    fi
}


export EDITOR=/usr/bin/vim
if uname -r | grep --silent -i wsl; then
  export PATH=$PATH:/mnt/c/Dev/script-collection/
fi
