#!/bin/bash 
# apache_with for centos
# ubuntu need apt-get libxext-dev
yum install expat-devel
wget -c http://archive.apache.org/dist/apr/apr-1.6.2.tar.gz
tar -xf apr-1.6.2.tar.gz
cd apr-1.6.2
./configure --prefix=/usr/local/apr
make && make install    
wget -c http://archive.apache.org/dist/apr/apr-util-1.6.1.tar.gz 
tar -xf apr-util-1.6.1.tar.gz 
cd apr-util-1.6.1
./configure --prefix=/usr/local/apr-util --with-apr=/usr/local/apr/bin/apr-1-config   
make && make install    
wget -c https://ftp.pcre.org/pub/pcre/pcre-8.41.tar.gz 
tar -xf pcre-8.41
cd pcre-8.41
./configure --prefix=/usr/local/pcre
make && make install    
