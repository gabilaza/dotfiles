#!/bin/sh

case "$1" in
    --toggle)
        dunstctl set-paused toggle
        ;;
    *)
        if [ "$(dunstctl is-paused)" = "true" ]; then
            echo "%{F#fe8019}"Bell"%{F-}"
        else
            echo "%{F#fabd2f}"Bell"%{F-}"
        fi
        ;;
esac
