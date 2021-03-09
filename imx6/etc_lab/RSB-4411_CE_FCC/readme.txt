

Test emi OS: Linux Yocto 2.1

ssh link 
ip address
       address 192.168.0.1
       netmask 255.255.255.0

-----------------------------------------------------------------
EMI  CE  (HDMI  colorbar + VGA  colorbar)

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

2.  imx6qrsb4411a1 login: root

3.  run CE test
    root@imx6qrsb4411a1:~# cd /
    root@imx6qrsb4411a1:/# /tools/emi_run_ce

-------------------------------------------------------------------
EMI FCC  (HDMI  H pattern + VGA  colorbar)

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
    root@imx6qrsb4411a1:~# cd /
    root@imx6qrsb4411a1:/# /tools/emi_run_fcc


*  When you run /tools/emi_run_ce, it's display the "Yocto LOGO" in HDMI .
*  Please connect the USB Keyboard and key "Ctrl + Alt + F1".  It's display the "framebuffer console" in HDMI.


