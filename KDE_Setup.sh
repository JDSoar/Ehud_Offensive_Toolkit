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

bg_filename="hacker.jpg"

# Get the full path of the script's directory
script_dir=$(dirname "$(readlink -f "$0")")

# Construct the full path to the image
bg_image="$script_dir/$bg_filename"

# Check if the file exists
if [ ! -f "$bg_image" ]; then
  echo "Error: $bg_filename not found in the script's directory"
  exit 1
fi

# Copy the image to the SDDM themes directory
cp "$bg_image" /usr/share/sddm/themes/

# Update SDDM configuration
sddm_conf="/etc/sddm.conf"

# Create the file if it doesn't exist
touch "$sddm_conf"

# Update or add the [Theme] section
if grep -q '^\[Theme\]' "$sddm_conf"; then
  sed -i '/^\[Theme\]/,/^\[/ s/^Background=.*/Background=\/usr\/share\/sddm\/themes\/'"$bg_filename"'/' "$sddm_conf"
else
  echo -e "\n[Theme]\nBackground=/usr/share/sddm/themes/$bg_filename" >> "$sddm_conf"
fi

echo "SDDM background updated to $bg_filename. Please restart SDDM or reboot your system to see the changes."

sudo reboot
