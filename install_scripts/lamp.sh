###
# BASICS
###

SHARED_DIR=$1

if [ -f "$SHARED_DIR/config/envvars" ]; then
  . $SHARED_DIR/config/envvars
  printf "found your local envvars file. Using it."

else
  . $SHARED_DIR/config/envvars.default
  printf "found your template file. Using its default values."

fi

# Set MySQL password
sudo debconf-set-selections <<< "mysql-server mysql-server/root_password password $SQL_PASSWORD"
sudo debconf-set-selections <<< "mysql-server mysql-server/root_password_again password $SQL_PASSWORD"

# Install LAMP
sudo apt-get -y install lamp-server^

apt-get -y install libapache2-mod-wsgi

a2enmod mpm_prefork so authz_groupfile authz_host authz_user autoindex cache cgi deflate dir disk_cache env expires fastcgi headers jk mem_cache mime negotiation php5 proxy proxy_ajp proxy_connect proxy_http reqtimeout rewrite setenvif ssl status wsgi

service apache2 reload

# SSL configurations needed.