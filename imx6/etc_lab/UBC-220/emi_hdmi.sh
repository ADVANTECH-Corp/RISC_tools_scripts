#!/bin/sh
while true
do
echo "**********************Video play*********************"
gplay --audio-sink='alsasink device="hw:0,0"' /tools/colorbar.mp4 &>/dev/null
done
