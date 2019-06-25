#!/bin/bash
SIZE=${SIZE:=1024}
SDDEV="mmcblk1"

dd if=/dev/urandom of=/data2 bs=1 count=$SIZE &>/dev/null
while true
do
	echo "/dev/$SDDEV Reading"
	dd if=/dev/$SDDEV of=/dataY bs=1 count=$SIZE skip=4096 &>/dev/null 

	echo "/dev/$SDDEV Writing"
	dd if=/data2 of=/dev/$SDDEV bs=1 seek=4096 &>/dev/null

	sleep 1
	rm /dataY
done