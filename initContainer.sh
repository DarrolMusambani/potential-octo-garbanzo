#!/bin/bash
#MOUNTPATH, SMB_IP & SHARE_NAME need to be predefined
CONFIGTARGET="/etc/init.d/fhem"
DBCONFIG="/opt/fhem/configDB.conf"
mkdir $MOUNTPATH
chown fhem:dialout $MOUNTPATH
mount -t cifs //$SMB_IP/$SHARE_NAME $MOUNTPATH
cp ${MOUNTPATH}fhem $CONFIGTARGET
cp ${MOUNTPATH}configDB.conf $DBCONFIG
chown fhem:dialout $DBCONFIG
service fhem start
