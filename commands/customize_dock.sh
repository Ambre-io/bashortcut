#! /bin/bash

echo "------------------------------------------"
read -p "- Do you want to customize the Dock? [Y/n] " -r reply
echo "------------------------------------------"
if [[ ${reply} =~ ^[Yy]$ ]]; then

	ask_exe "- Position Dock to the left?" "gsettings set net.launchpad.plank.dock.settings:/net/launchpad/plank/docks/dock1/ position 'left'"

	ask_exe "- Delete LibreOffice dings?" "rm ${HOME}/.config/plank/dock1/launchers/libreoffice*.dockitem"

	ask_exe "- Delete Budgie Welcome dings?" "rm ${HOME}/.config/plank/dock1/launchers/budgie-welcome.dockitem"

	ask_exe "- Icon Size 42?" "gsettings set net.launchpad.plank.dock.settings:/net/launchpad/plank/docks/dock1/ icon-size 42"
	# FIXME DOES NOT WORK
	ask_exe "- Icon Zoom 130?" "gsettings set net.launchpad.plank.dock.settings:/net/launchpad/plank/docks/dock1/ icon-zoom 130"
	# FIXME DOES NOT WORK
	ask_exe "- Disable Auto-Hide?" "gsettings set net.launchpad.plank.dock.settings:/net/launchpad/plank/docks/dock1/ autohide false"

fi
