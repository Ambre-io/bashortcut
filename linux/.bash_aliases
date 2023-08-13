#!/bin/bash

# ¯\_(ツ)_/¯
alias oops="more ${BASHORTCUT_LINUX_DIR}/.bash_aliases"
alias gba="gedit ${BASHORTCUT_LINUX_DIR}/.bash_aliases &"
alias gbpycharm="pycharm.sh ${BASHORTCUT_LINUX_DIR}/.bash_aliases &"
alias gbprofile="gedit ${BASHORTCUT_LINUX_DIR}/.bash_profile &"


########################################
# * OS
########################################

alias src="source ${HOME}/.bashrc"
alias ls="ls -a --color"
alias l="ls -lAh --color"
alias g="grep -e"
alias h="history"
alias c="clear"
alias e="exit"
alias sag="sudo apt-get"
alias sagi="sag install"
alias sagr="sag remove"
alias sagar="sag autoremove"
alias sagac="sag autoclean"
alias sagu="sag update"
alias psg="ps -edf | g"
alias k="kill -9"
alias n="ss -ntupl"
function np(){ sudo lsof -i ":${1}" ; }
alias np=np

function histogrep(){
    if [[ ${#} -lt 1 ]]; then
        h
    else
	    h | g "${1}";
	fi
}
alias hg=histogrep

function histocount(){
	if [ "${1}" = "date" ]; then
		history | awk '{c[$2]++}END{for (x in c) print c[x],x | "sort -n"}'
	else
		history | awk '{c[$4]++}END{for (x in c) print c[x],x | "sort -n"}'
	fi
}
alias hc=histocount

function ffind(){
	if [ ${#} -lt 1 ]; then
		echo "Error: patternname could not be empty"
		echo "Use: ffind <patternname> [<path>]"
		echo "1 parameter: find / -type f -name <patternname> -print"
		echo "2 parameters: find <path> -type f -name <patternname> -print"
	elif [ ${#} -lt 2 ]; then
		find / -type f -name "${1}" -print
	else
		find "${2}" -type f -name "${1}" -print
	fi
}
alias ffind=ffind

########################################
# * Libs
########################################

alias clrimg="exiftool -all="

########################################
# * TMUX
########################################

alias tsrc="tmux source-file .tmux.conf"
alias ta="tmux attach"
alias tks="tmux kill-session -t"
alias tkss="tmux kill-server"

alias tls="tmux list-session"
alias txns="tmux new-session -s $1"
alias txad="tmux attach -d -t $1"
alias tx="txns || txad"


########################################
# * GIT
########################################

# Actions
alias gst="git status"
alias gd="git diff"
alias ga="git add"
alias gagst="git add . && gst"
alias gcam="git commit -am"
alias gcm="git commit -m"
alias gca="git commit --amend"
alias gp="git push"
alias gl="git log --pretty=oneline"
alias glg="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
alias gbl="git branch -a"
alias grl="git remote -v"
alias gfp="git fetch --prune"
alias greset="git reset HEAD"
alias m="git diff --shortstat"
alias gfa="gagst && gca && gp -f"

# Config
alias gcl="git config --list"
alias gcg="git config --global"
alias gcuname="gcg user.name"
alias gcuemail="gcg user.email"

# Delete local and remote branch
function gbd(){
	if [[ ${#} -lt 1 ]]; then
		echo "Use: gbd <branch name>"
	else
		read -p "Confirm you delete the branch ${1} (y/n): " CONFIRM
		if [ "${CONFIRM}" = "y" || "${CONFIRM}" = "ye" || "${CONFIRM}" = "yes" ]; then
			git branch -D ${1}
			gp origin --delete ${1}
		fi
	fi
}
alias gbd=gbd


########################################
# * POSTGRESQL
########################################

# see: https://wiki.debian.org/PostgreSql

alias pguser="sudo -u postgres bash"
alias adminpg="sudo -u adminpg bash"

########################################
# * PYTHON
########################################

alias d="deactivate"

alias p="python3"
alias zen="p -c 'import this'"


########################################
# * DJANGO
########################################

# Setup DJANGO_PATH in a tmux session script

alias pm='p ${DJANGO_PATH}/src/manage.py'
alias pmr='p ${DJANGO_PATH}/src/manage.py runserver'
alias pmm='p ${DJANGO_PATH}/src/manage.py migrate'
alias pms='p ${DJANGO_PATH}/src/manage.py shell_plus'

alias pipf="pip freeze"

function djuml(){
    if [ -z "$1" ]; then
        echo -e "Use: djuml [all] for the entire UML\ndjuml [app1 ... appn] for certain app\nfollowing by the png name, like: djuml money notifications moneynotif-uml";
    elif [ "$1" = "all" ]; then
        ${DJANGO_PATH}/src/manage.py graph_models -a -g -o $HOME/all.png
    else
        ${DJANGO_PATH}/src/manage.py graph_models ${*} -o $HOME/choice.png
    fi
}

alias djuml=djuml


########################################
# * NODE
########################################

alias nvml="nvm list"

alias npms="npm start"


########################################
# * DOCKER
########################################
alias dcversion="docker version"
alias dcinfo="docker info"

alias dcr="docker run"  # -rm (del after), -d (detached), -name, -e (env)
alias dcri="docker run -it"
alias dcps="docker ps"  # -a (stopped), -q (id)
alias dcpsa="docker ps -a"
alias dcins="docker inspect"
alias dcrs="docker restart"
alias dcs="docker stop"
alias dcrm="docker rm"
function dcsrm() {
	dcs "${@}" && dcrm "${@}"
}
alias dcsrm=dcsrm
alias dci="docker images"
alias dcrmi="docker rmi"
alias dcl="docker logs -f"

# Build an image
alias dccb="docker compose build"

# Up on or multiple service container 
alias dccup="docker compose --verbose up"

# Down every service in a docker-compose file
alias dccdown="docker compose down"

# Network
alias dcnet="docker network ls"
alias dcneti="docker network inspect"
alias dcnetrm="docker network rm"

function dcnetcreate() {
    if [ "${#}" -lt 1 ]; then
        echo "Use: docker network create <network>"
    else
	    docker network create "${1}"
	fi
}
alias dcnetcreate=dcnetcreate

function dcnetconnect() {
    if [ "${#}" -lt 2 ]; then
        echo "Use: docker network connect <network> <container>"
    else
	    docker network connect "${1}" "${2}"
	fi
}
alias dcnetconnect=dcnetconnect

function dcip() {
    if [ "${#}" -lt 1 ]; then
        echo "Use: docker inspect <container>"
    else
	    docker inspect "${1}" | awk '/IPAddress/ {if ($2 != "null,")  print $2 }' | uniq | awk -F \" '{print $2}'
	fi
}
alias dcip=dcip

# Volumes
alias dcv="docker volume ls"
alias dcvi="docker volume inspect"
alias dcvrm="docker volume rm"

function dcrunv() {
    if [ "${#}" -lt 2 ]; then
        echo "Use: docker run -v </local/path or volume:/container/path> <image>"
    else
	    docker run -v "${1}" "${2}"
	fi
}
alias dcrunv=dcrunv

function dcvolume() {
    if [ "${#}" -lt 1 ]; then
        echo "Use: docker volume create -d local <volume>"
    else
        docker volume create -d local "${1}"
        docker volume ls
	fi
}
alias dcvolume=dcvolume

# Execution
function dcec() {
    if [ "${#}" -lt 2 ]; then
        echo "Use: docker exec <container> <command>"
    else
        docker exec "${@}"
	fi
}
alias dcec=dcec

function dcei() {
    if [ "${#}" -lt 1 ]; then
        echo "Use: docker exec -it <container> bash"
    elif [ "${#}" -lt 2 ]; then
        docker exec -it "${1}" bash
    else
        docker exec -it "${@}"
	fi
}
alias dcei=dcei

# Container to image
function dccti() {
    if [ "${#}" -lt 2 ]; then
        echo "Use: docker commit <container> <image:tag>" # then docker run <image:tag>
    else
        docker commit "${1}" "${2}"
	fi
}
alias dccti=dccti
