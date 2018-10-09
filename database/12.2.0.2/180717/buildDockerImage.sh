#!/bin/bash
docker build -t "oracle/database/12.2.0.1" .
docker image tag "oracle/database/12.2.0.1" "oracle/database/12.2.0.1:180717"
cd ../scripts
./buildDockerImage.sh
