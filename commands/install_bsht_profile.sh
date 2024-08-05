#! /bin/bash

########################################
# * Paths
########################################
BASEPATH="${HOME}/bashortcut/bsht"
BSHTPATHS="${BASEPATH}/paths.sh"
BSHTUTILS="${BASEPATH}/utils.sh"
[ ! -d "${BASEPATH}" ] && echo "Directory ${BASEPATH} DOES NOT exists." exit 1
[ ! -f "${BSHTPATHS}" ] && echo "File ${BSHTPATHS} DOES NOT exists." exit 1
[ ! -f "${BSHTUTILS}" ] && echo "File ${BSHTUTILS} DOES NOT exists." exit 1
# shellcheck source=bsht/paths.sh
. "${BSHTPATHS}"
# shellcheck source=bsht/utils.sh
. "${BSHTUTILS}"

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

	askexe "See .bashrc content?" "cat ${BASHRC}"

	echo "Nice! Open a new terminal or exec:"
	echo "cd ${HOME} && source ${BASHRC}"
fi
