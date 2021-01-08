Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28FAE2EF37E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 14:53:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727811AbhAHNxP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 08:53:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727373AbhAHNxO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 08:53:14 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB12FC0612F6
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jan 2021 05:52:33 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id s21so6256420pfu.13
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jan 2021 05:52:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7A7ZRyd8bM3EbD8yBbdrSHoI1I4U21dIzleuZWsUhdE=;
        b=lBZ/Tet2lEVBUJ6cn4rsZbF+EY1AQcZQEpBf7soVZUe6i7b6lEuy+OSzzvL4YBeTWE
         pi4OPzIY2RBCO4eq7ftPUsq4ajL64mfsbLagIW+J/e18ffX9zpKlhlYVNJIlLbEDpsr3
         iA6mioH26s3MZOBuj3xWQsoLC+orgN++HvuN/QwzItdKH1are7mu3PMsbWnWpuQE/GSN
         Zt6wSBAw8d1XbXwDHuYft1Wb5YfyfMJfrBi32xY2SU0QKMflqwJG07+BeiRFAXMY5oKE
         0l4f5L/oXJrRC3COE9dlCRJrapcqSgRRtp/bFxfXvwTEi3HIe7sWpTWFNEF2ZM6tQ0If
         +KKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7A7ZRyd8bM3EbD8yBbdrSHoI1I4U21dIzleuZWsUhdE=;
        b=RUavqsXIWq7CQmzpL15wiZRc7sf1ot3bD4Qx7qXNOTBWHqE150pXFOLyALvSJUNAfO
         4pLnSb60Cq+TM134q8v+VBYpAz3BLvbL7B4ljdvqlgP3FCEFUKxsfrLFCOA/R8AMOIDJ
         cOdaGCzN/+mTdg6v4ysAe/LAtHmrV/gHAsh6DRVk52WTZMmLr1MZgizRGpx3sAXL3L3B
         LFil7tALr2VthQQFNlqYi2JChhrgeFvvyWDOuqryxOSx3Fhj18F0b8jhJN7WQjZmvR7i
         Wvna8IgBLqCxctd/nVcx2Dj+h6rUggF1mpdwaEtytItn/0D0nYiw2xhZb5vi/NImo+52
         bCQw==
X-Gm-Message-State: AOAM530fD6IOX8tRFtUl9d5/CN8Ike6N7a4lLYs4Q0xtCMRsBe/EwZaa
        IbmOmyKVHDCTDCg4SVJlqgszjA==
X-Google-Smtp-Source: ABdhPJyIM/gZGveg3Ott3VbKrIOIO48KhY6FTrtWhfsUMn4YoBG+fUPNR6EqaujWOqbBL57BNjeY2Q==
X-Received: by 2002:a63:f512:: with SMTP id w18mr7191303pgh.154.1610113953427;
        Fri, 08 Jan 2021 05:52:33 -0800 (PST)
Received: from always-libai.bytedance.net ([153.254.110.96])
        by smtp.gmail.com with ESMTPSA id k64sm9401184pfd.75.2021.01.08.05.52.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jan 2021 05:52:32 -0800 (PST)
From:   zhenwei pi <pizhenwei@bytedance.com>
To:     arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     pbonzini@redhat.com, linux-kernel@vger.kernel.org,
        pizhenwei@bytedance.com
Subject: [PATCH v3 1/2] misc: pvpanic: introduce device capability
Date:   Fri,  8 Jan 2021 21:52:22 +0800
Message-Id: <20210108135223.2924507-2-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210108135223.2924507-1-pizhenwei@bytedance.com>
References: <20210108135223.2924507-1-pizhenwei@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to pvpanic spec:
https://git.qemu.org/?p=qemu.git;a=blob_plain;f=docs/specs/pvpanic.txt

The guest should determine pvpanic capability by RDPT, so initialize
capability during device probing. There is no need to register panic
notifier callback function if no events supported.

Before sending event to host side, check capability firstly.

Suggested by Greg KH, use sysfs to expose capability to user space.

Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
---
 .../ABI/testing/sysfs-bus-pci-devices-pvpanic |  7 ++++
 drivers/misc/pvpanic.c                        | 41 ++++++++++++++++---
 2 files changed, 42 insertions(+), 6 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-pci-devices-pvpanic

diff --git a/Documentation/ABI/testing/sysfs-bus-pci-devices-pvpanic b/Documentation/ABI/testing/sysfs-bus-pci-devices-pvpanic
new file mode 100644
index 000000000000..5daf1167b1c1
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-bus-pci-devices-pvpanic
@@ -0,0 +1,7 @@
+What:		/sys/devices/pci0000:00/*/QEMU0001:00/capability
+Date:		Jan 2021
+Contact:	zhenwei pi <pizhenwei@bytedance.com>
+Description:
+		Capabilities of pvpanic device which are supported by
+		QEMU.
+		Format: %s.
diff --git a/drivers/misc/pvpanic.c b/drivers/misc/pvpanic.c
index 951b37da5e3c..e1023c7b8fb0 100644
--- a/drivers/misc/pvpanic.c
+++ b/drivers/misc/pvpanic.c
@@ -19,6 +19,27 @@
 #include <uapi/misc/pvpanic.h>
 
 static void __iomem *base;
+static unsigned int capability = PVPANIC_PANICKED | PVPANIC_CRASH_LOADED;
+
+static ssize_t capability_show(struct device *dev,
+			       struct device_attribute *attr, char *buf)
+{
+	return sprintf(buf, "%s%s\n",
+		capability & PVPANIC_PANICKED ? "PANICKED " : "",
+		capability & PVPANIC_CRASH_LOADED ? "CRASH_LOADED" : "");
+}
+static DEVICE_ATTR_RO(capability);
+
+static struct attribute *pvpanic_sysfs_entries[] = {
+	&dev_attr_capability.attr,
+	NULL
+};
+
+static const struct attribute_group pvpanic_attribute_group = {
+	.name = NULL,
+	.attrs = pvpanic_sysfs_entries,
+};
+
 
 MODULE_AUTHOR("Hu Tao <hutao@cn.fujitsu.com>");
 MODULE_DESCRIPTION("pvpanic device driver");
@@ -27,7 +48,8 @@ MODULE_LICENSE("GPL");
 static void
 pvpanic_send_event(unsigned int event)
 {
-	iowrite8(event, base);
+	if (event & capability)
+		iowrite8(event, base);
 }
 
 static int
@@ -62,17 +84,24 @@ static int pvpanic_mmio_probe(struct platform_device *pdev)
 	if (IS_ERR(base))
 		return PTR_ERR(base);
 
-	atomic_notifier_chain_register(&panic_notifier_list,
-				       &pvpanic_panic_nb);
+	/* initlize capability by RDPT */
+	capability &= ioread8(base);
 
-	return 0;
+	if (capability)
+		atomic_notifier_chain_register(&panic_notifier_list,
+					       &pvpanic_panic_nb);
+
+	return sysfs_create_group(&dev->kobj, &pvpanic_attribute_group);
 }
 
 static int pvpanic_mmio_remove(struct platform_device *pdev)
 {
 
-	atomic_notifier_chain_unregister(&panic_notifier_list,
-					 &pvpanic_panic_nb);
+	if (capability)
+		atomic_notifier_chain_unregister(&panic_notifier_list,
+						 &pvpanic_panic_nb);
+
+	sysfs_remove_group(&pdev->dev.kobj, &pvpanic_attribute_group);
 
 	return 0;
 }
-- 
2.25.1

