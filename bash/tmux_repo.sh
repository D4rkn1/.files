#!/bin/sh

touch repolist

case $1 in
    find)
        repolist=$(fd -H -t d -g ".git" ~/repo)

        repolist_cleaned=$(echo "$repolist" | sed 's/\.git\///g')

        # repocount=$(echo "$repolist" | wc -l)
        #
        selected_repo=$(echo "$repolist_cleaned" | rofi -dmenu -i -p ">>> ") 
        if [ $? -eq 1 ]; then
            exit 0
        fi
        repo=$(echo "$selected_repo" | xargs basename)

        if tmux has-session -t "$repo" 2>/dev/null; then
            hyprctl dispatch exec "[workspace 1] alacritty -e tmux a -t $repo"
        else
            tmux new-session -d -s $repo
            tmux send-key -t $repo "cd $selected_repo" C-m
            tmux send-key -t $repo "vi" C-m
            hyprctl dispatch exec "[workspace 1] alacritty -e tmux a -t $repo"
        fi
    ;;
    read)
    ;;
    *)
        echo unknown command
    ;;
esac

