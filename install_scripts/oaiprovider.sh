#!/bin/sh
echo "---- Installing OAIProvider for Fedora Commons ------------------------------------------------"

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

# download in download dir from here: http://www.fedora-commons.org/software/repository

# unzip to tmp, move to Tomcat
echo "unzipping and moving war file"
unzip $SHARED_DIR/downloads/oaiprovider/oaiprovider-1.2.zip -d /tmp
cp /tmp/oaiprovider-1.2/oaiprovider.war /var/lib/tomcat7/webapps/

# restart Tomcat
service tomcat7 restart

# move config file to Tomcat
echo "copying config template and replacing values"
cp $SHARED_DIR/downloads/oaiprovider/proai.properties /var/lib/tomcat7/webapps/oaiprovider/WEB-INF/classes
sed -i "s/FEDORA_ADMIN_USERNAME/$FEDORA_ADMIN_USERNAME/g" /var/lib/tomcat7/webapps/oaiprovider/WEB-INF/classes/proai.properties
sed -i "s/FEDORA_ADMIN_PASSWORD/$FEDORA_ADMIN_PASSWORD/g" /var/lib/tomcat7/webapps/oaiprovider/WEB-INF/classes/proai.properties

# restart Tomcat
service tomcat7 restart