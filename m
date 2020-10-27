Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2263129C4E1
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 19:07:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1823633AbgJ0R7G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 13:59:06 -0400
Received: from mga01.intel.com ([192.55.52.88]:39996 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1823217AbgJ0R6R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 13:58:17 -0400
IronPort-SDR: 54UqjU+j7kU6zq9MSVi+6i+rWU/wJ0jVmNIFS0QpjPVvFq0feWZpCxeBv2ih1/DiMF/Ao2cFcV
 B7W+Is637bmA==
X-IronPort-AV: E=McAfee;i="6000,8403,9787"; a="185880830"
X-IronPort-AV: E=Sophos;i="5.77,424,1596524400"; 
   d="scan'208";a="185880830"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2020 10:58:09 -0700
IronPort-SDR: 4RwCFi1I4bCuRWKQaopjNq+p8HT1OJwS2HaOehfCntVLgXuDBMyA649vI2V3JppEXQAZ9GGcgF
 KUHCTOYOkD4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,424,1596524400"; 
   d="scan'208";a="360835247"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 27 Oct 2020 10:58:07 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 131084C7; Tue, 27 Oct 2020 19:58:07 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Peng Hao <peng.hao2@zte.com.cn>, Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v1 4/5] misc: pvpanic: Combine ACPI and platform drivers
Date:   Tue, 27 Oct 2020 19:58:05 +0200
Message-Id: <20201027175806.20305-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201027175806.20305-1-andriy.shevchenko@linux.intel.com>
References: <20201027175806.20305-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is nothing special in the driver that requires
to have special ACPI driver for it. Combine both
into simple platform driver.

Cc: Peng Hao <peng.hao2@zte.com.cn>
Cc: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/misc/pvpanic.c | 130 ++++++-----------------------------------
 1 file changed, 17 insertions(+), 113 deletions(-)

diff --git a/drivers/misc/pvpanic.c b/drivers/misc/pvpanic.c
index e16a5e51006e..103a09ed651d 100644
--- a/drivers/misc/pvpanic.c
+++ b/drivers/misc/pvpanic.c
@@ -8,7 +8,7 @@
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
-#include <linux/acpi.h>
+#include <linux/io.h>
 #include <linux/kernel.h>
 #include <linux/kexec.h>
 #include <linux/module.h>
@@ -49,101 +49,16 @@ static struct notifier_block pvpanic_panic_nb = {
 	.priority = 1, /* let this called before broken drm_fb_helper */
 };
 
-#ifdef CONFIG_ACPI
-static int pvpanic_add(struct acpi_device *device);
-static int pvpanic_remove(struct acpi_device *device);
-
-static const struct acpi_device_id pvpanic_device_ids[] = {
-	{ "QEMU0001", 0 },
-	{ "", 0 }
-};
-MODULE_DEVICE_TABLE(acpi, pvpanic_device_ids);
-
-static struct acpi_driver pvpanic_driver = {
-	.name =		"pvpanic",
-	.class =	"QEMU",
-	.ids =		pvpanic_device_ids,
-	.ops =		{
-				.add =		pvpanic_add,
-				.remove =	pvpanic_remove,
-			},
-	.owner =	THIS_MODULE,
-};
-
-static acpi_status
-pvpanic_walk_resources(struct acpi_resource *res, void *context)
-{
-	struct resource r;
-
-	if (acpi_dev_resource_io(res, &r)) {
-#ifdef CONFIG_HAS_IOPORT_MAP
-		base = ioport_map(r.start, resource_size(&r));
-		return AE_OK;
-#else
-		return AE_ERROR;
-#endif
-	} else if (acpi_dev_resource_memory(res, &r)) {
-		base = ioremap(r.start, resource_size(&r));
-		return AE_OK;
-	}
-
-	return AE_ERROR;
-}
-
-static int pvpanic_add(struct acpi_device *device)
-{
-	int ret;
-
-	ret = acpi_bus_get_status(device);
-	if (ret < 0)
-		return ret;
-
-	if (!device->status.enabled || !device->status.functional)
-		return -ENODEV;
-
-	acpi_walk_resources(device->handle, METHOD_NAME__CRS,
-			    pvpanic_walk_resources, NULL);
-
-	if (!base)
-		return -ENODEV;
-
-	atomic_notifier_chain_register(&panic_notifier_list,
-				       &pvpanic_panic_nb);
-
-	return 0;
-}
-
-static int pvpanic_remove(struct acpi_device *device)
-{
-
-	atomic_notifier_chain_unregister(&panic_notifier_list,
-					 &pvpanic_panic_nb);
-	iounmap(base);
-
-	return 0;
-}
-
-static int pvpanic_register_acpi_driver(void)
-{
-	return acpi_bus_register_driver(&pvpanic_driver);
-}
-
-static void pvpanic_unregister_acpi_driver(void)
-{
-	acpi_bus_unregister_driver(&pvpanic_driver);
-}
-#else
-static int pvpanic_register_acpi_driver(void)
-{
-	return -ENODEV;
-}
-
-static void pvpanic_unregister_acpi_driver(void) {}
-#endif
-
 static int pvpanic_mmio_probe(struct platform_device *pdev)
 {
-	base = devm_platform_ioremap_resource(pdev, 0);
+	struct device *dev = &pdev->dev;
+	struct resource *res;
+
+	res = platform_get_mem_or_io_resource(pdev, 0);
+	if (res && resource_type(res) == IORESOURCE_IO)
+		base = devm_ioport_map(dev, res->start, resource_size(res));
+	else
+		base = devm_ioremap_resource(dev, res);
 	if (IS_ERR(base))
 		return PTR_ERR(base);
 
@@ -167,30 +82,19 @@ static const struct of_device_id pvpanic_mmio_match[] = {
 	{}
 };
 
+static const struct acpi_device_id pvpanic_device_ids[] = {
+	{ "QEMU0001", 0 },
+	{ "", 0 }
+};
+MODULE_DEVICE_TABLE(acpi, pvpanic_device_ids);
+
 static struct platform_driver pvpanic_mmio_driver = {
 	.driver = {
 		.name = "pvpanic-mmio",
 		.of_match_table = pvpanic_mmio_match,
+		.acpi_match_table = pvpanic_device_ids,
 	},
 	.probe = pvpanic_mmio_probe,
 	.remove = pvpanic_mmio_remove,
 };
-
-static int __init pvpanic_mmio_init(void)
-{
-	if (acpi_disabled)
-		return platform_driver_register(&pvpanic_mmio_driver);
-	else
-		return pvpanic_register_acpi_driver();
-}
-
-static void __exit pvpanic_mmio_exit(void)
-{
-	if (acpi_disabled)
-		platform_driver_unregister(&pvpanic_mmio_driver);
-	else
-		pvpanic_unregister_acpi_driver();
-}
-
-module_init(pvpanic_mmio_init);
-module_exit(pvpanic_mmio_exit);
+module_platform_driver(pvpanic_mmio_driver);
-- 
2.28.0

