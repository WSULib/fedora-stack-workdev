
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

print "Downloading Solr"
wget -q -O "$SHARED_DIR/downloads/solr-$SOLR_VERSION.tgz" "http://archive.apache.org/dist/lucene/solr/$SOLR_VERSION/solr-$SOLR_VERSION.tgz"

cd /tmp
cp $SHARED_DIR/downloads/solr-$SOLR_VERSION.tgz /tmp
echo "Extracting Solr"
tar -xzf solr-"$SOLR_VERSION".tgz
cp -v /tmp/solr-"$SOLR_VERSION"/dist/solr-"$SOLR_VERSION".war /var/lib/tomcat7/webapps/solr4.war
service tomcat7 restart

chown -hR tomcat7:tomcat7 /usr/share/tomcat7/lib

cp $SHARED_DIR/downloads/solr/$SOLR_CATALINA_CONFIG /etc/tomcat7/Catalina/localhost/solr4.xml

chown -hR root:tomcat7 /etc/tomcat7/Catalina/localhost

cp -Rv /tmp/solr-"$SOLR_VERSION"/example/solr/* $SOLR_HOME

rm -r $SOLR_HOME/collection1

cp -R $SHARED_DIR/config/solr/multicore/ $SOLR_HOME/

cp -R $SHARED_DIR/config/solr/lib $SOLR_HOME/

chown -hR tomcat7:tomcat7 $SOLR_HOME

service tomcat7 restart