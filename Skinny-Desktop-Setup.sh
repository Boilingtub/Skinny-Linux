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

apt-get install -y curl xorg alsa-utils
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
