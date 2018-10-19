#!/bin/bash
# LICENSE CDDL 1.0 + GPL 2.0
#
# Copyright (c) 1982-2016 Oracle and/or its affiliates. All rights reserved.
#
# Since: November, 2016
# Author: gerald.venzl@oracle.com
# Description: Starts the Listener and Oracle Database.
#              The ORACLE_HOME and the PATH has to be set.
# 
# DO NOT ALTER OR REMOVE COPYRIGHT NOTICES OR THIS HEADER.
# 

# Check that ORACLE_HOME is set
if [ "$ORACLE_HOME" == "" ]; then
  script_name=`basename "$0"`
  echo "$script_name: ERROR - ORACLE_HOME is not set. Please set ORACLE_HOME and PATH before invoking this script."
  exit 1;
fi;

# Start Listener
lsnrctl start

# Start database
  sqlplus / as sysdba << EOF
    STARTUP;
    alter pluggable database all open;
    exit;
EOF

run_datapatch="datapatch"

patch_status=`sqlplus -s / as sysdba << EOF
set heading off;
set pagesize 0;
SELECT DECODE (sum(counter),
               0, 'patched',
               'datapatch')
from
(select count(1) counter
  FROM (  SELECT crs.con_id,
                 PATCH_ID,
                 MAX (action) KEEP (DENSE_RANK LAST ORDER BY action_time)
                     AS action
            FROM cdb_registry_sqlpatch crs
        GROUP BY crs.con_id, patch_id)
 WHERE     action = 'APPLY'
       AND patch_id IN (TO_NUMBER ('$OJVM_PATCH'), TO_NUMBER ('$RU_PATCH'))
union all
select count(1)*-2 counter from v\\$pdbs where open_mode='READ WRITE')
;
exit;
EOF`

# Store return code from SQL*Plus
ret=$?

echo $patch_status

# SQL Plus execution was successful and PDB is open
if [ $ret -eq 0 ] && [ "$patch_status" = "$run_datapatch" ]; then
  echo " "
  echo "*****************"
  echo "Running datapatch"
  echo "*****************"
  echo " "

  sqlplus / as sysdba << EOF
  shutdown immediate;
  startup upgrade;
  alter pluggable database all open upgrade;
  exit;
EOF

  $ORACLE_HOME/OPatch/datapatch -verbose

  sqlplus / as sysdba << EOF
    shutdown immediate;
    STARTUP;
    alter pluggable database all open;
    exit;
EOF
fi

