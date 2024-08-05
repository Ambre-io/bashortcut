#! /bin/bash

# * # * # * # * # * # * # * # * # * # * # * # * # * # * # * # * # * # * # * # * # * # * # * #
# *                                 Bashortcut environment                                * #
# * # * # * # * # * # * # * # * # * # * # * # * # * # * # * # * # * # * # * # * # * # * # * #

########################################
# * VM / OS
########################################

# Date in history
export HISTTIMEFORMAT="%d/%m/%y %T "

########################################
# * Load PATHS
########################################

BSHTPATHS="${HOME}/bashortcut/bsht/paths.sh"
[ ! -f "${BSHTPATHS}" ] && echo "File ${BSHTPATHS} DOES NOT exists." exit 1
# shellcheck source=bsht/paths.sh
. "${BSHTPATHS}"

########################################
# * Aliases
########################################
BSHTALIASES="${BASHORTCUT_BSHT_DIR}/aliases.sh"
if [ -f "${BSHTALIASES}" ]; then
    # shellcheck source="${BASHORTCUT_BSHT_DIR}/aliases.sh"
    . "${BSHTALIASES}"
fi

########################################
# * Prompt
########################################
BSHTPROMPT="${BASHORTCUT_BSHT_DIR}/prompt.sh"
if [ -f "${BSHTPROMPT}" ]; then
    # shellcheck source="${BASHORTCUT_BSHT_DIR}/prompt.sh"
    . "${BSHTPROMPT}"
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

# Go
[ -d "/usr/local/go/bin" ] && export PATH=${PATH}:/usr/local/go/bin:${HOME}/go

