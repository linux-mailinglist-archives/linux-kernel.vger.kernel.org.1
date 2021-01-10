Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A9492F06C1
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jan 2021 12:54:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726475AbhAJLyt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jan 2021 06:54:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726254AbhAJLys (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jan 2021 06:54:48 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A22EC06179F
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jan 2021 03:54:08 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id p18so10726043pgm.11
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jan 2021 03:54:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fjgBsqmgjtoPQ+96jQslDQ54xso/L+b1QOe4bqX9Ct4=;
        b=Ob9k0JRdgiItE5JL2IdfDoc+jHHTU/LzzVqLYDzQI15rsejy+P2ML8b70wPGzbe5y9
         RpFwyEGLDvn+5/eNdL/kC4aHSyGt0PBlyWI97G+G0b2W1KN8s3Jp2yBidgr4pXI8dYPM
         ks2OE6d4viEk6L0r0JJgIkrhS5p2ZUo5s/OYdfPQsvA9qAIuZwVJ8/YgVqyRmNd3hUXD
         rcrF96+KVDbO/ILGL49na350BM6ohHTiSlWcUmpJhn9xkPtWe3au3wkxR4hUirXjafqF
         Nj7Aj7/J9LCLc+VyY+rqTL0pR63TVM0DD//WDSF9jipRpO5rzVYkHr7qxxT0vigscEBy
         9ERA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fjgBsqmgjtoPQ+96jQslDQ54xso/L+b1QOe4bqX9Ct4=;
        b=NBGQqMw3Fjn4QTsCM0tGB0EimsulKsEZv0ZVhstrNb+O+ZJGU+51JlVwUVxOQFZbyr
         /W5zacX9xn5C6bUGy2py60kvqioYOUeYZEsw/r+BVVaAp3ydP/iw7cJeYMyWKAHm90Tl
         2rzghhN/goP0Eri3eVuOumordFZz/qwkN90unFsiKHEzdH0oHdsq8u5JG+qVuDX+lGtX
         mX5A/0my2H/BC/ELdTNfdlFhoEbeWduy4433W6VbHNaPTLh7FigLIEekAb0Ixxgjp9j9
         ony19Swthe6TAMzlvUpKz3fAgX6C6PV3m0NIYR6o6oWt1Z7Tsu7qYXMnYcWbjnBnsfLb
         s4Nw==
X-Gm-Message-State: AOAM533OzseLa//ifdpL+mxD/r97DEwonNqFAXIgC+jgOOdJyueIGdO3
        rObdCCmOfOiE7237Oa16PYEVjQ==
X-Google-Smtp-Source: ABdhPJyjSZ8tojDqnutyMS5TO/aEaXaX9s8MBRaiMPxG2RsBBHYYkDH5jltqzrwCbdH3Q02Wo4EJ9g==
X-Received: by 2002:a62:543:0:b029:19e:5627:1c4d with SMTP id 64-20020a6205430000b029019e56271c4dmr15627068pff.31.1610279647956;
        Sun, 10 Jan 2021 03:54:07 -0800 (PST)
Received: from always-libai.bytedance.net ([61.120.150.71])
        by smtp.gmail.com with ESMTPSA id x1sm15613906pfj.95.2021.01.10.03.54.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Jan 2021 03:54:07 -0800 (PST)
From:   zhenwei pi <pizhenwei@bytedance.com>
To:     arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     pbonzini@redhat.com, linux-kernel@vger.kernel.org,
        pizhenwei@bytedance.com
Subject: [PATCH v5 1/2] misc: pvpanic: introduce device capability
Date:   Sun, 10 Jan 2021 19:53:57 +0800
Message-Id: <20210110115358.79100-2-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210110115358.79100-1-pizhenwei@bytedance.com>
References: <20210110115358.79100-1-pizhenwei@bytedance.com>
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
 .../ABI/testing/sysfs-bus-pci-devices-pvpanic | 12 +++++++
 drivers/misc/pvpanic.c                        | 31 ++++++++++++++++---
 2 files changed, 38 insertions(+), 5 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-pci-devices-pvpanic

diff --git a/Documentation/ABI/testing/sysfs-bus-pci-devices-pvpanic b/Documentation/ABI/testing/sysfs-bus-pci-devices-pvpanic
new file mode 100644
index 000000000000..79b7dc31cd55
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-bus-pci-devices-pvpanic
@@ -0,0 +1,12 @@
+What:		/sys/devices/pci0000:00/*/QEMU0001:00/capability
+Date:		Jan 2021
+Contact:	zhenwei pi <pizhenwei@bytedance.com>
+Description:
+		Read-only attribute. Capabilities of pvpanic device which
+		are supported by QEMU.
+
+		Format: %x.
+
+		Detailed bit definition refers to section <Bit Definition>
+		from pvpanic device specification:
+		https://git.qemu.org/?p=qemu.git;a=blob_plain;f=docs/specs/pvpanic.txt
diff --git a/drivers/misc/pvpanic.c b/drivers/misc/pvpanic.c
index 951b37da5e3c..7e5254e8af1f 100644
--- a/drivers/misc/pvpanic.c
+++ b/drivers/misc/pvpanic.c
@@ -19,6 +19,20 @@
 #include <uapi/misc/pvpanic.h>
 
 static void __iomem *base;
+static unsigned int capability = PVPANIC_PANICKED | PVPANIC_CRASH_LOADED;
+
+static ssize_t capability_show(struct device *dev,
+			       struct device_attribute *attr, char *buf)
+{
+	return sysfs_emit(buf, "%x", capability);
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
@@ -27,7 +41,8 @@ MODULE_LICENSE("GPL");
 static void
 pvpanic_send_event(unsigned int event)
 {
-	iowrite8(event, base);
+	if (event & capability)
+		iowrite8(event, base);
 }
 
 static int
@@ -62,8 +77,12 @@ static int pvpanic_mmio_probe(struct platform_device *pdev)
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
@@ -71,8 +90,9 @@ static int pvpanic_mmio_probe(struct platform_device *pdev)
 static int pvpanic_mmio_remove(struct platform_device *pdev)
 {
 
-	atomic_notifier_chain_unregister(&panic_notifier_list,
-					 &pvpanic_panic_nb);
+	if (capability)
+		atomic_notifier_chain_unregister(&panic_notifier_list,
+						 &pvpanic_panic_nb);
 
 	return 0;
 }
@@ -93,6 +113,7 @@ static struct platform_driver pvpanic_mmio_driver = {
 		.name = "pvpanic-mmio",
 		.of_match_table = pvpanic_mmio_match,
 		.acpi_match_table = pvpanic_device_ids,
+		.dev_groups = pvpanic_dev_groups,
 	},
 	.probe = pvpanic_mmio_probe,
 	.remove = pvpanic_mmio_remove,
-- 
2.25.1

