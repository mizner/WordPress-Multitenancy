# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

    config.vm.box = "bento/ubuntu-16.04"
    config.vm.hostname = "simplelaunch"

    config.vm.network "forwarded_port", guest: 80, host: 8080
    config.vm.network "private_network", ip: "192.168.33.44"

    config.vm.provider "virtualbox" do |v|
        v.memory = 1024
        v.cpus = 2
        v.name = "Simple Launch"
    end

    # Folders
    config.vm.synced_folder ".", "/var/www", 
        id: "core",
        mount_options: ['dmode=777', 'fmode=666']
    config.vm.synced_folder "./nginx/sites-available", "/etc/nginx/sites-available", 
        id: "ngnix_sites_available"
    config.vm.synced_folder "./nginx/sites-enabled", "/etc/nginx/sites-enabled", 
        id: "ngnix_sites_enabled"
    config.ssh.insert_key = false
    config.vm.provision "shell", path: "setup/initial.sh", privileged: false

end