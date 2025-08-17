#!/bin/bash
key=$(< $HOME/secrets/sul)

if [ $# -ge 1 ]; then
    for file in "$@"; do
        curl -s -F "file=@$file" "https://s-ul.eu/api/v1/upload?wizard=true&key=$key" | jq -r '.url' | tr -d '\n' | wl-copy
        notify-send -u low "up" 
    done
else
    slurp | grim -g - - | curl -s -F "file=@-;filename=screenshot.png" "https://s-ul.eu/api/v1/upload?wizard=true&key=$key" | jq -r '.url' | tr -d '\n' | wl-copy
    notify-send -u low "up" 
fi
