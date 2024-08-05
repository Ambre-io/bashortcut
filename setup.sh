#! /bin/bash

cat <<EOF

# # # # # # # # # # # # # # # # # # # # # # # #
#          INSTALL OS LAYER BASHORTCUT        #
# # # # # # # # # # # # # # # # # # # # # # # #

EOF

########################################
# INCLUDE PATHS
########################################

cat <<EOF
# INCLUDE PATHS

EOF

SETUP=$(command -v -- "${0}")
SETUPPATH=$(cd -P -- "$(dirname -- "${SETUP}")" && pwd -P)
BSHTPATHS="${SETUPPATH}/bsht/paths.sh"
[ ! -d "${SETUPPATH}" ] && echo "Directory ${SETUPPATH} DOES NOT exists." && exit 1
[ ! -f "${BSHTPATHS}" ] && echo "File ${BSHTPATHS} DOES NOT exists." exit 1
# shellcheck source=bsht/paths.sh
. "${BSHTPATHS}"

########################################
# Update
########################################

sudo apt update

########################################
# CUSTOMIZE OS
########################################

. "${BASHORTCUT_COMMANDS_DIR}/customize_os.sh"

########################################
# CUSTOMIZE DOCK
########################################

. "${BASHORTCUT_COMMANDS_DIR}/customize_dock.sh"

########################################
# INSTALL TOOLS
########################################

cat <<EOF
# INSTALL TOOLS

EOF

# Curl
. "${BASHORTCUT_COMMANDS_DIR}/install_curl.sh"

# Tmux
. "${BASHORTCUT_COMMANDS_DIR}/install_tmux.sh"

# Git
. "${BASHORTCUT_COMMANDS_DIR}/install_git.sh"

# Gedit
. "${BASHORTCUT_COMMANDS_DIR}/install_gedit.sh"

# Docker
. "${BASHORTCUT_COMMANDS_DIR}/install_docker.sh"

# Spotify
. "${BASHORTCUT_COMMANDS_DIR}/install_spotify.sh"

# JetBrains Toolbox
. "${BASHORTCUT_COMMANDS_DIR}/install_jetbrains_toolbox.sh"

# VSCode
. "${BASHORTCUT_COMMANDS_DIR}/install_vscode.sh"

# Go
. "${BASHORTCUT_COMMANDS_DIR}/install_go.sh"

# Nvm
. "${BASHORTCUT_COMMANDS_DIR}/install_nvm.sh"

# Mongo-Compass
. "${BASHORTCUT_COMMANDS_DIR}/install_mongocompass.sh"

# DBeaver
. "${BASHORTCUT_COMMANDS_DIR}/install_dbeaver.sh"

########################################
# INSTALL BASHORTCUT OS LAYER
########################################

cat <<EOF
# INSTALL BSHT PROFILE

EOF

. "${BASHORTCUT_COMMANDS_DIR}/install_bsht_profile.sh"
