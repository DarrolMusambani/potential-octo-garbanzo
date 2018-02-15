#!/bin/bash

activate_configDB {
#configDB aktivieren/fhem.cfg deaktivieren
sed -i -e 's/perl fhem.pl fhem.cfg.*/#perl fhem.pl fhem.cfg/g' /etc/init.d/fhem
sed -i -e 's/#.*perl fhem.pl configDB.*/perl fhem.pl configDB/g' /etc/init.d/fhem

echo -n "" > /opt/fhem/configDB.conf
echo -n "%dbconfig= (connection => \"Pg:database=fhem;host=$DBHOST:$DBPORT\",user => \"$DBUSER\",password => \"$PGPASSWORD\"); " > /opt/fhem/configDB.conf
}
activate_DB_Log {
service fhem start
sleep 5
#DB-Logging aktivierencd. o
perl fhem.pl 7072 "configdb fileimport /opt/fhem/configDB.conf"
perl fhem.pl 7072 "define DBLogging DbLog /opt/fhem/configDB.conf .*:.*"
perl fhem.pl 7072 "attr DBLogging DbLogExclude .*"
perl fhem.pl 7072 "attr DBLogging DbLogSelectionMode Exclude/Include"
perl fhem.pl 7072 "attr DBLogging DbLogType Current/History"
perl fhem.pl 7072 "attr DBLogging asyncMode 1"
perl fhem.pl 7072 "attr DBLogging icon it_nas"
perl fhem.pl 7072 "attr DBLogging room Log"
perl fhem.pl 7072 "save"
}

set_basicAuth { 
perl fhem.pl 7072 "define allowed_WEB allowed"
perl fhem.pl 7072 "attr allowed_WEB validFor WEB"
perl fhem.pl 7072 "set allowed_WEB basicAuth $FHEMUSER:$FHEMPASSWD"
}

prepare_db {
psql --host=$DBHOST --port=$DBPORT --username=$DBUSER  -d postgres -f /create_fhem_db.sql
psql --host=$DBHOST --port=$DBPORT --username=$DBUSER  -d fhem -f /create_log_tables.sql
}

prepare_db
activate_configDB
activate_DB_Log
set_basicAuth
