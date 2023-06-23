#!/bin/bash

## Check if env vars exist, set them if not
if [[ -z $PATH ]] ; then
	export PATH=''
fi

if [[ -z $LD_LIBRARY_PATH ]] ; then
	export LD_LIBRARY_PATH=''
fi

if [[ -z $INFOPATH ]] ; then
	export INFOPATH=''
fi

if [[ -z $PKG_CONFIG_PATH ]] ; then
	export MANPATH=':'
fi

if [[ -z $PKG_CONFIG_PATH ]] ; then
	export PKG_CONFIG_PATH=''
fi


## OPTIONAL: set the TERM env var
if [[ -z $TERM ]] ; then 
	export TERM="xterm"
fi

if [[ -z $TERMINAL ]] ; then 
	export TERMINAL="xterm"
fi

if [[ -z $COLORTERM ]] ; then 
	export COLORTERM="gnome-terminal"
fi

## echo the current bash version
#echo "Bash version ${BASH_VERSION}..."

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

## Setup the color vars
red="\[\033[01;31m\]"
green="\[\033[00;32m\]"
greenb="\[\033[01;32m\]"
yellow="%{\033[1;33m%}"
blue="\[\033[01;34m\]"
magenta="\[\033[01;35m\]"
cyan="\[\033[01;36m\]"
white="\[\033[00;37m\]"
black="\[\033[01;30m\]"
end="\[\033[00m\]" # This is needed at the end... :(

## use a custom PS1 prompt
#PS1='${debian_chroot:+($debian_chroot)}${greenb}\u@\h${end}:${blue}\W${end}\$ '
# export PS1='\[\033[01;32m\] \u@\h \[\033[00m\]: \[\033[01;34m\]\W\[\033[00m\]\$ '
# export PS1="${green}\u@\h${end}: ${blue}\W${end}\$ "
export PS1="${green}\u@\h${end}:${blue}\W\$${end}"

## unset the color vars
unset red green greenb yellow blue magenta cyan white black end

## enable color support of ls and also add handy aliases
if [[ "$TERM" != "dumb" ]] ; then
    eval "`dircolors -b`"
    alias ls='ls --color=auto'
fi

## get the scriptpath
scriptpath=$(echo "$BASH_SOURCE" | xargs readlink -m | xargs dirname)

### source some config files ###

## Source the alias config file, if it exists
if [[ -f ${scriptpath}/.bash_aliases ]] ; then 
	source ${scriptpath}/.bash_aliases
fi

## Source the .bash_complete file for some custom autocomplete optons, if it exists
if [[ -f ${scriptpath}/.bash_complete ]] ; then 
	source ${scriptpath}/.bash_complete
fi

## add the ~/bin to the paths env var
export PATH="${HOME}/bin:${PATH}"

## uniquify paths (inplace)
export PATH=`echo $PATH | awk -F ":" '{for (i=1; i<=NF ; i++) {print $i} }' | xargs -n1 | cat -n | sort -uk2 | sort -nk1 | cut -f2- | xargs | sed -e 's/ /:/g'`
export LD_LIBRARY_PATH=`echo $LD_LIBRARY_PATH | awk -F ":" '{for (i=1; i<=NF ; i++) {print $i} }' | xargs -n1 | cat -n | sort -uk2 | sort -nk1 | cut -f2- | xargs | sed -e 's/ /:/g'`
export MANPATH=`echo $MANPATH | awk -F ":" '{for (i=1; i<=NF ; i++) {print $i} }' | xargs -n1 | cat -n | sort -uk2 | sort -nk1 | cut -f2- | xargs | sed -e 's/ /:/g'`

## fix to allow for the default manpath
export MANPATH=":${MANPATH}"

## HACK: add a mount -a to manually mount partitions from the /etc/fstab file, until /etc/wsl.config starts working
#sudo mount -a