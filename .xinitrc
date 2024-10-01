#!/bin/sh
xbindkeys

xmodmap ~/.Xmodmap
xrdb -merge ~/.Xresources
exec i3
