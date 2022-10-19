

ssh link 
ip address
       address 192.168.0.1
       netmask 255.255.255.0

-----------------------------------------------------------------
Quick Test Step (EMI  CE)

1. Login
   root@imx6ubc220 login: root

2. Modify run-level
   root@imx6ubc220:~# sed -i '/id:/cid:5:initdefault:' /etc/inittab

3. U-boot env setting
   root@imx6ubc220:~# fw_setenv mmcargs 'setenv bootargs console=${console},${baudrate} ${smp} root=${mmcroot} ${bootargs}'
   root@imx6ubc220:~# sync

4. System restart

5. Login again
   root@imx6ubc220 login: root

6. Run CE test
   root@imx6ubc220:~# cd /
   root@imx6ubc220:/# /tools/emi_run_ce

-----------------------------------------------------------------
Quick Test Step (EMI  FCC)

1. Login
   root@imx6ubc220 login: root

2. Modify run-level
   root@imx6ubc220:~# sed -i '/id:/cid:3:initdefault:' /etc/inittab

3. U-boot env setting
   root@imx6ubc220:~# fw_setenv mmcargs 'setenv bootargs console=${console},${baudrate} console=tty0 ${smp} root=${mmcroot} ${bootargs}'
   root@imx6ubc220:~# sync

4. System restart

5. Login again
   root@imx6ubc220 login: root

6. Run FCC test
   root@imx6ubc220:~# cd /
   root@imx6ubc220:/# /tools/emi_run_fcc

-----------------------------------------------------------------
EMI  CE  (HDMI  colorbar)

1. Display colorbar  for EMI CE test.
   (1) check id is 5. 
       path: vi /etc/inittab
       # The default runlevel.
       original:
       id:5:initdefault:     

   (2) Setting to defualt uboot env parameter
      1. System boot up 
      2. Setting in uboot env
      3. Send command
          env default -a
          saveenv
          reset

2.  root@imx6ubc220 login: root

3.  run CE test
    root@imx6ubc220:~# cd /
    root@imx6ubc220:/# /tools/emi_run_ce

-------------------------------------------------------------------
EMI FCC  (HDMI  H pattern)

1. Diaplay H pattern for EMI FCC test.
   (1) change id: 5 --> 3
      path: vi /etc/inittab

      # The default runlevel.
        original:
        id:5:initdefault:

      new:
        id:3:initdefault:

   (2) Add 'console=tty0' in kernel parameter
      1. System boot up 
      2. Setting in uboot env
      3. Send command
         setenv mmcargs 'setenv bootargs console=${console},${baudrate} console=tty0 ${smp} root=${mmcroot} ${bootargs}'
         saveenv
         reset

-->Purpose: When you run emi_run_fcc, it will execute "modprobe fbcon",then it will switch to console windows:

3.  run FCC test
    root@imx6ubc220:~# cd /
    root@imx6ubc220:/# /tools/emi_run_fcc


*  When you run /tools/emi_run_ce, it's display the "Yocto LOGO" in HDMI .

