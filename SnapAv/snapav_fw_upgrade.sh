#!/bin/sh
if [ $# -le 0  ];then
	echo "usage:$0 fw_name"
	exit;
fi


if [ ! -f "$1" ];then
	echo "$1" not exist !!
	exit;
fi


if [ -f /tmp/fw_upgrade.lock ];then
	echo "upgrade running !! please wait untill previous one finish!"
	exit
fi

/etc/init.d/S50nginx stop

touch /tmp/fw_upgrade.lock

cd /media/userdata/

mkdir fw_upgrade

unzip "$1" -o -d fw_upgrade
if [ $? != 0 ];then
	echo "extract fw faild!!"
	rm $1
	rm /tmp/fw_upgrade.lock
	/etc/init.d/S50nginx start
	exit;
fi
rm $1
fwdir=`ls fw_upgrade | head -n 1`

echo $fwdir

cd /media/userdata/fw_upgrade/$fwdir
ls 
deleteDb=`cat deleteDb.config`
if [ "$deleteDb" = "true" ];then
	rm /media/userdata/*
fi
boardt=`cat boardtype`
boardt=$boardt
if [ `hostname`_t != ${boardt}_t  ];then
	
	echo "boardtype error"
	rm /tmp/fw_upgrade.lock
	rm -rf fw_upgrade
	/etc/init.d/S50nginx start
	exit ; 
fi

bootimgchecksum=`cat checksum.txt | grep boot.img | cut -d ' ' -f 1`
bootimgchecksum=$bootimgchecksum
echo $bootimgchecksum

bootimgcchecksum=`md5sum boot.img | cut -d ' ' -f 1`
bootimgcchecksum=$bootimgcchecksum
echo $bootimgcchecksum

rootfschecksum=`cat checksum.txt | grep rootfs | cut -d ' ' -f 1`
rootfschecksum=$rootfschecksum
echo $rootfschecksum

rootfscchecksum=`md5sum rootfs.img | cut -d ' ' -f 1`
rootfscchecksum=$rootfscchecksum
echo $rootfscchecksum

if [ $bootimgchecksum != $bootimgcchecksum ]
then
	echo "boot checksum error"
	rm /tmp/fw_upgrade.lock
	rm -rf fw_upgrade
	/etc/init.d/S50nginx start
	exit;
fi
if [ $rootfschecksum != $rootfscchecksum  ]
then
	echo "rootfs checksum error!!"
	rm -rf fw_upgrade
	rm /tmp/fw_upgrade.lock
	/etc/init.d/S50nginx start
	exit;
fi

echo "everythin is ok !! upgrading"
snapav_updater -b boot.img -r rootfs.img

if [  -f ./setup.sh ];then
	./setup.sh
fi

echo "upgrade finish !,rebooting"


cd -
rm -rf fw_upgrade
rm /tmp/fw_upgrade.lock

reboot



