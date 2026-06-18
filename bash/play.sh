#!/usr/bin/sh

socket=/tmp/mpv-socket
playlists=$HOME/musics/playlists
tmp_playlist=/tmp/playlist

mkdir -p $HOME/musics
touch $playlists

: > "$tmp_playlist" || {
    printf '%s\n' "error: cannot write $tmp_playlist" >&2
    exit 1
}

case $1 in
    find) 
        all_playlists=$(cat $playlists | tr '\n' ' ') 
        fd_res=$(fd -e mp3 -e ogg -e flac . $all_playlists)
        
        stripped=""
        while IFS= read -r f; do
            while IFS= read -r dir; do
                if [[ "$f" == "$dir/"* ]]; then
                    stripped+="${f#$dir/}\n"
                    break
                fi
            done < "$playlists"
        done <<< "$fd_res"

        selected=$(printf "$stripped" | rofi -dmenu "search" --no-custom) || exit 1

        while IFS= read -r dir; do
            if [ -f "$dir/$selected" ]; then
                selected="$dir/$selected"
                break
            fi
        done < "$playlists"

        if [ -S $socket ]; then
            printf '{ "command": ["quit"] }\n' | socat - $socket
            rm $socket
        fi
        mpv --loop-file=inf --no-video "$selected" --input-ipc-server="$socket"
    ;;
    selectplaylist) 
        selected_playlist=$(cat $playlists | rofi -dmenu "playlists ") 
        
        if [ $? -eq 1 ]; then
            exit 0
        fi

        fd \
        -tf\
        -e ogg\
        -e mp3\
        -e wav\
        -e flac\
        --search-path "$selected_playlist" \
        . >> "$tmp_playlist" || {
            printf '%s\n' "error: fd failed for $selected_playlist" >&2
            exit 1
        }

        if [ -S $socket ]; then
            printf '{ "command": ["quit"] }\n' | socat - $socket
            rm $socket
        fi
        mpv --no-video --input-ipc-server="$socket" --shuffle --playlist="$tmp_playlist"
    ;;
    addplaylist) 
        newplaylist=$(fd -td . $HOME | rofi -dmenu "select folder") 
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
        if [ -S $socket ]; then
            printf '{ "command": ["quit"] }\n' | socat - $socket
            rm $socket
        else
            while IFS= read -r dir; do
                [ -n "$dir" ] || continue
                fd \
                -tf\
                -e ogg\
                -e mp3\
                -e wav\
                -e flac\
                --search-path "$dir" \
                . >> "$tmp_playlist" || {
                    printf '%s\n' "error: fd failed for $dir" >&2
                    exit 1
                }
            done < "$playlists"
            mpv --no-video --directory-filter-types=audio --input-ipc-server="$socket" --shuffle --playlist="$tmp_playlist"
        fi
    ;;
    next)
        echo '{ "command": ["playlist-next"] }' | socat - $socket
    ;;
    prev)
        echo '{ "command": ["playlist-prev"] }' | socat - $socket
    ;;
    pause)
        ispaused=$(echo '{ "command": ["get_property", "pause"] }' | socat - $socket | jq '.data')
        if [[ "$ispaused" == "false" ]]; then
            echo '{ "command": ["set_property", "pause", true] }' | socat - $socket
        else
            echo '{ "command": ["set_property", "pause", false] }' | socat - $socket
        fi
    ;;
    stop)
        echo '{ "command": ["stop"] }' | socat - $socket
        rm $socket
    ;;
    stat)
        current_file=$(echo '{ "command": ["get_property", "path"] }' | socat - $socket | jq -r '.data')

        if [[ -n "$current_file" ]]; then
            echo -n "$current_file" | wl-copy
            notify-send "Now Playing" "$current_file"
        fi
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
