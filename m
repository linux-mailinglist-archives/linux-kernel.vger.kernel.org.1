Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D71B256EB6
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Aug 2020 16:42:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727901AbgH3Omm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Aug 2020 10:42:42 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:44862 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726928AbgH3OmE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Aug 2020 10:42:04 -0400
Received: by mail-lf1-f66.google.com with SMTP id 12so2102900lfb.11;
        Sun, 30 Aug 2020 07:42:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=t835k1LV75bF/p7yGDiAqwKpKLxEKCTqYo8kSWmJosQ=;
        b=JcIN868ambj6eshg95VTyxr8LR84DqFp+vyRSsGGYxaTRv2ML+V+/180CfNTBwRCfZ
         +tb05BniajotTXDh6Hff0oPydaRlmH+qbfNI1H/hkcUxru7MVGzh4NsETfvhzLP1N/dC
         G5U+7v95tN34ubYrZIH5Oi+8jkfHAF9dxOdzOO3gN/se7yNHfgc64w74Cv+6AWxfEgOV
         40Uiiw318735xuR7nUk2mENrtpDBcb6gPVUnUArdc9cjKV1YyJkQooTPjFDpkl6JGUms
         2yQF69fW4elTzyjDDeDkQNFFc7+XHe0p7bW8nOL7Ij1D6j3GzF7T5JmqqTpa3XZaGcfn
         mHZw==
X-Gm-Message-State: AOAM531DUp46aJtrb+K6gTw3rVHjvgzaR6Bcy6mL7n+LpjJduT6Kp7t2
        N+fDdNjewvRIyc4MmTSGW/E=
X-Google-Smtp-Source: ABdhPJxiljaJHGwPNIAIZzx360N62T61h6Lq/D+R5KWmxG/uacLFXXWCUDMnrzNtjnAgnw7ODWkRmQ==
X-Received: by 2002:a05:6512:10ce:: with SMTP id k14mr3666539lfg.7.1598798522069;
        Sun, 30 Aug 2020 07:42:02 -0700 (PDT)
Received: from localhost.localdomain ([213.87.147.111])
        by smtp.googlemail.com with ESMTPSA id h2sm1002466ljl.16.2020.08.30.07.41.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Aug 2020 07:42:01 -0700 (PDT)
From:   Denis Efremov <efremov@linux.com>
To:     Jonathan Corbet <corbet@lwn.net>, Harry Wei <harryxiyou@gmail.com>
Cc:     Denis Efremov <efremov@linux.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] docs: filesystems: replace to_dev() with kobj_to_dev()
Date:   Sun, 30 Aug 2020 17:41:35 +0300
Message-Id: <20200830144135.6956-1-efremov@linux.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit a4232963757e ("driver-core: Move kobj_to_dev from genhd.h to device.h")
introduced kobj_to_dev() function.

Signed-off-by: Denis Efremov <efremov@linux.com>
---
 Documentation/filesystems/sysfs.rst                    | 3 +--
 Documentation/translations/zh_CN/filesystems/sysfs.txt | 3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/Documentation/filesystems/sysfs.rst b/Documentation/filesystems/sysfs.rst
index ab0f7795792b..5a3209a4cebf 100644
--- a/Documentation/filesystems/sysfs.rst
+++ b/Documentation/filesystems/sysfs.rst
@@ -172,14 +172,13 @@ calls the associated methods.
 
 To illustrate::
 
-    #define to_dev(obj) container_of(obj, struct device, kobj)
     #define to_dev_attr(_attr) container_of(_attr, struct device_attribute, attr)
 
     static ssize_t dev_attr_show(struct kobject *kobj, struct attribute *attr,
 				char *buf)
     {
 	    struct device_attribute *dev_attr = to_dev_attr(attr);
-	    struct device *dev = to_dev(kobj);
+	    struct device *dev = kobj_to_dev(kobj);
 	    ssize_t ret = -EIO;
 
 	    if (dev_attr->show)
diff --git a/Documentation/translations/zh_CN/filesystems/sysfs.txt b/Documentation/translations/zh_CN/filesystems/sysfs.txt
index 9481e3ed2a06..046cc1d52058 100644
--- a/Documentation/translations/zh_CN/filesystems/sysfs.txt
+++ b/Documentation/translations/zh_CN/filesystems/sysfs.txt
@@ -154,14 +154,13 @@ sysfs 会为这个类型调用适当的方法。当一个文件被读写时，
 
 示例:
 
-#define to_dev(obj) container_of(obj, struct device, kobj)
 #define to_dev_attr(_attr) container_of(_attr, struct device_attribute, attr)
 
 static ssize_t dev_attr_show(struct kobject *kobj, struct attribute *attr,
                              char *buf)
 {
         struct device_attribute *dev_attr = to_dev_attr(attr);
-        struct device *dev = to_dev(kobj);
+        struct device *dev = kobj_to_dev(kobj);
         ssize_t ret = -EIO;
 
         if (dev_attr->show)
-- 
2.26.2

