#!/bin/sh

if [ $# -lt 4  ];then
        echo "usage:$0 tunnelPort sshServer devicePort key [userName]"
        exit;
fi

sshport=$1
sshserver=$2
devport=$3
key=$4
username=$5

if [ ! $username ]; then
        username="ovrc"
fi

echo -e "${key}" > /tmp/id_rsa_ovrc
chmod 600 /tmp/id_rsa_ovrc

while true
do
ssh -o StrictHostKeyChecking=no -N -i /tmp/id_rsa_ovrc -p 22 -R 0.0.0.0:$sshport:127.0.0.1:$devport $username@$sshserver
sleep 1

done
