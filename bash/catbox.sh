#!/bin/bash
key=$(< $HOME/secrets/catbox)

if [ $# -ge 1 ]; then
    for file in "$@"; do
        curl -F "fileToUpload=@$file" -F "userhash=$key" -F "reqtype=fileupload" https://catbox.moe/user/api.php | wl-copy
        notify-send -u low "up" 
    done
else
    slurp | grim -g - - | curl -F "reqtype=fileupload" -F "fileToUpload=@-;filename=screenshot.png" -F "userhash=$key" https://catbox.moe/user/api.php | wl-copy
    notify-send -u low "up" 
fi
