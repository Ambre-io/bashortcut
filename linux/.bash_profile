# * # * # * # * # * # * # * # * # * # * # * # * # * # * # * # * # * # * # * # * # * # * # * #
# *                                 Bashortcut environment                                * #
# * # * # * # * # * # * # * # * # * # * # * # * # * # * # * # * # * # * # * # * # * # * # * #

########################################
# * VM / OS
########################################

# Date in history
export HISTTIMEFORMAT="%d/%m/%y %T "

# homemade alert for ZFS filesystem
function ZFSstate() {
	zpool_health=$(zpool status -x)
	if [ "${zpool_health}" != "all pools are healthy" ]; then
		echo "[Warning] >>> You should look at ZFS states: zpool status -x"
	fi
	zpool_states=$(zpool status | grep state | wc -l)
	zpool_online=$(zpool status | grep state | grep ONLINE | wc -l)
	if [ "${zpool_states}" -ne "${zpool_online}" ]; then
		echo "[Warning] >>> Some zpool are not online, see: zpool status"
	fi
}
#ZFSstate # not activated by default


########################################
# * Paths
########################################
# @@@ FIXME find a generic way to discover the bashortcut original path
LINUXPATHS="${HOME}/bashortcut/linux/paths"
[ ! -f "${LINUXPATHS}" ] && echo "File ${LINUXPATHS} DOES NOT exists." exit 1
# shellcheck source=paths
. "${LINUXPATHS}"

########################################
# * Aliases
########################################

BASHALIASES="${BASHORTCUT_LINUX_DIR}/.bash_aliases"
if [ -f "${BASHALIASES}" ]; then
    . "${BASHALIASES}"
fi

########################################
# * Prompt
########################################

BASHPROMPT="${BASHORTCUT_LINUX_DIR}/.bash_prompt"
if [ -f "${BASHPROMPT}" ]; then
    . "${BASHPROMPT}"
fi

########################################
# * Development
########################################

# Git
[ -x "$(command -v git)" ] && source /usr/share/bash-completion/completions/git

# Node.js
export NVM_DIR="${HOME}/.nvm"
[ -s "${NVM_DIR}/nvm.sh" ] && \. "${NVM_DIR}/nvm.sh" # This loads nvm
[ -s "${NVM_DIR}/bash_completion" ] && \. "${NVM_DIR}/bash_completion"  # This loads nvm bash_completion
