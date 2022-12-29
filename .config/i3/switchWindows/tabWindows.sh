#!/bin/bash

windowId=$(python ~/.config/i3/switchWindows/tabWindows.py)
if [ -n "$windowId" ]; then
    i3-msg [id="$windowId"] focus > /dev/null
fi
