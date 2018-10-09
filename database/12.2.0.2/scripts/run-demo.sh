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

docker run -d                                  `# run container in the background` \
--name $CONTAINER_NAME$CONTAINER_ID            `# Container Name - should be unique` \
-p 15$CONTAINER_ID:1521                        `# Maps host_port:container_port for listener - use container port 1521` \
-e ORACLE_SID=CDB$CONTAINER_ID                 `# CDB Sid - this should be unique for the docker host` \
-e ORACLE_PDB=$CONTAINER_NAME                  `# PDB Name (also service_name for connections)` \
-e ORACLE_PWD=welcome1                         `# password for sys/system/pdbadmin` \
-v /swdata:/opt/oracle/oradata                 `# Maps volume host_volume:container volume - use container volume /opt/oracle/oradata - host_volume must be owned by 54321:54321` \
oracle/database/12.2.0.1.180717-scripts        `# Image Repository/tag`

docker logs -f  ${CONTAINER_NAME}${CONTAINER_ID}
