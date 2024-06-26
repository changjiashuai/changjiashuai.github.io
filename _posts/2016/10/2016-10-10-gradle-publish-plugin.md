---
layout: post
title: "Gradle Plugin Publish"
description: Gradle Plugin Publish
headline: Gradle Plugin Publish
modified: 2016-10-10
category: Gradle Plugin Publish
tags: [Android, Gradle Plugin]
image:
feature:
comments: true
mathjax:
---

---
1. 注册
	> https://plugins.gradle.org/user/register

2. 登录后点击`API Keys` Tab 可以看到

	```
	gradle.publish.key=***
  gradle.publish.secret=***
	```

3. 添加API Keys到你的gradle配置文件 gradle配置文件位置：
  ```
	$USER_HOME/.gradle/gradle.properties
  ```

4.  使用 publishing plugin

	Simple Example:

	```
	// First, apply the publishing plugin
	buildscript {
	  repositories {
	    maven {
	      url "https://plugins.gradle.org/m2/"
	    }
	  }
	  dependencies {
	    classpath "com.gradle.publish:plugin-publish-plugin:0.9.6"
	  }
	}

	apply plugin: "com.gradle.plugin-publish"
	// Apply other plugins here, e.g. java plugin for a plugin written in java or
	// the groovy plugin for a plugin written in groovy

	// If your plugin has any external java dependencies, Gradle will attempt to
	// downloaded them from JCenter for anyone using the plugins DSL
	// so you should probably use JCenter for dependency resolution in your own
	// project.
	repositories {
	  jcenter()
	}

	dependencies {
	  compile gradleApi()
	  compile localGroovy() //not needed for Java plugins
	  // other dependencies that your plugin requires
	}

	// Unless overridden in the pluginBundle config DSL, the project version will
	// be used as your plugin version when publishing
	version = "1.2"
	group = "com.foo.myplugin"

	// The configuration example below shows the minimum required properties
	// configured to publish your plugin to the plugin portal
	pluginBundle {
	  website = 'http://www.gradle.org/'
	  vcsUrl = 'https://github.com/gradle/gradle'
	  description = 'Greetings from here!'
	  tags = ['greetings', 'salutations']

	  plugins {
	    greetingsPlugin {
	      id = 'org.samples.greeting'
	      displayName = 'Gradle Greeting plugin'
	    }
	  }
	}
	```

	Full Example:

	```
	// First, apply the publishing plugin
	buildscript {
	  repositories {
	    maven {
	      url "https://plugins.gradle.org/m2/"
	    }
	  }
	  dependencies {
	    classpath "com.gradle.publish:plugin-publish-plugin:0.9.6"
	  }
	}

	apply plugin: "com.gradle.plugin-publish"
	// Apply other plugins here, e.g. java plugin for a plugin written in java or
	// the groovy plugin for a plugin written in groovy

	// If your plugin has any external java dependencies, Gradle will attempt to
	// downloaded them from JCenter for anyone using the plugins DSL
	// so you should probably use JCenter for dependency resolution in your own
	// project.
	repositories {
	  jcenter()
	}

	dependencies {
	  compile gradleApi()
	  compile localGroovy() //not needed for Java plugins
	  // other dependencies that your plugin requires
	}

	pluginBundle {
	  // These settings are set for the whole plugin bundle
	  website = 'http://www.gradle.org/'
	  vcsUrl = 'https://github.com/gradle/gradle'

	  // tags and description can be set for the whole bundle here, but can also
	  // be set / overridden in the config for specific plugins
	  description = 'Greetings from here!'

	  // The plugins block can contain multiple plugin entries.
	  //
	  // The name for each plugin block below (greetingsPlugin, goodbyePlugin)
	  // does not affect the plugin configuration, but they need to be unique
	  // for each plugin.

	  // Plugin config blocks can set the id, displayName, version, description
	  // and tags for each plugin.

	  // id and displayName are mandatory.
	  // If no version is set, the project version will be used.
	  // If no tags or description are set, the tags or description from the
	  // pluginBundle block will be used, but they must be set in one of the
	  // two places.

	  plugins {

	    // first plugin
	    greetingsPlugin {
	      id = 'org.samples.greeting'
	      displayName = 'Gradle Greeting plugin'
	      tags = ['individual', 'tags', 'per', 'plugin']
	      version = '1.2'
	    }

	    // another plugin
	    goodbyePlugin {
	      id = 'org.samples.goodbye'
	      displayName = 'Gradle Goodbye plugin'
	      description = 'Override description for this plugin'
	      tags = ['different', 'for', 'this', 'one']
	      version = '1.3'
	    }
	  }

	  // Optional overrides for Maven coordinates.
	  // If you have an existing plugin deployed to Bintray and would like to keep
	  // your existing group ID and artifact ID for continuity, you can specify
	  // them here.
	  //
	  // As publishing to a custom group requires manual approval by the Gradle
	  // team for security reasons, we recommend not overriding the group ID unless
	  // you have an existing group ID that you wish to keep. If not overridden,
	  // plugins will be published automatically without a manual approval process.
	  //
	  // You can also override the version of the deployed artifact here, though it
	  // defaults to the project version, which would normally be sufficient.

	  mavenCoordinates {
	    groupId = "org.samples.override"
	    artifactId = "greeting-plugins"
	    version = "1.4"
	  }
	}
	```

5. 通过审核后，会收到邮件通知，就可以在`https://plugins.gradle.org`这里搜索到你的插件了^……^。
