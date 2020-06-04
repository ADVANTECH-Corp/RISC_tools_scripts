#!/bin/bash
USBTYPE=( "USB-1" )
USBBUS=( "2-1/2-1:1.0" "4-1/4-1:1.0" )
USBDEV=""
SIZE=${SIZE:=1024}

dd if=/dev/urandom of=/data bs=1 count=$SIZE &>/dev/null
while true
do
	  SYSBUS="/sys/devices/platform/32e50000.usb/ci_hdrc.1/usb1/1-1/1-1.1/1-1.1:1.0/host0/target0:0:0/0:0:0:0/block"
	  USBDEV=`ls $SYSBUS 2>/dev/null`
	  if [ "$USBDEV" == "" ]; then echo "${USBTYPE[0]} not detected"; continue; fi

	  echo "${USBTYPE[0]} Reading"
	  dd if=/dev/$USBDEV of=/dataX bs=1 count=$SIZE skip=4096 &>/dev/null 

	  echo "${USBTYPE[0]} Writing"
	  dd if=/data of=/dev/$USBDEV bs=1 seek=4096 &>/dev/null

	sleep 1
	rm /dataX
done
