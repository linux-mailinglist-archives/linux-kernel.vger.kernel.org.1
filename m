Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 378D22F0565
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jan 2021 06:38:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726495AbhAJFiK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jan 2021 00:38:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726447AbhAJFiJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jan 2021 00:38:09 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DBE8C06179F
        for <linux-kernel@vger.kernel.org>; Sat,  9 Jan 2021 21:37:29 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id j13so8495142pjz.3
        for <linux-kernel@vger.kernel.org>; Sat, 09 Jan 2021 21:37:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bcYNk7Z0JDeHH9RGSjZ2lY+BP3JT2nwQaLEzMSlfTuc=;
        b=UW7b/j7lwth15/RAsdrPHf3N0hoMp1d1sDqNJGtve9//iSX6O1e5tS3L4EaROezvQ4
         SLNT7xo/pFeUx9F3XpMn7S8ZR04WYHKIwFw4jTKas6rW2d2Kps227vNzrq49mlpNsfhO
         Hpzr4/Icl2cEHQVDPnzDPBmskjKZkhUEFn0idmn/kK5NL372vaqac+5tZLI/Tv6HeEBn
         HUNx+vL+sFLgLMTJc2X2jUbF58Z2yFzsNQBqI7r5kEF8U32ep8cx70vaMFIRpoN+BNvz
         Y3mNnKwOfaLVnws1oKew7svDiVxlTbD8Ww5jRc/HW9mVznbkkoWlxwwjzpn33981wuvL
         WyXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bcYNk7Z0JDeHH9RGSjZ2lY+BP3JT2nwQaLEzMSlfTuc=;
        b=A9P+AA61PyXvW8ieObGjBC+I7iRk/yz3uVuIMYs7ORbSVNM+E3+GxSMArScj0xfa/s
         bCPoB9bx53vid5qMIKVEf6BF5l4DOGraKPKC4w0ncHYTuHAiifLf+kcV/kXVISn2W7Yr
         8mom79qVr8gZc+ImHEU+AY/fX8POlOlFxYiyfQ1HOdrf7wkd/0vke+TOxauRDdDmXzMt
         u12ZFbApequ8J4fQaiH9Jt+sk3DskHtJV+di7v1jV0/sCrdU6Sd2h2fHklpq7uDPxbRp
         Xg6AtxJStMZanoFiNIB7UlE8KORJ1gS3gCFjYvCbIjxUylJKhVIpJ7YBBnUeb9GjrO+4
         aLRg==
X-Gm-Message-State: AOAM5302GyGZRKcQPLgCTRk9m/xXKQAzn9Yp2JNhuN2eVpAEeSfXFwCT
        d+CBWSdPSmkovtJwNJgu3Gwp7Q==
X-Google-Smtp-Source: ABdhPJwTIAoFvTFN8eG6/bwAVX+h7V5okbCcGaavwgeCpcfKZMGB6uXejI2+CA9PXSYu//+8TwJmqg==
X-Received: by 2002:a17:902:d202:b029:da:d86b:78be with SMTP id t2-20020a170902d202b02900dad86b78bemr14396045ply.0.1610257049098;
        Sat, 09 Jan 2021 21:37:29 -0800 (PST)
Received: from always-libai.bytedance.net ([61.120.150.71])
        by smtp.gmail.com with ESMTPSA id q15sm14474013pgk.11.2021.01.09.21.37.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Jan 2021 21:37:28 -0800 (PST)
From:   zhenwei pi <pizhenwei@bytedance.com>
To:     arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     pbonzini@redhat.com, linux-kernel@vger.kernel.org,
        pizhenwei@bytedance.com
Subject: [PATCH v4 1/2] misc: pvpanic: introduce device capability
Date:   Sun, 10 Jan 2021 13:37:18 +0800
Message-Id: <20210110053719.3038348-2-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210110053719.3038348-1-pizhenwei@bytedance.com>
References: <20210110053719.3038348-1-pizhenwei@bytedance.com>
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

Suggested by Greg KH, use sysfs to expose capability to user space,
also add new sysfs attribute in document.

Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
---
 .../ABI/testing/sysfs-bus-pci-devices-pvpanic |  7 ++++
 drivers/misc/pvpanic.c                        | 33 ++++++++++++++++---
 2 files changed, 35 insertions(+), 5 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-pci-devices-pvpanic

diff --git a/Documentation/ABI/testing/sysfs-bus-pci-devices-pvpanic b/Documentation/ABI/testing/sysfs-bus-pci-devices-pvpanic
new file mode 100644
index 000000000000..57d014a2c339
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-bus-pci-devices-pvpanic
@@ -0,0 +1,7 @@
+What:		/sys/devices/pci0000:00/*/QEMU0001:00/capability
+Date:		Jan 2021
+Contact:	zhenwei pi <pizhenwei@bytedance.com>
+Description:
+		Read-only attribute. Capabilities of pvpanic device
+		which are supported by QEMU.
+		Format: %s.
diff --git a/drivers/misc/pvpanic.c b/drivers/misc/pvpanic.c
index 951b37da5e3c..c2f6a9e866b3 100644
--- a/drivers/misc/pvpanic.c
+++ b/drivers/misc/pvpanic.c
@@ -19,6 +19,22 @@
 #include <uapi/misc/pvpanic.h>
 
 static void __iomem *base;
+static unsigned int capability = PVPANIC_PANICKED | PVPANIC_CRASH_LOADED;
+
+static ssize_t capability_show(struct device *dev,
+			       struct device_attribute *attr, char *buf)
+{
+	return sprintf(buf, "%s%s",
+		capability & PVPANIC_PANICKED ? "PANICKED[BIT 0]\n" : "",
+		capability & PVPANIC_CRASH_LOADED ? "CRASH_LOADED[BIT 1]\n" : "");
+}
+static DEVICE_ATTR_RO(capability);
+
+static struct attribute *pvpanic_dev_attrs[] = {
+	&dev_attr_capability.attr,
+	NULL
+};
+ATTRIBUTE_GROUPS(pvpanic_dev);
 
 MODULE_AUTHOR("Hu Tao <hutao@cn.fujitsu.com>");
 MODULE_DESCRIPTION("pvpanic device driver");
@@ -27,7 +43,8 @@ MODULE_LICENSE("GPL");
 static void
 pvpanic_send_event(unsigned int event)
 {
-	iowrite8(event, base);
+	if (event & capability)
+		iowrite8(event, base);
 }
 
 static int
@@ -62,8 +79,12 @@ static int pvpanic_mmio_probe(struct platform_device *pdev)
 	if (IS_ERR(base))
 		return PTR_ERR(base);
 
-	atomic_notifier_chain_register(&panic_notifier_list,
-				       &pvpanic_panic_nb);
+	/* initlize capability by RDPT */
+	capability &= ioread8(base);
+
+	if (capability)
+		atomic_notifier_chain_register(&panic_notifier_list,
+					       &pvpanic_panic_nb);
 
 	return 0;
 }
@@ -71,8 +92,9 @@ static int pvpanic_mmio_probe(struct platform_device *pdev)
 static int pvpanic_mmio_remove(struct platform_device *pdev)
 {
 
-	atomic_notifier_chain_unregister(&panic_notifier_list,
-					 &pvpanic_panic_nb);
+	if (capability)
+		atomic_notifier_chain_unregister(&panic_notifier_list,
+						 &pvpanic_panic_nb);
 
 	return 0;
 }
@@ -93,6 +115,7 @@ static struct platform_driver pvpanic_mmio_driver = {
 		.name = "pvpanic-mmio",
 		.of_match_table = pvpanic_mmio_match,
 		.acpi_match_table = pvpanic_device_ids,
+		.dev_groups = pvpanic_dev_groups,
 	},
 	.probe = pvpanic_mmio_probe,
 	.remove = pvpanic_mmio_remove,
-- 
2.25.1

