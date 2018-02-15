#!/bin/bash
mkdir $SMB_PATH
chown fhem:dialout $SMB_PATH
mount -t cifs //$SMB_IP/$SHARE_NAME $SMB_PATH -o guest

#configDB aktivieren/fhem.cfg deaktivieren
sed -i -e 's/perl fhem.pl fhem.cfg.*/#perl fhem.pl fhem.cfg/g' /etc/init.d/fhem
sed -i -e 's/#.*perl fhem.pl configDB.*/perl fhem.pl configDB/g' /etc/init.d/fhem

chown -R fhem:dialout ${FHEM_PATH}
service fhem start
