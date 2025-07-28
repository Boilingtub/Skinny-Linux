#!/bin/bash

if [ $(cat ~/.mobile_mode) = "0" ]; then 
wvkbd &
wlr-randr --output eDP-1 --transform 180 &
echo "1" > ~/.mobile_mode
elif [ $(cat ~/.mobile_mode) = "1" ]; then
pkill wvkbd &
wlr-randr --output eDP-1 --transform normal &
echo "0" > ~/.mobile_mode
fi

