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

### installing nagios


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


htpasswd -c /usr/local/nagios/etc/htpasswd.users fcao
njit
njit

# install plugin

cd /tmp
wget https://nagios-plugins.org/download/nagios-plugins-2.2.1.tar.gz
tar -zxvf /tmp/nagios-plugins-2.2.1.tar.gz
cd /tmp/nagios-plugins-2.2.1/

./configure --with-nagios-user=nagios --with-nagios-group=nagios
make
make install
