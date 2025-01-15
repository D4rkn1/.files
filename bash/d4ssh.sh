#!/bin/sh

myssh=$(ssh-agent -s)
eval $myssh
myadd="ssh-add $HOME/.ssh/D4rkn1"
eval $myadd

