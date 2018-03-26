#! /bin/bash

path=`pwd`

cat << EOF


+++++++++++++++++++++++++++++++++++++++++++++++++++++++++
REQUIRED:     centOS-6 (Defulte 32bit/64bit)
DESCRIPTION:  Install LAMP in CentOS
AUTHOR:       Jing.wang
REVISION:     1.0
++++++++++++++++++++++++++++++++++++++++++++++++++++++++


EOF


echo -e "++++++++++++++++++++++++++++Sectino 1 Redy++++++++++++++++++++++++++++"
. ./ready.conf
#Require root 
 
disable_selinux

clean_iptables_rule

requirerpm
if [ $D -eq 5 ] ;then
   echo -e "\033[32m++++++++++++++++++++++++Read Finshed,In stage 2++++++++++++++++++++\033[0m"
else
   echo -e "\033[31mRPM Install Not Finsh,Please Updated REPO Or Up Network\033[0m" && exit 8
fi

inDevelopment
###################################################################################
echo -e "++++++++++++++++++++++++++Sectino2 Download++++++++++++++++++++++++++++"
. ./download.conf

DOWNLOAD

if [ $D -eq 9 ] ;then
   echo -e "\033[32m++++++++++++++++++++++++DownLoad Finshed,In stage 3++++++++++++++++++++\033[0m"
else
   echo -e "\033[31mDownLoad Not Finsh,Please Updated download.conf Or Up Network\033[0m" && exit 8
fi

#################################################################################


echo -e "++++++++++++++++++++++++++Sectino3 UNPACK IN RPM++++++++++++++++++++++++++++"
. ./unpack.conf
INRPM
UNPACK

#################################################################################


echo -e "++++++++++++++++++++++++++Sectino4 Conf && Make && INST+++++++++++++++++++++"
cd $path
. ./makehttpd.conf

INSAPR

INSAPRUTIL

INSHTTPD

UPDADEHTTPD

###################################################################################
cd $path
. ./makemysql.conf
INSMYSQL

UPMYCONF

######################################################################################
cd $path
. ./makephp.conf	

INSPHP


#################################################################################
if ! chkconfig --list httpd ;then
     chkconfig --add httpd
   if [ $? -eq 0  ] ;then
      chkconfig httpd on
      echo -e "\033[32mAdd httpd Server Finish\033[0m"
   else
      echo -e "\033[31mNot Add httpd Server Finish\033[0m"
   fi
else
      echo -e "\033[35mhttpd Server Exist\033[0m"
fi
    

if ! chkconfig --list mysqld ;then
     chkconfig --add mysqld
   if [ $? -eq 0  ] ;then
      chkconfig mysqld on
      echo -e "\033[32mAdd mysqld Server Finish\033[0m"
   else
      echo -e "\033[31mNot Add mysqld Server Finish\033[0m"
    fi
else
      echo -e "\033[35mmysqldServer Exist\033[0m"
fi

. /etc/profile
  ldconfig
 
service mysqld start || service mysqld status
service httpd start  || service httpd status 
    
     
   
   


