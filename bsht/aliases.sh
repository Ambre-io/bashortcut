#!/bin/bash

# ¯\_(ツ)_/¯
alias oops='cat ${BASHORTCUT_BSHT_DIR}/aliases.sh'
alias gba='gedit ${BASHORTCUT_BSHT_DIR}/aliases.sh &'
alias gbpycharm='pycharm.sh ${BASHORTCUT_BSHT_DIR}/aliases.sh &'
alias gbprofile='gedit ${BASHORTCUT_BSHT_DIR}/profile.sh &'


########################################
# * OS
########################################
alias src='source ${HOME}/.bashrc'
alias ls="ls -a --color"
alias l="ls -lAh --color"
alias g="grep -e"
alias h="history"
alias c="clear"
alias e="exit"
alias psg="ps -edf | g"
alias k="kill -9"
function np() { sudo lsof -i ":${1}" ; }
alias np=np
alias hg="history | grep -e"
alias lg="ls -lAh --color | grep -e"

function histocount() {
	if [ "${1}" = "date" ]; then
		history | awk '{c[$2]++}END{for (x in c) print c[x],x | "sort -n"}'
	else
		history | awk '{c[$4]++}END{for (x in c) print c[x],x | "sort -n"}'
	fi
}
alias hc=histocount

function ffind() {
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

function v() {
    volume_file="${HOME}/.Xmodmap"
    if [ -f "${volume_file}" ]; then
        xmodmap "${volume_file}"
    else
        echo "xmodmap not configured"
    fi
}
alias v=v

########################################
# * Network
########################################
alias n="ss -ntupl"
alias ng="ss -ntupl|grep"
alias i="ip a"
# sudo systemctl restart systemd-networkd.service
# sudo systemctl restart NetworkManager
# sudo nmcli networking off/on

########################################
# * TMUX
########################################
alias tsrc="tmux source-file .tmux.conf"
alias ta="tmux attach"
alias tks="tmux kill-session"
alias tkss="tmux kill-server"

alias tls="tmux list-session"
alias txns="tmux new-session -s"
alias txad="tmux attach -d -t"
alias tx="txns || txad"

########################################
# * GIT
########################################
alias gst="git status"
alias gd="git diff"
alias ga="git add"
alias gagst="git add . && gst"
alias grs="git restore --staged"
alias gcam="git commit -am"
alias gcm="git commit -m"
alias gca="git commit --amend"
alias gp="git push"
alias gl="git log --pretty=oneline"
alias glg="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
alias gbl="git branch -a"
alias grl="git remote -v"
alias gfp="git fetch --prune"
alias gds="git diff --shortstat"
alias gpt="git push --tags"
function gt() {
	if [[ ${#} -lt 2 ]]; then
		echo "Use: gt <version, e.g.: v1.0.0> <message>"
	else
		git tag -a "${1}" -m "${2}"
	fi
}
alias gt=gt
function gtd() {
	if [[ ${#} -lt 1 ]]; then
		echo "Use: gtd <tag to delete>"
	else
		read -p "Confirm you want to delete the tag ${1} (y/n): " -r CONFIRM
		if [[ "${CONFIRM}" == "y" || "${CONFIRM}" == "ye" || "${CONFIRM}" == "yes" ]]; then
			git tag -d "${1}"
			git push --delete origin "${1}"
		fi
	fi
}
alias gtd=gtd

# Config
alias gcl="git config --list"
alias gcg="git config --global"
alias gcuname="gcg user.name"
alias gcuemail="gcg user.email"

# Delete local and remote branch
function gbd() {
	if [[ ${#} -lt 1 ]]; then
		echo "Use: gbd <branch name>"
	else
		read -p "Confirm you want to delete the branch ${1} (y/n): " -r CONFIRM
		if [[ "${CONFIRM}" == "y" || "${CONFIRM}" == "ye" || "${CONFIRM}" == "yes" ]]; then
			git branch -D "${1}"
			git push --delete origin "${1}"
		fi
	fi
}
alias gbd=gbd

########################################
# * DOCKER
########################################
alias dcversion="docker version"
alias dcinfo="docker info"
alias dcr="docker run"  # -rm (del after), -d (detached), -name, -e (env)
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
alias dcirm="docker rmi"
alias dcl="docker logs -f"
alias dce="docker exec"
alias dcsysprune="docker system prune"  # clean

# * DOCKER COMPOSE
alias dcc="docker compose --verbose"
alias dccbuild="dcc build"  # Build an image
alias dccup="dcc up"  # Up on one or multiple service container
alias dccdown="dcc down"  # Down every service in a docker-compose file

# TODO do it in a proper way with command args (-f) and maybe autocompletion...

function dccbuildf() {
    if [ "${#}" -lt 1 ]; then
        echo "Use: dccbuildf <docker-compose.dev.yml> [build options]"
    else
        docker compose --verbose -f "${1}" build "${@:2}"
	fi
}
alias dccbuildf=dccbuildf
function dccupf() {
    if [ "${#}" -lt 1 ]; then
        echo "Use: dccupf <docker-compose.dev.yml> [up options]"
    else
        docker compose --verbose -f "${1}" up "${@:2}"
	fi
}
alias dccupf=dccupf
function dccdownf() {
    if [ "${#}" -lt 1 ]; then
        echo "Use: dccupf <docker-compose.dev.yml> [down options]"
    else
        docker compose --verbose -f "${1}" down "${@:2}"
	fi
}
alias dccdownf=dccdownf

# * DOCKER RUN
function dcri() {
    if [ "${#}" -lt 1 ]; then
        echo "Use: docker run -it <image> bash"
    elif [ "${#}" -lt 2 ]; then
        dcr -it "${1}" bash
    else
        dcr -it "${@}"
	fi
}
alias dcri=dcri

# * DOCKER EXEC
function dcei() {
    if [ "${#}" -lt 1 ]; then
        echo "Use: docker exec -it <container> bash"
    elif [ "${#}" -lt 2 ]; then
        if ! docker exec -it "${1}" bash; then
	    docker exec -it "${1}" ash
        fi
    else
        docker exec -it "${@}"
    fi
}
alias dcei=dcei

# DOCKER CHAINED
function dccreload() {
    if [ "${#}" -lt 1 ]; then
        echo "Use: dccreload <container> [docker-compose file] [build options like --no-cache]"
    else
        # args
        local container="${1}"
        local compose_file="${2:-docker-compose.yml}"
        local build_options="${*:3}"

        # remove the container
        dcsrm "${container}"
        # rebuild
        if [ -n "${build_options}" ]; then
            dccbuildf "${compose_file}" "${build_options}"
        else
            dccbuildf "${compose_file}"
        fi
        # reup
        dccupf "${compose_file}" -d
        # display logs
        dcl "${container}"
    fi
}
alias dccreload=dccreload

# * DOCKER NETWORK
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

# * DOCKER VOLUME
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

# * DOCKER INSPECT
function dcip() {
    if [ "${#}" -lt 1 ]; then
        echo "Use: docker inspect <container>"
    else
	    docker inspect "${1}" | awk '/IPAddress/ {if ($2 != "null,")  print $2 }' | uniq | awk -F \" '{print $2}'
	fi
}
alias dcip=dcip

# * DOCKER COMMIT
function dccti() {
    if [ "${#}" -lt 2 ]; then
        echo "Use: docker commit <container> <image:tag>" # then docker run <image:tag>
    else
        docker commit "${1}" "${2}"
	fi
}
alias dccti=dccti

########################################
# * Redis
########################################
function redisall() {
	REDISCLI=$(redis.cli -v)
	if [[ "${REDISCLI}" != *"redis-cli"* ]]; then
		echo "You should install the redis cli first: https://redis.io/docs/getting-started/"
	else
		for i in $(redis.cli KEYS '*'); do echo "${i} \"$(redis.cli GET "${i}")\""; done
	fi
}
alias redisall=redisall


########################################
# * NODE
########################################
alias nvml="nvm list"
alias npmi="npm i"  # install
alias npmstart="npm start"
alias npmdevelop="npm run develop"
alias npmdev="npm run dev"
alias npmbuild="npm run build"
alias npmcompile="npm run compile"
alias npmclean="npm run clean"
alias npmserve="npm run serve"
alias npmtypecheck="npm run typecheck"

########################################
# * POSTGRESQL
########################################
# see: https://wiki.debian.org/PostgreSql
alias pguser="sudo -u postgres bash"
alias adminpg="sudo -u adminpg bash"

########################################
# * PYTHON
########################################
alias a="source venv/bin/activate"
alias d="deactivate"
alias p="python3"
alias zen="p -c 'import this'"

#pp [pip]
alias ppl="pip list --outdated"
alias ppupgradeall="pip3 list -o | cut -f1 -d' ' | tr \" \" \"\n\" | awk '{if(NR>=3)print}' | cut -d' ' -f1 | xargs -n1 pip3 install -U"
alias ppfreezer="pip freeze > requirements.txt"
alias ppi="pip install -r requirements.txt"

#ppv [pipenv]
alias ppvg="pipenv graph"
alias ppvip="pipenv run pip install"
alias ppvi="pipenv install -r requirements.txt"

alias ppvup="ppl && ppupgradeall && ppfreezer && ppvi" # equivalent to 'ncu -u' (npm-check-update to upgrade every packages)

########################################
# * DJANGO
########################################
# Setup DJANGO_PATH in a tmux session script
alias pm='p ${DJANGO_PATH}/src/manage.py'
alias pmr='p ${DJANGO_PATH}/src/manage.py runserver'
alias pmm='p ${DJANGO_PATH}/src/manage.py migrate'
alias pms='p ${DJANGO_PATH}/src/manage.py shell_plus'

alias pipf="pip freeze"

function djuml() {
    if [ -z "$1" ]; then
        echo -e "Use: djuml [all] for the entire UML\ndjuml [app1 ... appn] for certain app\nfollowing by the png name, like: djuml money notifications moneynotif-uml";
    elif [ "$1" = "all" ]; then
        "${DJANGO_PATH}"/src/manage.py graph_models -a -g -o "${HOME}/all.png"
    else
        "${DJANGO_PATH}"/src/manage.py graph_models "${*}" -o "${HOME}/choice.png"
    fi
}

alias djuml=djuml

########################################
# * exiftool
########################################
alias clrimg="exiftool -all="

########################################
# * ^^
########################################
function oeoe() {
    if [ "${#}" -lt 1 ]; then
        echo "it's: ^^"
    else
        echo "it's: ${*} :)"
    fi
}
alias oeoe=oeoe
