#!/bin/bash

echo "WARNING: Running this script will reboot your system!"


#Set Wallpaper
# Get the full path of the script's directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Set the wallpaper
qdbus org.kde.plasmashell /PlasmaShell org.kde.PlasmaShell.evaluateScript '
    var allDesktops = desktops();
    for (i = 0; i < allDesktops.length; i++) {
        d = allDesktops[i];
        d.wallpaperPlugin = "org.kde.image";
        d.currentConfigGroup = Array("Wallpaper", "org.kde.image", "General");
        d.writeConfig("Image", "file://'"$SCRIPT_DIR"'/hacker.jpg");
    }
'

echo "Wallpaper has been set to $SCRIPT_DIR/hacker.jpg"


#Change Desktop to Darkmode
lookandfeeltool -a org.kde.breezedark.desktop


#Remove Gnome Desktop and Packages
sudo apt purge ubuntu-desktop gnome-shell
sudo apt purge gnome*
sudo apt autoremove --purge

#Set KDE as the Default Login Display Manager
sudo apt install sddm
sudo apt install -y debconf-utils
echo "sddm shared/default-x-display-manager select sddm" | sudo debconf-set-selections

#Minimize the on-screen Keyboard on Reboot


#Set Login Screen Background
sudo mkdir -p /etc/sddm.conf.d
sudo tee /etc/sddm.conf.d/kde_settings.conf > /dev/null <<EOL
[Theme]
Current=breezedark

[Greeter]
Background="file://'"$SCRIPT_DIR"'/hacker.jpg"
EOL


sudo reboot
