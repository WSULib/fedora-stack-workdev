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
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password password $SQL_PASSWORD'
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password $SQL_PASSWORD'

# Install LAMP
sudo apt-get -y install lamp-server^

apt-get -y install libapache2-mod-wsgi libapache2-mod-jk

a2enmod cache cgi cache_disk expires headers proxy proxy_ajp proxy_connect proxy_http reqtimeout rewrite ssl

service apache2 restart

# SSL configurations needed.
# mem_cache (and probably disk_cache) now use cache_disk. I'm not installing fastcgi (which is deprecated for 14.04) until we track down what uses it.

# Copy ports.conf

# Copy workers.properties

# Copy sites-available

# Set IP addr and networking info

# Copy /etc/hosts file

# enable all sites