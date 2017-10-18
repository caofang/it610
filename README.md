# it610
# 2017 Fall
# fang cao

### gitlab installtion 
sudo apt-get install -y curl openssh-server ca-certificates
sudo apt-get install -y postfix
curl -sS https://packages.gitlab.com/install/repositories/gitlab/gitlab-ce/script.deb.sh | sudo bash
sudo apt-get install gitlab-ce
sudo gitlab-ctl reconfigure


### config gitlab

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

sudo service restart apache2 
sudo a2ensite nagios
sudo a2enmod rewrite cgi


sudo cp /etc/init.d/skeleton /etc/init.d/nagios
sudo vi /etc/init.d/nagios (and add the following lines)

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

uncomment line 51 for the host monitor configuration.
cfg_dir=/usr/local/nagios/etc/servers

##Nagios Service Setup
sudo update-rc.d nagios defaults





<!-- ### configure remote host
apt-get install nagios-plugins nagios-nrpe-server
/etc/nagios/nrpe.cfg -->
