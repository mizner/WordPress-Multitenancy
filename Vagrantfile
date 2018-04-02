# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

    config.vm.box = "bento/ubuntu-16.04"
    config.vm.hostname = "wp-multitenancy"

    config.vm.network "forwarded_port", guest: 80, host: 8080
    config.vm.network "private_network", ip: "192.168.33.44"

    config.vm.provider "virtualbox" do |v|
        v.memory = 2048
        v.cpus = 2
        v.name = "WP Multitenancy"
    end

    # Folders
    config.vm.synced_folder ".", "/var/www",
        id: "core",
        mount_options: ['dmode=777', 'fmode=666']
    config.vm.synced_folder "./nginx/sites-available", "/etc/nginx/sites-available",
        id: "ngnix-sites-available"
    config.vm.synced_folder "./nginx/sites-enabled", "/etc/nginx/sites-enabled",
        id: "ngnix-sites-enabled"
    config.ssh.insert_key = false
    config.vm.provision "shell", path: "setup/bootstrap.sh", privileged: false

end