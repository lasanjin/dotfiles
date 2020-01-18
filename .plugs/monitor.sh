#!/bin/bash

read PORT </sys/class/drm/card0/card0-DP-2/status # connected/disconnected

if [ "$PORT" == "connected" ]; then
    . /home/lasanjin/.scripts/blue && blue on
else
    . /home/lasanjin/.scripts/blue && blue off
fi
