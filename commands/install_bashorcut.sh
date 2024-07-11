#! /bin/bash

########################################
# * Paths
########################################
LINUXPATHS="${HOME}/bashortcut/linux/paths"
[ ! -f "${LINUXPATHS}" ] && echo "File ${LINUXPATHS} DOES NOT exists." exit 1
# shellcheck source=paths
. "${LINUXPATHS}"

########################################
# * BASHORTCUT LAYER
########################################
cat <<EOF
# INSTALL BASHORTCUT OS LAYER

EOF
echo "------------------------------------------"
read -p "- Ready to install BASHORTCUT ? [Y/n] " -r reply
echo "------------------------------------------"
if [[ ${reply} =~ ^[Yy]$ ]]; then
	[ ! -f "${BASHRC}" ] && echo "#! /bin/bash -e" >> "${BASHRC}"

	echo "------------------------------------------"
    read -p "- Activate Aliases ? [Y/n] " -r res_aliases
    echo "------------------------------------------"

    echo "------------------------------------------"
    read -p "- Activate Prompt ? [Y/n] " -r res_prompt
    echo "------------------------------------------"

	cat <<EOF >>"${BASHRC}"
#@@
########################################
# * Profile
########################################
if [ -f "${BASH_PROFILE}" ]; then
    . "${BASH_PROFILE}"
fi

########################################
# * Aliases
########################################
if [[ ${res_aliases} =~ ^[Yy]$ ]]; then
    BASHALIASES="${BASHORTCUT_LINUX_DIR}/.bash_aliases"
    if [ -f "${BASHALIASES}" ]; then
        . "${BASHALIASES}"
    fi
fi
########################################
# * Prompt
########################################
if [[ ${res_prompt} =~ ^[Yy]$ ]]; then
    BASHPROMPT="${BASHORTCUT_LINUX_DIR}/.bash_prompt"
    if [ -f "${BASHPROMPT}" ]; then
        . "${BASHPROMPT}"
    fi
fi
#@@@

EOF

	ask_exe "See .bashrc content?" "cat ${BASHRC}"

	echo "Nice! Open a new terminal or exec:"
	echo "cd ${HOME} && source ${BASHRC}"
fi
