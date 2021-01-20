Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F9132FC866
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 04:05:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389611AbhATDFH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 22:05:07 -0500
Received: from mga17.intel.com ([192.55.52.151]:3813 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731344AbhATCsq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 21:48:46 -0500
IronPort-SDR: kkhR90n0FHtHAR7BBlTXcalBcLAw5YFQg90jSLa9tRVlejw4B1qzegqvDShbUKIKUixWyPzDCP
 hVl6gwipRxnw==
X-IronPort-AV: E=McAfee;i="6000,8403,9869"; a="158808452"
X-IronPort-AV: E=Sophos;i="5.79,359,1602572400"; 
   d="scan'208";a="158808452"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2021 18:48:05 -0800
IronPort-SDR: lOAppi37a2Ant2Zyd3AdA2GnHBbqwySsUAehzJBk8TfZ9s69bNlWHeEAVgjVBLjg6rsb14RX0F
 +FxGS6imR+Zw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,359,1602572400"; 
   d="scan'208";a="355871053"
Received: from yilunxu-optiplex-7050.sh.intel.com ([10.239.159.141])
  by fmsmga008.fm.intel.com with ESMTP; 19 Jan 2021 18:48:03 -0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, trix@redhat.com, lgoncalv@redhat.com,
        yilun.xu@intel.com, hao.wu@intel.com
Subject: [PATCH v7 1/2] fpga: dfl: add the userspace I/O device support for DFL devices
Date:   Wed, 20 Jan 2021 10:43:25 +0800
Message-Id: <1611110606-10380-2-git-send-email-yilun.xu@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1611110606-10380-1-git-send-email-yilun.xu@intel.com>
References: <1611110606-10380-1-git-send-email-yilun.xu@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch supports the DFL drivers be written in userspace. This is
realized by exposing the userspace I/O device interfaces.

The driver leverages the uio_pdrv_genirq, it adds the uio_pdrv_genirq
platform device with the DFL device's resources, and let the generic UIO
platform device driver provide support to userspace access to kernel
interrupts and memory locations.

The driver now supports the ether group feature. To support a new DFL
feature been directly accessed via UIO, its feature id should be added to
the driver's id_table.

Signed-off-by: Xu Yilun <yilun.xu@intel.com>
Reviewed-by: Tom Rix <trix@redhat.com>
Acked-by: Wu Hao <hao.wu@intel.com>
---
v2: switch to the new matching algorithem. It matches DFL devices which
     could not be handled by other DFL drivers.
    refacor the code about device resources filling.
    fix some comments.
v3: split the dfl.c changes out of this patch.
    some minor fixes
v4: drop the idea of a generic matching algorithem, instead we specify
     each matching device in id_table.
    to make clear that only one irq is supported, the irq handling code
     is refactored.
v5: refactor the irq resource code.
v6: fix the res[] zero initialization issue.
    improve the return code for probe().
v7: use platform_device_register_resndata() for pdev creation.
    remove some unnecessary head file includings.
    some minor fixes.
---
 drivers/fpga/Kconfig        | 10 ++++++
 drivers/fpga/Makefile       |  1 +
 drivers/fpga/dfl-uio-pdev.c | 84 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 95 insertions(+)
 create mode 100644 drivers/fpga/dfl-uio-pdev.c

diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
index 5ff9438..0a21bf2 100644
--- a/drivers/fpga/Kconfig
+++ b/drivers/fpga/Kconfig
@@ -203,6 +203,16 @@ config FPGA_DFL_NIOS_INTEL_PAC_N3000
 	  the card. It also instantiates the SPI master (spi-altera) for
 	  the card's BMC (Board Management Controller).
 
+config FPGA_DFL_UIO_PDEV
+	tristate "FPGA DFL Driver for Userspace I/O platform devices"
+	depends on FPGA_DFL && UIO_PDRV_GENIRQ
+	help
+	  Enable this to allow DFL drivers to be written in userspace. It
+	  adds the uio_pdrv_genirq platform device with the DFL feature's
+	  resources, and lets the generic UIO platform device driver provide
+	  support for userspace access to kernel interrupts and memory
+	  locations.
+
 config FPGA_DFL_PCI
 	tristate "FPGA DFL PCIe Device Driver"
 	depends on PCI && FPGA_DFL
diff --git a/drivers/fpga/Makefile b/drivers/fpga/Makefile
index 18dc9885..8847fe0 100644
--- a/drivers/fpga/Makefile
+++ b/drivers/fpga/Makefile
@@ -45,6 +45,7 @@ dfl-afu-objs := dfl-afu-main.o dfl-afu-region.o dfl-afu-dma-region.o
 dfl-afu-objs += dfl-afu-error.o
 
 obj-$(CONFIG_FPGA_DFL_NIOS_INTEL_PAC_N3000)	+= dfl-n3000-nios.o
+obj-$(CONFIG_FPGA_DFL_UIO_PDEV)		+= dfl-uio-pdev.o
 
 # Drivers for FPGAs which implement DFL
 obj-$(CONFIG_FPGA_DFL_PCI)		+= dfl-pci.o
diff --git a/drivers/fpga/dfl-uio-pdev.c b/drivers/fpga/dfl-uio-pdev.c
new file mode 100644
index 0000000..9572ffd
--- /dev/null
+++ b/drivers/fpga/dfl-uio-pdev.c
@@ -0,0 +1,84 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * DFL driver for Userspace I/O platform devices
+ *
+ * Copyright (C) 2020 Intel Corporation, Inc.
+ */
+#include <linux/dfl.h>
+#include <linux/errno.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/uio_driver.h>
+
+#define DRIVER_NAME "dfl-uio-pdev"
+
+static int dfl_uio_pdev_probe(struct dfl_device *ddev)
+{
+	struct resource res[2] = { { 0 } };
+	struct uio_info uio_pdata = { 0 };
+	struct platform_device *uio_pdev;
+	struct device *dev = &ddev->dev;
+	unsigned int num_res = 1;
+
+	res[0].parent = &ddev->mmio_res;
+	res[0].flags = IORESOURCE_MEM;
+	res[0].start = ddev->mmio_res.start;
+	res[0].end = ddev->mmio_res.end;
+
+	if (ddev->num_irqs) {
+		if (ddev->num_irqs > 1)
+			dev_warn(dev,
+				 "%d irqs for %s, but UIO only supports the first one\n",
+				 ddev->num_irqs, dev_name(dev));
+
+		res[1].flags = IORESOURCE_IRQ;
+		res[1].start = ddev->irqs[0];
+		res[1].end = ddev->irqs[0];
+		num_res++;
+	}
+
+	uio_pdata.name = DRIVER_NAME;
+	uio_pdata.version = "0";
+
+	uio_pdev = platform_device_register_resndata(dev,
+						     "uio_pdrv_genirq",
+						     PLATFORM_DEVID_AUTO,
+						     res, num_res,
+						     &uio_pdata,
+						     sizeof(uio_pdata));
+	if (IS_ERR(uio_pdev))
+		return PTR_ERR(uio_pdev);
+
+	dev_set_drvdata(dev, uio_pdev);
+
+	return 0;
+}
+
+static void dfl_uio_pdev_remove(struct dfl_device *ddev)
+{
+	struct platform_device *uio_pdev = dev_get_drvdata(&ddev->dev);
+
+	platform_device_unregister(uio_pdev);
+}
+
+#define FME_FEATURE_ID_ETH_GROUP	0x10
+
+static const struct dfl_device_id dfl_uio_pdev_ids[] = {
+	{ FME_ID, FME_FEATURE_ID_ETH_GROUP },
+	{ }
+};
+MODULE_DEVICE_TABLE(dfl, dfl_uio_pdev_ids);
+
+static struct dfl_driver dfl_uio_pdev_driver = {
+	.drv	= {
+		.name       = DRIVER_NAME,
+	},
+	.id_table = dfl_uio_pdev_ids,
+	.probe	= dfl_uio_pdev_probe,
+	.remove	= dfl_uio_pdev_remove,
+};
+module_dfl_driver(dfl_uio_pdev_driver);
+
+MODULE_DESCRIPTION("DFL driver for Userspace I/O platform devices");
+MODULE_AUTHOR("Intel Corporation");
+MODULE_LICENSE("GPL v2");
-- 
2.7.4

