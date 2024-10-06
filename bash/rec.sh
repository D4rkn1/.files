#!/usr/bin/bash

pgrep -x "wf-recorder" && pkill -INT -x wf-recorder && notify-send -h string:wf-recorder:record -t 100 "Finished Recording" -u low && exit 0

notify-send -h string:wf-recorder:record -t 100 "Recording in:" "<span color='#90a4f4' font='26px'><i><b>1</b></i></span>" -u low

sleep 1

dateTime=$(date +%m-%d-%Y-%H:%M:%S)
wf-recorder --bframes max_b_frames -f $HOME/Recordings/$dateTime.mp4
