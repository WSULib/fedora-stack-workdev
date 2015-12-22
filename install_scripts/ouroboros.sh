#!/bin/sh
echo "---- Installing Ouroboros ------------------------------------------------"

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

if [ ! -d $OUROBOROS_HOME ]; then
  mkdir $OUROBOROS_HOME
fi

# change to dir
cd /opt

# clone repository
git clone https://github.com/WSUlib/ouroboros.git
cd ouroboros

# install system dependencies
apt-get -y install libxml2-dev libxslt1-dev python-dev python-pip python-mysqldb python-lxml libldap2-dev libsasl2-dev

# python modules
pip install -r requirements.txt

# other applications
# redis
apt-get -y install redis-server

# copy ouroboros's localConfig
cp $SHARED_DIR/downloads/ouroboros/localConfig.py /opt/ouroboros/localConfig.py

# create MySQL database, users, tables
echo "creating MySQL database, users, and tables"
mysql --user=root --password=$SQL_PASSWORD < $SHARED_DIR/downloads/ouroboros/ouroboros_mysql_db_create.sql
ipython <<EOF
from console import *
db.create_all()
EOF

# copy Ouroboros and Celery conf to supervisor dir, reread, update (automatically starts then)
cp $SHARED_DIR/config/ouroboros/ouroboros.conf /etc/supervisor/conf.d/
cp $SHARED_DIR/config/ouroboros/celery.conf /etc/supervisor/conf.d/
supervisorctl reread
supervisorctl update
