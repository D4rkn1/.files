#!/bin/sh

$keys=$(ls | grep -v '\.pub\|config\|known_hosts\|authorized_keys\|agent')
eval $(keychain --eval --quiet --agents ssh $keys)
