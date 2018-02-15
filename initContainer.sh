#!/bin/bash

#configDB aktivieren/fhem.cfg deaktivieren
sed -i -e 's/perl fhem.pl fhem.cfg.*/#perl fhem.pl fhem.cfg/g' /etc/init.d/fhem
sed -i -e 's/#.*perl fhem.pl configDB.*/perl fhem.pl configDB/g' /etc/init.d/fhem
echo -n "" > /opt/fhem/configDB.conf
echo -n "%dbconfig= (connection => \"Pg:database=$FHEMDB;host=$DBHOST\",user => \"$DBUSER\",password => \"$DBPASSWD\"); " > configDB.conf ^C

service fhem start
