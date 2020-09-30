Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8A6927EF58
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 18:37:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731044AbgI3Qhh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 12:37:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725355AbgI3Qhf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 12:37:35 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 176BBC061755
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 09:37:33 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id c2so2031080qkf.10
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 09:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=eclypsium.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=TWpkbDArwjl1NhSgUMBvh/I+P1miVQgCWyPgsMU6MqQ=;
        b=dxTXdI0ieJN4qHlhc4fMXvFyp+ScXy2czhcBKuwbkyBZOyaTnK/qr9mwTsUXDTox0i
         Ccx3Pw/jn6BhB3a7S/JmKqeKFC0WAmqUac4PqkY58M/b58iQ32ZOTXyUA2d14D+1j8bC
         uFm998c1fjVznKTQBM3g7v65HjVwHcw2VwCgTk1fIcap7C7XaUpopVQfCbMSq9vidj9x
         wPoWzDRZUBj9Im4OLJ/u7m0Qcp/LT8TTvZSW8QJaU+I/VC0+azrluYrDyb8Bzykv0Lqy
         SCwG1IKM3OPVv5FuOY/Vl5EoClObbW+3JT51CIwnYbDXn9fpxpDDZ+/qZEDdcdnaTjls
         akdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TWpkbDArwjl1NhSgUMBvh/I+P1miVQgCWyPgsMU6MqQ=;
        b=QtZQcOs6GIOSg43q7Ys5pcOlec80JtKC8ne63tpIw0yDxdrUfBid3Ti4sv9AjuW4lz
         1gJbBJ+XlLsexSdCNf+q0oB/3zYd3AN9iLGvoGihhTcY2vx2W0TvG74OdL5SyhuCz8HC
         S99NyUb4ngj8WmRkGD6Zv5k7KRxrvQE4h0+V5u54ZG7U/hnoWv8X97OftpRzfdFTMwNP
         bU7FYjRGWQitH7D+RJRq9fWbfbZq9yboHvjYOM+V5VmnVMpCjWvPdR8qXCRNmi14T+u7
         qxMK4aR1o0BLrVfLY4HkETomB64xMAtyW66s0Cb2brESuVgxAcqsDCKohpDNdq4f7JkJ
         CQOw==
X-Gm-Message-State: AOAM532C3+QDCmkEX12gv493Az1EfWB0ZDQbiBWRm9VQUIBwpmJx8P7C
        CBqGwxhDrG6TriLg+9Itxw+7fw==
X-Google-Smtp-Source: ABdhPJzvpaSXDFY3+3kGLa+uAu/6sx8zKnXT1yyBxTMvwpZEIIvGD0zCGa665e8V3nphGUM++PcJTg==
X-Received: by 2002:a37:a049:: with SMTP id j70mr1246049qke.139.1601483852060;
        Wed, 30 Sep 2020 09:37:32 -0700 (PDT)
Received: from localhost ([190.190.138.51])
        by smtp.gmail.com with ESMTPSA id 18sm2751966qkd.120.2020.09.30.09.37.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Sep 2020 09:37:31 -0700 (PDT)
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
Subject: [PATCH 1/2] Platform integrity information in sysfs (version 9)
Date:   Wed, 30 Sep 2020 13:37:13 -0300
Message-Id: <20200930163714.12879-2-daniel.gutson@eclypsium.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200930163714.12879-1-daniel.gutson@eclypsium.com>
References: <20200930163714.12879-1-daniel.gutson@eclypsium.com>
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

