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

#purge unneeded packages
apt-get purge -y vim-common emacsen-common nano #python3

apt-get install -y zstd

#update system and remove kernels
export DEBIAN_FRONTEND=noninteractive
apt-get update -yq

apt-get autoremove -yq
apt-get purge -yq linux-image-5.10.0-17-amd64
apt-get purge -yq linux-image-5.10.0-16-amd64

apt-get upgrade -yq
export DEBIAN_FRONTEND=dialog

#install wanted needed packages
apt-get install -y curl xorg alsa-utils pcmanfm lxappearance doas neovim lua5.4 xwallpaper

echo "permit persist ${USER} as root" >> /etc/doas.conf

#set sbin to be accessable
echo "if [ -d "usr/local/sbin" ] ; then\n   PATH=\"usr/local/sbin:$PATH\"\nfi" >> /home/${USER}/.profile
echo "if [ -d \"/sbin\" ] ; then\n    PATH=\"/sbin:$PATH\"\nfi" >> /home/${USER}/.profile
echo "export \"PATH=$PATH:/usr/local/sbin\"" >> /root/.profile
echo "export \"PATH=$PATH:/usr/local/sbin\"" >> /root/.profile


#install customizations form github
curl -LJO https://github.com/Boilingtub/Skinny-Linux/x86_64/raw/main/Suckless-Software.tar.gz
tar xf Suckless-Software.tar.gz
chmod +x ./Suckless-Software/Suckless-Software-Setup.sh
./Suckless-Software/Suckless-Software-Setup.sh

curl -LJO https://github.com/Boilingtub/Skinny-Linux/x86_64/raw/main/Skinny-Linux-theme.tar.gz
tar xf Skinny-Linux-theme.tar.gz
chmod +x ./Skinny-Linux-theme/Skinny-theme-setup.sh
./Skinny-Linux-theme/Skinny-theme-setup.sh

curl -LJO https://github.com/Boilingtub/Skinny-Linux/x86_64/raw/main/Skinny-Linux-icons.tar.gz
tar xf Skinny-Linux-icons.tar.gz
chmod +x ./Skinny-Linux-icons/Skinny-icons-setup.sh
./Skinny-Linux-icons/Skinny-icons-setup.sh

curl -LJO https://github.com/Boilingtub/Skinny-Linux/x86_64/raw/main/Skinny-Linux-applications.tar.gz
tar xf Skinny-Linux-applications.tar.gz
chmod +x ./Skinny-Linux-applications/Skinny-applications-setup.sh
./Skinny-Linux-applications/Skinny-applications-setup.sh

curl -LJO https://github.com/Boilingtub/Skinny-Linux/x86_64/raw/main/Skinny-Neovim.tar.gz
tar xf Skinny-Neovim.tar.gz
chmod +x ./Skinny-Neovim/Skinny-neovim-setup.sh
./Skinny-Neovim/Skinny-neovim-setup.sh

curl -LJO https://github.com/Boilingtub/Skinny-Linux/x86_64/raw/main/Skinny-Linux-fonts.tar.gz
tar xf Skinny-Linux-fonts.tar.gz
chmod +x ./Skinny-Linux-fonts/Skinny-fonts-setup.sh
./Skinny-Linux-fonts/Skinny-fonts-setup.sh

#remove and clean system
apt-get purge -y --autoremove python3 lxde-icon-theme
apt-get autoremove -yq
apt clean

#remove github packages
rm Suckless-Software.tar.gz
rm -dr Suckless-Software

rm Skinny-Linux-applications.tar.gz
rm -dr Skinny-Linux-applications

rm Skinny-Linux-icons.tar.gz
rm -dr Skinny-Linux-icons

rm Skinny-Linux-theme.tar.gz
rm -dr Skinny-Linux-theme

rm Skinny-Neovim.tar.gz
rm -dr Skinny-Neovim

rm Skinny-Linux-fonts.tar.gz
rm -dr Skinny-Linux-fonts       

rm Skinny-Desktop-Setup.sh

