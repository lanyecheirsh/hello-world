#!/bin/bash


serverIP=172.25.21.146
port=3306
user=videoweb
passwd=suntek

#登陆MYSQL执行SQL语句
#mysql -u${user} -p${passwd} -e"
#tee /tmp/tmp.log
#drop database pd_viid if exists pd_viid;
#create database if not exists pd_viid default charset utf8 COLLATE utf8_general_ci;
#notee
#quit
#"

#登陆MYSQL执行SQL语句
mysql -u${user} -p${passwd} <<EOF 
tee /tmp/tmp.log
drop database pd_viid if exists pd_viid;
create database if not exists pd_viid default charset utf8 COLLATE utf8_general_ci;
notee
EOF
exit; 

#初始化视图库
echo "初始化视图库">>/tmp/tmp.log
mysql --host=$serverIP --port=$port --user=videoweb --password=suntek  --default-character-set=utf8  -D pd_viid <./pd_viid/pd_viid.sql

#初始化视图表
echo "初始化视图表">>/tmp/tmp.log
mysql --host=$serverIP --port=$port --user=videoweb --password=suntek  --default-character-set=utf8  -D pd_viid <./pd_viid/pd_viid_dep_view.sql 


#!/bin/bash

#creat mysqlfile
baseDir=`pwd`
time=$(date +"%Y%m%d%H%M%S")
file_name=test_insert_${time}.sql

max=10
for ((i=0;i<$max;i++));
do
#-e打开echo对转义字符的解释功能
echo -e "INSERT INTO pd_viid.DB_VERSION (VERSION, REMARK, VERSION_TYPE, UPDATE_DATE) VALUES ('视图库v4.0.0', '${i}', '6', '2020-06-24 17:21:49');\n">>${file_name}
done
