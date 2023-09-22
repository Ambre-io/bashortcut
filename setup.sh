#! /bin/bash -e

cat <<EOF

# # # # # # # # # # # # # # # # # # # # # # # #
#          SETUP LINUX BASHORTCUT             #
# # # # # # # # # # # # # # # # # # # # # # # #

EOF

########################################
# INCLUDE PATHS
########################################
SETUP=$(command -v -- "${0}")
SETUPPATH=$(cd -P -- "$(dirname -- "${SETUP}")" && pwd -P)
LINUXPATHS="${SETUPPATH}/linux/paths"
[ ! -d "${SETUPPATH}" ] && echo "Directory ${SETUPPATH} DOES NOT exists." && exit 1
[ ! -f "${LINUXPATHS}" ] && echo "File ${LINUXPATHS} DOES NOT exists." exit 1
# shellcheck source=linux/paths
. "${LINUXPATHS}"

########################################
# INSTALL UTILS
########################################

[ ! -x "$(command -v tmux)" ] && read -p "Do you want tmux? (y/n) " -r REPLY && [[ ${REPLY} =~ ^[Yy]$ ]] && sudo apt install tmux
[ ! -x "$(command -v git)" ] && read -p "Do you want git? (y/n) " -r REPLY && [[ ${REPLY} =~ ^[Yy]$ ]] && sudo apt install git && git config --global --add safe.directory "${BASHORTCUT}"
# TODO
#   - git config --global alias.co checkout
#   - git config --global credential.helper cache
[ ! -x "$(command -v gedit)" ] && read -p "Do you want gedit? (y/n) " -r REPLY && [[ ${REPLY} =~ ^[Yy]$ ]] && sudo apt install gedit

########################################
# INSTALL DOCKER
########################################
read -p "Do you want docker? (y/n) " -r REPLY
if [[ ${REPLY} =~ ^[Yy]$ ]] && ! systemctl is-active --quiet docker; then
    echo "Docker Engine repository preparation & installation"
    echo "Maybe you should look if something change here: https://docs.docker.com/engine/install/ubuntu/"
    sudo apt-get install ca-certificates curl gnupg
    sudo mkdir -m 0755 -p /etc/apt/keyrings
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
    echo \
        "deb [arch=\"$(dpkg --print-architecture)\" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
        \"$(. /etc/os-release && echo "$VERSION_CODENAME")\" stable" | \
        sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    if { sudo apt-get update 2>&1 || echo E: update failed; } | grep -q '^[WE]:'; then
        sudo chmod a+r /etc/apt/keyrings/docker.gpg
        sudo apt-get update
    fi

    sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
    sudo usermod -aG docker "${USER}"
fi

########################################
# Disable unicode code shortcut
########################################
read -p "Do you want to disable the unicode shortcut CTRL+SHIFT+u on Ubuntu? (y/n) " -r REPLY
if [[ ${REPLY} =~ ^[Yy]$ ]]; then
    gsettings set org.freedesktop.ibus.panel.emoji unicode-hotkey "@as []"
fi

########################################
# TMUX CONFIGURATION LINK
########################################

cat <<EOF
=> Creating Tmux link
+ ${TMUXCONF_TARGET} -> ${TMUXCONF_SOURCE}

EOF

# Creating symlinks
ln -s "${TMUXCONF_SOURCE}" "${TMUXCONF_TARGET}"

########################################
# NOTES FILE
########################################

echo "Create the notes file"
touch "${HOME}/notes"

########################################
# MAIN LINK IN .bashrc
########################################

[ ! -f "${BASHRC}" ] && echo "⚠️ There's no .bashrc file BASHRC=${BASHRC}." && echo "Creating one:" && echo "#! /bin/bash -e" >>"${BASHRC}"

cat <<EOF >>"${BASHRC}"
#@@
if [ -f "${BASH_PROFILE}" ]; then
    . "${BASH_PROFILE}"
fi
#@@@

EOF

read -p "See .bashrc content? (y/n) " -r REPLY && [[ ${REPLY} =~ ^[Yy]$ ]] && cat "${BASHRC}"

echo "Nice! Now exec:"
echo "source ${BASHRC}"
