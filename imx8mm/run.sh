#!/bin/sh
sed -i "s/size=.*/size=$1/g" /etc/xdg/weston/weston.ini
sync
grep "size\=" /etc/xdg/weston/weston.ini
