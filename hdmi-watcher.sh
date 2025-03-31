
#!/bin/bash

export DISPLAY=:0
export XAUTHORITY=/home/c/.Xauthority
LOG="/tmp/hdmi-watcher.log"

echo "===== START $(date) =====" >> "$LOG"

last_state=""

while true; do
    HDMI_LINE=$(xrandr | grep "HDMI-A-0")
    HDMI_STATUS=$(echo "$HDMI_LINE" | awk '{print $2}')

    echo "$(date): HDMI status = $HDMI_STATUS" >> "$LOG"

    if [ "$HDMI_STATUS" = "connected" ]; then
        if [ "$last_state" != "connected" ]; then
            echo "$(date): Detected HDMI CONNECTED" >> "$LOG"
            /home/c/dotfiles/hdmi-connected.sh >> "$LOG" 2>&1
            last_state="connected"
        fi
    else
        if [ "$last_state" != "disconnected" ]; then
            echo "$(date): Detected HDMI DISCONNECTED" >> "$LOG"
            /home/c/dotfiles/hdmi-disconnected.sh >> "$LOG" 2>&1
            last_state="disconnected"
        fi
    fi

    sleep 5
done
