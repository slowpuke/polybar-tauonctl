#!/usr/bin/env bash

player=$(playerctl -p tauon status 2> /dev/null)
PLAYING=$'\uf04b'
STOPPED=$'\uf04c'
divider="-"
max_char=80

while getopts "d:c:" OPTION; do
    case "$OPTION" in
        d)
            divider=${OPTARG}
            ;;
        c)
            max_char=${OPTARG}
            ;;
        *)
            ;;
    esac
done
shift $((OPTIND-1))

display() {
    artist_title="$(playerctl -p tauon metadata artist 2> /dev/null) $divider $(playerctl -p tauon metadata title 2> /dev/null)"
    if [ "$player" = "Paused" ]; then
        if [ "${#artist_title}" -gt "$max_char" ]; then
            echo "$STOPPED" "$(echo "$artist_title" | head -c "$max_char")" "..."
        else
            echo "$STOPPED $artist_title"
        fi
    elif [ "$player" = "Playing" ]; then
        if [ "${#artist_title}" -gt "$max_char" ]; then
            echo "$PLAYING" "$(echo "$artist_title" | head -c "$max_char")" "..."
        else
            echo "$PLAYING $artist_title"
        fi
    else
        echo ""
    fi
}

play_pause_toggle() {
    if [ "$player" = "Paused" ]; then
        playerctl -p tauon play
    elif [ "$player" = "Playing" ]; then
        playerctl -p tauon pause
    fi
}

song_change() {
    if [ "$1" = "next" ]; then
        playerctl -p tauon next
    elif [ "$1" = "previous" ]; then
        playerctl -p tauon previous
    fi
}

volume_change() {
    if [ "$1" = "up" ]; then
        playerctl -p tauon volume 0.05+
    elif [ "$1" = "down" ]; then
        playerctl -p tauon volume 0.05-
    fi
}

help() {
    echo "\
Usage: $0 [ARG] [ACTION]

Arguments:
    -d              sets a default divider between artist and song. By default it's \"-\"
    -c              sets a maximum amount of character displayed for the artist and song. By default set to 80

Action:
    display         displays the currently playing/paused song
    playpause       pauses/unpauses the song
    next            plays the next song
    previous        plays the previous song
    volumeup        raises the volume by 0.05 ranging from 0 to 1
    volumedown      lowers the volume by 0.05 ranging from 0 to 1
    help            displays all the possible actions

Author:
    slowpuke
GitHub:
    https://github.com/slowpuke/polybar-tauonctl"
}

case "$1" in
    display)
        display
        ;;
    playpause)
        play_pause_toggle
        ;;
    next)
        song_change next
        ;;
    previous)
        song_change previous
        ;;
    volumeup)
        volume_change up
        ;;
    volumedown)
        volume_change down
        ;;
    help)
        help
       ;;
    "")
        echo "No action was specified, for a list of all actions run \`$0 help\`."
        ;;
    *)
        echo "Unrecognised action: $1" >&2
        exit 1
        ;;
esac

