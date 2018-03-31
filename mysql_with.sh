#openssl openssl-devel
#bison
#boost
#cmake

#php libxml2
#ubuntu
apt-get install libxml2
apt-get install libxml2-dev
#centos
yum install libxml2
yum install libxml2-devel -y

./configure --prefix=/usr/local/php --with-config-file-path=/usr/local/php/etc/ --with-apxs2=/usr/local/apache/bin/apxs
