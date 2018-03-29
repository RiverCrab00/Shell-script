#!/usr/bash
# auto lamp script
# PATH=/bin: /usr/bin: /usr/local/bin:
# export PATH

src_dir=`pwd`

include(){
	local include=${1}
	if [[ -s ${src_dir}/${include}.sh ]];then
		. ${src_dir}/${include}.sh
	else
		echo -e "\033[31mError:${src_dir}/${include}.sh not found,please check\033[0m"
		exit
	fi
}

lamp(){
	include lamp
}
lamp 2>&1 | tee ${src_dir}/lamp.log
