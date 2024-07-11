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

