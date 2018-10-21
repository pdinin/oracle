# Before building this image oracle/database:12.1.0.2-ee must be available at your local registry
# See https://github.com/oracle/docker-images/blob/master/OracleDatabase/README.md for more details
# Finally build a new image using ./buildDockerImage.sh script
# To run a container using patch installed image you should pass at least three parameters:
#    ORACLE_SID
#    ORACLE_PDB
# for example:
# docker run -d --privileged=true --name test --hostname test \
#   -p 1521:1521 -p 5500:5500 \
#   -e ORACLE_SID=TEST \
#   -e ORACLE_PDB=PDB1 \
#   -v /home/data/db/test:/opt/oracle/oradata \
#   oracle/database:12.2.0.1.170718-ee

FROM	oracle/database/18c
MAINTAINER pete@dinin.net    

ENV CONFIG_RSP="dbca.rsp.tmpl" \
    PWD_FILE="setPassword.sh" \
    RUN_FILE="runOracle.sh" \
    START_FILE="startDB.sh" \
    CREATE_DB_FILE="createDB.sh" \
    CHECK_DB_FILE="checkDBStatus.sh" \
    USER_SCRIPTS_FILE="runUserScripts.sh" 

USER root
WORKDIR /home/oracle

COPY $RUN_FILE $START_FILE $CREATE_DB_FILE $CONFIG_RSP $PWD_FILE $CHECK_DB_FILE $USER_SCRIPTS_FILE $ORACLE_BASE/
RUN  chmod ug+x $ORACLE_BASE/*.sh && \
     chown oracle:dba $ORACLE_BASE/*.sh $ORACLE_BASE/$CONFIG_RSP

USER oracle
WORKDIR /home/oracle

VOLUME ["$ORACLE_BASE/oradata"]
EXPOSE 1521 5500
HEALTHCHECK --interval=1m --start-period=5m \
   CMD "$ORACLE_BASE/$CHECK_DB_FILE" >/dev/null || exit 1

# Define default command to start Oracle Database. 
CMD exec $ORACLE_BASE/$RUN_FILE
