# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  # All Vagrant configuration is done here. The most common configuration
  # options are documented and commented below. For a complete reference,
  # please see the online documentation at vagrantup.com.

  # Every Vagrant virtual environment requires a box to build off of.
  config.vm.box = 'csymlstd/bowtie'

  # The hostname for the VM
  config.vm.hostname = 'bowtie-vagrant'

  # Disable automatic box update checking. If you disable this, then
  # boxes will only be checked for updates when the user runs
  # `vagrant box outdated`. This is not recommended.
  # config.vm.box_check_update = false

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  # config.vm.network "forwarded_port", guest: 80, host: 8080

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  config.vm.network 'private_network', ip: '192.168.56.50'

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  # config.vm.network "public_network"

  # If true, then any SSH connections made will enable agent forwarding.
  # Default value: false
  config.ssh.forward_agent = false
  config.ssh.insert_key = false

  # Create an entry in the /etc/hosts file for #{hostname}.test
  if defined? VagrantPlugins::HostsUpdater
    config.hostsupdater.aliases = ["#{config.vm.hostname}.test", "phpmyadmin.#{config.vm.hostname}.test", "portal8.#{config.vm.hostname}.test", "drupal.#{config.vm.hostname}.test"]
  end

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  # config.vm.synced_folder "../data", "/vagrant_data"

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # Example for VirtualBox:
  #
  # config.vm.provider "virtualbox" do |vb|
  #   # Don't boot with headless mode
  #   vb.gui = true
  #
  #   # Use VBoxManage to customize the VM. For example to change memory:
  #   vb.customize ["modifyvm", :id, "--memory", "1024"]
  # end
  config.vm.provider 'virtualbox' do |vb|
    vb.customize ['modifyvm', :id, '--memory', '1024']
  end

  config.vm.synced_folder 'www', '/var/www', id: 'vagrant-root',
    owner: 'vagrant',
    group: 'www-data',
    mount_options: ["dmode=777,fmode=777"]

  config.vm.synced_folder 'nginx', '/etc/nginx/sites-enabled', id: 'nginx-sites',
    owner: 'root',
    group: 'root',
    mount_options: ["dmode=777,fmode=777"]

  config.vm.synced_folder 'apache', '/etc/apache2/sites-enabled', id: 'apache-sites',
    owner: 'root',
    group: 'root',
    mount_options: ["dmode=777,fmode=777"]

  # View the documentation for the provider you're using for more
  # information on available options.

  # Fixes "stdin: is not a tty" and "mesg: ttyname failed : Inappropriate ioctl for device" messages --> mitchellh/vagrant#1673

  config.vm.provision "shell", args: "#{config.vm.hostname}", path: 'provision.sh'

end
