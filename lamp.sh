#!/bin/bash
#auto make install lamp
#by author river
#httpd(apache) define path variable

H_FILES=httpd-2.4.33.tar.bz2
H_FILES_DIR=httpd-2.4.33
H_URL=https://mirrors.aliyun.com/apache/httpd/
H_PREFIX=/usr/local/apache/

#MySQL define path variable
M_FILES=mysql-5.7.18.tar.gz  
M_FILES_DIR=mysql-5.7.18
M_URL=http://mirrors.sohu.com/mysql/MySQL-5.7/
M_PREFIX=/usr/local/mysql

#PHP define path variable
P_FILES=php-5.6.9.tar.gz
P_FILES_DIR=php-5.6.9          
P_URL=http://mirrors.sohu.com/php/
P_PREFIX=/usr/local/php

#src_dir
SRC_DIR=`pwd`

echo -e '\033[32m######################\033[0m'
if [ -z "$1" ];then
	echo -e "\033[36mPlease Select Install Menu follow:\033[0m"
	echo "1)编译安装 Apache 服务器"
	echo "2)编译安装 MySQL 服务器"
	echo "3)编译安装 PHP 服务器"
	echo "4)配置 index.php 并启动 LAMP 服务"
	echo -e "\033[31mUsage: { /bin/sh $0 1|2|3|4|help}\033[0m"
exit
elif [[ "$1" -eq 'help' ]];then
	echo -e "\033[36mPlease Select Install Menu follow:\033[0m"
	echo "1)编译安装 Apache 服务器"
	echo "2)编译安装 MySQL 服务器"
	echo "3)编译安装 PHP 服务器"
	echo "4)配置 index.php 并启动 LAMP 服务"
	echo -e "\033[31mUsage: { /bin/sh $0 1|2|3|4|help}\033[0m"
exit
#apache 安装
elif [[ "$1" -eq 1 ]];then
	wget -c $H_URL/$H_FILES && tar -xf $H_FILES && cd $H_FILES_DIR;
	#http 用你下载的版本文件夹
	cp -r ${SRC_DIR}/apr-1.6.2 ${SRC_DIR}/${H_FILES_DIR}/srclib/apr
	cp -r ${SRC_DIR}/apr-util-1.6.1 ${SRC_DIR}/${H_FILES_DIR}/srclib/apr-util
	./configure --prefix=/usr/local/apache --with-apr=/usr/local/apr --with-apr-util=/usr/local/apr-util/ --with-pcre=/usr/local/pcre --enable-mods-shared=most --enable-so --with-included-apr
	if [[ "$?" -eq 0 ]]; then
		make && make install
		ln -s /usr/local/apache/bin/apachectl /etc/init.d/httpd 
		sed -i 's/#ServerNam/ServerNam/' /usr/local/apache/conf/httpd.conf 
		echo 'AddType application/x-httpd-php .php'>>/usr/local/apache/conf/httpd.conf 
		echo -e "\033[32mThe $H_FILES_DIR install success\033[0m"
	else
		echo -e "\033[31mThe $H_FILES_DIR install error,Please check\033[0m"
		exit
	fi
#Mysql 安装 建议用apt 或yum 安装
elif [[ "$1" -eq 20 ]];then
	wget -c $M_URL/$M_FILES && tar -xf $M_FILES && cd $M_FILES_DIR;
	apt-get install cmake
	#centos yum install cmake
	cmake . \
	-DCMAKE_INSTALL_PREFIX=/usr/local/mysql \
	-DMYSQL_DATADIR=/data/mysql \
	-DDOWNLOAD_BOOST=1 \
	-DWITH_BOOST=/usr/local/boost_1_59_0 \
	-DSYSCONFDIR=/etc \
	-DWITH_INNOBASE_STORAGE_ENGINE=1 \
	-DWITH_MYISAM_STORAGE_ENGINE=1 \
	-DWITH_PARTITION_STORAGE_ENGINE=1 \
	-DWITH_FEDERATED_STORAGE_ENGINE=1 \
	-DWITH_BLACKHOLE_STORAGE_ENGINE=1 \
	-DMYSQL_TCP_PORT=3306 \
	-DWITH_SSL=bundled \
	-DENABLED_LOCAL_INFILE=1 \
	-DENABLE_DTRACE=0 \
	-DDEFAULT_CHARSET=utf8mb4 \
	-DDEFAULT_COLLATION=utf8mb4_general_ci \
	-DWITH_EMBEDDED_SERVER=1 
	if [[ "$?" -eq 0 ]]; then
		make && make install
		echo -e "\033[32mThe $M_FILES_DIR install success\033[0m"
	else
		echo -e "\033[31mThe $M_FILES_DIR install error,Please check\033[0m"
		exit
	fi
#安装php
elif [[ "$1" -eq 3 ]];then
	wget -c $P_URL/$P_FILES && tar -xf $P_FILES && cd $P_FILES_DIR;
	apt-get install libxml2
	apt-get install libxml2-dev
	./configure --prefix=${P_PREFIX} --with-config-file-path=${P_PREFIX}/etc/ --with-apxs2=${P_PREFIX}/bin/apxs
	if [[ "$?" -eq 0 ]]; then
		make && make install
		echo -e "\033[32mThe $P_FILES_DIR install success\033[0m"
	else
		echo -e "\033[31mThe $P_FILES_DIR install error,Please check\033[0m"
		exit
	fi
fi 
