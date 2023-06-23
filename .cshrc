#!/bin/csh	

## Appel du cshrc commun
#source /home/gene/gene.cshrc

## Check if env vars exist, set them if not
if ( ! $?PATH ) then
	setenv PATH ''
endif

if ( ! $?LD_LIBRARY_PATH ) then
	setenv LD_LIBRARY_PATH ''
endif

if ( ! $?INFOPATH ) then
	setenv INFOPATH ''
endif

if ( ! $?PKG_CONFIG_PATH ) then
	setenv MANPATH ':'
endif

if ( ! $?PKG_CONFIG_PATH ) then
	setenv PKG_CONFIG_PATH ''
endif


## OPTIONAL: set the TERM env var
if ( ! $?TERM ) then 
	setenv TERM "xterm"
endif

if ( ! $?TERMINAL ) then 
	setenv TERMINAL "xterm"
endif

if ( ! $?COLORTERM ) then 
	setenv COLORTERM "gnome-terminal"
endif

## tcsh Colors
set red="%{\033[31m%}"
set green="%{\033[32;1m%}"
set yellow="%{\033[33m%}"
set blue="%{\033[34m%}"
set magenta="%{\033[35m%}"
set cyan="%{\033[36m%}"
set white="%{\033[37m%}"
set black="%{\033[30m%}"
set end="%{\033[0m%}"
set dollar='$'

## csh Colors
# set e="`echo x | tr x '\033'`"
# set red="${e}[31m"
# set green="${e}[32m"
# set yellow="${e}[33m"
# set blue="${e}[34m"
# set magenta="${e}[35m"
# set cyan="${e}[36m"
# set white="${e}[37m"
# set black="${e}[38m"
# set end="${e}[0m"
# set dollar='$'

## Setup a custom tcsh prompt
set prompt="${green}%n@%m${end}:${blue}%c${dollar} ${end} "

## Setup a custom csh prompt
#set prompt="${green}`id -un`@`hostname`${end}:${blue}`pwd -P | xargs basename`${dollar} ${end} "

## Clean up after ourselves
unset red green yellow blue magenta cyan yellow white end

## Load the alias config file
if (-f ~/.csh_aliases) then
	source ~/.csh_aliases
endif

## Source the .csh_complete file for some custom autocomplete optons, if it exists in the users's home directory
if (-f ~/.csh_complete) then
	source ~/.csh_complete
endif

## add the ~/bin to the paths env var
setenv PATH "${HOME}/bin:${PATH}"

## uniquify paths (inplace)
setenv PATH `echo $PATH | awk -F ":" '{for (i=1; i<=NF ; i++) {print $i} }' | xargs -n1 | cat -n | sort -uk2 | sort -nk1 | cut -f2- | xargs | sed -e 's/ /:/g'`
setenv LD_LIBRARY_PATH `echo $LD_LIBRARY_PATH | awk -F ":" '{for (i=1; i<=NF ; i++) {print $i} }' | xargs -n1 | cat -n | sort -uk2 | sort -nk1 | cut -f2- | xargs | sed -e 's/ /:/g'`
setenv MANPATH `echo $MANPATH | awk -F ":" '{for (i=1; i<=NF ; i++) {print $i} }' | xargs -n1 | cat -n | sort -uk2 | sort -nk1 | cut -f2- | xargs | sed -e 's/ /:/g'`

## fix to allow for the default manpath
setenv MANPATH ":${MANPATH}"