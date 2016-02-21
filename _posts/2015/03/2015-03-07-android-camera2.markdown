---
layout: post
title: Android Camera2
description: Android Camera2
modified: 2015-03-07 16:34:06 +0800
category: Android Camera2
tags: [Android, Camera2]
image:
feature:
comments: true
mathjax:
featured: false
published: true
---

## CameraApp

1. MediaSaver
2. CaptureSessionManager
3. SessionStorageManager
4. MemoryManagerImpl
5. PlaceholderManager
6. RemoteShutterListener
7. MotionManager
8. SettingsManager
9. CameraServices
  + Functionality available to all modules and services


      /**
       * Returns the capture session manager instance that modules use to store
       * temporary or final capture results.
       */
      public CaptureSessionManager getCaptureSessionManager();

      /**
       * Returns the memory manager which can be used to get informed about memory
       * status updates.
       */
      public MemoryManager getMemoryManager();

      /**
       * Returns the motion manager which senses when significant motion of the
       * camera should unlock a locked focus.
       */
      public MotionManager getMotionManager();

      /**
       * Returns the media saver instance.
       * <p>
       * Deprecated. Use {@link #getCaptureSessionManager()} whenever possible.
       * This direct access to media saver will go away.
       */
      @Deprecated
      public MediaSaver getMediaSaver();

      /**
       * @return A listener to be informed by events interesting for remote
       *         capture apps. Will never return null.
       */
      public RemoteShutterListener getRemoteShutterListener();

      /**
       * @return The settings manager which allows get/set of all app settings.
       */
      public SettingsManager getSettingsManager();

## AbstractGalleryActivity
## ActivityBase
## CameraActivity
