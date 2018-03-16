#!/bin/bash
today="$(date '+%Y-%m-%d')"
DUMPFILENAME=$today"_fhemDB_komplett.sql.gz"
DESTINATION="/..Backup path.../$DUMPFILENAME" #Modify
TARGET="<ssh-Connection>>" #Modify
SCP_PASS="ssh-Password" #Modify
pg_dumpall -U postgres -l fhem | gzip > /home/postgres/$DUMPFILENAME
sshpass -p $SCP_PASS scp /home/postgres/$DUMPFILENAME $TARGET:$DESTINATION
rm /home/postgres/$DUMPFILENAME 
