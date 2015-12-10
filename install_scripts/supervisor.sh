# supervisor

echo "Installing Supervisor"

if [ -f "$SHARED_DIR/config/envvars" ]; then
  . $SHARED_DIR/config/envvars
  print "found your local envvars file. Using it."

else
  . $SHARED_DIR/config/envvars.template
  print "found your template file. Using its default values."

fi

# apt-get install 
apt-get -y install supervisor
service supervisor restart

