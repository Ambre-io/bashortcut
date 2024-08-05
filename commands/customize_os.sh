#! /bin/bash

echo "------------------------------------------"
read -p "- Do you want to customize OS? [Y/n] " -r reply
echo "------------------------------------------"
if [[ ${reply} =~ ^[Yy]$ ]]; then

    cat <<EOF
# CUSTOMIZE OS (Ubuntu Budgie 24.04 gnome-like settings)

EOF

    ########################################
    # * Paths
    ########################################
    BASEPATH="${HOME}/bashortcut/bsht"
    BSHTUTILS="${BASEPATH}/utils.sh"
    [ ! -d "${BASEPATH}" ] && echo "Directory ${BASEPATH} DOES NOT exists." exit 1
    [ ! -f "${BSHTUTILS}" ] && echo "File ${BSHTUTILS} DOES NOT exists." exit 1
    # shellcheck source=bsht/utils.sh
    . "${BSHTUTILS}"

    askexe "- Reduce Mouse Speed?" "gsettings set org.gnome.desktop.peripherals.mouse speed -0.6"

    askexe "- Activate Over-Amplification?" "gsettings set org.gnome.desktop.sound allow-volume-above-100-percent true"

    askexe "- Create ${HOME}/App/ folder (used for installed applications)?" "[ ! -d ${HOME}/App ] && mkdir ${HOME}/App"

    askexe "- Create ${HOME}/Projects/ folder (used for cloned repositories)?" "[ ! -d ${HOME}/Projects ] && mkdir ${HOME}/Projects"

    # FIXME: this is not working
    askexe "- Pin App/ folder in file explorer?" "[ ! -d ${HOME}/App ] && sed -i '1s/^/file:\/\/\/${HOME}\/App App\n/' ${HOME}/.config/gtk-3.0/bookmarks"

    askexe "- Switch Power Mode to Performance?" "powerprofilesctl set performance"

    askexe "- Deactivate Screen Blank?" "gsettings set org.gnome.desktop.session idle-delay 0"

    askexe "- Deactivate Automatic Power Saver?" "gsettings set org.gnome.settings-daemon.plugins.power power-saver-profile-on-low-battery false"

    askexe "- Deactivate Automatic Suspend?" "gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-battery-type 'nothing' && gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-ac-type 'nothing'"

    askexe "- Deactivate Power Button Behavior?" "gsettings set org.gnome.settings-daemon.plugins.power power-button-action 'nothing'"

    askexe "- Deactivate Automatic Screen Lock?" "gsettings set org.gnome.desktop.screensaver lock-enabled false"

    askexe "- Deactive Unicode Code Point ctrl+shift+u?" 'sudo apt install ibus && gsettings set org.freedesktop.ibus.panel.emoji unicode-hotkey "@as []"'

    echo "------------------------------------------"
    read -p "- Do you want to bind Volume Mute on PrtSc, Volume Down on ScrLk and Volume Up on Pause buttons? [Y/n] " -r reply
    echo "------------------------------------------"
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
        # FIXME correctly added to Startup Applications but does not work: it's not loadedd at start
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

    [ ! -f "${HOME}/notes" ] && askexe "- Create a notes file?" "touch ${HOME}/notes"
fi
