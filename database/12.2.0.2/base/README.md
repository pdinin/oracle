Based off of https://github.com/oracle/docker-images/tree/master/OracleDatabase/SingleInstance/dockerfiles/12.2.0.1

To use, you will need to download linuxx64_12201_database.zip from http://www.oracle.com/technetwork/database/enterprise-edition/downloads/index.html and place file in this directory

To build, run buildDockerImage.sh

This will build a base installation of Oracle Database 12.2 Enterprise Edition.   The following is the order that this image should be used:
oracle/database/12.2.0.1-ee      
oracle/database/12.2.0.1.YYMMDD-ee (Latest Patchset)
oracle/database/12.2.0.1.YYMMDD-ee-scripts (Add latest scripts)

