#!/usr/bin/bash

pgrep -x "wf-recorder" && pkill -INT -x wf-recorder && notify-send -h string:wf-recorder:record -t 100 "Finished Recording" -u low && exit 0

notify-send -h string:wf-recorder:record -t 100 "Recording"  -u low

dateTime=$(date +%m-%d-%Y-%H:%M:%S)
wf-recorder -a alsa_output.pci-0000_05_00.6.analog-stereo.monitor --bframes max_b_frames -f $HOME/Recordings/$dateTime.mp4
