# -*- mode: ruby -*-
# vi: set ft=ruby :

BOX_NAME = ENV['BOX_NAME'] || "ubuntu"
BOX_URI = ENV['BOX_URI'] || "/Volumes/data/vagrant/box/"

Vagrant::Config.run do |config|
  # Setup virtual machine box. This VM configuration code is always executed.
  config.vm.box = BOX_NAME
  config.vm.box_url = BOX_URI

  #Shipyard
  config.vm.forward_port 8005, 8005

  #nginx
  config.vm.forward_port 80, 8088

  #mysql
  config.vm.forward_port 3306, 6000

  #redis
  config.vm.forward_port 6379, 6001

  #memcached
  config.vm.forward_port 11211, 6002
  
  #mongo
  config.vm.forward_port 27017, 6003
  config.vm.forward_port 28017, 6004

 end


# Providers were added on Vagrant >= 1.1.0
Vagrant::VERSION >= "1.1.0" and Vagrant.configure("2") do |config|
  config.vm.provider :virtualbox do |vb|
    config.vm.box = BOX_NAME
    config.vm.box_url = BOX_URI
    #memory
    vb.customize ["modifyvm", :id, "--memory", "1448"]
  end
end



