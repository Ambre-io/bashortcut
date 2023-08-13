#! /bin/bash -e

cat <<EOF

# # # # # # # # # # # # # # # # # # # # # # # #
#          SETUP LINUX BASHORTCUT             #
# # # # # # # # # # # # # # # # # # # # # # # #

EOF

########################################
# INCLUDE PATHS
########################################
SETUP=$(command -v -- "${0}")
echo "SETUP.SH: SETUP=${SETUP}"
SETUPPATH=$(cd -P -- "$(dirname -- "${SETUP}")" && pwd -P)
#SETUPPATH="${0}"
echo "SETUP.SH: SETUPPATH=${SETUPPATH}"
[ ! -f "${SETUPPATH}" ] && echo "File ${SETUPPATH} DOES NOT exists." && exit 1

PATHS="${SETUPPATH}/linux/paths"
echo "SETUP.SH: PATHS=${PATHS}"
[ ! -f "${PATHS}" ] && echo "File ${PATHS} DOES NOT exists." exit 1

. PATHS

[ ! -d "${BASHORTCUT_PROJECTS_DIR}" ] && mkdir -p "${HOME}/Projects"
[ ! -f "${BASHRC}" ] && echo "Creating file ${BASHRC}" && echo "#! /bin/bash -e" >>"${BASHRC}"

########################################
# INSTALL UTILS
########################################

[ ! -x "$(command -v git)" ] && sudo apt install git
[ ! -x "$(command -v tmux)" ] && sudo apt install tmux

read -p "Do you want to install gedit? (y/n) " -n 1 -r
if [[ ${REPLY} =~ ^[Yy]$ ]]; then
    sudo apt install gedit
fi

########################################
# INSTALL DOCKER
########################################

if ! systemctl is-active --quiet docker; then
    read -p "Do you want to install docker? (y/n) " -n 1 -r
    if [[ ${REPLY} =~ ^[Yy]$ ]]; then
        echo "Docker Engine repository preparation & installation"
        echo "Maybe you should look if something change here: https://docs.docker.com/engine/install/ubuntu/"
        sudo apt-get install ca-certificates curl gnupg
        sudo mkdir -m 0755 -p /etc/apt/keyrings
        curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
        echo \
            "deb [arch=\"$(dpkg --print-architecture)\" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
            \"$(. /etc/os-release && echo "$VERSION_CODENAME")\" stable" | \
            sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
        if { sudo apt-get update 2>&1 || echo E: update failed; } | grep -q '^[WE]:'; then
            sudo chmod a+r /etc/apt/keyrings/docker.gpg
            sudo apt-get update
        fi

        sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
        sudo usermod -aG docker "${USER}"
	fi
fi

########################################
# TMUX CONFIGURATION LINK
########################################

cat <<EOF
=> Creating Tmux link
+ ${TMUXCONF_TARGET} -> ${TMUXCONF_SOURCE}

EOF

# Creating symlinks
ln -s "${TMUXCONF_SOURCE}" "${TMUXCONF_TARGET}"

########################################
# NOTES FILE
########################################

echo "Create the notes file"
touch "${HOME}/notes"

########################################
# MAIN LINK IN .bashrc
########################################

echo "=> .bashrc writing (extended if exists)"

cat <<EOF >>"${BASHRC}"
#@@
if [ -f "${BASH_PROFILE}" ]; then
    . "${BASH_PROFILE}"
fi
#@@@

EOF


echo "=> Sourcing"
# shellcheck source=${HOME}/.bashrc
source "${BASHRC}"

echo "Nice!"
