#! /bin/bash

set -e

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

    read -p "$question [Y/n] " -r reply
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
# Update
########################################

sudo apt update

########################################
# CUSTOMIZE OS
########################################

cat <<EOF
# CUSTOMIZE OS (Ubuntu Budgie 24.04 gnome-like settings)

EOF

ask_exe "- Reduce Mouse Speed?" "gsettings set org.gnome.desktop.peripherals.mouse speed -0.6"

ask_exe "- Activate Over-Amplification?" "gsettings set org.gnome.desktop.sound allow-volume-above-100-percent true"

ask_exe "- Create App/ folder?" 'mkdir ~/App'

ask_exe "- Pin App/ folder in file explorer?" "[ ! -d \"${HOME}/App\" ] && sed -i '1s/^/file:\/\/\/${HOME}\/App App\n/' ${HOME}/.config/gtk-3.0/bookmarks"

ask_exe "- Switch Power Mode to Performance?" "powerprofilesctl set performance"

ask_exe "- Deactivate Screen Blank?" "gsettings set org.gnome.desktop.session idle-delay 0"

ask_exe "- Deactivate Automatic Power Saver?" "gsettings set org.gnome.settings-daemon.plugins.power power-saver-profile-on-low-battery false"

ask_exe "- Deactivate Automatic Suspend?" "gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-battery-type 'nothing' && gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-ac-type 'nothing'"

ask_exe "- Deactivate Power Button Behavior?" "gsettings set org.gnome.settings-daemon.plugins.power power-button-action 'nothing'"

ask_exe "- Deactivate Automatic Screen Lock?" "gsettings set org.gnome.desktop.screensaver lock-enabled false"

ask_exe "- Deactive Unicode Code Point ctrl+shift+u?" 'sudo apt install ibus && gsettings set org.freedesktop.ibus.panel.emoji unicode-hotkey "@as []"'

read -p "- Do you want to bind Volume Mute on PrtSc, Volume Down on ScrLk and Volume Up on Pause buttons? [Y/n] " -r reply
if [[ ${reply} =~ ^[Yy]$ ]]; then
	# install
	sudo apt install xdotool x11-xserver-utils
	# write file
	cat <<EOL > "${HOME}/.Xmodmap"
keycode 107 = XF86AudioMute
keycode 78 = XF86AudioLowerVolume
keycode 127 = XF86AudioRaiseVolume
EOL
	# apply
	xmodmap ${HOME}/.Xmodmap
	# bind it to start
	cat <<EOL > "${HOME}/.config/autostart/xmodmap.desktop"
[Desktop Entry]
Type=Application
Exec=xmodmap ${HOME}/.Xmodmap
Hidden=false
NoDisplay=false
X-GNOME-Autostart-enabled=true
Name[en_US]=Xmodmap
Name=Xmodmap
Comment[en_US]=Apply Xmodmap key bindings
Comment=Apply Xmodmap key bindings
EOL

	chmod +x "${HOME}/.config/autostart/xmodmap.desktop"
fi

[ ! -f "${HOME}/notes" ] && ask_exe "- Create a notes file?" "touch ${HOME}/notes"

########################################
# CUSTOMIZE DOCK
########################################

read -p "- Do you want to customize the Dock? [Y/n] " -r reply
if [[ ${reply} =~ ^[Yy]$ ]]; then

	ask_exe "- Position Dock to the left?" "gsettings set net.launchpad.plank.dock.settings:/net/launchpad/plank/docks/dock1/ position 'left'"

	ask_exe "- Delete LibreOffice dings?" "rm ${HOME}/.config/plank/dock1/launchers/libreoffice*.dockitem"

	ask_exe "- Delete Budgie Welcome dings?" "rm ${HOME}/.config/plank/dock1/launchers/budgie-welcome.dockitem"
	
	ask_exe "- Icon Size 42?" "gsettings set net.launchpad.plank.dock.settings:/net/launchpad/plank/docks/dock1/ icon-size 42"
	
	ask_exe "- Icon Zoom 130?" "gsettings set net.launchpad.plank.dock.settings:/net/launchpad/plank/docks/dock1/ icon-zoom 130"

	ask_exe "- Disable Auto-Hide?" "gsettings set net.launchpad.plank.dock.settings:/net/launchpad/plank/docks/dock1/ autohide false"
fi

########################################
# INSTALL TOOLS
########################################

cat <<EOF
# INSTALL TOOLS

EOF

# Curl
if [ ! -x "$(command -v curl)" ]; then
	# Install
	sudo apt install -y curl
fi

# Tmux
if [ ! -x "$(command -v tmux)" ]; then
	read -p "- Install Tmux? [Y/n] " -r reply
	if [[ ${reply} =~ ^[Yy]$ ]]; then
		# Install
		sudo apt install tmux
		echo "## Tmux configuration"
		echo "> Creating tmux config file symlink"
		# Creating symlink
		ln -s "${TMUXCONF_SOURCE}" "${TMUXCONF_TARGET}"
		# Done
		echo "Tmux installed: tmux (you should use tmux session that use this command)"
	fi
fi

# Git
if [ ! -x "$(command -v git)" ]; then
	read -p "- Install Git? [Y/n] " -r reply
	if [[ ${reply} =~ ^[Yy]$ ]]; then
		# Install
		sudo apt install git
		echo "## Git configuration ###"
		git config --global --add safe.directory "${BASHORTCUT}"
		# Ask for username, mail and cache credentials
		read -p "> Git username: " -r gitusername
		read -p "> Git email: " -r gitemail
		read -p "> Do you want to cache your credentials? [Y/n] " -r gitcredentials
		# Apply
		git config --global user.name "${gitusername}"
		git config --global user.email "${gitemail}"
		git config --global alias.co checkout
		if [[ ${gitcredentials} =~ ^[Yy]$ ]]; then
			git config --global credential.helper cache
		fi
		# Done
		echo "Git installed: git"
	fi
fi

# Gedit
if [ ! -x "$(command -v gedit)" ]; then
	read -p "- Install Gedit? [Y/n] " -r reply
	if [[ ${reply} =~ ^[Yy]$ ]]; then
		# Install
		sudo apt install gedit
		# Done
		echo "Gedit installed: gedit"
	fi
fi

# Docker
if [ ! systemctl is-active --quiet docker ]; then
	read -p "- Install Docker? [Y/n] " -r reply
	if [[ ${reply} =~ ^[Yy]$ ]]; then

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
		# Install
		sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
		sudo usermod -aG docker "${USER}"
		# Done
		echo "Docker installed: docker"
	fi
fi

# Spotify
if [ ! -x "$(command -v spotify)" ]; then
	read -p "- Install Spotify? [Y/n] " -r reply
	if [[ ${reply} =~ ^[Yy]$ ]]; then
		# Install
		sudo snap install spotify
		# Done
		echo "Spotify installed: spotify"
	fi
fi

# JetBrains Toolbox
read -p "- Install JetBrains Toolbox? [Y/n] " -r reply
if [[ ${reply} =~ ^[Yy]$ ]]; then
	# helped by: https://github.com/nagygergo/jetbrains-toolbox-install/blob/master/jetbrains-toolbox.sh
	# Dirs
	install_dir="${HOME}/App"
	[ ! -d "${install_dir}" ] && mkdir "${install_dir}"
	name="jetbrains-toolbox"
	dir_exe="${install_dir}/${name}"
	symlink_exe="/usr/local/bin/${name}"

	# Get URI and Archive name
	archive_url=$(curl -s 'https://data.services.jetbrains.com/products/releases?code=TBA&latest=true&type=release' | grep -Po '"linux":.*?[^\\]",' | awk -F ':' '{print $3,":"$4}'| sed 's/[", ]//g')
	archive_filename=$(basename "${archive_url}")

	# Download the archive
	rm "./${archive_filename}" 2>/dev/null || true
	wget -q --show-progress -cO "./${archive_filename}" "${archive_url}"

	# Exctract in ~/App
	rm "${dir_exe}" 2>/dev/null || true
	tar -xzf "./${archive_filename}" -C "${install_dir}" --strip-components=1
	rm "./${archive_filename}"
	chmod +x "${dir_exe}"

	# Symlink it
	rm "${symlink_exe}" 2>/dev/null || true
	ln -s "${dir_exe}" "${symlink_exe}"

	# Done
	echo "JetBrains Toolbox installed: jetbrains-toolbox"
fi

# Go
read -p "- Install Go (lang)? [Y/n] " -r reply
if [[ ${reply} =~ ^[Yy]$ ]]; then
	# Get latest version
	go_version=$(curl https://go.dev/VERSION?m=text | head -n1)
	# Download archive
	archive_filename="${go_version}.linux-amd64.tar.gz"
	wget "https://dl.google.com/go/${archive_filename}"
	# Clean older if exists
	sudo rm -rf /usr/local/go
	# Exctract
	sudo tar -C /usr/local -xzf "./${archive_filename}"
	rm "./${archive_filename}"
	# Export (also done in linux/.bash_profile)
	export PATH=$PATH:/usr/local/go/bin
	# Done
	echo "Go installed: go"
fi

# Nvm
if [ ! -x "$(command -v nvm)" ]; then
	read -p "- Install Nvm (Node Version Manager)? [Y/n] " -r reply
	if [[ ${reply} =~ ^[Yy]$ ]]; then
		# Get latest version
		NVM_LATEST_VERSION=$(curl -s https://api.github.com/repos/nvm-sh/nvm/releases/latest | grep -Po '"tag_name": "\K.*?(?=")')
		# Download and install
		curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/${NVM_LATEST_VERSION}/install.sh | bash

		# Export
		export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"

		# Activate NVM
		[ -s "${NVM_DIR}/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
		# Activate NVM Completion
		[[ -r ${NVM_DIR}/bash_completion ]] && \. ${NVM_DIR}/bash_completion
		# Done
		echo "Nvm installed: nvm"
		# Ask for Node using nvm
		read -p "- Install Node? [Y/n] " -r reply
		if [[ ${reply} =~ ^[Yy]$ ]]; then
			# Install
			nvm install node
			# Done
			echo "Node installed: node"
		fi
	fi
fi

# Mongo-Compass
if [ ! -x "$(command -v mongo-compass)" ]; then
	read -p "- Install Mongo-Compass? [Y/n] " -r reply
	if [[ ${reply} =~ ^[Yy]$ ]]; then
		# Install prerequisite
		if [ ! -x  "$(command -v jq)" ]; then
			# Install jq
			sudo apt install -y jq
		fi
		# Get latest version
		mongocompass_latestversion=$(curl -s https://api.github.com/repos/mongodb-js/compass/releases/latest | jq -r '.tag_name' | sed 's/^v//')
		# URI
		download_uri="https://downloads.mongodb.com/compass/mongodb-compass-${mongocompass_latestversion}-linux-x64.deb"
		# Download
		curl -LO ${download_uri}
		# Install (debian like)
		sudo dpkg -i mongodb-compass-${mongocompass_latestversion}-linux-x64.deb
		# Fix Broken Dependencies
		sudo apt-get install -f -y
		# Clean
		rm "./mongodb-compass-${mongocompass_latestversion}-linux-x64.deb"
		# Done
		echo "Mongo-Compass installed: mongodb-compass"
	fi
fi


########################################
# INSTALL BASHORTCUT OS LAYER
########################################

cat <<EOF
# INSTALL BASHORTCUT OS LAYER

EOF

[ ! -f "${BASHRC}" ] && echo "#! /bin/bash -e" >> "${BASHRC}"

cat <<EOF >>"${BASHRC}"
#@@
if [ -f "${BASH_PROFILE}" ]; then
    . "${BASH_PROFILE}"
fi
#@@@

EOF

ask_exe "See .bashrc content?" "cat ${BASHRC}"

echo "Nice! Now exec:"
echo "source ${BASHRC}"
