#!/bin/sh
while true
do
echo "**********************Video play*********************"
#gplay-1.0 --audio-sink='alsasink device="hw:1,0"' /tools/BV_Logo_BT471-1_1080p_MP4.mp4 &>/dev/null
gst-launch-1.0 playbin uri=file:////tools/colorbar.mp4 video-sink="imxv4l2sink device=/dev/video19" &>/dev/null
done
