#! /bin/bash

if [ ! -x "$(command -v gedit)" ]; then
	echo "------------------------------------------"
	read -p "- Install Gedit? [Y/n] " -r reply
	echo "------------------------------------------"
	if [[ ${reply} =~ ^[Yy]$ ]]; then
		# Install
		sudo apt install gedit
		# Done
		echo "Gedit installed: gedit"
	fi
fi
