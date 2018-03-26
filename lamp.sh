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
p_FILES=php-5.6.9.tar.gz
p_FILES_DIR=php-5.6.9          
p_URL=http://mirrors.sohu.com/php/
p_PREFIX=/usr/local/php

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
elif [[ "$1" -eq 1 ]];then
	wget -c $H_URL/$H_FILES && tar -xf $H_FILES && cd $H_FILES_DIR;
	./configure --prefix=$H_PREFIX --with-include-apr --with-apr=/usr/local/apr --with-apr-util=/usr/local/apr-util --with-pcre=/usr/local/pcre  --with-included-apr
	./configure --prefix=/usr/local/apache2 --with-apr=/usr/local/apr --with-apr-util=/usr/local/apr-util/ --with-pcre=/usr/local/pcre --enable-mods-shared=most --enable-so --with-included-apr
	if [[ "$?" -eq 0 ]]; then
		make && make install
		echo "\033[32mThe $H_FILES_DIR install success\033[0m"
	else
		echo "\033[31mThe $H_FILES_DIR install error,Please check\033[0m"
		exit
	fi
fi 