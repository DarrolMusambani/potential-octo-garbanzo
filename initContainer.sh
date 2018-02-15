#!/bin/bash

activate_configDB() {
#configDB aktivieren/fhem.cfg deaktivieren
sed -i -e 's/perl fhem.pl fhem.cfg.*/#perl fhem.pl fhem.cfg/g' /etc/init.d/fhem
sed -i -e 's/#.*perl fhem.pl configDB.*/perl fhem.pl configDB/g' /etc/init.d/fhem

DBCON="%dbconfig= (connection => \"Pg:database=fhem;host=$DBHOST:$DBPORT\",user => \"$DBUSER\",password => \"$PGPASSWORD\");"
echo -n "" > /opt/fhem/configDB.conf
echo -n "$DBCON" > /opt/fhem/configDB.conf
}
activate_DB_Log() {
service fhem start
sleep 5
#DB-Logging aktivierencd. o
perl /opt/fhem/fhem.pl 7072 "configdb fileimport /opt/fhem/configDB.conf"
perl /opt/fhem/fhem.pl 7072 "define DBLogging DbLog /opt/fhem/configDB.conf .*:.*"
perl /opt/fhem/fhem.pl 7072 "attr DBLogging DbLogExclude .*"
perl /opt/fhem/fhem.pl 7072 "attr DBLogging DbLogSelectionMode Exclude/Include"
perl /opt/fhem/fhem.pl 7072 "attr DBLogging DbLogType Current/History"
perl /opt/fhem/fhem.pl 7072 "attr DBLogging asyncMode 1"
perl /opt/fhem/fhem.pl 7072 "attr DBLogging icon it_nas"
perl /opt/fhem/fhem.pl 7072 "attr DBLogging room Log"
perl /opt/fhem/fhem.pl 7072 "save"
}

set_basicAuth() { 
perl /opt/fhem/fhem.pl 7072 "define allowed_WEB allowed"
perl /opt/fhem/fhem.pl 7072 "attr allowed_WEB validFor WEB"
perl /opt/fhem/fhem.pl 7072 "set allowed_WEB basicAuth $FHEMUSER:$FHEMPASSWD"
}

prepare_db() {
psql --host=$DBHOST --port=$DBPORT --username=$DBUSER  -d postgres -f /create_fhem_db.sql
psql --host=$DBHOST --port=$DBPORT --username=$DBUSER  -d fhem -f /create_log_tables.sql
}

prepare_db
activate_configDB
activate_DB_Log
set_basicAuth
