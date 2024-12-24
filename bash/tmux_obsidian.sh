#!/bin/sh

session=obsidian

tmux new-session -d -s $session
tmux send-key -t $session "cd ~/vaults/personal" C-m
tmux send-key -t $session "nvim -c :ObsidianToday" C-m
tmux a -t $session
