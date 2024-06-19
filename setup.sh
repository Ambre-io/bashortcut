#! /bin/bash -e

cat <<EOF

# # # # # # # # # # # # # # # # # # # # # # # #
#          SETUP LINUX BASHORTCUT             #
# # # # # # # # # # # # # # # # # # # # # # # #

EOF


########################################
# UTILS
########################################

ask_exe() {
    local question="$1"
    local command="$2"

    read -p "$question (y/n) " -r reply
    if [[ ${reply} =~ ^[Yy]$ ]]; then
        eval "$command"
    fi
}

########################################
# INCLUDE PATHS
########################################

cat <<EOF
# INCLUDE PATHS
EOF

SETUP=$(command -v -- "${0}")
SETUPPATH=$(cd -P -- "$(dirname -- "${SETUP}")" && pwd -P)
LINUXPATHS="${SETUPPATH}/linux/paths"
[ ! -d "${SETUPPATH}" ] && echo "Directory ${SETUPPATH} DOES NOT exists." && exit 1
[ ! -f "${LINUXPATHS}" ] && echo "File ${LINUXPATHS} DOES NOT exists." exit 1
# shellcheck source=linux/paths
. "${LINUXPATHS}"

########################################
# CUSTOMIZE OS
########################################

cat <<EOF
# CUSTOMIZE OS (Ubuntu Budgie 24.04 gnome-like settings)

EOF

ask_exe "- Reduce Mouse Speed?" "gsettings set org.gnome.desktop.peripherals.mouse speed -0.6"

ask_exe "- Activate Over-Amplification?" "gsettings set org.gnome.desktop.sound allow-volume-above-100-percent true"

ask_exe "- Create App/ folder?" 'mkdir ~/App'

ask_exe "- Pin App/ folder in file explorer?" "[ ! -d \"~/App\" ] && sed -i '1s/^/file:\/\/\/${HOME}\/App App\n/' ~/.config/gtk-3.0/bookmarks"

ask_exe "- Switch Power Mode to Performance?" "powerprofilesctl set performance"

ask_exe "- Deactivate Screen Blank?" "gsettings set org.gnome.desktop.session idle-delay 0"

ask_exe "- Deactivate Automatic Power Saver?" "gsettings set org.gnome.settings-daemon.plugins.power power-saver-profile-on-low-battery false"

ask_exe "- Deactivate Automatic Suspend?" "gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-battery-type 'nothing' && gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-ac-type 'nothing'"

ask_exe "- Deactivate Power Button Behavior?" "gsettings set org.gnome.settings-daemon.plugins.power power-button-action 'nothing'"

ask_exe "- Deactivate Automatic Screen Lock?" "gsettings set org.gnome.desktop.screensaver lock-enabled false"

ask_exe "- Deactive Unicode Code Point ctrl+shift+u?" 'sudo apt install ibus && gsettings set org.freedesktop.ibus.panel.emoji unicode-hotkey "@as []"'

########################################
# INSTALL TOOLS
########################################

cat <<EOF
# INSTALL TOOLS

EOF

# tmux
if [ ! -x "$(command -v tmux)" ]; then
	read -p "Do you want tmux? (y/n) " -r REPLY 
	if [[ ${REPLY} =~ ^[Yy]$ ]]; then
		sudo apt install tmux
	fi
fi

# git
if [ ! -x "$(command -v git)" ]; then
	read -p "Do you want git? [y/n] " -r REPLY
	if [[ ${REPLY} =~ ^[Yy]$ ]]; then
		sudo apt install git
		git config --global --add safe.directory "${BASHORTCUT}"
	fi
fi
# TODO
#   - git config --global alias.co checkout
#   - git config --global credential.helper cache

# gedit
if [ ! -x "$(command -v gedit)" ]; then
	read -p "Do you want gedit? (y/n) " -r REPLY
	if [[ ${REPLY} =~ ^[Yy]$ ]]; then
		sudo apt install gedit
	fi
fi

# Docker
read -p "Do you want docker? (y/n) " -r REPLY
if [[ ${REPLY} =~ ^[Yy]$ ]] && ! systemctl is-active --quiet docker; then

	# Add Docker's official GPG key
    echo "Docker Engine repository preparation & installation"
    sudo apt-get install ca-certificates curl gnupg
    sudo mkdir -m 0755 -p /etc/apt/keyrings
    sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
	sudo chmod a+r /etc/apt/keyrings/docker.asc

    # Add the repository to Apt sources
	echo \
		"deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
		$(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
		sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

    if { sudo apt-get update 2>&1 || echo E: update failed; } | grep -q '^[WE]:'; then
        sudo chmod a+r /etc/apt/keyrings/docker.gpg
        sudo apt-get update
    fi

    sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
    sudo usermod -aG docker "${USER}"
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
