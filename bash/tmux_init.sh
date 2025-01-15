#!/bin/sh

tmux new-session -d -s "config"
tmux send-key -t "config" "cd ~/.files" C-m
tmux send-key -t "config" "vi" C-m

