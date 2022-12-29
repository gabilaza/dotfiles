#!/bin/sh

STATUS=$(nordvpn status | grep Status | tr -d ' ' | cut -d ':' -f2)

if [ "$STATUS" = "Connected" ]; then
    echo "%{F#fabd2f}%{A1:nordvpn d:}VPN:$(nordvpn status | grep Country | cut -d ':' -f2)%{A}%{F-}"
else
    echo "%{F#fe8019}%{A1:nordvpn c:}VPN%{A}%{F-}"
fi
