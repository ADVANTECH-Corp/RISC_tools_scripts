#!/bin/bash
USBTYPE=( "USB-1" "USB-2" )
USBBUS=( "1-1.1/1-1.1:1.0" "1-1.2/1-1.2:1.0" )
USBDEV=""
SIZE=${SIZE:=1024}

dd if=/dev/urandom of=/data bs=1 count=$SIZE &>/dev/null
while true
do
	for N in 0 1; do
	  SYSBUS="/sys/devices/soc0/soc/2100000.aips-bus/2184200.usb/ci_hdrc.1/usb1/1-1/${USBBUS[N]}/host*/target*:0:0/*:0:0:0/block"
	  USBDEV=`ls $SYSBUS 2>/dev/null`
	  if [ "$USBDEV" == "" ]; then echo "${USBTYPE[N]} not detected"; continue; fi

	  echo "${USBTYPE[N]} Reading"
	  dd if=/dev/$USBDEV of=/dataX bs=1 count=$SIZE skip=4096 &>/dev/null 

	  echo "${USBTYPE[N]} Writing"
	  dd if=/data of=/dev/$USBDEV bs=1 seek=4096 &>/dev/null

	sleep 1
	done
	rm /dataX
done
