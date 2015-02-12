---
layout: post
title: "Apache Maven WAR Plugin"
description: Apache Maven WAR Plugin
modified: 2015-02-12 10:14:06 +0800
category: Apache Maven
tags: [Apache, Maven]
image:
feature:
comments: true
mathjax:
featured: false
published: true
---

`Apache Maven WAR`插件负责收集所有工件的依赖性,web应用程序的类和资源,包装成一个web应用程序存档。

---

##目标概述


+ `war:war` 构建一个war文件
+ `war:exploded`开发阶段加速测试通常用来生成一个额外的webapp文件夹
+ `war:inplace`类似`war:exploded`只是webapp文件夹目录位置不一样，默认在`src/main/webapp`
+ `war:manifest`为这个应用生成一个清单。清单文件在web应用程序源目录中创建

---

##使用


#####1.使用`war:war`

这是正常的使用maven-war插件方式。为了说明这一点,这是pom.xml中我们的项目

~~~
<project>
  ...
  <groupId>com.example.projects</groupId>
  <artifactId>documentedproject</artifactId>
  <packaging>war</packaging>
  <version>1.0-SNAPSHOT</version>
  <name>Documented Project</name>
  <url>http://example.com</url>
  ...
</project>
~~~

项目结构：

~~~
 |-- pom.xml
 `-- src
     `-- main
         |-- java
         |   `-- com
         |       `-- example
         |           `-- projects
         |               `-- SampleAction.java
         |-- resources
         |   `-- images
         |       `-- sampleimage.jpg
         `-- webapp
             |-- WEB-INF
             |   `-- web.xml
             |-- index.jsp
             `-- jsp
                 `-- websource.jsp
~~~

调用

~~~
mvn package
~~~

或者

~~~
mvn compile war:war
~~~

将会生成/documentedproject-1.0-snapshot.war WAR文件。以下是该WAR文件的内容:

~~~
documentedproject-1.0-SNAPSHOT.war
  |-- META-INF
  |   |-- MANIFEST.MF
  |   `-- maven
  |       `-- com.example.projects
  |           `-- documentedproject
  |               |-- pom.properties
  |               `-- pom.xml
  |-- WEB-INF
  |   |-- classes
  |   |   |-- com
  |   |   |   `-- example
  |   |   |       `-- projects
  |   |   |           `-- SampleAction.class
  |   |   `-- images
  |   |       `-- sampleimage.jpg
  |   `-- web.xml
  |-- index.jsp
  `-- jsp
      `-- websource.jsp
~~~

#####2.使用`war:exploded`

开发阶段加速测试可以使用`war:exploded`

~~~
mvn compile war:exploded
~~~

将会生成target/documentedproject-1.0-SNAPSHOT 文件。以下是目录文件的内容:

~~~
 documentedproject-1.0-SNAPSHOT
 |-- META-INF
 |-- WEB-INF
 |   |-- classes
 |   |   |-- com
 |   |   |   `-- example
 |   |   |       `-- projects
 |   |   |           `-- SampleAction.class
 |   |   `-- images
 |   |       `-- sampleimage.jpg
 |   `-- web.xml
 |-- index.jsp
 `-- jsp
     `-- websource.jsp
~~~

默认目录WAR是target/<finalName>。finalName通常的形式<artifactId>-<version>。这可以通过`webappDirectory`参数覆盖默认指定的目录。

~~~
<project>
  ...
  <build>
    <plugins>
      <plugin>
        <groupId>org.apache.maven.plugins</groupId>
        <artifactId>maven-war-plugin</artifactId>
        <version>2.6</version>
        <configuration>
          <webappDirectory>/sample/servlet/container/deploy/directory</webappDirectory>
        </configuration>
      </plugin>
    </plugins>
  </build>
  ...
</project>
~~~

#####3.使用`war:inplace`

类似`war:exploded`只是webapp文件夹目录位置不一样，默认在`src/main/webapp`

~~~
mvn compile war:inplace
~~~

生成项目结构

~~~
 |-- pom.xml
 |-- src
 |   `-- main
 |       |-- java
 |       |   `-- com
 |       |       `-- example
 |       |           `-- projects
 |       |               `-- SampleAction.java
 |       |-- resources
 |       |   `-- images
 |       |       `-- sampleimage.jpg
 |       `-- webapp
 |           |-- META-INF
 |           |-- WEB-INF
 |           |   |-- classes
 |           |   |   |-- com
 |           |   |   |   `-- example
 |           |   |   |       `-- projects
 |           |   |   |           `-- SampleAction.class
 |           |   |   `-- images
 |           |   |       `-- sampleimage.jpg
 |           |   `-- web.xml
 |           |-- index.jsp
 |           `-- jsp
 |               `-- websource.jsp
 `-- target
     `-- classes
         |-- com
         |   `-- example
         |       `-- projects
         |           `-- SampleAction.class
         `-- images
             `-- sampleimage.jpg
~~~

---
[maven-war-plugin](http://maven.apache.org/plugins/maven-war-plugin/)