# bowtie-vagrant

A pre-configured Ubuntu LEMP box for Wordpress. 

Use the barebones quick start instructions if you are not an Infinite employee, otherwise:

Make sure the SSH key for your host system is saved in GitHub to use the provision script. It will pull the `Bowtie` & `bowtie-wordpress` repos into `www` and import the `www/bowtie-wordpress.sql` database during provision.

## In the Box
- Ubuntu 16.04
- Nginx 1.10
- PHP 7
- MySQL 5.7
- phpMyAdmin 4.5.4

#### External Dependencies

- [bowtie-wordpress](https://github.com/theinfiniteagency/bowtie-wordpress)
- [Bowtie](https://github.com/theinfiniteagency/bowtie)
- Optionally, install [Vagrant Hostsupdater](https://github.com/cogitatio/vagrant-hostsupdater) to automatically add the VM to your hosts file.

## Quick Start

Follow the instructions below depending on your environment

Access the site at `project-name.localhost` or phpmyadmin at `project-name.dev:8080`

HTTPS for Wordpress is available beginning with the v1.2 vagrant box.

### Barebones

Clone this repo and run `$ vagrant up` for a barebones box that does not include our Wordpress distribution.

Move your static or PHP site to the `www` folder, and use phpMyAdmin to create a database. Credentials are listed below.

### Using Quick Start Script (WIP)

This will download our Wordpress distribution including plugins and themes.

Clone this repo and run `$ ./quick-start.sh` for first boot and provisioning, or to overwrite the current site.

### Using Bowtie CLI

This will download our Wordpress distribution including plugins and themes.

Run `$ bowtie new project-name` and this repo will be cloned, as well as the Wordpress distribution. The box will be booted and ready to use.

## Credentials

Account     | Username  | Password
------------|-----------|---------
MySQL       | root      | vagrant
WordPress   | coders    | B********

## Destroying with a Backup

To save space (each box is about 500mb), you can destroy the VM while keeping a copy of the site and db, ready for next boot.

**Using Bowtie CLI**

1. Run `$ bowtie backup -d` to dump the db to www and destroy the machine (remove the -d flag to only create a backup)
3. Use `$ bowtie up` to restore the site.

**Manually**

1. First, login to phpmyadmin and dump the `wordpress` db to `bowtie-wordpress.sql` in the `www` folder.
2. Run `$ vagrant destroy` to delete the VM
3. When you are ready to use the site again, run `$ vagrant up --provision`. This will rebuild the box and import the db again.

## Repackaging Box for Vagrant Cloud

After making system updates, run the following commands to prepare the box and package.

```
$ vagrant ssh
$ mysql --login-path=local -e "DROP DATABASE IF EXISTS wordpress"
$ sudo apt-get clean
$ sudo dd if=/dev/zero of=/EMPTY bs=1M
$ sudo rm -f /EMPTY
$ cat /dev/null > ~/.bash_history && history -c && exit
$ vagrant package --output bowtie.box
```

Login to [Vagrant Cloud](https://app.vagrantup.com/theinfiniteagency) and upload a new version for the `virtualbox` provider. You will then need to return to the version list and release it to make it public.
