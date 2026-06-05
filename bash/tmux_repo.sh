#!/usr/bin/env sh

list_repo() {
    fd -H -t d -g ".git" $1
}

clean_repolist() {
    sed -e "s|^$1||" -e 's|/\.git/||g'
}

repolist_clean() {
    list_repo "$1" | clean_repolist "$1"
}

tmux_focus() {
    dir=$1
    repo=$(basename $dir)
    shift
    cmd="[workspace 8] alacritty -e tmux a -t $repo"
    if tmux has-session -t "$repo" 2>/dev/null; then
        hyprctl dispatch 'hl.dsp.focus({ workspace = "8" })'
    else
        tmux new-session -d -s $repo
        for key in "$@"; do
            tmux send-key -t "$repo" l "$key" C-m
        done
        hyprctl eval "hl.exec_cmd('$cmd')"
    fi
}

create_dir() {
    if [[ ! -d "$1" ]] then
        mkdir -p "$1"
    fi
}

case $1 in
    find)
        repo_dir="$HOME/repo/"
        selected=$(repolist_clean "$repo_dir" | rofi -dmenu -no-custom)
        tmux_focus "$repo_dir$selected" "cd $repo_dir$selected" "vi"
    ;;
    create)
        personal_repo_dir="$HOME/repo/personal/"
        selected=$(repolist_clean "$personal_repo_dir" | rofi -dmenu -format f -theme-str 'inputbar { enabled: true; }')
        create_dir "$personal_repo_dir$selected"
        repo=$(basename $selected)
        tmux_focus "$personal_repo_dir$selected" "cd $personal_repo_dir$selected" "git init -b master" "vi"
    ;;
    *)
        echo unknown command
    ;;
esac

