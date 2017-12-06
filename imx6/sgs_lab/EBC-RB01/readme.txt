
1. Diaplay H pattern for EMI FCC test
   1) change id: 5 --> 3
path: vi /etc/inittab

# The default runlevel.
original:
id:5:initdefault:

new:
id:3:initdefault:

-->Purpose: When you run emi_run_fcc, it will execute "modprobe fbcon",then it will switch to console windows.

2. Display color bar video for EMI EC test
