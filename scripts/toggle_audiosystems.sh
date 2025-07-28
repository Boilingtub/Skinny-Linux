#!/bin/bash
if pgrep -x "pipewire" > /dev/null 
then 
  pkill pipewire &
  pkill wireplumber &
else
  pipewire &
  wireplumber &
fi

