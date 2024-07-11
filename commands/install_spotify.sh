#! /bin/bash

if [ ! -x "$(command -v spotify)" ]; then
	echo "------------------------------------------"
	read -p "- Install Spotify? [Y/n] " -r reply
	echo "------------------------------------------"
	if [[ ${reply} =~ ^[Yy]$ ]]; then
		# Install
		sudo snap install spotify
		# Done
		echo "Spotify installed: spotify"
	fi
fi
