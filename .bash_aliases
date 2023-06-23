#!/bin/bash

### Aliases ###

## FIX: cd was setup to alawys change the prompt
# isaliassed=`alias -p | grep cd=`
# if [[ $isaliassed ]] ; then
	# unalias cd
# fi

## remove all previous aliases
unalias -a

## Set the aliases
alias ls="ls -h --group-directories-first --color=always"
alias cls="clear -x; ls --color=always"
alias ll="ls -lh"
alias lla="ls -Alh"
alias lsa="ls -Ah"

alias cd..="cd .."
alias cd.="cd .."

alias mkdir="mkdir -pv"
alias cp="cp -rdv"
alias rm="rm -rdvf"
alias ln="ln -s"

alias du="du -sh"
alias df="df -h"
alias h="history"

alias ssh="ssh -X"
alias scp="scp -r"
alias su="su -"

alias tree="tree -a --dirsfirst"

#alias diff="git diff --no-index -w"
alias diff="diff -swuB --color=auto"

alias watch="watch -c"
#alias quota="quota -sv"

## hack to enable aliases for sudo
alias sudo="sudo "

## file editors aliases
alias g="gedit"
alias s="source"
alias e="evince"
alias v="gvim"
#alias vim="gvim"

## gitk all alias
alias gitk="gitk --all"

## grep options 
grepopts="--color=auto -is"
#grepopts=""

## grep aliases
#export grepopts="$grepopts"
alias grep="grep $grepopts"

## git alias
alias mergebranches="git switch devops ; echo master develop recette | xargs -n1 | xargs -I {} bash -c 'git switch {} ; git rebase  devops --autostash ; git switch devops'"
#alias git_pushall="git fetch && git status && git remote | xargs -L1 git push --all"

## wsl aliases
alias g="/mnt/c/Program\ Files/Notepad++/notepad++.exe"

## winget alias
alias winget="winget.exe"

## line editing
export EDITOR="vim"
#export EDITOR="gedit"
export VISUAL=${EDITOR}

## autocomplete options
if [[ $- =~ i ]] ; then
	bind "set show-all-if-ambiguous on"
	bind "set show-all-if-unmodified on"
	bind "set completion-ignore-case on"
	bind "set completion-map-case on"
	bind "set colored-completion-prefix on"
	bind "set colored-stats on"
	bind "set bell-style none"
	bind "set editing-mode emacs"
fi

## other options
stty erase ^?
bind '"\e[3~": delete-char'
bind '"\e[1;5C": forward-word'
bind '"\e[1;5D": backward-word'
bind '"\e[1;2A": shift-up'
bind '"\e[1;2B": shift-down'

## setup mailx mailto
#export MALITO="adrian.mihai.iordache@gmail.com"
#export MALITO="miordache@adentis.fr"
#export MALITO="mihai.iordache@cea.fr"

### wslg display hack ###
if [[ -e "/tmp/.X11-unix" && -L "/tmp/.X11-unix" ]]; then
	# echo "x11-unix"
	sudo rm -rfv /tmp/.X11-unix >/dev/null
	ln -sv /mnt/wslg/.X11-unix /tmp/.X11-unix >/dev/null
fi

### path variables ###

## add notepad++ path to the path variable
export PATH="${PATH}:/mnt/c/Program\ Files/Notepad++/"
#export PATH="/mnt/c/Program\ Files/Notepad++:${PATH}"

## general path variables
export PATH="${PATH}:${HOME}/bin"
#export PATH="${PATH}:${HOME}/work/tools/"
#export LD_LIBRARY_PATH="${HOME}/work/tools/lib:${LD_LIBRARY_PATH}"

## cd to the home directory / custom directory
#workdir="$HOME"
#cd $workdir

## docker serve alias
#docker_serve="docker serve --address unix:///home/mihai/.docker/run/docker-cli-api.sock"

## save the ip adress
#export DISTRO_DNS=$(cat /etc/resolv.conf | grep nameserver | awk '{print $2}' 2>/dev/null)
#export ip_wsl=$(cat /etc/resolv.conf | awk '/nameserver/ {print $2}')
#export ip_external=$(host myip.opendns.com resolver1.opendns.com | awk 'END {print $NF}')
#export ip_freebox=$(cat /etc/hosts | awk '/freebox/ {print $1}')
#export ip_ubuntu=$(ifconfig eth0 | awk '/inet / {print $2}')
#export ip_windows=$(netsh.exe interface ip show config name="Wifi 3" | awk '/IP Address:/ {print $3}')

### ls colors ###

## LS_COLORS file fix 
#export LS_COLORS="fi=01;30:$LS_COLORS"

### display ###
#set host="`hostname`"
#set hosts="grenx01 grenx02 grenx03 grenx04"
#echo "host: $host | hosts: $hosts"

#export DISPLAY=$(awk '/nameserver / {print $2}' /etc/resolv.conf 2>/dev/null):0.0
#export DISPLAY=$(cat /etc/resolv.conf | grep nameserver | awk '{print $2}' 2>/dev/null):0.0
#export LIBGL_ALWAYS_INDIRECT=1
#export $(dbus-launch)

#if ( "${hosts}" =~ "*${host}*" ) then
#	echo "Host is one of the grenx machines."
#else
#	echo "Host is not one of the grenx machines."
#	export DISPLAY=:0
#endif
