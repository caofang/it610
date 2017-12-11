# Final Project Branch
# it610
# 2017 Fall
# fang cao

### ========== gitlab installtion ==========
sudo apt-get install -y curl openssh-server ca-certificates
sudo apt-get install -y postfix
curl -sS https://packages.gitlab.com/install/repositories/gitlab/gitlab-ce/script.deb.sh | sudo bash
sudo apt-get install gitlab-ce
sudo gitlab-ctl reconfigure

### https 
sudo mkdir -p /etc/gitlab/ssl
sudo chmod 700 /etc/gitlab/ssl

# copy the ssl certificate and key to /etc.gitlab/ssl/

nginx['ssl_certificate'] = "/etc/gitlab/ssl/diy1024_com.crt"
nginx['ssl_certificate_key'] = "/etc/gitlab/ssl/diy1024.key"



### ========== config gitlab ==========

/etc/gitlab/gitlab.rb


### auto backup 
# repository backup
sudo gitlab-rake gitlab:backup:create

# config backup
sudo tar cvfj /home/it610/Desktop/it610/proj1/gitlab/backup/$(date "+etc_gitlab_%s.tar.bz2") /etc/gitlab




### ========== installing nagios ==========
##	https://assets.nagios.com/downloads/nagioscore/docs/Installing_Nagios_Core_From_Source.pdf#_ga=2.241881026.1103181573.1508160512-1166814691.1508016816


sudo apt-get install apache2 php7.0-gd libapache2-mod-php7.0 build-essential libgd2-xpm-dev

sudo apt-get install build-essential apache2 php7.0 openssl perl make php7.0-gd libgd2-xpm-dev libapache2-mod-php7.0 libperl-dev libssl-dev daemon wget apache2-utils unzip


useradd nagios
groupadd nagcmd
usermod -a -G nagcmd nagios
usermod -a -G nagcmd www-data


cd /tmp
wget https://assets.nagios.com/downloads/nagioscore/releases/nagios-4.3.2.tar.gz
tar -zxvf nagios-4.3.2.tar.gz
cd /tmp/nagios-4.3.2/


./configure --with-nagios-group=nagios --with-command-group=nagcmd --with-httpd_conf=/etc/apache2/sites-enabled/
make all
make install
make install-init
make install-config
make install-commandmode
make install-webconf


cp -R contrib/eventhandlers/ /usr/local/nagios/libexec/
chown -R nagios:nagios /usr/local/nagios/libexec/eventhandlers

/usr/local/nagios/bin/nagios -v /usr/local/nagios/etc/nagios.cfg
sudo service nagios restart

sudo service apache2 restart
sudo a2ensite nagios
sudo a2enmod rewrite cgi


sudo cp /etc/init.d/skeleton /etc/init.d/nagios
sudo nano /etc/init.d/nagios (and add the following lines)

DESC="Nagios"
NAME=nagios
DAEMON=/usr/local/nagios/bin/$NAME
DAEMON_ARGS="-d /usr/local/nagios/etc/nagios.cfg"
PIDFILE=/usr/local/nagios/var/$NAME.lock



nano /etc/systemd/system/nagios.service

[Unit]
Description=Nagios
BindTo=network.target

[Install]
WantedBy=multi-user.target

[Service]
User=nagios
Group=nagios
Type=simple
ExecStart=/usr/local/nagios/bin/nagios /usr/local/nagios/etc/nagios.cfg



sudo htpasswd -c /usr/local/nagios/etc/htpasswd.users nagiosadmin
njit
njit




## install plugin
wget https://nagios-plugins.org/download/nagios-plugins-2.1.2.tar.gz
tar -xzf nagios-plugins-2.1.2.tar.gz
cd nagios-plugin-2.1.2/

./configure --with-nagios-user=nagios --with-nagios-group=nagios --with-openssl
make
make install

## uncomment line 51 for the host monitor configuration.
sudo nano -c /usr/local/nagios/etc/nagios.cfg

cfg_dir=/usr/local/nagios/etc/servers

##Nagios Service Setup
sudo update-rc.d nagios defaults

## install NRPE Service
sudo apt-get install nagios-nrpe-server nagios-plugins





<!-- ### configure remote host
apt-get install nagios-plugins nagios-nrpe-server
/etc/nagios/nrpe.cfg -->


#### configure remote host
# install nrpe

sudo apt-get update
sudo apt-get install nagios-nrpe-server
cd /usr/lib/nagios/plugins/
ls

# check nrpe is running
netstat -nl | grep 5666

# restart nrpe server
sudo /etc/init.d/nagios-nrpe-server restart


# configure /etc/nagios/nrpe.cfg
allowed_hosts=127.0.0.1,fcao1024.com,fcaolabs.com,diy1024.com

# run nrpe via cli
/usr/lib/nagios/plugins/check_nrpe -H fcaolabs.com -n -c check_load


### ========== mysql ==========

sudo apt-get install mysql-server
root password: njit

user: it610
password: njit

# install php
sudo apt-get install php libapache2-mod-php php-mcrypt php-mysql


# install phpMyAdmin
sudo apt-get install phpmyadmin php-mbstring php-gettext
application passwrd: njit

sudo ln -s /usr/share/phpmyadmin/ /var/www/html/phpmyadmin

# allow remote connection to db
sudo nano /etc/mysql/mysql.conf.d/mysqld.cnf


# the ip of the db local address, so client machine can connect this address
bind-address		= 172.31.20.48


# install mysql client on client machine
sudo apt-get install mysql-client


# connecting to db from client machine
mysql --host=172.31.20.48 --user=it610 --password=njit

mysql --user="$user" --password="$password" --database="$user" --execute='SELECT * FROM backup';
mysql --user=it610 --password=njit --database=git --execute='SELECT * FROM backup';





