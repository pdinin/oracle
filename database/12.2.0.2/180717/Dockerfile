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

FROM	oracle/database:12.2.0.1-ee
MAINTAINER mochoa@scotas.com

ENV     COMBO_PATCH="28317292" \
     PATCH1="27923353" \
     PATCH2="28163133" \ 
     OPATCH_FILE="p6880880_180000_Linux-x86-64.zip"

ENV      PATCH_FILE="p"$COMBO_PATCH"_122010_Linux-x86-64.zip"

USER	root
WORKDIR	/home/oracle
COPY	$PATCH_FILE $OPATCH_FILE $INSTALL_DIR/
COPY    $START_FILE $ORACLE_BASE/
RUN	chown oracle:dba $INSTALL_DIR/$PATCH_FILE $INSTALL_DIR/$OPATCH_FILE $INSTALL_DIR

USER	oracle
RUN	unzip -o $INSTALL_DIR/$OPATCH_FILE -d $ORACLE_HOME && \
        unzip $INSTALL_DIR/$PATCH_FILE -d $INSTALL_DIR && \
	mv $ORACLE_HOME/rdbms/admin/preupgrade.jar $ORACLE_HOME/rdbms/admin/preupgrade.jar.old  

WORKDIR $INSTALL_DIR/$COMBO_PATCH/$PATCH1
RUN	$ORACLE_HOME/OPatch/opatch prereq CheckConflictAgainstOHWithDetail -ph . && \
	$ORACLE_HOME/OPatch/opatch apply -silent

WORKDIR $INSTALL_DIR/$COMBO_PATCH/$PATCH2
RUN     $ORACLE_HOME/OPatch/opatch prereq CheckConflictAgainstOHWithDetail -ph . && \
        $ORACLE_HOME/OPatch/opatch apply -silent

USER    root
WORKDIR /home/oracle
RUN	rm -rf $INSTALL_DIR

USER oracle
WORKDIR /home/oracle

VOLUME ["$ORACLE_BASE/oradata"]
EXPOSE	1521 5500

# Define default command to start Oracle Database. 
CMD exec $ORACLE_BASE/$RUN_FILE
