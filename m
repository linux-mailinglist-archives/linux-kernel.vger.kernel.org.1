Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39A3227EA4E
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 15:51:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730298AbgI3Nvb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 09:51:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728149AbgI3Nvb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 09:51:31 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E312EC061755
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 06:51:30 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id o21so1206937qtp.2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 06:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=eclypsium.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4I3uX02Igjq18E7APS347132GnIV7mVYlpb51la7dFw=;
        b=dXXQG14tcvVm2kKeVN19uxT1NXyXk372I+SN2SbWmOSH6FNdHz9xSt/amFtaLvQamC
         NDMQs/570CKp7eNV3qS/KB+FgBpcHe2NzZDRQm14UmslFXj6mQTJw9pUI/OTg71SRGdW
         CQkXewCO3VBKh3piQZVuMPq4hcys/HQTTm+K0qsiTxQsjZ5eD4Keyq0ZbGifn2vVIyG7
         Nx+TXyse1zqtke907Q0YU2+Sg0PCJkya0bcHzaaVsjhYRy481a+gpNWY4Yex4cauXGFo
         KSxqXe9WrynCD3aVeWHfN9WOslFxn9ZQzg6MY0q8RdtckEU1PkaT1vJsd/PHqZ7z+ZFT
         Dj4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4I3uX02Igjq18E7APS347132GnIV7mVYlpb51la7dFw=;
        b=kT7ut4YcEJ4CNVeLyROFPrvarPs+OPkKnMIskGafuA5oqCU/0K6/h93879fI6xG+Sc
         FJWx4Kkzix4I4ZYvXkuTnKW4ZuJX1NT7AdsQ8g/MWHA4dg27yzE0iavvcBhig269E1Mp
         XfTc4o0ZD5NGpeQyxwBI7sCa9U7nKi9un0AxKXtwJyoLbt0lmBFDr3A7eGp/aZTWkebJ
         F3Q8MtTPX48rovf9i/7NAb2Cdp9eX6fTm6ShwBnxqUBWRGmPCk+QzGpq3auY4bSmL1sl
         Jdm+N010kLEuE6EKXd44nI04kN7qiLIJTYHsVJtzlep1isIpXsvdBH40xq+7mVOabpL3
         30hA==
X-Gm-Message-State: AOAM530tIUTSS7mx1mHlhXqTGOTjs4MZx4Cy8yv5gfXwZl0GLP0L8jNH
        vmIncnwce0Pw2cHQlaeG31VqvQ==
X-Google-Smtp-Source: ABdhPJxw5FvmBoDmwJKiVyHp2IapB/dsg3Zs+mG5QzBpmJvucHtKYh3JgWwKPcg55xirNwOX0Vjq9w==
X-Received: by 2002:ac8:5194:: with SMTP id c20mr2382493qtn.344.1601473889967;
        Wed, 30 Sep 2020 06:51:29 -0700 (PDT)
Received: from localhost ([190.190.138.51])
        by smtp.gmail.com with ESMTPSA id d10sm2028290qko.32.2020.09.30.06.51.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Sep 2020 06:51:29 -0700 (PDT)
From:   Daniel Gutson <daniel.gutson@eclypsium.com>
To:     Daniel Gutson <daniel.gutson@eclypsium.com>,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Richard Hughes <hughsient@gmail.com>,
        Alex Bazhaniuk <alex@eclypsium.com>,
        linux-mtd@lists.infradead.org
Cc:     Richard Hughes <richard@hughsie.com>
Subject: [PATCH 1/2] Platform integrity information in sysfs (version 9)
Date:   Wed, 30 Sep 2020 10:51:22 -0300
Message-Id: <20200930135122.5566-1-daniel.gutson@eclypsium.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch provides a driver and an API for exporting
information about the platform integrity
firmware configuration in the sysfs filesystem.

The goal is that the attributes are avilable to fwupd.

Signed-off-by: Daniel Gutson <daniel.gutson@eclypsium.com>
Tested-by: Richard Hughes <richard@hughsie.com>
---
 .../ABI/stable/sysfs-class-platform-integrity | 23 ++++++++
 MAINTAINERS                                   |  7 +++
 drivers/misc/Kconfig                          | 11 ++++
 drivers/misc/Makefile                         |  1 +
 drivers/misc/platform-integrity.c             | 56 +++++++++++++++++++
 include/linux/platform-integrity.h            | 19 +++++++
 6 files changed, 117 insertions(+)
 create mode 100644 Documentation/ABI/stable/sysfs-class-platform-integrity
 create mode 100644 drivers/misc/platform-integrity.c
 create mode 100644 include/linux/platform-integrity.h

diff --git a/Documentation/ABI/stable/sysfs-class-platform-integrity b/Documentation/ABI/stable/sysfs-class-platform-integrity
new file mode 100644
index 000000000000..0978079bde50
--- /dev/null
+++ b/Documentation/ABI/stable/sysfs-class-platform-integrity
@@ -0,0 +1,23 @@
+What:		/sys/class/platform-integrity/intel-spi/bioswe
+Date:		September 2020
+KernelVersion:	5.10
+Contact:	Daniel Gutson <daniel.gutson@eclypsium.com>
+Description:	If the system firmware set BIOS Write Enable.
+		0: writes disabled, 1: writes enabled.
+Users:		https://github.com/fwupd/fwupd
+
+What:		/sys/class/platform-integrity/intel-spi/biosle
+Date:		September 2020
+KernelVersion:	5.10
+Contact:	Daniel Gutson <daniel.gutson@eclypsium.com>
+Description:	If the system firmware set BIOS Lock Enable.
+		0: SMM lock disabled, 1: SMM lock enabled.
+Users:		https://github.com/fwupd/fwupd
+
+What:		/sys/class/platform-integrity/intel-spi/smm_bioswp
+Date:		September 2020
+KernelVersion:	5.10
+Contact:	Daniel Gutson <daniel.gutson@eclypsium.com>
+Description:	If the system firmware set SMM BIOS Write Protect.
+		0: writes disabled unless in SMM, 1: writes enabled.
+Users:		https://github.com/fwupd/fwupd
diff --git a/MAINTAINERS b/MAINTAINERS
index d746519253c3..98bd26cd1adc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13774,6 +13774,13 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/iio/chemical/plantower,pms7003.yaml
 F:	drivers/iio/chemical/pms7003.c
 
+PLATFORM INTEGRITY DATA MODULE
+M:	Daniel Gutson <daniel.gutson@eclypsium.com>
+S:	Supported
+F:	Documentation/ABI/sysfs-class-platform-integrity
+F:	drivers/misc/platform-integrity.c
+F:	include/linux/platform-integrity.h
+
 PLDMFW LIBRARY
 M:	Jacob Keller <jacob.e.keller@intel.com>
 S:	Maintained
diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index ce136d685d14..8602049bd0ad 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -456,6 +456,17 @@ config PVPANIC
 	  a paravirtualized device provided by QEMU; it lets a virtual machine
 	  (guest) communicate panic events to the host.
 
+config PLATFORM_INTEGRITY_DATA
+	bool "Platform integrity information in the sysfs"
+	depends on SYSFS
+	help
+	  This kernel module is a helper driver to provide information about
+	  platform integrity settings and configuration.
+	  This module is used by other device drivers -such as the intel-spi-
+	  to publish the information in /sys/class/platform-integrity which is
+	  consumed by software such as fwupd which can verify the platform
+	  has been configured in a secure way.
+
 source "drivers/misc/c2port/Kconfig"
 source "drivers/misc/eeprom/Kconfig"
 source "drivers/misc/cb710/Kconfig"
diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index c7bd01ac6291..97ebb997fc47 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -57,3 +57,4 @@ obj-$(CONFIG_PVPANIC)   	+= pvpanic.o
 obj-$(CONFIG_HABANA_AI)		+= habanalabs/
 obj-$(CONFIG_UACCE)		+= uacce/
 obj-$(CONFIG_XILINX_SDFEC)	+= xilinx_sdfec.o
+obj-$(CONFIG_PLATFORM_INTEGRITY_DATA)	+= platform-integrity.o
diff --git a/drivers/misc/platform-integrity.c b/drivers/misc/platform-integrity.c
new file mode 100644
index 000000000000..e17d27850a3b
--- /dev/null
+++ b/drivers/misc/platform-integrity.c
@@ -0,0 +1,56 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Platform integrity data kernel module
+ *
+ * Copyright (C) 2020 Daniel Gutson <daniel.gutson@eclypsium.com>
+ * Copyright (C) 2020 Eclypsium Inc.
+ */
+#include <linux/sysfs.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/kdev_t.h>
+#include <linux/platform-integrity.h>
+
+static struct class platform_integrity_class = {
+	.name = "platform-integrity",
+	.owner = THIS_MODULE,
+};
+
+struct device *
+create_platform_integrity_device(struct device *parent, const char *name,
+				 const struct attribute_group **groups)
+{
+	return device_create_with_groups(&platform_integrity_class, parent,
+					 MKDEV(0, 0), groups, groups, "%s",
+					 name);
+}
+EXPORT_SYMBOL_GPL(create_platform_integrity_device);
+
+void destroy_platform_integrity_device(struct device *pi_device)
+{
+	device_remove_groups(pi_device,
+		(const struct attribute_group **)dev_get_drvdata(pi_device));
+	device_unregister(pi_device);
+}
+EXPORT_SYMBOL_GPL(destroy_platform_integrity_device);
+
+static int __init platform_integrity_init(void)
+{
+	int status;
+
+	status = class_register(&platform_integrity_class);
+	if (status < 0)
+		return status;
+
+	return 0;
+}
+
+static void __exit platform_integrity_exit(void)
+{
+	class_unregister(&platform_integrity_class);
+}
+
+module_init(platform_integrity_init);
+module_exit(platform_integrity_exit);
+MODULE_LICENSE("GPL v2");
+MODULE_AUTHOR("Daniel Gutson <daniel.gutson@eclypsium.com>");
diff --git a/include/linux/platform-integrity.h b/include/linux/platform-integrity.h
new file mode 100644
index 000000000000..56eb1a1190e8
--- /dev/null
+++ b/include/linux/platform-integrity.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Platform integrity data kernel module
+ *
+ * Copyright (C) 2020 Daniel Gutson <daniel.gutson@eclypsium.com>
+ * Copyright (C) 2020 Eclypsium Inc.
+ */
+#ifndef PLATFORM_INTEGRITY_H
+#define PLATFORM_INTEGRITY_H
+
+#include <linux/device.h>
+
+struct device *
+create_platform_integrity_device(struct device *parent, const char *name,
+				 const struct attribute_group **groups);
+
+extern void destroy_platform_integrity_device(struct device *pi_device);
+
+#endif /* PLATFORM_INTEGRITY_H */
-- 
2.25.1

