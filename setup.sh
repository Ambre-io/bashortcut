#! /bin/bash

cat <<EOF

# # # # # # # # # # # # # # # # # # # # # # # #
#          INSTALL OS LAYER BASHORTCUT        #
# # # # # # # # # # # # # # # # # # # # # # # #

EOF


########################################
# UTILS
########################################

ask_exe() {
	local question="$1"
	local command="$2"

	echo "------------------------------------------"
	read -p "$question [Y/n] " -r reply
	echo "------------------------------------------"
	if [[ ${reply} =~ ^[Yy]$ ]]; then
		eval "$command"
	fi
}

########################################
# INCLUDE PATHS
########################################

cat <<EOF
# INCLUDE PATHS

EOF

SETUP=$(command -v -- "${0}")
SETUPPATH=$(cd -P -- "$(dirname -- "${SETUP}")" && pwd -P)
LINUXPATHS="${SETUPPATH}/linux/paths"
[ ! -d "${SETUPPATH}" ] && echo "Directory ${SETUPPATH} DOES NOT exists." && exit 1
[ ! -f "${LINUXPATHS}" ] && echo "File ${LINUXPATHS} DOES NOT exists." exit 1
# shellcheck source=linux/paths
. "${LINUXPATHS}"

########################################
# Update
########################################

sudo apt update

########################################
# CUSTOMIZE OS
########################################

source "${COMMANDS_PATH}/customize_os.sh"

########################################
# CUSTOMIZE DOCK
########################################

source "${COMMANDS_PATH}/customize_dock.sh"

########################################
# INSTALL TOOLS
########################################

cat <<EOF
# INSTALL TOOLS

EOF

# Curl
source "${COMMANDS_PATH}/install_curl.sh"

# Tmux
source "${COMMANDS_PATH}/install_tmux.sh"

# Git
source "${COMMANDS_PATH}/install_git.sh"

# Gedit
source "${COMMANDS_PATH}/install_gedit.sh"

# Docker
source "${COMMANDS_PATH}/install_docker.sh"

# Spotify
source "${COMMANDS_PATH}/install_spotify.sh"

# JetBrains Toolbox
source "${COMMANDS_PATH}/install_jetbrains_toolbox.sh"

# Go
source "${COMMANDS_PATH}/install_go.sh"

# Nvm
source "${COMMANDS_PATH}/install_nvm.sh"

# Mongo-Compass
source "${COMMANDS_PATH}/install_mongocompass.sh"

########################################
# INSTALL BASHORTCUT OS LAYER
########################################

cat <<EOF
# INSTALL BSHT PROFILE

EOF

source "${COMMANDS_PATH}/install_bsht_profile.sh"
