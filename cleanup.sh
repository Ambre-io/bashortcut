#! /bin/bash -e

cat <<EOF

# # # # # # # # # # # # # # # # # # # # # #
#	    CLEANUP LINUX BASHORTCUT          #
# # # # # # # # # # # # # # # # # # # # # #

EOF

read -p "Are you sure to clean BASHORTCUT (y/n)? " -r REPLY
if [[ ! ${REPLY} =~ ^[Yy]$ ]]; then
    exit 0
fi

########################################
# Including paths constants
########################################
SETUP=$(command -v -- "${0}")
SETUPPATH=$(cd -P -- "$(dirname -- "${SETUP}")" && pwd -P)
BSHTPATHS="${SETUPPATH}/bsht/paths.sh"
[ ! -d "${SETUPPATH}" ] && echo "Directory ${SETUPPATH} DOES NOT exists." && exit 1
[ ! -f "${BSHTPATHS}" ] && echo "File ${BSHTPATHS} DOES NOT exists." exit 1
# shellcheck source=bsht/paths.sh
. "${BSHTPATHS}"

########################################
# Deleting tmux symlink
########################################

[ ! -f "${TMUXCONF_TARGET}" ] && echo "Missing file ${TMUXCONF_TARGET}." && exit 1

cat <<EOF
=> removing "${TMUXCONF_TARGET}"
EOF

rm -f "${TMUXCONF_TARGET}"

############################################################
# Deleting include in .bashrc
############################################################

[ ! -f "${BASHRC}" ] && echo "Missing file ${BASHRC}." && exit 1

cat <<EOF
=> removing link in "${BASHRC}"
EOF

# Deleting link in main .bashrc
BASHRC_TMP="${BASHRC}_tmp"
sed -e "/#@@/,/#@@@/d" "${BASHRC}" > "${BASHRC_TMP}" # deleting part from '#@@@' to the end
rm "${BASHRC}"
mv "${BASHRC_TMP}" "${BASHRC}"

# shellcheck source=${HOME}/.bashrc
source "${BASHRC}"

# TODO git config --global --unset credential.helper
