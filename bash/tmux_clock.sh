#!/bin/sh

session=clock

tmux new-session -d -s $session
tmux clock-mode -t $session
tmux a -t $session
