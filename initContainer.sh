#!/bin/bash
CONFIGTARGET="/etc/init.d/fhem"
mkdir $MOUNTPATH
chown fhem:dialout $MOUNTPATH
mount -t cifs //$SMB_IP/$SHARE_NAME $MOUNTPATH
cp ${MOUNTPATH}fhem $CONFIGTARGET
service fhem start
