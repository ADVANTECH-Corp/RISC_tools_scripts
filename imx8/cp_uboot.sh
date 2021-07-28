#!/bin/sh
UBOOT_PATH=$1
SOC=$2
case $SOC in
	"imx8mm")
		echo "Copy files to [iMX8MM]"
		cp $UBOOT_PATH/u-boot-nodtb.bin iMX8M/u-boot-nodtb.bin
		cp $UBOOT_PATH/u-boot.dtb iMX8M/imx8mm-evk.dtb
		cp $UBOOT_PATH/spl/u-boot-spl.bin iMX8M/u-boot-spl.bin
	;;
	"imx8m")
		echo "Copy files to [iMX8M]"
		cp $UBOOT_PATH/u-boot-nodtb.bin iMX8M/u-boot-nodtb.bin
		cp $UBOOT_PATH/u-boot.dtb iMX8M/imx8mq-evk.dtb
		cp $UBOOT_PATH/spl/u-boot-spl.bin iMX8M/u-boot-spl.bin
	;;
	"imx8mp")
		echo "Copy files to [iMX8MP]"
		cp $UBOOT_PATH/u-boot-nodtb.bin iMX8M/u-boot-nodtb.bin
		cp $UBOOT_PATH/u-boot.dtb iMX8M/imx8mp-evk.dtb
		cp $UBOOT_PATH/spl/u-boot-spl.bin iMX8M/u-boot-spl.bin
	;;
	"imx8qxp")
		echo "Copy files to [iMX8QX]"
		cp $UBOOT_PATH/u-boot.bin iMX8QX/
	;;
	"imx8qm")
		echo "Copy files to [iMX8QM]"
		cp $UBOOT_PATH/u-boot.bin iMX8QM/
	;;
	*)
		echo "parameter2 must be imx8mm, imx8mp, imx8m, imx8qxp, imx8qm"
	;;
esac
	
sync

