
#!/bin/sh

export DISPLAY=:0
export XAUTHORITY=/home/c/.Xauthority

# HDMI接続されてるか判定
if xrandr | grep "HDMI-A-0 connected"; then
    ~/dotfiles/hdmi-connected.sh
else
    ~/dotfiles/hdmi-disconnected.sh
fi
