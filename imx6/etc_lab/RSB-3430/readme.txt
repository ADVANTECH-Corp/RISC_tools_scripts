
Test emi OS: Linux Yocto 2.1

1. Diaplay H pattern for EMI FCC test.
   1) change id: 5 --> 3
path: vi /etc/inittab

# The default runlevel.
original:
id:5:initdefault:

new:
id:3:initdefault:

   2) Add 'console=tty0' in kernel parameter
setenv mmcargs 'setenv bootargs console=${console},${baudrate} console=tty0 ${smp} root=${mmcroot} ${bootargs}'
saveenv
reset

-->Purpose: When you run emi_run_fcc, it will execute "modprobe fbcon",then it will switch to console windows:

2. Display color bar video (BV_Logo_BT471-1_1080p_MP4.mp4) for EMI EC test.

3. Set eth1:0 static IP(192.168.1.2):
   3.1: Modify file path: /etc/network/interfaces
   3.2: Add static IP of eth1:0 interface:

# Wired or wireless interfaces
auto eth0 eth0:0 eth1 eth1:0

iface eth0 inet dhcp
iface eth0:0 inet static
       address 192.168.0.1
       netmask 255.255.255.0

iface eth1 inet dhcp
iface eth1:0 inet static
       address 192.168.1.2
       netmask 255.255.255.0

