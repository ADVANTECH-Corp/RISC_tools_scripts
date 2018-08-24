llall wpa_supplicant
ifconfig wlan0 up
wpa_passphrase $1 $2 > /tmp/wpa.conf
wpa_supplicant -BDwext -iwlan0 -c/tmp/wpa.conf
udhcpc -b -i wlan0
