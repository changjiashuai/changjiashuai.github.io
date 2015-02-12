---
layout: post
title: "CentOS安装配置Tomcat7"
description: CentOS安装配置Tomcat7
modified: 2015-02-11 22:17:06 +0800
category: CentOS Tomcat7
tags: [CentOS, Tomcat7]
image:
feature:
comments: true
mathjax:
featured: false
published: true
---

##下载tomcat

~~~
cd /usr/local/src
wget http://mirror.bit.edu.cn/apache/tomcat/tomcat-7/v7.0.59/bin/apache-tomcat-7.0.59.zip
~~~

##解压安装tomcat

~~~
yum install unzip -y
unzip -d /usr/local apache-tomcat-7.0.59.zip
cd /usr/local
mv apache-tomcat-7.0.59/ tomcat7
~~~

##配置环境变量

~~~
vi /etc/profile
~~~


######1. 配置`JAVA_HOME`在这个文件末尾加上

~~~
export JAVA_HOME=/usr/java/jdk1.8.0
export JRE_HOME=/usr/java/jdk1.8.0/jre
export CLASSPATH=.:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar
export PATH=$PATH:/sbin:/bin:/usr/sbin:/usr/bin:/usr/X11R6/bin:$JAVA_HOME/bin
~~~


######2. 配置`TOMCAT_HOME`

~~~
cd /usr/local/tomcat7/bin
vi catalina.sh
~~~

在`#!/bin/sh`后面加上

~~~
export TOMCAT_HOME=/usr/local/tomcat7
export CATALINA_HOME=/usr/local/tomcat7
~~~


######3. 利用下面命令使文件有执行权限并使配置生效

~~~
source /etc/profile
cd /usr/local/tomcat7/bin
chmod 777 *.*
~~~

##配置tomcat

######1. 将tomcat加入开机自启动

~~~
echo "source /etc/profile" >>/etc/rc.d/rc.local
echo "/usr/local/tomcat7/bin/startup.sh" >>/etc/rc.d/rc.local  
~~~

>这里有点要说明，rc.local先于/etc/profile执行，所以会得不到JAVA环境变量，所以在startup.sh前加入代码：source /etc/profile  这样就可以


######2. 关闭防火墙

~~~
chkconfig iptables off iptables
service iptables stop
~~~

##测试

~~~
cd /usr/local/tomcat7/bin
./startup.sh
~~~



[开源软件镜像服务](http://mirror.bit.edu.cn/web/)
