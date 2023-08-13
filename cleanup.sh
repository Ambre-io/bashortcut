#! /bin/bash -e

cat <<EOF

# # # # # # # # # # # # # # # # # # # # # #
#	    CLEANUP LINUX BASHORTCUT          #
# # # # # # # # # # # # # # # # # # # # # #

EOF

read -p "Are you sure to clean BASHORTCUT (y/n)? " -n 1 -r
if [[ ! ${REPLY} =~ ^[Yy]$ ]]; then
    exit 0
fi

########################################
# Including paths constants
########################################

# Including: TMUXCONF_TARGET, BASHRC
SETUP_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
. "${SETUP_DIR}/linux/paths"

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

# shellcheck source=/dev/null
source "${BASHRC}"

############################################################
# Deleting notes
############################################################

read -p "Delete ~/notes? (y/n) " -n 1 -r
if [[ ! ${REPLY} =~ ^[Yy]$ ]]; then
    rm "${HOME}/notes"
fi
