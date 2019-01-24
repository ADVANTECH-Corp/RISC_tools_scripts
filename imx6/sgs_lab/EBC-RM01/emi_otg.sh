#!/bin/bash
USBTYPE=( "OTG-1")
USBBUS=("1-1/1-1:1.0")
USBDEV=""

#Yocto 2.1 path
#insert otg before boot the device
USBOTGPATH="/sys/devices/platform/soc/30800000.aips-bus/30b10000.usb/ci_hdrc.0/usb1"
SIZE=${SIZE:=5120}

dd if=/dev/urandom of=/dataOTG bs=1 count=$SIZE &>/dev/null
while true
do
	for N in 0; do
	  SYSBUS="$USBOTGPATH/${USBBUS[N]}/host*/target*:0:0/*:0:0:0/block"
	  #echo "${USBTYPE[N]} $SYSBUS"
	  USBDEV=`ls $SYSBUS 2>/dev/null`
	  if [ "$USBDEV" == "" ]; then echo "${USBTYPE[N]} not detected"; continue; fi

      echo "${USBTYPE[N]} Writing"
	  dd if=/dataOTG of=/dev/$USBDEV bs=1024 seek=4096 &>/dev/null

	  echo "${USBTYPE[N]} Reading"
	  dd if=/dev/$USBDEV of=/dataOTG bs=1024 count=$SIZE skip=4096 &>/dev/null 

	sleep 1
	done
done

