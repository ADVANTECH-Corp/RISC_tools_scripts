#!/bin/bash
CON_NAME=work
IMAGE=fsl-image-validation-imx
function select_product()
{
        case $1 in
                "rom5720")
			PRODUCT=imx8mqrom5720a1
                        ;;
                "rom5721")
			PRODUCT=imx8mmrom5721a1
                        ;;
                "rom7720")
			PRODUCT=imx8qmrom7720a1
                        ;;
                "rom5620")
                        PRODUCT=imx8qxprom5620a1
                        ;;
                *)
                        echo "No such project"
			exit 1
                        ;;
        esac
}
select_product $1
echo "[Prepare build $PRODUCT project]"
echo "[Create Folder]"
mkdir workspace
echo "[Pull Docker Image]"
sudo docker pull advrisc/u16.04-imx8lbv1
echo "[Create Container]"
sudo docker run -d --privileged -it --name $CON_NAME -v $PWD/workspace:/home/adv/adv-release-bsp -v /dev:/dev advrisc/u16.04-imx8lbv1 /bin/bash
sudo docker exec work bash -c " sudo chown adv:adv adv-release-bsp;
				cd adv-release-bsp; 
				repo init -u git://github.com/ADVANTECH-Corp/adv-arm-yocto-bsp.git  -b imx-linux-sumo -m imx-4.14.98-2.0.0_ga.xml; 
				repo sync;
				EULA=1 DISTRO=fsl-imx-xwayland MACHINE=$PRODUCT source fsl-setup-release.sh -b build-xwayland;
				bitbake $IMAGE
				"

