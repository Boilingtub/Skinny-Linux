# .bashrc

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '

export PATH=$HOME/.local/bin:$PATH
#export LIBSEAT_BACKEND=logind

if [ $(tty) == "/dev/tty1" ]; then
echo "starting bashrc"
#sudo rm -rf /run/wpa_supplicant/wlo1
#sudo wpa_supplicant -B -iwlo1 -c/etc/wpa_supplicant/wpa_supplicant.conf -D wext
#sudo dhcpcd

#export XDG_RUNTIME_DIR=/run/user/$(id -u)
#sudo mkdir $XDG_RUNTIME_DIR
#sudo chown -R $USER:$USER $XDG_RUNTIME_DIR
#sudo chmod -R 700 $XDG_RUNTIME_DIR

dbus-run-session dwl >> "$HOME/.cache/dwl_info"
fi
