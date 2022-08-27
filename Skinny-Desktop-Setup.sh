#!/bin/sh

mv /etc/apt/sources.list /etc/apt/sources.list.disable
rm /etc/apt/sources.list.d/stable.list
rm /etc/apt/sources.list.d/testing.list

echo "deb http://deb.debian.org/debian/ bullseye main contrib non-free" >> /etc/apt/sources.list.d/stable.list
echo "deb http://security.debian.org/debian-security bullseye-security main contrib non-free" >> /etc/apt/sources.list.d/stable.list
echo "deb http://deb.debian.org/debian/ bullseye-updates main contrib non-free" >> /etc/apt/sources.list.d/stable.list

echo "deb http://deb.debian.org/debian/ testing main contrib non-free" >> /etc/apt/sources.list.d/testing.list
echo "deb http://security.debian.org/debian-security testing-security main contrib non-free" >> /etc/apt/sources.list.d/testing.list
echo "deb http://deb.debian.org/debian/ testing-updates main contrib non-free" >> /etc/apt/sources.list.d/testing.list

apt-get update -y
apt-get upgrade -y

apt-get install -y curl xorg alsa-utils zstd
curl -LJO https://github.com/Boilingtub/Skinny-Linux/raw/main/Suckless-Software.tar.gz
tar xvf Suckless-Software.tar.gz
mv ./Suckless-Software/dwm /usr/local/bin/dwm
mv ./Suckless-Software/st /usr/local/bin/st
mv ./Suckless-Software/dmenu /usr/local/bin/dmenu
mv ./Suckless-Software/dmenu_run /usr/local/bin/dmenu_run
mv ./Suckless-Software/dmenu_path /usr/local/bin/dmenu_path
mv ./Suckless-Software/stest /usr/local/bin/stest

if [ $USER != "root" ] ; then
echo "exec dwm" >> /home/${USER}/.xinitrc
echo "TERM=xterm" >> /home/${USER}/.bashrc
echo "if [ -d "usr/local/sbin" ] ; then\n   PATH=\"usr/local/sbin:$PATH\"\nfi" >> /home/${USER}/.profile
echo "if [ -d \"/sbin\" ] ; then\n    PATH=\"/sbin:$PATH\"\nfi" >> /home/${USER}/.profile
echo "if [[ \"$(tty)\" == \"/dev/tty1\" ]]\nthen\n        startx\nfi" >> /home/${USER}/.profile
fi

echo "export \"PATH=$PATH:/usr/local/sbin\"" >> /root/.profile
echo "export \"PATH=$PATH:/usr/local/sbin\"" >> /root/.profile

curl -LJO https://github.com/Boilingtub/Skinny-Linux/raw/main/Skinny-Linux-Theme.tar.gz
tar xvf Skinny-Linux-Theme.tar.gz

mv ./Skinny-Linux-Theme/.gtkrc-2.0 /home/${USER}/.gtkrc-2.0
if [ ! -d "/home/${USER}/.themes"]
then
	mkdir /home/${USER}/.themes
fi

mv ./Skinny-Linux-Theme/Breeze-dark-gtk /home/${USER}/.themes/Breeze-dark-gtk

curl -LJO https://github.com/Boilingtub/Skinny-Linux/raw/main/Skinny-Linux-icons.tar.gz
tar xvf Skinny-Linux-icons.tar.gz

if [! -d "/home/${USER}/.icons"]
then
	mkdir /home/${USER}/.icons
fi

mv ./Skinny-Linux-icons/Vimix                  /home/${USER}/.icons/Vimix
mv ./Skinny-Linux-icons/Vimix-dark             /home/${USER}/.icons/Vimix-dark
mv ./Skinny-Linux-icons/alsamixer-icon.png     /home/${USER}/.icons/alsamixer-icon.png
mv ./Skinny-Linux-icons/Restart-icon.png       /home/${USER}/.icons/Restart-icon.png
mv ./Skinny-Linux-icons/Shutdown-icon.png      /home/${USER}/.icons/Shutdown-icon.png
mv ./Skinny-Linux-icons/terminal-icon.png      /home/${USER}/.icons/terminal-icon.png
mv ./Skinny-Linux-icons/root-terminal-icon.png /home/${USER}/.icons/root-terminal-icon.png





