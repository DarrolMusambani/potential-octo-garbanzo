#!/bin/bash

SMB_IP="100.10.1.10"
SHARE_NAME="public/FhemBackup"
MOUNTPATH = "/media/WDMYCLOUD/"
CONFIGTARGET="/etc/init.d/fhem"
mkdir $MOUNTPATH
chown fhem:dialout $MOUNTPATH
mount -t cifs //$SMB_IP/$SHARE_NAME $MOUNTPATH
cp ${MOUNTPATH}fhem $CONFIGTARGET
