#!/bin/sh
if [ "$1" = "p" ]; then
wlr-randr --output eDP-1 --transform 90
fi 

if [ "$1" = "n" ]; then
wlr-randr --output eDP-1 --transform normal
fi
