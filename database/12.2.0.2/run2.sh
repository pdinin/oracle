#!/bin/bash

## Container_ID is used to 
## (1) DB Port=15xx
## (2) CDB Name = CDBxx
## (3) Container Suffix - NAMExx
export CONTAINER_ID=24  ## Should be exactly 2 numeric characters    

## Container_Name is used to
## (1) Name = xxxx12
## (2) PDB Name = xxxx
export CONTAINER_NAME=PETE

docker run -d      \
--name ${CONTAINER_NAME}${CONTAINER_ID}   \
-p 15${CONTAINER_ID}:1521   \
-p 55${CONTAINER_ID}:5500   \
-e ORACLE_SID=CDB${CONTAINER_ID}  \
-e ORACLE_PDB=${CONTAINER_NAME}   \
-e ORACLE_PWD=welcome1            \
-v /oradata:/opt/oracle/oradata   \
-v /oradiag:/opt/oracle/diag      \
oracle/database/12.2.0.1   

docker logs -f  ${CONTAINER_NAME}${CONTAINER_ID}
