# -*- mode: ruby -*-
# vi: set ft=ruby :

BOX_NAME = ENV['BOX_NAME'] || "ubuntu_1.0.0"
BOX_URI = ENV['BOX_URI'] || "http://docker.repo.in:8000/ubuntu.box"

Vagrant.configure(2) do |config|
  # Setup virtual machine box. This VM configuration code is always executed.
  config.vm.box = BOX_NAME
  config.vm.box_url = BOX_URI

  #Shipyard
  config.vm.network "forwarded_port", guest: 8005, host: 8005

  #nginx
  config.vm.network "forwarded_port", guest: 80, host: 8088

  #mysql
  config.vm.network "forwarded_port", guest: 3306, host: 6000

  #redis
  config.vm.network "forwarded_port", guest: 6379, host: 6001

  #memcached
  config.vm.network "forwarded_port", guest: 11211, host: 6002
  
  #mongo
  config.vm.network "forwarded_port", guest: 27017, host: 6003
  config.vm.network "forwarded_port", guest: 28017, host: 6004

  config.vm.synced_folder "./www", "/home/vagrant/www"
 end

# Providers were added on Vagrant >= 1.1.0
Vagrant::VERSION >= "1.1.0" and Vagrant.configure("2") do |config|
  config.vm.provider :virtualbox do |vb|
    config.vm.box = BOX_NAME
    config.vm.box_url = BOX_URI
    #memory
    vb.customize ["modifyvm", :id, "--memory", "1048"]
  end
end



