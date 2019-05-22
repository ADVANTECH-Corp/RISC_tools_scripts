#!/bin/sh
while true
do
echo "**********************Video play*********************"
gplay-1.0 --audio-sink='alsasink device="hw:1,0"' /tools/EN55032_Color_Bar.mp4 &>/dev/null
done
