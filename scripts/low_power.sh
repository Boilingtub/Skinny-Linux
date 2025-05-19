#!/bin/sh
pkill -f Xwayland
pkill -f at-spi-bus-launcher
pkill -f xdg-desktop-portal
pkill -f xdg-document-portal
pkill -f xdg-desktop-portal-wlr
pkill -f at-spi2-registryd
pkill -f xdg-permission-store
if [ "${1}" = "audio" ]; then
    echo "Disabling audio systems"
    pkill -f wireplumber
    pkill -f pipewire
    bluetooth off
fi
