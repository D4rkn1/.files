#!/usr/bin/env sh

session=ping

tmux new-session -d -s $session
tmux send-key -t $session l "ping one.one.one.one | cut -d ' ' -f 8" C-m
tmux a -t $session
