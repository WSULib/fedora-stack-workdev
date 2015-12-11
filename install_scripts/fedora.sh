#!/bin/sh
echo "---- Installing Fedora Commons 3.x ------------------------------------------------"

#### GET ENVARS #################################################
SHARED_DIR=$1

if [ -f "$SHARED_DIR/config/envvars" ]; then
  . $SHARED_DIR/config/envvars
  printf "found your local envvars file. Using it."

else
  . $SHARED_DIR/config/envvars.default
  printf "found your default envvars file. Using its default values."

fi
#################################################################

# Downloads (currently in downloads dir for dev)
# 3.8
FEDORA_3_8="http://sourceforge.net/projects/fedora-commons/files/fedora/3.8.1/fcrepo-installer-3.8.1.jar/download"

# 3.6.2
FEDORA_3_6="http://sourceforge.net/projects/fedora-commons/files/fedora/3.6.2/fcrepo-installer-3.6.2.jar/download"

# Create MySQL DB
mysql --user=root --password=$SQL_PASSWORD < $SHARED_DIR/downloads/fedora/fedora_mysql_db_create.sql

# Installation
java -jar $SHARED_DIR/downloads/fedora/fcrepo-installer-3.8.1.jar $SHARED_DIR/downloads/fedora/install.properties

# copy custom fedora.fcfg
cp /opt/fedora/server/config/fedora.fcfg /opt/fedora/server/config/fedora.fcfg.BACKUP
cp $SHARED_DIR/downloads/fedora/fedora.fcfg /opt/fedora/server/config

# chown fedora dir
chown -R tomcat7:tomcat7 /opt/fedora

# restart tomcat7
service tomcat7 restart

