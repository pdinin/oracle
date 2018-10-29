#!/bin/bash

## Container_ID is used to 
## (1) DB Port=15xx
## (2) CDB Name = CDBxx
## (3) Container Suffix - NAMExx
export CONTAINER_ID=31  ## Should be exactly 2 numeric characters    

## Container_Name is used to
## (1) Name = xxxx12
## (2) PDB Name = xxxx
export CONTAINER_NAME=xe

docker run -d      \
--name ${CONTAINER_NAME}${CONTAINER_ID}   \
-p 15${CONTAINER_ID}:1521   \
-p 55${CONTAINER_ID}:5500   \
-v /oradata:/opt/oracle/oradata   \
-v /oradiag:/opt/oracle/diag      \
oracle/database/18xe  

docker logs -f  ${CONTAINER_NAME}${CONTAINER_ID}
