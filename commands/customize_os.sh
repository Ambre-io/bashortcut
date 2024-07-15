#! /bin/bash

echo "------------------------------------------"
read -p "- Do you want to customize OS? [Y/n] " -r reply
echo "------------------------------------------"
if [[ ${reply} =~ ^[Yy]$ ]]; then

    cat <<EOF
# CUSTOMIZE OS (Ubuntu Budgie 24.04 gnome-like settings)

EOF

    ask_exe "- Reduce Mouse Speed?" "gsettings set org.gnome.desktop.peripherals.mouse speed -0.6"

    ask_exe "- Activate Over-Amplification?" "gsettings set org.gnome.desktop.sound allow-volume-above-100-percent true"

    ask_exe "- Create ${HOME}/App/ folder (used for installed applications)?" "[ ! -d ${HOME}/App ] && mkdir ${HOME}/App"

    ask_exe "- Create ${HOME}/Projects/ folder (used for cloned repositories)?" "[ ! -d ${HOME}/Projects ] && mkdir ${HOME}/Projects"

    # FIXME: this is not working
    ask_exe "- Pin App/ folder in file explorer?" "[ ! -d ${HOME}/App ] && sed -i '1s/^/file:\/\/\/${HOME}\/App App\n/' ${HOME}/.config/gtk-3.0/bookmarks"

    ask_exe "- Switch Power Mode to Performance?" "powerprofilesctl set performance"

    ask_exe "- Deactivate Screen Blank?" "gsettings set org.gnome.desktop.session idle-delay 0"

    ask_exe "- Deactivate Automatic Power Saver?" "gsettings set org.gnome.settings-daemon.plugins.power power-saver-profile-on-low-battery false"

    ask_exe "- Deactivate Automatic Suspend?" "gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-battery-type 'nothing' && gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-ac-type 'nothing'"

    ask_exe "- Deactivate Power Button Behavior?" "gsettings set org.gnome.settings-daemon.plugins.power power-button-action 'nothing'"

    ask_exe "- Deactivate Automatic Screen Lock?" "gsettings set org.gnome.desktop.screensaver lock-enabled false"

    ask_exe "- Deactive Unicode Code Point ctrl+shift+u?" 'sudo apt install ibus && gsettings set org.freedesktop.ibus.panel.emoji unicode-hotkey "@as []"'

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

    [ ! -f "${HOME}/notes" ] && ask_exe "- Create a notes file?" "touch ${HOME}/notes"
fi
