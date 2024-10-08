#/bin/bash

#Desktop Enviroment

echo "Choose your Desktop Enviroment."
echo " (1) KDE Plasma"
echo " (2) XFCE"
echo " (3) Skip and keep the default."

echo "Enter Choice:"
read selection

if [ "$selection" -eq 1 ]; then 
	sudo apt update &> /dev/null
	sudo apt install kde-plasma-desktop

elif [ "$selection" -eq 2 ]; then
	sudo apt update &> /dev/null
	sudo apt install xfce4

	# Set Desktop Background
	xfconf-query -c xfce4-desktop \
	-p /backdrop/screen0/monitor1/workspace0/last-image \
	-s hacker.jpg

elif [ "$selection" -eq 3 ]; then
	echo "Default Ubuntu"
else 
	echo "Invalid selection."
fi


#Hacking Tool Packages

#Add Kali Linux archives
sudo sh -c "echo 'deb https://http.kali.org/kali kali-rolling main non-free contrib' > /etc/apt/sources.list.d/kali.list"
sudo apt update &> /dev/null
sudo apt install gnupg
wget 'https://archive.kali.org/archive-key.asc'
sudo apt-key add archive-key.asc
sudo apt update &> /dev/null
sudo sh -c "echo 'Package: *'>/etc/apt/preferences.d/kali.pref; echo 'Pin: release a=kali-rolling'>>/etc/apt/preferences.d/kali.pref; echo 'Pin-Priority: 50'>>/etc/apt/preferences.d/kali.pref"
sudo apt update &> /dev/null


#Install Packages
chmod +x package.sh
./package.sh

