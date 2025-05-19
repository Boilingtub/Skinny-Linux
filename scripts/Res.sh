#!/bin/sh
if [ "$1" = "low" ]; then
wlr-randr --output eDP-1  --custom-mode 720x400@60Hz  
fi
if [ "$1" = "mid" ]; then
wlr-randr --output eDP-1  --custom-mode 1280x720@60Hz  
fi
if [ "$1" = "high" ]; then
wlr-randr --output eDP-1  --custom-mode 1920x1080@60Hz  
fi
