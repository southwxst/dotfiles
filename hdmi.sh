#!/bin/sh

# Reset Redshift (if it's running)
redshift -x

# Set Redshift color temperature to 2800K
redshift -O 2800

# Switch to external display at 144Hz and turn off the internal display
xrandr --output eDP --off --output HDMI-A-0 --mode 1920x1080 --rate 143.86 && nitrogen --restore
