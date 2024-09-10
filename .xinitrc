#!/bin/sh
#~/.fehbg &
xbindkeys

xmodmap ~/.Xmodmap
xrdb -merge ~/.Xresources
exec i3
