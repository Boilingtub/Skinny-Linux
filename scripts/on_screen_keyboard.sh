#!/bin/bash
if pgrep -x "wvkbd" > /dev/null
then 
  pkill wvkbd
else
  wvkbd
fi

