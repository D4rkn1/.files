#!/usr/bin/env sh

set -eu

DOWNLOAD_DIR="$HOME/yt-dl"
LOG_DIR="/tmp/ytdl"

prepare_dirs() {
	mkdir -p "$DOWNLOAD_DIR"
	mkdir -p "$LOG_DIR"
}

get_url() {
	URL="$1"

	[ -n "$URL" ] || {
		printf 'missing URL\n' >&2
		exit 1
	}
}

get_video_id() {
	VIDEO_ID="$(yt-dlp --get-id "$URL")"

	[ -n "$VIDEO_ID" ] || {
		notify-send "yt-dlp" "Failed to retrieve video ID."
		exit 1
	}

	LOG_FILE="$LOG_DIR/$VIDEO_ID.log"
	LOCK_DIR="$LOG_DIR/$VIDEO_ID.lock"
}

acquire_lock() {
	if ! mkdir "$LOCK_DIR" 2>/dev/null; then
		notify-send "yt-dlp" "Download already running for video: $VIDEO_ID"
		exit 0
	fi

	trap 'rm -rf "$LOCK_DIR"' EXIT INT TERM HUP
}

download() {
	notify-send "yt-dlp" "Starting download."

	if (
		cd "$DOWNLOAD_DIR"

		yt-dlp \
			-f "bestvideo[height<=?720]+bestaudio[acodec*=opus]/bestvideo[height<=?720]+bestaudio/best[height<=?720]" \
			--merge-output-format mkv \
			-o "%(title)s.%(ext)s" \
			--trim-filenames 100 \
			"$URL"
	) >"$LOG_FILE" 2>&1; then
		notify-send "yt-dlp" "Finished downloading."
	else
		notify-send "yt-dlp" "Download failed. See: $LOG_FILE"
		exit 1
	fi
}

show_logs() {
	entries=""

	for lock in "$LOG_DIR"/*.lock; do
		[ -e "$lock" ] || continue

		id="${lock##*/}"
		id="${id%.lock}"
		log="$LOG_DIR/$id.log"

		[ -f "$log" ] || continue

		entries="${entries}${id}\n"
	done

	[ -n "$entries" ] || {
		notify-send "yt-dlp" "No active downloads."
		exit 0
	}

	selected="$(
		printf "%b" "$entries" |
			rofi -dmenu -no-custom -p "Active downloads"
	)"

	[ -n "$selected" ] || exit 0

	log="$LOG_DIR/$selected.log"

    hyprctl eval "
        hl.exec_cmd(
	        'alacritty -e tail -f \"$log\"',
	        {
		        float = true,
		        center = true,
		        size = {1000, 500},
	        }
        )
    "
}

main() {
	prepare_dirs

	case "${1:-}" in
		log)
			show_logs
			;;
		"")
			printf 'Usage: %s <url>|log\n' "$0" >&2
			exit 1
			;;
		*)
			get_url "$1"
			get_video_id
			acquire_lock
			download
			;;
	esac
}

main "$@"
