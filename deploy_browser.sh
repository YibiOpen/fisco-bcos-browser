#!/bin/bash

######################  参数配置  ######################
userName="p_bcos"  #需要创建的数据库用户
password="Ebkj!@#201805" #需要创建的数据库用户密码
dbName="product_bcos"     #需要创建的数据库名
dbIp="rm-bp1g1a6x067o727di.mysql.rds.aliyuncs.com"   #数据库所在机器IP
tomcatpath="/httx/run/tomcat8/" #tomcat所在路径

###################### 参数配置结束 #################### 



#################### 计算全局路径####################
dirpath="$(cd "$(dirname "$0")" && pwd)"

#server gradle build 路径
serverpath="${dirpath}/server/fisco-bcos-browser"

#page gradle build 路径
pagepath="${dirpath}/page/fisco-bcos-browser" 

#生成war包cp进Tomcat路径
deployserverpath="${tomcatpath}/webapps"	

#启动Tomcat bin目录下的项目启动脚本路径
startbroswer="${tomcatpath}/bin"


###################### 配置server ######################

# execute sql end  
set -e

echo "开始配置server...."

echo "
db.ip=${dbIp}
db.user=${userName}
db.password=${password}
db.database=${dbName}
db.port=3306
db.initialSize=10
db.minIdle=0
db.maxActive=100
db.maxWait=10000
db.timeBetweenEvictionRunsMillis=60000
db.minEvictableIdleTimeMillis=300000

startTrigger.schedule.time=0/3 * * * * ?
blockInfoTrigger.schedule.time=0/5 * * * * ?
pendingTransTrigger.schedule.time=0/1 * * * * ?
NodeInfoTrigger.schedule.time=0/5 * * * * ?

" > ${serverpath}/src/main/resources/application.properties

#server gradle build and cp
echo "gradle build start"

echo "${serverpath}"

cd ${serverpath}

gradle build

#sudo rm ${deployserverpath}/bcos-server* -rf
#sudo cp "${serverpath}/bcos-server/apps/bcos-server.war" "${deployserverpath}"

###################### 配置page ######################

#page gradle build and cp 
cd ${pagepath}

echo "开始配置page...."

echo "
jdbc_driverClassName = com.mysql.jdbc.Driver
jdbc_initialSize = 5
jdbc_maxActive = 20
jdbc_minIdle = 5
jdbc_maxIdle = 5
jdbc_maxWait = 60000
jdbc_url = jdbc:mysql://${dbIp}/${dbName}
jdbc_username = ${userName}
jdbc_password = ${password}
" > ${pagepath}/src/main/resources/jdbc.properties

echo "${pagepath}"

gradle build

#sudo rm ${deployserverpath}/fisco-bcos-browser* -rf
#sudo cp "${pagepath}/dist/apps/fisco-bcos-browser.war" "${deployserverpath}"

echo "gradle build end"

###################### 启动tomcat ######################

echo "开始部署浏览器应用..."

cd ${startbroswer}

#set +e && sudo sh shutdown.sh && set -e

sudo rm ${deployserverpath}/fisco-bcos-server* -rf
sudo cp "${serverpath}/fisco-bcos-server/apps/fisco-bcos-server.war" "${deployserverpath}"

sudo rm ${deployserverpath}/fisco-bcos-browser* -rf
sudo rm ${deployserverpath}/ROOT* -rf
sudo cp "${pagepath}/dist/apps/fisco-bcos-browser.war" "${deployserverpath}"
sudo mv "${deployserverpath}/fisco-bcos-browser.war" "${deployserverpath}/ROOT.war"

sudo sh startup.sh

echo "部署成功！请继续在每台机器上部署report脚本。"

exit;
































