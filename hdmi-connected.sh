#!/bin/sh
redshift -x
redshift -O 2800
xrandr --output eDP --off --output HDMI-A-0 --mode 1920x1080 --rate 143.86
nitrogen --restore
