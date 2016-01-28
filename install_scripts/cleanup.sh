#!/bin/sh
echo "---- Cleanup ------------------------------------------------"

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

# copy apache / info file
cp $SHARED_DIR/config/cleanup/index.php /var/www/wsuls/

# eulxml
# cd /tmp
# cp $SHARED_DIR/downloads/cleanup/eulxml-0.22.1.tar.gz /tmp
# tar -xvf eulxml-0.22.1.tar.gz
# cd eulxml-0.22.1
# python setup.py install
# # remove bad requests from eulxml install
# rm -r /usr/lib/python2.7/dist-packages/requests*

# python progressbar for repo-cp
pip install progressbar

# ingest test bags
echo "running ingest of demo objects from /downloads/WSUDOR_object_samples"
cd /opt/ouroboros/
cp $SHARED_DIR/downloads/ouroboros/ingest_bags.py /opt/ouroboros/
sudo python /opt/ouroboros/ingest_bags.py
sudo rm /opt/ouroboros/ingest_bags.py

# index all documents in Fedora to Solr, specifically to power front-end
# assumes Fedora, Solr, and Ouroboros are up and operational
curl "http://$VM_HOST:$OUROBOROS_PORT/tasks/updateSolr/purgeAndFullIndex"
curl "http://$VM_HOST:$OUROBOROS_PORT/tasks/updateSolr/replicateStagingToProduction"

