#! /bin/sh

dhcp=$1
address=$2
gateway=$3
netmask=$4
dns=$5


sed -i '/^iface eth0 inet /c iface eth0 inet '$dhcp'' /media/usedata/interfaces
if [ -n "$address" ];then
sed -i '/^address /c address '$address'' /media/usedata/interfaces
sed -i '/^gateway /c gateway '$gateway'' /media/usedata/interfaces
sed -i '/^netmask /c netmask '$netmask'' /media/usedata/interfaces
sed -i '/^nameserver /c nameserver '$dns'' /tmp/resolv.conf
fi

/etc/init.d/S40network restart 
