#!/bin/bash
mkdir $SMB_PATH
chown fhem:dialout $SMB_PATH
mount -t cifs //$SMB_IP/$SHARE_NAME $SMB_PATH -o guest
cp ${SMB_PATH}fhem $INIT_FHEM
cp ${SMB_PATH}configDB.conf ${FHEM_PATH}configDB.conf
chown -R fhem:dialout ${FHEM_PATH}
service fhem start
