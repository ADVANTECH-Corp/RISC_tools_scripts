# Test EMI in RS02 

OS: Linux Yocto 2.1

* [Setting](#setting)
* [EMI_CE](#emi_ce)

## Setting
PC setting IP 
Example:

       address 192.168.0.2
       netmask 255.255.255.0

Device(RS02) IP address (Already to Setting)

       address 192.168.0.1
       netmask 255.255.255.0

Please use ssh link to device

## EMI_CE

Test USB disk (Five)

1. Copy the file (include all files in RS02 folder) to tools

2. Run CE test

    root@imx6qrsb4411a1:~# cd /

    root@imx6qrsb4411a1:/# /tools/emi_run_ce

