# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  # All Vagrant configuration is done here. The most common configuration
  # options are documented and commented below. For a complete reference,
  # please see the online documentation at vagrantup.com.
  
  config.vm.hostname = "fedora-stack"

  config.vm.box = "ubuntu/trusty64"

  config.vm.network :forwarded_port, guest: 80, host: 8081
  # using convention of adding "4" to the default port from the VM (e.g. 8080 -> 48080)
  config.vm.network :forwarded_port, guest: 8080, host: 48080

  config.vm.provider "virtualbox" do |vb|
    vb.memory = 8192
    vb.cpus = 2
  end

  # sets shared dir that is passed to bootstrap
  shared_dir = "/vagrant"  

  config.vm.provision "shell", path: "./install_scripts/bootstrap.sh", args: shared_dir
  config.vm.provision "shell", path: "./install_scripts/lamp.sh", args: shared_dir
  config.vm.provision "shell", path: "./install_scripts/java.sh", args: shared_dir
  config.vm.provision "shell", path: "./install_scripts/tomcat.sh", args: shared_dir
  config.vm.provision "shell", path: "./install_scripts/fedora.sh", args: shared_dir
  #config.vm.provision "shell", path: "./install_scripts/supervisor.sh", args: shared_dir
  #config.vm.provision "shell", path: "./install_scripts/ouroboros.sh", args: shared_dir

end