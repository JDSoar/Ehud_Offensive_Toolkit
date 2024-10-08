#!/bin/bash


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


#change to darkmode
lookandfeeltool -a org.kde.breezedark.desktop
