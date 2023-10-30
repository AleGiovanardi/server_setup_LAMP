# allocate 4 gigabytes of swap memory
fallocate -l 4G /swapfile
chmod 0600 /swapfile
mkswap /swapfile
swapon /swapfile
# make swap permanent
#we backup the fstab file in case anything goes wrong
cp /etc/fstab /etc/fstab.bak
echo '/swapfile none swap sw 0 0' | sudo tee -a /etc/fstab
# set swappiness
sysctl vm.swappiness=10
# write swappiness permanent after reboot
echo 'vm.swappiness=10' | sudo tee -a /etc/sysctl.conf
# adjust cache pressure settings
sysctl vm.vfs_cache_pressure=50
# write cache pressure permanent
echo 'sysctl vm.vfs_cache_pressure=50' | sudo tee -a /etc/sysctl.conf
# INSTALL APACHE WEB SERVER
apt update
apt install apache2
# INSTALL MYSQL 
apt install mysql-server
# MySql secure installation wizard needs human interaction
mysql_secure_installation
# INSTALL PHP
apt install php libapache2-mod-php php-mysql
# setup firewall
ufw allow https
ufw allow ssh
