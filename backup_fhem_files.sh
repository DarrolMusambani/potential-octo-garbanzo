#!/bin/bash

DEST1="/shares/Public/FhemBackup/Backup/controls.txt"
TARGET="root@100.10.1.10"
SCP_PASS="v0kabelN"
sshpass -p $SCP_PASS scp /opt/fhem/FHEM/controls.txt $TARGET:$DEST1
