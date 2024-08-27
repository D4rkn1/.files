#!/usr/bin/bash

x=1
while true;
do
	echo "hi $x"
	((x=x+1))
	sleep 1s
done
