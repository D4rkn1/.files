#!/usr/bin/env sh

session=obsidian

tmux new-session -d -s $session
tmux send-key -t $session l "cd ~/vaults/personal" C-m
tmux send-key -t $session l "nvim" C-m
tmux a -t $session
