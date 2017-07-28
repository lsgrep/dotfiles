#!/bin/bash


CurrentNetwork=$(nmcli device status |grep -E -v 'disconnected|docker|bridge' |grep connected |awk '{print $4}')

if [ "bitmain-office" = "$CurrentNetwork" ]
then
    echo "current network bitmain-office, switching to bitmain-download"
	nmcli c up bitmain-download
elif [ "bitmain-download" = "$CurrentNetwork" ]
then
    echo "current network bitmain-download, switching to bitmain-office"
	nmcli c up bitmain-office
else
    echo "network down, connecting bitmain-download"
	nmcli c up bitmain-download
fi
