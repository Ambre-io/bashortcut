#! /bin/bash

########################################
# * Paths
########################################
LINUXPATHS="${HOME}/bashortcut/linux/paths"
[ ! -f "${LINUXPATHS}" ] && echo "File ${LINUXPATHS} DOES NOT exists." exit 1
# shellcheck source=paths
. "${LINUXPATHS}"

########################################
# * BSHT profile
########################################

echo "------------------------------------------"
read -p "- Ready to install the BSHT profile ? [Y/n] " -r reply
echo "------------------------------------------"
if [[ ${reply} =~ ^[Yy]$ ]]; then
	[ ! -f "${BASHRC}" ] && echo "#! /bin/bash" >> "${BASHRC}"
	cat <<EOF >>"${BASHRC}"
#@@
########################################
# * BSHT profile
########################################
if [ -f "${BSHT_PROFILE}" ]; then
    . "${BSHT_PROFILE}"
fi
#@@@

EOF

	ask_exe "See .bashrc content?" "cat ${BASHRC}"

	echo "Nice! Open a new terminal or exec:"
	echo "cd ${HOME} && source ${BASHRC}"
fi
