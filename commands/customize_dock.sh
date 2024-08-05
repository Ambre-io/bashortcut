#! /bin/bash

echo "------------------------------------------"
read -p "- Do you want to customize the Dock? [Y/n] " -r reply
echo "------------------------------------------"
if [[ ${reply} =~ ^[Yy]$ ]]; then

    # Function to prompt user for dock position
    while true; do
        echo "Select the position for the Dock (GK 1):"
        echo "1) left"
        echo "2) bottom"
        echo "3) right"
        echo "4) top"
        read -p "Enter the number corresponding to your choice: " -r choice

        case $choice in
            1) position="left"; break ;;
            2) position="bottom"; break ;;
            3) position="right"; break ;;
            4) position="top"; break ;;
            *) echo "Invalid choice. Please select a valid option." ;;
        esac
    done

    # Function to set the dock position using gsettings
    gsettings set net.launchpad.plank.dock.settings:/net/launchpad/plank/docks/dock1/ position "${position}"
    echo "Dock position set to ${position}."

    # Function to prompt user for deleting LibreOffice and Budgie Welcome dock items
    while true; do
        read -p "Do you want to delete the LibreOffice dock items (GK y)? [Y/n] " -r libreoffice_choice
        case ${libreoffice_choice} in
            [Yy]*) rm -f "${HOME}/.config/plank/dock1/launchers/libreoffice*.dockitem"; echo "LibreOffice dock items deleted."; break ;;
            [Nn]*) echo "LibreOffice dock item kept."; break ;;
            *) echo "Invalid choice. Please select y or n." ;;
        esac
    done

    while true; do
        read -p "Do you want to delete the Budgie Welcome dock item (GK y)? [Y/n] " -r budgie_welcome_choice
        case ${budgie_welcome_choice} in
            [Yy]*) rm -f "${HOME}/.config/plank/dock1/launchers/budgie-welcome.dockitem"; echo "Budgie Welcome dock item deleted."; break ;;
            [Nn]*) echo "Budgie Welcome dock item kept."; break ;;
            *) echo "Invalid choice. Please select y or n." ;;
        esac
    done

    # Function to check if input is a number and within the range
    is_valid_number() {
        [[ "$1" =~ ^[0-9]+$ ]] && [ "$1" -ge 24 ] && [ "$1" -le 128 ]
    }

    # Ask user for icon size
    read -p "Enter the icon size for Plank dock (GK 42) [24; 128] " -r icon_size

    # Validate the input
    while ! is_valid_number "${icon_size}"; do
        echo "Invalid input. Please enter a number between 24 and 128."
        read -p "Enter the icon size for Plank dock (GK 42) [24; 128] " -r icon_size
    done

    # Set the icon size using gsettings
    gsettings set net.launchpad.plank.dock.settings:/net/launchpad/plank/docks/dock1/ icon-size "${icon_size}"

    echo "Plank dock icon size set to ${icon_size}."

    # # shellcheck source=bsht/utils.sh
    #. "${BSHTUTILS}"
    # FIXME askexe "- Icon Zoom 130?" argument seems to not exists
    # FIXME askexe "- Disable Auto-Hide?" argument seems to not exists

fi
