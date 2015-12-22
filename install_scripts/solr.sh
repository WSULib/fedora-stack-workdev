
echo "--------------- Installing Solr 4.1 ------------------------------"

SHARED_DIR=$1

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


if [ ! -d $SOLR_HOME ]; then
  mkdir $SOLR_HOME
fi

if [ ! -f "$DOWNLOAD_DIR/solr-$SOLR_VERSION.tgz" ]; then
  echo -n "Downloading Solr..."
  wget -q -O "$DOWNLOAD_DIR/solr-$SOLR_VERSION.tgz" "http://archive.apache.org/dist/lucene/solr/$SOLR_VERSION/solr-$SOLR_VERSION.tgz"
  echo " done"
fi

cd /tmp
cp "$DOWNLOAD_DIR/solr-$SOLR_VERSION.tgz" /tmp
echo "Extracting Solr"
tar -xzf solr-"$SOLR_VERSION".tgz
cp -v /tmp/solr-"$SOLR_VERSION"/dist/solr-"$SOLR_VERSION".war /var/lib/tomcat7/webapps/solr4.war
chown tomcat7:tomcat7 /var/lib/tomcat7/webapps/solr4.war
service tomcat7 restart

chown -hR tomcat7:tomcat7 /usr/share/tomcat7/lib

cp $SHARED_DIR/downloads/solr/$SOLR_CATALINA_CONFIG /etc/tomcat7/Catalina/localhost/solr4.xml

chown -hR root:tomcat7 /etc/tomcat7/Catalina/localhost

# cp -Rv /tmp/solr-"$SOLR_VERSION"/example/solr/* $SOLR_HOME

# rm -r $SOLR_HOME/collection1

cp -R $SHARED_DIR/config/solr/multicore/ $SOLR_HOME/

cp -R /vagrant/config/solr/lib $SOLR_HOME/

chown -hR tomcat7:tomcat7 $SOLR_HOME

touch /var/lib/tomcat7/velocity.log
chown tomcat7:tomcat7 /var/lib/tomcat7/velocity.log

service tomcat7 restart
