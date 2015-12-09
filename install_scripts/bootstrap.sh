###
# BASICS
###

SHARED_DIR=$1

if [ -f "$SHARED_DIR/config/_config" ]; then
  . $SHARED_DIR/config/_config
  print "found your already made _config file. Using it."

else
  . $SHARED_DIR/config/config
  print "found your template file. Using its default values."

fi

cd $HOME_DIR

# Update
apt-get -y update && apt-get -y upgrade

# SSH
apt-get -y install openssh-server

# Build tools
apt-get -y install build-essential

# Git vim
apt-get -y install git vim

# Wget and curl
apt-get -y install wget curl
