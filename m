Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 912EB2F06C2
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jan 2021 12:54:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726511AbhAJLyw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jan 2021 06:54:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726254AbhAJLyv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jan 2021 06:54:51 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62A81C0617A2
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jan 2021 03:54:11 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id b8so8051427plx.0
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jan 2021 03:54:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VeaXxSmfDmEyhYbpRgODxLXYHKKQpbVaRLSWVCUfEEs=;
        b=ob/PBPUzU3CRW8Ec2HtNpeAtxYohDUGUGRJOlHAb87E8usN3Juk9Zeb47EipxXqIQR
         /is4Dkb4P5iW4/F5xSNj2/lv9wb1BEUggPHOHmKu9jDEyfh6i34vxuskU9mudlN5D95F
         c6NGyxcc2S3EijhZM3fETFcghwGK84lqwiLeTgS4IMwcbpw4ziUBngb6STTB1jNIx77/
         INlaFKIZGJvpfidTuGSujy2kCGWxcuSAYrD75cUarMLnA2V97ZozYTqic0pxkoQ9TcLO
         sshpKoTwmkdX4QXVNIE6mMVJnJpKz4OXrP09jMXqOGa9E/hNEBC2lJpr2LCCRrPXSxhU
         mEXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VeaXxSmfDmEyhYbpRgODxLXYHKKQpbVaRLSWVCUfEEs=;
        b=NLA4TQcsDZJCgK5iiKIdwl8K1lLzH2fjY7Rn9cuwKmcNbtOWOlsh8DbJJoHrLmmu2O
         DBm8THe9J+O3T5sqxErzz4xXKp5LIvMpqt1f3Y2nLUKkWPfBVQ7miXDuGVrU/foj6KXK
         BAWjFBnVy7BkqkP098tTamSEDSR4U9OXaJ1Wv2qrNl3Td/kAZZgLWBFT96dmqI5MMYa0
         3CQAS+gTa/FODD2dzstANDVhpLJHg6SZIQUWehb2oUIub1mzU8svmVdcOjP+jxb8AYxC
         nW3ArSL2vBdYVn3RKt57RLD+VyLK22Xdu7fb3J5/v8TD5OqFS5tiz32WqhLrIItO2oPp
         a9tQ==
X-Gm-Message-State: AOAM533G/j6dqJEA6Et69ufRlEyoZ3+Wjpm1iODVP/swc4enfJfZecJj
        HuHrnavgXK65sCe0VIoyqqeptw==
X-Google-Smtp-Source: ABdhPJyyqFVF9qSPl2hYa17TC4CdkjgSqQZsxBXIkOhe4fspEVWa3W9lNHJPqtCuD5pvxOcYogV9Yg==
X-Received: by 2002:a17:90b:ece:: with SMTP id gz14mr13118040pjb.158.1610279650930;
        Sun, 10 Jan 2021 03:54:10 -0800 (PST)
Received: from always-libai.bytedance.net ([61.120.150.71])
        by smtp.gmail.com with ESMTPSA id x1sm15613906pfj.95.2021.01.10.03.54.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Jan 2021 03:54:10 -0800 (PST)
From:   zhenwei pi <pizhenwei@bytedance.com>
To:     arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     pbonzini@redhat.com, linux-kernel@vger.kernel.org,
        pizhenwei@bytedance.com
Subject: [PATCH v5 2/2] misc: pvpanic: introduce events device attribue
Date:   Sun, 10 Jan 2021 19:53:58 +0800
Message-Id: <20210110115358.79100-3-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210110115358.79100-1-pizhenwei@bytedance.com>
References: <20210110115358.79100-1-pizhenwei@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Suggested by Paolo & Greg, add 'events' device attribute that can be
used to limit which capabilities the driver uses.

Finally, the pvpanic guest driver works by the limitation of both
device capability and user setting.

Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
---
 .../ABI/testing/sysfs-bus-pci-devices-pvpanic | 12 ++++++++
 drivers/misc/pvpanic.c                        | 30 ++++++++++++++++++-
 2 files changed, 41 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-pci-devices-pvpanic b/Documentation/ABI/testing/sysfs-bus-pci-devices-pvpanic
index 79b7dc31cd55..1936f7324155 100644
--- a/Documentation/ABI/testing/sysfs-bus-pci-devices-pvpanic
+++ b/Documentation/ABI/testing/sysfs-bus-pci-devices-pvpanic
@@ -10,3 +10,15 @@ Description:
 		Detailed bit definition refers to section <Bit Definition>
 		from pvpanic device specification:
 		https://git.qemu.org/?p=qemu.git;a=blob_plain;f=docs/specs/pvpanic.txt
+
+What:		/sys/devices/pci0000:00/*/QEMU0001:00/events
+Date:		Jan 2021
+Contact:	zhenwei pi <pizhenwei@bytedance.com>
+Description:
+		RW attribute. Set/get which features in-use. This attribute
+		is used to enable/disable feature(s) of pvpanic device.
+		Notice that this value should be a subset of capability.
+
+		Format: %x.
+
+		Also refer to pvpanic device specification.
diff --git a/drivers/misc/pvpanic.c b/drivers/misc/pvpanic.c
index 7e5254e8af1f..a9ac26c7b11f 100644
--- a/drivers/misc/pvpanic.c
+++ b/drivers/misc/pvpanic.c
@@ -20,6 +20,7 @@
 
 static void __iomem *base;
 static unsigned int capability = PVPANIC_PANICKED | PVPANIC_CRASH_LOADED;
+static unsigned int events;
 
 static ssize_t capability_show(struct device *dev,
 			       struct device_attribute *attr, char *buf)
@@ -28,8 +29,34 @@ static ssize_t capability_show(struct device *dev,
 }
 static DEVICE_ATTR_RO(capability);
 
+static ssize_t events_show(struct device *dev,  struct device_attribute *attr, char *buf)
+{
+	return sysfs_emit(buf, "%x", events);
+}
+
+static ssize_t events_store(struct device *dev,  struct device_attribute *attr,
+			    const char *buf, size_t count)
+{
+	unsigned int tmp;
+	int err;
+
+	err = kstrtouint(buf, 16, &tmp);
+	if (err)
+		return err;
+
+	if ((tmp & capability) != tmp)
+		return -EINVAL;
+
+	events = tmp;
+
+	return count;
+
+}
+static DEVICE_ATTR_RW(events);
+
 static struct attribute *pvpanic_dev_attrs[] = {
 	&dev_attr_capability.attr,
+	&dev_attr_events.attr,
 	NULL
 };
 ATTRIBUTE_GROUPS(pvpanic_dev);
@@ -41,7 +68,7 @@ MODULE_LICENSE("GPL");
 static void
 pvpanic_send_event(unsigned int event)
 {
-	if (event & capability)
+	if (event & capability & events)
 		iowrite8(event, base);
 }
 
@@ -79,6 +106,7 @@ static int pvpanic_mmio_probe(struct platform_device *pdev)
 
 	/* initlize capability by RDPT */
 	capability &= ioread8(base);
+	events = capability;
 
 	if (capability)
 		atomic_notifier_chain_register(&panic_notifier_list,
-- 
2.25.1

