#!/bin/bash 
# apache_with for centos
# ubuntu need apt-get libxext-dev libexpat1-dev
#yum install expat-devel
#src_dir
SRC_DIR=`pwd`
apt-get install libexpat1-dev
wget -c http://archive.apache.org/dist/apr/apr-1.6.2.tar.gz
tar -xf apr-1.6.2.tar.gz
cd ${SRC_DIR}/apr-1.6.2
./configure --prefix=/usr/local/apr
make && make install
if [[ $? -ne 0 ]]; then
	echo -e "\033[31mapr install error,please check\033[0m"
	exit
fi
cd ${SRC_DIR}    
wget -c http://archive.apache.org/dist/apr/apr-util-1.6.1.tar.gz 
tar -xf apr-util-1.6.1.tar.gz 
cd ${SRC_DIR}/apr-util-1.6.1
./configure --prefix=/usr/local/apr-util --with-apr=/usr/local/apr/bin/apr-1-config   
make && make install
if [[ $? -ne 0 ]]; then
	echo -e "\033[31mapr-util install error,please check\033[0m"
	exit
fi
cd ${SRC_DIR}       
wget -c https://ftp.pcre.org/pub/pcre/pcre-8.41.tar.gz 
tar -xf pcre-8.41.tar.gz
cd ${SRC_DIR}/pcre-8.41
./configure --prefix=/usr/local/pcre
make && make install
if [[ $? -ne 0 ]]; then
	echo -e "\033[31mpcre install error,please check\033[0m"
	exit
else
	echo -e "\033[32minstall success\033[0m"
fi     
