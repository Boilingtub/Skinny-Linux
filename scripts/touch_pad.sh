#!/bin/sh
if pgrep -x "evtest" > /dev/null 
then 
 echo "jan" | sudo -S pkill evtest &
else
 echo "jan" | sudo -S reroute_event Touchpad /dev/null
fi
