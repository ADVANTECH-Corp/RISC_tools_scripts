#!/bin/bash

#Yocto 2.1 path
USBTYPE=( "USB-1" "USB-2")

#insert usb before boot the device
# case A: Support USB-OTG Port
USBBUS=( "2-1.1/2-1.1:1.0/" "2-1.2/2-1.2:1.0/")
USBPATH="/sys/devices/platform/soc/30800000.aips-bus/30b20000.usb/ci_hdrc.1/usb2/2-1"

# case B: unsupport USB-OTG Port
#USBBUS=( "1-1.1/1-1.1:1.0/" "1-1.2/1-1.2:1.0/")
#USBPATH="/sys/devices/platform/soc/30800000.aips-bus/30b20000.usb/ci_hdrc.1/usb1/1-1"

USBDEV=""
SIZE=${SIZE:=5120}

dd if=/dev/urandom of=/dataUSB bs=1024 count=$SIZE &>/dev/null

while true
do
	for N in 0 1; do
	  SYSBUS="$USBPATH/${USBBUS[N]}/host*/target*:0:0/*:0:0:0/block"
	  #echo "${USBTYPE[N]} $SYSBUS"
	  USBDEV=`ls $SYSBUS 2>/dev/null`
	  if [ "$USBDEV" == "" ]; then echo "${USBTYPE[N]} not detected"; continue; fi

	  echo "${USBTYPE[N]} Writing"
	  dd if=/dataUSB of=/dev/$USBDEV bs=1024 seek=4096 &>/dev/null

      echo "${USBTYPE[N]} Reading"
	  dd if=/dev/$USBDEV of=/dataUSB bs=1024 count=$SIZE skip=4096 &>/dev/null

	sleep 1
	done
done
