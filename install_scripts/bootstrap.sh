###
# BASICS
###

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

# Create Users
for user in "${USERS_ARRAY[@]}";
do
	echo "Creating user ${user%%:*}"
	useradd -m -s /bin/bash ${user%%:*}
	echo ${user%%:*}:${user#*:} | chpasswd
done