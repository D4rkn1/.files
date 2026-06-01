#!/bin/sh
keys=$(ls $HOME/.ssh | grep -v '\.pub\|config\|known_hosts\|authorized_keys\|agent')
eval $(keychain --eval --quiet $keys)
