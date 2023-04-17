#!/bin/bash

xrandr --setmonitor HDMI-1~1 960/254x1080/286+0+0 HDMI-1 &
xrandr --setmonitor HDMI-1~2 960/255x1080/286+960+0 none & 
    
xrandr --fb 1921x1080 &
xrandr --fb 1920x1080 &

xrandr --output HDMI-1~1 --mode 960x1080 --output HDMI-1~2 --mode 960x1080 --right-of HDMI-1~1 &
