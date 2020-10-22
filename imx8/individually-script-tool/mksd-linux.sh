#!/bin/bash

#check arg number
if [ $# != 1 ];then
    echo "Usage: ./mksd-linux.sh /dev/sdb ."
    exit
fi

# check the if root?
userid=`id -u`
if [ $userid -ne "0" ]; then
echo "you're not root?"
exit
fi
#
check_node=`echo $1 | grep mmc`
if [ -n "$check_node" ];then
        part="p"
fi
#check image file exist or not?
files=`ls ../image/`
if [ -z "$files" ]; then
echo "There are no file in image folder."
exit
fi

#avoid format my computer
if [ "$1" == "/dev/sda" ];then
        echo "cannot format your filesystem"
        exit
fi

node=$1
#check if /dev/sdx exist?
if [ ! -e ${node} ]; then
echo "There is no "${node}" in you system"
exit
fi

echo "All data on "${node}" now will be destroyed! Continue? [y/n]"
read ans
if [ $ans != 'y' ]; then exit 1; fi

# umount device
umount ${node}* &> /dev/null

# destroy the partition table
dd if=/dev/zero of=${node} bs=512 count=2 conv=fsync &> /dev/null;sync

#partition
echo "partitionfile start"
tmp=partitionfile
#echo u > $tmp
echo n >> $tmp
echo p >> $tmp
echo 1 >> $tmp
echo 16384 >> $tmp
echo +64M >> $tmp
echo n >> $tmp
echo p >> $tmp
echo 2 >> $tmp
echo 147456 >>$tmp
#2.2G->""
echo "" >> $tmp 
echo w >> $tmp
echo "" >> $tmp	
fdisk ${node} < $tmp &> /dev/null
rm $tmp
sync
fdisk -l
echo "partitionfile done"
# format filesystem
mkfs.vfat -F 32 -n "boot" ${node}${part}1
mkfs.ext4 -L "rootfs" ${node}${part}2
sync
sync

dd if=/dev/zero of=${node} bs=1k seek=4096 conv=fsync count=8 1>/dev/null 2>/dev/null;sync
# copy files
echo "dd [u-boot]"
#dd if=../image/u-boot.imx of=${node} bs=512 seek=2 1>/dev/null 2>/dev/null;sync
dd if=../image/flash.bin of=$1 bs=1k seek=33 conv=fsync 1>/dev/null 2>/dev/null;sync
sync
sync

umount mount_point0 &> /dev/null
rm -fr mount_point0 &> /dev/null
mkdir mount_point0

if ! mount -t vfat ${node}${part}1 mount_point0 &> /dev/null; then 
	echo  "Cannot mount ${node}${part}1"
	exit 1
fi
rm -fr mount_point0/*
echo "copy [Image & dtb]"
cp -f ../image/Image mount_point0/
cp -f ../image/imx8* mount_point0/
cp -f ../image/*.dtb mount_point0/
sync
sync

umount ${node}${part}1
sync
sync
if ! mount ${node}${part}2 mount_point0 &> /dev/null; then 
	echo  "Cannot mount ${node}${part}2"
	exit 1
fi
rm -fr mount_point0/*
echo "copy [rootfs]"
tar -jxvf ../image/rootfs.tar.bz2 -C mount_point0/ &> /dev/null
#cp -fr ../Factory_Test/* mount_point0/home/root/ &> /dev/null
sed -i "/cache/d" mount_point0/etc/fstab  # remove cache partition setting 

if [ 1 -eq 1 ];then
# for emmc update usage
    echo "[Copying iNAND upgrate tools...]"
    mkdir mount_point0/mk_inand &> /dev/null
    mkdir mount_point0/mk_inand/image
    mkdir mount_point0/mk_inand/scripts
#    cp -a mac_write* Factory.sh mkinand-linux.sh mkspi-advboot.sh mount_point0/mk_inand/scripts/
    cp -a mkinand-linux.sh mount_point0/mk_inand/scripts/
    
    cp -a ../image/Image ../image/*.dtb ../image/imx8* ../image/rootfs.tar.bz2   mount_point0/mk_inand/image/
#    cp -a ../image/*.bmp mount_point0/mk_inand/image/
    chown -R 0.0 mount_point0/*
fi


sudo sync
sync
umount ${node}${part}2
rmdir mount_point0
sync
echo "mksd done"



