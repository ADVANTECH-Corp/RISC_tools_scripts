#!/bin/sh
UBOOT_PATH=$1
SOC=$2
case $SOC in
	"imx8mm")
		echo "Copy files to [iMX8MM]"
		cp $UBOOT_PATH/u-boot-nodtb.bin iMX8M/u-boot-nodtb.bin
		cp $UBOOT_PATH/u-boot.dtb iMX8M/fsl-imx8mm-evk.dtb
		cp $UBOOT_PATH/spl/u-boot-spl.bin iMX8M/u-boot-spl.bin

		[ -e iMX8M/imx8mm-evk.dtb ] && rm iMX8M/imx8mm-evk.dtb
		cp $UBOOT_PATH/tools/mkimage iMX8M/mkimage_uboot
		rm -rf iMX8M/mkimage_imx8
	;;
	"imx8m")
		echo "Copy files to [iMX8M]"
		cp $UBOOT_PATH/u-boot-nodtb.bin iMX8M/u-boot-nodtb.bin
		cp $UBOOT_PATH/u-boot.dtb iMX8M/fsl-imx8m-evk.dtb
		cp $UBOOT_PATH/spl/u-boot-spl.bin iMX8M/u-boot-spl.bin
		cp $UBOOT_PATH/tools/mkimage iMX8M/mkimage_uboot
		rm -rf iMX8M/mkimage_imx8
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
		echo "parameter2 must be imx8mm, imx8m, imx8qxp, imx8qm"
	;;
esac
	
sync

