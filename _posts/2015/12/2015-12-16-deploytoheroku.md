---
layout: post
title: "deploy to heroku"
description: deploy to heroku
headline: jersey java
modified: 2015-12-16
category: jersey java
tags: [jersey, java]
image:
feature:
comments: true
mathjax:
---

## deploy to heroku

## install heroku
>https://devcenter.heroku.com/articles/getting-started-with-java#introduction


## create heroku webapp
>plugin

~~~xml
<dependency>
	<groupId>org.glassfish.jersey.archetypes</groupId>
	<artifactId>jersey-heroku-webapp</artifactId>
	<version>2.22.1</version>
</dependency>
~~~

~~~
mvn archetype:generate -DarchetypeArtifactId=jersey-heroku-webapp \
                -DarchetypeGroupId=org.glassfish.jersey.archetypes -DinteractiveMode=false \
                -DgroupId=com.example -DartifactId=simple-heroku-webapp -Dpackage=com.example \
                -DarchetypeVersion=2.22.1
~~~

## compile
~~~
mvn clean package
~~~

## Deploy it on Heroku
~~~
 $ git init
 Initialized empty Git repository in /.../simple-heroku-webapp/.git/
~~~

## create a Heroku instance and add a remote reference to your Git repository
~~~
$ heroku create
    Creating simple-heroku-webapp... done, stack is cedar
    http://simple-heroku-webapp.herokuapp.com/ | git@heroku.com:simple-heroku-webapp.git
    Git remote heroku added
~~~

## Add and commit files to your Git repository
~~~
$ git add src/ pom.xml Procfile system.properties
    $ git commit -a -m "initial commit"
    [master (root-commit) e2b58e3] initial commit
     7 files changed, 221 insertions(+)
     create mode 100644 Procfile
     create mode 100644 pom.xml
     create mode 100644 src/main/java/com/example/MyResource.java
     create mode 100644 src/main/java/com/example/heroku/Main.java
     create mode 100644 src/main/webapp/WEB-INF/web.xml
     create mode 100644 src/test/java/com/example/MyResourceTest.java
     create mode 100644 system.properties
~~~

## Push changes to Heroku
~~~
$ git push heroku master
    Counting objects: 21, done.
    Delta compression using up to 8 threads.
    Compressing objects: 100% (11/11), done.
    Writing objects: 100% (21/21), 3.73 KiB | 0 bytes/s, done.
    Total 21 (delta 0), reused 0 (delta 0)

    -----> Java app detected
    -----> Installing OpenJDK 1.7... done
    -----> Installing Maven 3.0.3... done
    -----> Installing settings.xml... done
    -----> executing /app/tmp/cache/.maven/bin/mvn -B -Duser.home=/tmp/build_992cc747-26d6-4800-bdb1-add47b9583cd -Dmaven.repo.local=/app/tmp/cache/.m2/repository -s /app/tmp/cache/.m2/settings.xml -DskipTests=true clean install
           [INFO] Scanning for projects...
           [INFO]
           [INFO] ------------------------------------------------------------------------
           [INFO] Building simple-heroku-webapp 1.0-SNAPSHOT
           [INFO] ------------------------------------------------------------------------
           [INFO]
           [INFO] --- maven-clean-plugin:2.4.1:clean (default-clean) @ simple-heroku-webapp ---
           [INFO]
           [INFO] --- maven-resources-plugin:2.4.3:resources (default-resources) @ simple-heroku-webapp ---
           [INFO] Using 'UTF-8' encoding to copy filtered resources.
           [INFO] skip non existing resourceDirectory /tmp/build_992cc747-26d6-4800-bdb1-add47b9583cd/src/main/resources
           [INFO]
           [INFO] --- maven-compiler-plugin:2.5.1:compile (default-compile) @ simple-heroku-webapp ---
           [INFO] Compiling 2 source files to /tmp/build_992cc747-26d6-4800-bdb1-add47b9583cd/target/classes
           [INFO]
           [INFO] --- maven-resources-plugin:2.4.3:testResources (default-testResources) @ simple-heroku-webapp ---
           [INFO] Using 'UTF-8' encoding to copy filtered resources.
           [INFO] skip non existing resourceDirectory /tmp/build_992cc747-26d6-4800-bdb1-add47b9583cd/src/test/resources
           [INFO]
           [INFO] --- maven-compiler-plugin:2.5.1:testCompile (default-testCompile) @ simple-heroku-webapp ---
           [INFO] Compiling 1 source file to /tmp/build_992cc747-26d6-4800-bdb1-add47b9583cd/target/test-classes
           [INFO]
           [INFO] --- maven-surefire-plugin:2.7.2:test (default-test) @ simple-heroku-webapp ---
           [INFO] Tests are skipped.
           [INFO]
           [INFO] --- maven-war-plugin:2.1.1:war (default-war) @ simple-heroku-webapp ---
           [INFO] Packaging webapp
           [INFO] Assembling webapp [simple-heroku-webapp] in [/tmp/build_992cc747-26d6-4800-bdb1-add47b9583cd/target/simple-heroku-webapp]
           [INFO] Processing war project
           [INFO] Copying webapp resources [/tmp/build_992cc747-26d6-4800-bdb1-add47b9583cd/src/main/webapp]
           [INFO] Webapp assembled in [88 msecs]
           [INFO] Building war: /tmp/build_992cc747-26d6-4800-bdb1-add47b9583cd/target/simple-heroku-webapp.war
           [INFO] WEB-INF/web.xml already added, skipping
           [INFO]
           [INFO] --- maven-dependency-plugin:2.1:copy-dependencies (copy-dependencies) @ simple-heroku-webapp ---
           [INFO] Copying guava-14.0.1.jar to /tmp/build_992cc747-26d6-4800-bdb1-add47b9583cd/target/dependency/guava-14.0.1.jar
           [INFO] Copying javax.annotation-api-1.2.jar to /tmp/build_992cc747-26d6-4800-bdb1-add47b9583cd/target/dependency/javax.annotation-api-1.2.jar
           [INFO] Copying validation-api-1.1.0.Final.jar to /tmp/build_992cc747-26d6-4800-bdb1-add47b9583cd/target/dependency/validation-api-1.1.0.Final.jar
           [INFO] Copying javax.ws.rs-api-2.0.jar to /tmp/build_992cc747-26d6-4800-bdb1-add47b9583cd/target/dependency/javax.ws.rs-api-2.0.jar
           [INFO] Copying jetty-http-9.0.6.v20130930.jar to /tmp/build_992cc747-26d6-4800-bdb1-add47b9583cd/target/dependency/jetty-http-9.0.6.v20130930.jar
           [INFO] Copying jetty-io-9.0.6.v20130930.jar to /tmp/build_992cc747-26d6-4800-bdb1-add47b9583cd/target/dependency/jetty-io-9.0.6.v20130930.jar
           [INFO]....
           ......
           ......
remote:        [INFO] Downloaded: https://repo.maven.apache.org/maven2/org/codehaus/plexus/plexus-utils/3.0.5/plexus-utils-3.0.5.jar (226 KB at 4788.2 KB/sec)
remote:        [INFO] Installing /tmp/build_6fd9105b9ada958abe216454b931be4f/target/simple-heroku-webapp.war to /app/tmp/cache/.m2/repository/com/cjs/simple-heroku-webapp/1.0-SNAPSHOT/simple-heroku-webapp-1.0-SNAPSHOT.war
remote:        [INFO] Installing /tmp/build_6fd9105b9ada958abe216454b931be4f/pom.xml to /app/tmp/cache/.m2/repository/com/cjs/simple-heroku-webapp/1.0-SNAPSHOT/simple-heroku-webapp-1.0-SNAPSHOT.pom
remote:        [INFO] ------------------------------------------------------------------------
remote:        [INFO] BUILD SUCCESS
remote:        [INFO] ------------------------------------------------------------------------
remote:        [INFO] Total time: 19.404 s
remote:        [INFO] Finished at: 2015-12-16T16:09:29+00:00
remote:        [INFO] Final Memory: 27M/157M
remote:        [INFO] ------------------------------------------------------------------------
remote: -----> Discovering process types
remote:        Procfile declares types -> web
remote:
remote: -----> Compressing... done, 73.9MB
remote: -----> Launching... done, v5
remote:        https://desolate-sierra-6321.herokuapp.com/ deployed to Heroku
remote:
remote: Verifying deploy.... done.
To https://git.heroku.com/desolate-sierra-6321.git
 * [new branch]      master -> master
~~~

## Now you can access your application at, for example
> http://desolate-sierra-6321.herokuapp.com/myresource
