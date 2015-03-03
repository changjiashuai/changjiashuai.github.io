---
layout: post
title: "Maven部署Web项目到Tomcat的配置"
description: Maven部署Web项目到Tomcat的配置
modified: 2015-02-11 17:33:06 +0800
category: Java Maven Tomcat
tags: [Java, Maven, Tomcat]
image:
feature:
comments: true
mathjax:
featured: false
published: true
---

##配置Tomcat角色

Maven自动部署实际上调的是Tomcat安装目录下的manager功能。而为了能正常访问`http://localhost:8080/manager`页面，我们需要修改`$TOMCAT_HOME/conf`目录下的`tomcat-users.xml`

~~~
<tomcat-users>
  <role rolename="tomcat"/>
  <role rolename="manager"/>
  <role rolename="manager-gui"/>
  <role rolename="manager-script" />
  <role rolename="admin-gui"/>
  <user username="tomcat" password="tomcat" roles="tomcat,manager,
      manager-gui,manager-script,admin-gui" />
</tomcat-users>					
~~~

##修改pom.xml增加Tomcat Maven插件

我使用的Tomcat7，pom.xml中增加如下配置：

~~~
<plugin>
	<groupId>org.apache.tomcat.maven</groupId>
	<artifactId>tomcat7-maven-plugin</artifactId>
	<version>2.2</version>
	<configuration>
		<uriEncoding>UTF-8</uriEncoding>
		<url>http://localhost:8080/manager/text</url>
		<server>tomcat</server>
		<username>tomcat</username>
		<password>tomcat</password>
		<port>8080</port>
		<path>/${finalName}</path>
	</configuration>
</plugin>
~~~
上面username、password来自tomcat-users.xml。server是Tomcat服务器名称。path是访问应用的路径。url指定Tomcat管理页路径。

##修改Maven的settings.xml

在`$USER_HOME/.m2`目录下找到`settings.xml`，添加server节点

~~~
<servers>
    <server>
       <id>tomcat</id>
       <username>tomcat</username>
       <password>tomcat</password>
    </server>
</servers>
~~~
上面的username、password依然与`tomcat-users.xml`中相同，id与`pom.xml`中的server相同

##部署项目到Tomcat

先确保Tomcat服务器已经启动，然后cd到项目根目录，运行下面的命令

~~~
mvn clean tomcat7:redeploy
~~~

##部署成功，如下:

~~~
➜  party  mvn clean tomcat7:redeploy
[INFO] Scanning for projects...
[INFO]                                                                         
[INFO] ------------------------------------------------------------------------
[INFO] Building party 1.0-SNAPSHOT
[INFO] ------------------------------------------------------------------------
[INFO] 
[INFO] --- maven-clean-plugin:2.5:clean (default-clean) @ party ---
[INFO] Deleting /Users/CJS/Documents/VersionRepository/Git/party/target
[INFO] 
[INFO] >>> tomcat7-maven-plugin:2.2:redeploy (default-cli) > package @ party >>>
[INFO] 
[INFO] --- maven-resources-plugin:2.6:resources (default-resources) @ party ---
[INFO] Using 'UTF-8' encoding to copy filtered resources.
[INFO] Copying 0 resource
[INFO] 
[INFO] --- maven-compiler-plugin:3.1:compile (default-compile) @ party ---
[INFO] Changes detected - recompiling the module!
[INFO] Compiling 3 source files to /Users/CJS/Documents/VersionRepository/Git/party/target/classes
[INFO] 
[INFO] --- maven-resources-plugin:2.6:testResources (default-testResources) @ party ---
[INFO] Using 'UTF-8' encoding to copy filtered resources.
[INFO] Copying 0 resource
[INFO] 
[INFO] --- maven-compiler-plugin:3.1:testCompile (default-testCompile) @ party ---
[INFO] Nothing to compile - all classes are up to date
[INFO] 
[INFO] --- maven-surefire-plugin:2.12.4:test (default-test) @ party ---
[INFO] 
[INFO] --- maven-war-plugin:2.2:war (default-war) @ party ---
[INFO] Packaging webapp
[INFO] Assembling webapp [party] in [/Users/CJS/Documents/VersionRepository/Git/party/target/party]
[INFO] Processing war project
[INFO] Copying webapp resources [/Users/CJS/Documents/VersionRepository/Git/party/src/main/webapp]
[INFO] Webapp assembled in [56 msecs]
[INFO] Building war: /Users/CJS/Documents/VersionRepository/Git/party/target/party.war
[INFO] WEB-INF/web.xml already added, skipping
[INFO] 
[INFO] <<< tomcat7-maven-plugin:2.2:redeploy (default-cli) < package @ party <<<
[INFO] 
[INFO] --- tomcat7-maven-plugin:2.2:redeploy (default-cli) @ party ---
[INFO] Deploying war to http://blog.vzhibo.tv:8080/party  
Uploading: http://xxxx:8080/manager/text/deploy?path=%2Fparty&update=true
Uploaded: http://xxxx:8080/manager/text/deploy?path=%2Fparty&update=true (1774 KB at 1193.7 KB/sec)

[INFO] tomcatManager status code:200, ReasonPhrase:OK
[INFO] OK - Deployed application at context path /party
[INFO] ------------------------------------------------------------------------
[INFO] BUILD SUCCESS
[INFO] ------------------------------------------------------------------------
[INFO] Total time: 8.042 s
[INFO] Finished at: 2015-02-11T16:48:07+08:00
[INFO] Final Memory: 15M/81M
[INFO] ------------------------------------------------------------------------
➜  party  
~~~

然后我们就能在Tomcat安装目录的webapps目录下找到新部署的WAR包。

初次部署用的是`tomcat7:deploy`命令，重新部署可以用`tomcat7:redeploy`命令，Tomcat Maven插件支持的命令包括：`run`、`shutdown`、`run-war-only`、`exec-war`、`standalone-war-only`、`deploy`、`standalone-war`、`undeploy`、`run-war`、`redeploy`等。

[maven-plugin-2.2](http://tomcat.apache.org/maven-plugin-2.2/index.html)

