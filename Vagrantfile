# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

    config.vm.box = "bento/ubuntu-16.04"
    config.vm.hostname = "scotchbox"
    config.vm.network "forwarded_port", guest: 80, host: 8080
    config.vm.network "private_network", ip: "192.168.33.44"
    config.vm.synced_folder ".", "/var/www", 
        id: "webroot",
        :nfs => true,
        :mount_options => ["dmode=777", "fmode=666"]
    config.vm.synced_folder ".", "/etc/nginx/sites-available", 
        id: "ngnix-sites-available",
        :nfs => true,
        :mount_options => ["dmode=777", "fmode=666"]
    config.ssh.insert_key = false
    config.vm.provision "shell", path: "scripts/install.sh", privileged: false

end