#!/usr/bin/env bash

player=$(playerctl -p tauon status 2> /dev/null)
PLAYING=$'\uf04b'
STOPPED=$'\uf04c'

function display() {
    if [ "$player" = "Paused" ]; then
        echo "$STOPPED $(playerctl -p tauon metadata artist) // $(playerctl -p tauon metadata title)"
    elif [ "$player" = "Playing" ]; then
        echo "$PLAYING $(playerctl -p tauon metadata artist) // $(playerctl -p tauon metadata title)"
    else
        echo ""
    fi
}

function play_pause_toggle() {
    if [ "$player" = "Paused" ]; then
        playerctl -p tauon play
    elif [ "$player" = "Playing" ]; then
        playerctl -p tauon pause
    fi
}

function song_change() {
    if [ "$1" = "next" ]; then
        playerctl -p tauon next
    elif [ "$1" = "previous" ]; then
        playerctl -p tauon previous
    fi
}

function help() {
    echo "\
Usage: $0 ACTION

Action:
    display         displays the currently playing/paused song
    playpause       pauses/unpauses the song
    next            plays the next song
    previous        plays the previous song
    help            displays all the possible actions

Author:
    slowpuke
GitHub:
    https://github.com/slowpuke/tauon-playerctl"
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

