#!/bin/sh
while true
do
gst-launch-1.0 playbin uri=file:////tools/EN55032_Color_Bar.mp4 1>/dev/null 2>/dev/null
sleep 1
done
