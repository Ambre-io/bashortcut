#! /bin/bash

if [ ! -x "$(command -v git)" ]; then
	echo "------------------------------------------"
	read -p "- Install Git? [Y/n] " -r reply
	echo "------------------------------------------"
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
