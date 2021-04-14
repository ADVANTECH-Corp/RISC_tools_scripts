#!/bin/sh
stty -F /dev/ttymxc1 speed 115200 -echo;
cat /dev/ttymxc1 & 
while true
do
	echo "[Serial Port]" > /dev/ttymxc1
	sleep 1
done

