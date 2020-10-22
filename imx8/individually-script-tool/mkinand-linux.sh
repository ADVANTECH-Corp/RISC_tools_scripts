#!/bin/bash

#check arg number
if [ $# != 1 ];then
	echo "Usage: ./mkinand-linux.sh /dev/mmcblk0"
	exit
fi

# check the if root?
userid=`id -u`
if [ $userid -ne "0" ]; then
echo "you're not root?"
exit
fi

#check image file exist or not?
files=`ls ../image/`
if [ -z "$files" ]; then
echo "There are no file in image folder."
exit
fi

node=$1
#check if /dev/sdx exist?
if [ ! -e ${node} ]; then
echo "There is no "${node}" in you system"
exit
fi
#
check_node=`echo $1 | grep mmc`
if [ -n "$check_node" ];then
        part="p"
fi

#do not ask
#echo "All data on "${node}" now will be destroyed! Continue? [y/n]"
#read ans
#if [ $ans != 'y' ]; then exit 1; fi

# umount device
umount ${node}* &> /dev/null

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
echo "" >> $tmp
echo w >> $tmp
echo "" >> $tmp	
fdisk ${node} < $tmp &> /dev/null
rm $tmp
sync
fdisk -l
echo "partitionfile done"
# format filesystem
mkfs.vfat -F 32 -n boot ${node}${part}1 &> /dev/null
mkfs.ext4 -F -L rootfs ${node}${part}2 &> /dev/null
sync

# copy files
echo "dd [u-boot]"
#This is diffrent `from mksd_*.sh
dd if=/dev/zero of=${node} bs=1k seek=4096 conv=fsync count=8 1>/dev/null 2>/dev/null;sync
dd if=../image/flash.bin of=$1 bs=1k seek=33 conv=fsync 1>/dev/null 2>/dev/null;sync
sync
sync

rm -fr mount_point0
mkdir mount_point0
mount ${node}${part}1 mount_point0/ &> /dev/null
rm -fr mount_point0/*
echo "copy [Image & dtb]"
cp -f ../image/Image mount_point0/
cp -f ../image/imx8* mount_point0/
cp -f ../image/*.dtb mount_point0/
sync

umount ${node}${part}1
mount ${node}${part}2 mount_point0/ &> /dev/null
rm -fr mount_point0/*
echo "copy [rootfs]"
tar -xvf ../image/rootfs.tar.bz2 -C mount_point0/ &> /dev/null
sed -i "/cache/d" mount_point0/etc/fstab  # remove cache partition setting
sync
umount ${node}${part}2
rmdir mount_point0
sync
echo "mkinand done"
