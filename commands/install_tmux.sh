#! /bin/bash

if [ ! -x "$(command -v tmux)" ]; then
	echo "------------------------------------------"
	read -p "- Install Tmux? [Y/n] " -r reply
	echo "------------------------------------------"
	if [[ ${reply} =~ ^[Yy]$ ]]; then
		# Install
		sudo apt install tmux
		read -p "- Use the BASHORTCUT default configuration? [Y/n] " -r reply
		if [[ ${reply} =~ ^[Yy]$ ]]; then
			# Creating symlink
			echo "> Creating tmux config file symlink"
			ln -s "${TMUXCONF_SOURCE}" "${TMUXCONF_TARGET}"
		fi
		# Done
		echo "Tmux installed: tmux (you should use tmux session that use this command)"
	fi
fi
