#!/bin/sh
SOC=$1
case $SOC in
	"imx8mm")
		echo "[iMX8MM] Make imx-boot"
		make SOC=iMX8MM flash_evk	
	;;
	"imx8m")
		echo "[iMX8MQ] Make imx-boot"
		make SOC=iMX8M flash_evk	
	;;
	"imx8mp")
		echo "[iMX8MP] Make imx-boot"
		make SOC=iMX8MP flash_evk	
	;;
	"imx8qxp")
		echo "[iMX8QXP] Make imx-boot"
		make SOC=iMX8QX REV=C0 flash
	;;
	"imx8qm")
		echo "[iMX8QM] Make imx-boot"
		make SOC=iMX8QM flash
	;;
	*)
		echo "parameter2 must be imx8mm, imx8mp, imx8m, imx8qxp, imx8qm"
	;;
esac
	

