#!/bin/sh

if lsof /dev/video0 >/dev/null 2>&1; then
    camera="%{F#b8bb26}"•"%{F-}"
fi

if pacmd list-sources 2>&1 | grep -q RUNNING; then
    mic="%{F#b57614}"•"%{F-}"
fi

echo "$camera$mic"
