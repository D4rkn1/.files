#!/usr/bin/sh

socket=/tmp/mpv-socket
playlist=$HOME/musics/fav
shuf $playlist -o $playlist

case $1 in
    select) 
        selected=$(find $HOME -type f -name "*.mp3" | rofi -dmenu -i -p "Select music") 
        
        if pgrep -x "mpv" > /dev/null
        then
            pkill "mpv"
        fi
        mpv --no-video "$selected" --input-ipc-server="$socket"
    ;;
    start)
        if pgrep -x "mpv" > /dev/null
        then
            pkill "mpv"
        fi
        mpv --no-video --input-ipc-server="$socket" --playlist="$playlist"
    ;;
    next)
        echo '{ "command": ["playlist-next"] }' | socat - $socket
    ;;
    prev)
        echo '{ "command": ["playlist-prev"] }' | socat - $socket
    ;;
    stop)
        echo '{ "command": ["stop"] }' | socat - $socket
    ;;
    volup)
        current_volume=$(echo '{ "command": ["get_property", "volume"] }' | socat - $socket | jq '.data')
        
        new_volume=$(echo "$current_volume + 5" | bc)

        if [ $new_volume -mt 100 ]; then
            new_volume=100
        fi

        echo '{ "command": ["set_property", "volume", '"$new_volume"'] }' | socat - $socket
    ;;
    voldown)
        current_volume=$(echo '{ "command": ["get_property", "volume"] }' | socat - $socket | jq '.data')
        new_volume=$(echo "$current_volume - 5" | bc)

        if [ $new_volume -lt 10 ]; then
            new_volume=0
        fi
        echo '{ "command": ["set_property", "volume", '"$new_volume"'] }' | socat - $socket
    ;;
    *) echo unknown command
    ;;
esac



