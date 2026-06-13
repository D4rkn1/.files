#!/usr/bin/env sh

set -eu

url="$(wl-paste)"

[ -n "$url" ] || {
	printf 'clipboard is empty\n' >&2
	exit 1
}

yt-dlp \
	-f "bestvideo[height<=?720]+bestaudio[acodec*=opus]/bestvideo[height<=?720]+bestaudio/best[height<=?720]" \
	--merge-output-format mkv \
	-o "%(title)s.%(ext)s" \
	"$url"
