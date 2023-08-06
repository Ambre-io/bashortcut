#! /bin/bash -e

# # # # # # # # # # # # # # # # # # # # # # # #
#	       SETUP LINUX BASHORTCUT             #
# # # # # # # # # # # # # # # # # # # # # # # #

cat <<EOF

#########################################
*** Setting up BASHORTCUT environment ***
#########################################

EOF

# Creating the main folder
export BASHORTCUT_PROJECTS_DIR="${HOME}/Projects"
[ ! -d "${BASHORTCUT_PROJECTS_DIR}" ] && mkdir -p "${HOME}/Projects"

############################################################
# Including paths constants
############################################################

# Including: TMUXCONF_SOURCE, TMUXCONF_TARGET, BASHRC
SETUP_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
. "${SETUP_DIR}/paths"

TMUXCONF_SOURCE="${TMUXCONF_SOURCE}"
TMUXCONF_TARGET="${TMUXCONF_TARGET}"
BASHRC="${HOME}/.bashrc"

[ ! -f "${BASHRC}" ] && echo "Creating file ${BASHRC}" && echo "#! /bin/bash" >>"${BASHRC}"

command -v tmux
[ "${?}" -eq 1 ] && sudo apt-get install tmux

############################################################
# Intall Utils
############################################################

sudo apt install git tmux gedit

############################################################
# Install Docker
############################################################

systemctl is-active --quiet docker
if [ ${?} -ne 0 ]; then
	echo "Docker Engine repository preparation & installation"
	echo "Maybe you should look if something change here: https://docs.docker.com/engine/install/ubuntu/"
	sudo apt-get install ca-certificates curl gnupg
	sudo mkdir -m 0755 -p /etc/apt/keyrings
	curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
	echo \
		"deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
		"$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
		sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
	if { sudo apt-get update 2>&1 || echo E: update failed; } | grep -q '^[WE]:'; then
		sudo chmod a+r /etc/apt/keyrings/docker.gpg
		sudo apt-get update
	fi

	sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
	sudo usermod -aG docker ${USER}
fi

############################################################
# Tmux configuration link
############################################################

cat <<EOF
=> Creating Tmux link
+ ${TMUXCONF_TARGET} -> ${TMUXCONF_SOURCE}

EOF

# Creating symlinks
ln -s "${TMUXCONF_SOURCE}" "${TMUXCONF_TARGET}"

############################################################
# Notes file
############################################################

echo "Create the notes file"
touch "${HOME}/notes"

################################################################
# Main .bashrc writing link to environment
################################################################

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

