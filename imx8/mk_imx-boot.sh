#!/bin/sh
SOC=$1
case $SOC in
	"imx8mm")
		echo "[iMX8MM] Make imx-boot"
		make SOC=iMX8MM flash_evk	
	;;
	"imx8m")
		echo "[iMX8MM] Make imx-boot"
		make SOC=iMX8M flash_evk	
	;;
	"imx8qxp")
		echo "[iMX8MM] Make imx-boot"
		make SOC=iMX8QX flash
	;;
	"imx8qm")
		echo "[iMX8MM] Make imx-boot"
		make SOC=iMX8QM flash
	;;
	*)
		echo "parameter2 must be imx8mm, imx8m, imx8qxp, imx8qm"
	;;
esac
	

