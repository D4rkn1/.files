#!/bin/bash

for i in {1..12}; do
  tr -dc 'A-Za-z0-9' </dev/urandom | head -c 12
  echo
done | wl-copy
