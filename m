Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D9C0247FA8
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Aug 2020 09:45:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726611AbgHRHpH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Aug 2020 03:45:07 -0400
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:47638 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726324AbgHRHpG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 03:45:06 -0400
Received: by kvm5.telegraphics.com.au (Postfix, from userid 502)
        id F043629A1F; Tue, 18 Aug 2020 03:45:03 -0400 (EDT)
To:     "David S. Miller" <davem@davemloft.net>
Cc:     "Bartlomiej Zolnierkiewicz" <b.zolnierkie@samsung.com>,
        "Geert Uytterhoeven" <geert@linux-m68k.org>,
        "Joshua Thompson" <funaho@jurai.org>,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        linux-ide@vger.kernel.org
Message-Id: <00ee44fe6ecdce1c783c3cc3b1b9a62b498dcdb2.1597736545.git.fthain@telegraphics.com.au>
From:   Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH] ide/macide: Convert Mac IDE driver to platform driver
Date:   Tue, 18 Aug 2020 17:42:25 +1000
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add platform devices for the Mac IDE controller variants. Convert the
macide module into a platform driver to support two of those variants.
For the third, use a generic "pata_platform" driver instead.
This enables automatic loading of the appropriate module and begins
the process of replacing the driver with libata alternatives.

Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Joshua Thompson <funaho@jurai.org>
References: commit 5ed0794cde593 ("m68k/atari: Convert Falcon IDE drivers to platform drivers")
References: commit 7ad19a99ad431 ("ide: officially deprecated the legacy IDE driver")
Tested-by: Stan Johnson <userm57@yahoo.com>
Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
---
This patch was tested successfully on a Powerbook 190 (MAC_IDE_BABOON)
using both pata_platform and ide_platform drivers.
The next step will be to try using these generic drivers with the other
IDE controller variants (MAC_IDE_QUADRA or MAC_IDE_PB) so that the macide
driver can be entirely replaced with libata drivers.
---
 arch/m68k/mac/config.c | 65 +++++++++++++++++++++++++++++++++++++++
 drivers/ide/macide.c   | 70 ++++++++++++++++++++++++++++--------------
 2 files changed, 112 insertions(+), 23 deletions(-)

diff --git a/arch/m68k/mac/config.c b/arch/m68k/mac/config.c
index 5c9f3a2d65388..9ad3a0d3481b1 100644
--- a/arch/m68k/mac/config.c
+++ b/arch/m68k/mac/config.c
@@ -24,6 +24,7 @@
 #include <linux/init.h>
 #include <linux/vt_kern.h>
 #include <linux/platform_device.h>
+#include <linux/ata_platform.h>
 #include <linux/adb.h>
 #include <linux/cuda.h>
 #include <linux/pmu.h>
@@ -940,6 +941,50 @@ static const struct resource mac_scsi_ccl_rsrc[] __initconst = {
 	},
 };
 
+static const struct resource mac_ide_quadra_rsrc[] __initconst = {
+	{
+		.flags = IORESOURCE_MEM,
+		.start = 0x50F1A000,
+		.end   = 0x50F1A103,
+	}, {
+		.flags = IORESOURCE_IRQ,
+		.start = IRQ_NUBUS_F,
+		.end   = IRQ_NUBUS_F,
+	},
+};
+
+static const struct resource mac_ide_pb_rsrc[] __initconst = {
+	{
+		.flags = IORESOURCE_MEM,
+		.start = 0x50F1A000,
+		.end   = 0x50F1A103,
+	}, {
+		.flags = IORESOURCE_IRQ,
+		.start = IRQ_NUBUS_C,
+		.end   = IRQ_NUBUS_C,
+	},
+};
+
+static const struct resource mac_pata_baboon_rsrc[] __initconst = {
+	{
+		.flags = IORESOURCE_MEM,
+		.start = 0x50F1A000,
+		.end   = 0x50F1A037,
+	}, {
+		.flags = IORESOURCE_MEM,
+		.start = 0x50F1A038,
+		.end   = 0x50F1A03B,
+	}, {
+		.flags = IORESOURCE_IRQ | IORESOURCE_IRQ_SHAREABLE,
+		.start = IRQ_BABOON_1,
+		.end   = IRQ_BABOON_1,
+	},
+};
+
+static const struct pata_platform_info mac_pata_baboon_data __initconst = {
+	.ioport_shift  = 2,
+};
+
 int __init mac_platform_init(void)
 {
 	phys_addr_t swim_base = 0;
@@ -1048,6 +1093,26 @@ int __init mac_platform_init(void)
 		break;
 	}
 
+	/*
+	 * IDE device
+	 */
+
+	switch (macintosh_config->ide_type) {
+	case MAC_IDE_QUADRA:
+		platform_device_register_simple("mac_ide", -1,
+			mac_ide_quadra_rsrc, ARRAY_SIZE(mac_ide_quadra_rsrc));
+		break;
+	case MAC_IDE_PB:
+		platform_device_register_simple("mac_ide", -1,
+			mac_ide_pb_rsrc, ARRAY_SIZE(mac_ide_pb_rsrc));
+		break;
+	case MAC_IDE_BABOON:
+		platform_device_register_resndata(NULL, "pata_platform", -1,
+			mac_pata_baboon_rsrc, ARRAY_SIZE(mac_pata_baboon_rsrc),
+			&mac_pata_baboon_data, sizeof(mac_pata_baboon_data));
+		break;
+	}
+
 	/*
 	 * Ethernet device
 	 */
diff --git a/drivers/ide/macide.c b/drivers/ide/macide.c
index 3c6bb8599303b..e16877ce719e9 100644
--- a/drivers/ide/macide.c
+++ b/drivers/ide/macide.c
@@ -18,10 +18,11 @@
 #include <linux/delay.h>
 #include <linux/ide.h>
 #include <linux/module.h>
+#include <linux/platform_device.h>
 
 #include <asm/macintosh.h>
-#include <asm/macints.h>
-#include <asm/mac_baboon.h>
+
+#define DRV_NAME "mac_ide"
 
 #define IDE_BASE 0x50F1A000	/* Base address of IDE controller */
 
@@ -109,42 +110,65 @@ static const char *mac_ide_name[] =
  * Probe for a Macintosh IDE interface
  */
 
-static int __init macide_init(void)
+static int mac_ide_probe(struct platform_device *pdev)
 {
-	unsigned long base;
-	int irq;
+	struct resource *mem, *irq;
 	struct ide_hw hw, *hws[] = { &hw };
 	struct ide_port_info d = macide_port_info;
+	struct ide_host *host;
+	int rc;
 
 	if (!MACH_IS_MAC)
 		return -ENODEV;
 
-	switch (macintosh_config->ide_type) {
-	case MAC_IDE_QUADRA:
-		base = IDE_BASE;
-		irq = IRQ_NUBUS_F;
-		break;
-	case MAC_IDE_PB:
-		base = IDE_BASE;
-		irq = IRQ_NUBUS_C;
-		break;
-	case MAC_IDE_BABOON:
-		base = BABOON_BASE;
-		d.port_ops = NULL;
-		irq = IRQ_BABOON_1;
-		break;
-	default:
+	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!mem)
+		return -ENODEV;
+
+	irq = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
+	if (!irq)
 		return -ENODEV;
+
+	if (!devm_request_mem_region(&pdev->dev, mem->start,
+				     resource_size(mem), DRV_NAME)) {
+		dev_err(&pdev->dev, "resources busy\n");
+		return -EBUSY;
 	}
 
 	printk(KERN_INFO "ide: Macintosh %s IDE controller\n",
 			 mac_ide_name[macintosh_config->ide_type - 1]);
 
-	macide_setup_ports(&hw, base, irq);
+	macide_setup_ports(&hw, mem->start, irq->start);
+
+	rc = ide_host_add(&d, hws, 1, &host);
+	if (rc)
+		goto release_mem;
+
+	platform_set_drvdata(pdev, host);
+	return 0;
+
+release_mem:
+	release_mem_region(mem->start, resource_size(mem));
+	return rc;
+}
+
+static int mac_ide_remove(struct platform_device *pdev)
+{
+	struct ide_host *host = dev_get_drvdata(&pdev->dev);
 
-	return ide_host_add(&d, hws, 1, NULL);
+	ide_host_remove(host);
+	return 0;
 }
 
-module_init(macide_init);
+static struct platform_driver mac_ide_driver = {
+	.driver = {
+		.name = DRV_NAME,
+	},
+	.probe  = mac_ide_probe,
+	.remove = mac_ide_remove,
+};
+
+module_platform_driver(mac_ide_driver);
 
+MODULE_ALIAS("platform:" DRV_NAME);
 MODULE_LICENSE("GPL");
-- 
2.26.2

