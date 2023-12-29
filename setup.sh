#!/bin/bash -x

if [ $USER != "root" ] ; then
    echo "Restarting script with sudo..."
    sudo $0 ${*}
    exit
fi

for i in 0 2 4 6
do
	accel-config disable-device dsa${i}
done

sleep 3

for i in 0 2 4 6
do
	accel-config config-device dsa${i}
	accel-config config-engine dsa${i}/engine${i}.0 --group-id=0
	accel-config config-wq dsa${i}/wq${i}.0 --driver-name=user --group-id=0 --wq-size=128 --priority=10 --block-on-fault=0 --max-batch-size=32 --max-transfer-size=2097152 --type=user --name=swq --mode=shared --threshold=128
	accel-config enable-device dsa${i}
	accel-config enable-wq dsa${i}/wq${i}.0
done

## Optionally save this config using accel-config save-config -s <>
## and reload using accel-config load-config -c <>
