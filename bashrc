# .bashrc

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias cmus='cmus --show-cursor'
#alias lynx='lynx www.duckduckgo.com'
alias tuks="cd ~/Documents/TUKS/Semester_2/"
#alias foot="foot -T terminal"
#alias cal="calcurse"

PS1='[\u@\h \W]\$ '

export PATH=$HOME/.local/bin:$PATH

if [ $(tty) == "/dev/tty1" ]; then
echo "starting bashrc"

export XDG_SESSION_TYPE=wayland
export XDG_CURRENT_DESKTOP=sway # sway because this makes obs screen sharing work
export XDG_SESSION_DESKTOP=sway

export QT_AUTO_SCREEN_SCALE_FACTOR=1
export QT_QPA_PLATFORM="wayland;xcb"
export QT_WAYLAND_DISABLE_WINDOWDECORATION=1
export QT_QPA_PLATFORMTHEME=qt5ct

export _JAVA_AWT_WM_NONREPARENTING=1
export CLUTTER_BACKEND="wayland"
export SDL_VIDEODRIVER="wayland,x11"

export GDK_BACKEND="wayland,x11"

slstatus -s | dbus-run-session dwl
fi
. "$HOME/.cargo/env"
