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

apt-get install -y doas linux-image-amd64
apt-get autoremove -y
apt-get purge -y linux-image-5.10.0-17-amd64
apt-get purge -y linux-image-5.10.0-16-amd64

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

apt-get install -y pcmanfm lxappearance

curl -LJO https://github.com/Boilingtub/Skinny-Linux/raw/main/Skinny-Linux-theme.tar.gz
tar xf Skinny-Linux-theme.tar.gz

mv ./Skinny-Linux-theme/.gtkrc-2.0 /home/${USER}/.gtkrc-2.0
if [ ! -d "/usr/share/themes"]
then
	mkdir /usr/share/themes
fi

mv ./Skinny-Linux-theme/Breeze-dark-gtk /usr/share/themes/Breeze-dark-gtk

curl -LJO https://github.com/Boilingtub/Skinny-Linux/raw/main/Skinny-Linux-icons.tar.gz
tar xf Skinny-Linux-icons.tar.gz

if [! -d "/usr/share/icons"]
then
	mkdir /usr/share/icons
fi

mv ./Skinny-Linux-icons/Vimix                  /usr/share/icons/Vimix
mv ./Skinny-Linux-icons/Vimix-dark             /usr/share/icons/Vimix-dark
mv ./Skinny-Linux-icons/alsamixer-icon.png     /usr/share/icons/alsamixer-icon.png
mv ./Skinny-Linux-icons/Restart-icon.png       /usr/share/icons/Restart-icon.png
mv ./Skinny-Linux-icons/Shutdown-icon.png      /usr/share/icons/Shutdown-icon.png
mv ./Skinny-Linux-icons/terminal-icon.png      /usr/share/icons/terminal-icon.png
mv ./Skinny-Linux-icons/root-terminal-icon.png /usr/share/icons/root-terminal-icon.png
mv ./Skinny-Linux-icons/lua-icon.svg /usr/share/icons/lua-icon.svg

curl -LJO https://github.com/Boilingtub/Skinny-Linux/raw/main/Skinny-Linux-applications.tar.gz
tar xf Skinny-Linux-applications.tar.gz

mv ./Skinny-Linux-applications/alsamixer.desktop       /usr/share/applications/alsamixer.desktop
mv ./Skinny-Linux-applications/Shutdown.desktop        /usr/share/applications/Shutdown.desktop
mv ./Skinny-Linux-applications/Restart.desktop         /usr/share/applications/Restart.desktop
mv ./Skinny-Linux-applications/Run-In-Terminal.desktop /usr/share/applications/Run-In-Terminal.desktop
mv ./Skinny-Linux-applications/Terminal.desktop        /usr/share/applications/Terminal.desktop
mv ./Skinny-Linux-applications/lua.desktop             /usr/share/applications/lua.desktop
mv ./Skinny-Linux-applications/Shutdown.directory      /usr/share/desktop-directories:/Shutdown.directory
mv ./Skinny-Linux-applications/lxde-applications.menu  /etc/xdg/menus/lxde-applications.menu

apt-get install -y doas linux-image-amd64
apt-get autoremove -y
apt-get purge -y linux-image-5.10.0-17-amd64
apt-get purge -y linux-image-5.10.0-16-amd64
apt-get purge -y vim-common emacsen-common nano python3
apt-get install -y neovim lua5.4
apt-get autoremove -y

rm Suckless-Software.tar.gz
rm -dr Suckless-Software

rm Skinny-Linux-applications.tar.gz
rm -dr Skinny-Linux-applications

rm Skinny-Linux-icons.tar.gz
rm -dr Skinny-Linux-icons

rm Skinny-Linux-theme.tar.gz
rm -dr Skinny-Linux-theme

rm Skinny-Desktop-Setup.sh

