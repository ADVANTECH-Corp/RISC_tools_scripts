#!/bin/bash
USBTYPE=( "USB-1" "USB-2" )
USBBUS=( "2-1/2-1:1.0" "4-1/4-1:1.0" )
USBDEV=""
SIZE=${SIZE:=1024}

dd if=/dev/urandom of=/data bs=1 count=$SIZE &>/dev/null
while true
do
	for N in 0 1; do
	  SYSBUS="/sys/devices/platform/usb@38*00000/38*00000.dwc3/xhci-hcd.*.auto/usb*/${USBBUS[N]}/host*/target*:0:0/*:0:0:0/block"
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
