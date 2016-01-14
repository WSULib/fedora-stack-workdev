#!/bin/sh
echo "---- Installing NFS ------------------------------------------------"

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

sudo apt-get -y install nfs-kernel-server

mkdir /archivematica

chown nobody:nogroup /archivematica
echo "/home    $ARCHIVEMATICA_HOST(rw,sync,no_root_squash,no_subtree_check)" >> /etc/exports
echo "/archivematica    $ARCHIVEMATICA_HOST(rw,sync,no_root_squash,no_subtree_check)" >> /etc/exports

exportfs -a
service nfs-kernel-server start
