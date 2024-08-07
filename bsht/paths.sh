#!/bin/bash

########################################
# BASHORCUT PATHS
########################################
BASHRC="${HOME}/.bashrc" # entry point
BASHORTCUT="${HOME}/bashortcut"
BASHORTCUT_BSHT_DIR="${BASHORTCUT}/bsht"
BASHORTCUT_COMMANDS_DIR="${BASHORTCUT}/commands"
BSHT_PROFILE="${BASHORTCUT_BSHT_DIR}/profile.sh" # main bsht file
TMUXCONF_SOURCE="${BASHORTCUT}/tmux/.tmux.conf" # tmux configuration file
TMUXCONF_TARGET="${HOME}/.tmux.conf" # created by setup.sh

########################################
# SECURITY
########################################
IE=0
[ ! -f "${BASHRC}" ] && echo "File ${BASHRC} DOES NOT exists."
[ ! -d "${BASHORTCUT}" ] && echo "Directory ${BASHORTCUT} DOES NOT exists. You should go in ${HOME} and clone https://github.com/guiklimek/bashortcut.git." && IE=1
[ ! -d "${BASHORTCUT_BSHT_DIR}" ] && echo "Directory ${BASHORTCUT_BSHT_DIR} DOES NOT exists." && IE=1
[ ! -d "${BASHORTCUT_COMMANDS_DIR}" ] && echo "Directory ${BASHORTCUT_COMMANDS_DIR} DOES NOT exists." && IE=1
[ ! -f "${BSHT_PROFILE}" ] && echo "File ${BSHT_PROFILE} DOES NOT exists." && IE=1
[ ! -f "${TMUXCONF_SOURCE}" ] && echo "File ${TMUXCONF_SOURCE} DOES NOT exists." && IE=1
# TMUXCONF_TARGET could not exists

if [ "${IE}" -eq 1 ]; then
    echo "It seems you need to check your paths."
    exit 1
fi

########################################
# EXPORT
########################################

export BASHRC
export BASHORTCUT
export BASHORTCUT_BSHT_DIR
export BASHORTCUT_COMMANDS_DIR
export BSHT_PROFILE
export TMUXCONF_SOURCE
export TMUXCONF_TARGET
