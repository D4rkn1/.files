#!/usr/bin/sh

socket=/tmp/mpv-socket
playlists=$HOME/musics/playlists

mkdir -p $HOME/musics
touch $playlists

case $1 in
    find) 
        selected_playlist=$(cat $playlists | rofi -dmenu -i -p "playlists ") 
        
        if [ $? -eq 1 ]; then
            exit 0
        fi

        selected=$(find $selected_playlist -type f -name "*.mp3" | rofi -dmenu -i -p "search ")

        if [ $? -eq 1 ]; then
            exit 0
        fi

        if pgrep -x "mpv" > /dev/null
        then
            pkill "mpv"
        fi
        mpv --loop-file=inf --no-video "$selected" --input-ipc-server="$socket"
    ;;
    selectplaylist) 
        selected_playlist=$(cat $playlists | rofi -dmenu -i -p "playlists ") 
        
        if [ $? -eq 1 ]; then
            exit 0
        fi

        tmp_playlist=/tmp/tmp_playlist
        random_string=$(head /dev/urandom | tr -dc A-Za-z0-9 | head -c 8)
        tmp_playlist=$tmp_playlist$random_string
        touch $tmp_playlist
        newplaylist=$(find $selected_playlist -type f -name "*.mp3" | shuf >> $tmp_playlist)
        if [ $? -eq 1 ]; then
            exit 0
        fi

        if pgrep -x "mpv" > /dev/null
        then
            pkill "mpv"
        fi
        mpv --no-video --input-ipc-server="$socket" --playlist="$tmp_playlist"
        rm "$tmp_playlist"
    ;;
    addplaylist) 
        newplaylist=$(find $HOME -type d | rofi -dmenu -i -p "select folder") 
        if [ $? -eq 1 ]; then
            exit 0
        fi

        if grep -xn "$newplaylist" "$playlists"; then
            line_number=$(grep -xn "$newplaylist" "$playlists" | cut -d: -f1)
            newplaylist=$(sed ${line_number}d $playlists)
            
            printf "$newplaylist" | cat > $playlists
            printf "\n" >> $playlists
        else
            echo $newplaylist >> $playlists
        fi
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
