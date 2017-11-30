#!/bin/bash
SMB_IP="100.10.1.10"
SHARE_NAME="public/FhemBackup"
SMB_PATH="/media/WDMYCLOUD/"
INIT_FHEM="/etc/init.d/fhem"
FHEM_PATH="/opt/fhem/"
mkdir $SMB_PATH
chown fhem:dialout $SMB_PATH
mount -t cifs //$SMB_IP/$SHARE_NAME $SMB_PATH
cp ${SMB_PATH}fhem $INIT_FHEM
cp ${SMB_PATH}configDB.conf ${FHEM_PATH}configDB.conf
chown fhem:dialout ${FHEM_PATH}configDB.conf
service fhem start
