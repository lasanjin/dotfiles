#!/bin/bash

read STATUS </sys/class/drm/card0/card0-DP-2/status

if [ "$STATUS" == "connected" ]; then
    . /home/lasanjin/.scripts/blue && blue on
else
    . /home/lasanjin/.scripts/blue && blue off
fi
