Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A41502F0566
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jan 2021 06:38:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726531AbhAJFiO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jan 2021 00:38:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726447AbhAJFiN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jan 2021 00:38:13 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90A5FC0617A2
        for <linux-kernel@vger.kernel.org>; Sat,  9 Jan 2021 21:37:32 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id s15so7789397plr.9
        for <linux-kernel@vger.kernel.org>; Sat, 09 Jan 2021 21:37:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3I/CL8Jla53b7d11LKJ+4S2e8QSsZLZtH4O2WL7MyxQ=;
        b=J8H1r9zb83GPmaYa1HkjTuIcIO1g0aq90jxvx2XAeuLZoE6rc1wF8bhferTQCKKUm/
         fWPGSgGYLy97jDpcpkaXuSKR8rky6RG9cS43vdI+rC1VuWmOE6EnphR9BS5FMOCi/A59
         gr6014A3DFbb8jq/y49xBkwA1bdYFSw9HgLWleZMG3MZ7+xFvlxUtM1eH+qGL64Si8xb
         AP5r7RPE+A6KbX5cp+VDk/RQo83vAMmxGrFW83u9FvWcUnJF8nODlppkZOkXAq1/fe0z
         /bn+HiQp303JtxkmYspysnWYBt4LfgrPT9WYvQXBGuisNs+8Q1brUVIisIb41r1FBdct
         kQdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3I/CL8Jla53b7d11LKJ+4S2e8QSsZLZtH4O2WL7MyxQ=;
        b=DSNPhQrihy0TPKZp1wk/hxQ8faUWzFsUS7ILEP/MrWNqQwYhFFm8utIQugnEAxOS9S
         IWjcFsJSGXfhx5+48EGAlWDw4tfYkYUBSZ3PNMHvWVUXkPNFEvBgtNgXpgIAYsPnFFYx
         frCEvKpT/3I8XBbp1eP99cNTdH22Vovml/199puYmtENlrAK3cEYDqotRjz+Jweo7+uR
         sJXK6+t4u0ylQ/0Kaj0zCotPRhp+BTBBXvkknuEvidk9D1WbFq3p2XRRglP24KRJmYBq
         eKzuir+sJV4jjpJXxNQMpGd2/sXuxNsfDwnK3rUl8mAw53K0EJzFFCaKuFifQtaynCVH
         YEUg==
X-Gm-Message-State: AOAM531zLrGf4/5krPvXfpf2xXH5KPXMw9Wy8i7H9VJDf60Dwzk88LfA
        G7XN51rVgqKPrzaNuJ+3Fmf6OQ==
X-Google-Smtp-Source: ABdhPJz6HBCX2l4Z0qe7iSea5XOLs3zF2OGQOqF7ltEyrFvLjQJwhYpg0dxdsvzopi+HB8sO9kXJPg==
X-Received: by 2002:a17:902:ec03:b029:dc:f27:dd4a with SMTP id l3-20020a170902ec03b02900dc0f27dd4amr11168478pld.9.1610257052116;
        Sat, 09 Jan 2021 21:37:32 -0800 (PST)
Received: from always-libai.bytedance.net ([61.120.150.71])
        by smtp.gmail.com with ESMTPSA id q15sm14474013pgk.11.2021.01.09.21.37.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Jan 2021 21:37:31 -0800 (PST)
From:   zhenwei pi <pizhenwei@bytedance.com>
To:     arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     pbonzini@redhat.com, linux-kernel@vger.kernel.org,
        pizhenwei@bytedance.com
Subject: [PATCH v4 2/2] misc: pvpanic: introduce events device attribue
Date:   Sun, 10 Jan 2021 13:37:19 +0800
Message-Id: <20210110053719.3038348-3-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210110053719.3038348-1-pizhenwei@bytedance.com>
References: <20210110053719.3038348-1-pizhenwei@bytedance.com>
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
 .../ABI/testing/sysfs-bus-pci-devices-pvpanic |  7 +++++
 drivers/misc/pvpanic.c                        | 26 ++++++++++++++++++-
 2 files changed, 32 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-pci-devices-pvpanic b/Documentation/ABI/testing/sysfs-bus-pci-devices-pvpanic
index 57d014a2c339..4750cfa0af2b 100644
--- a/Documentation/ABI/testing/sysfs-bus-pci-devices-pvpanic
+++ b/Documentation/ABI/testing/sysfs-bus-pci-devices-pvpanic
@@ -5,3 +5,10 @@ Description:
 		Read-only attribute. Capabilities of pvpanic device
 		which are supported by QEMU.
 		Format: %s.
+
+What:          /sys/devices/pci0000:00/*/QEMU0001:00/events
+Date:          Jan 2021
+Contact:       zhenwei pi <pizhenwei@bytedance.com>
+Description:
+               RW attribute. Set/get which features in-use.
+               Format: %x.
diff --git a/drivers/misc/pvpanic.c b/drivers/misc/pvpanic.c
index c2f6a9e866b3..07a008e15bd2 100644
--- a/drivers/misc/pvpanic.c
+++ b/drivers/misc/pvpanic.c
@@ -19,8 +19,31 @@
 #include <uapi/misc/pvpanic.h>
 
 static void __iomem *base;
+static unsigned int events = PVPANIC_PANICKED | PVPANIC_CRASH_LOADED;
 static unsigned int capability = PVPANIC_PANICKED | PVPANIC_CRASH_LOADED;
 
+static ssize_t events_show(struct device *dev,  struct device_attribute *attr, char *buf)
+{
+	return sprintf(buf, "%x\n", events);
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
+	events = tmp;
+
+	return count;
+
+}
+static DEVICE_ATTR_RW(events);
+
 static ssize_t capability_show(struct device *dev,
 			       struct device_attribute *attr, char *buf)
 {
@@ -32,6 +55,7 @@ static DEVICE_ATTR_RO(capability);
 
 static struct attribute *pvpanic_dev_attrs[] = {
 	&dev_attr_capability.attr,
+	&dev_attr_events.attr,
 	NULL
 };
 ATTRIBUTE_GROUPS(pvpanic_dev);
@@ -43,7 +67,7 @@ MODULE_LICENSE("GPL");
 static void
 pvpanic_send_event(unsigned int event)
 {
-	if (event & capability)
+	if (event & capability & events)
 		iowrite8(event, base);
 }
 
-- 
2.25.1

