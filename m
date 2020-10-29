Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A18929EBD3
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 13:26:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726518AbgJ2M0B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 08:26:01 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:59978 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725767AbgJ2MZz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 08:25:55 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09TCPUtT142929;
        Thu, 29 Oct 2020 12:25:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=Z0KWHqoWmX1vJHp2FI30UdIxdknB4SgQP2ydxYq2TFk=;
 b=zvSSCmLocxWbL/+e/E7tPEhiCB4a4fH9UhNszKAWIlSE70SWy0rdBFuGerxIwuf33WhE
 UpiCSGcAosGoAbjCcvAKZi+II/lQdqx+8bCLN3ejID0Qh5EXiPJP2BtpKbk6/uWuHGFY
 GIAEHuo+eDBOsc2IE4jpDEltQTuGgejSU5fbBf8lsEekQyMsoI0oSiFYqIB/3vY00MDz
 9Ag7BnhOjFi7l/n47GAKYhmlrvEiBoJlE42KD0pDHHB9Iuj0sBWerqSxqrU2pVlWBnTo
 qqABJghU6Boa7rZHxbgFED2ORYq1zXunIu0rCnOfomijl502zSwP5oAV2zxzDfZiTWZ9 DQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2130.oracle.com with ESMTP id 34c9sb4n5s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 29 Oct 2020 12:25:52 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09TCAXkA063198;
        Thu, 29 Oct 2020 12:25:52 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 34cwupqgnk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Oct 2020 12:25:52 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 09TCPoS3011476;
        Thu, 29 Oct 2020 12:25:51 GMT
Received: from mihai.localdomain (/10.153.73.25)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 29 Oct 2020 05:25:49 -0700
From:   Mihai Carabas <mihai.carabas@oracle.com>
To:     linux-kernel@vger.kernel.org
Cc:     Peng Hao <peng.hao2@zte.com.cn>,
        Mihai Carabas <mihai.carabas@oracle.com>
Subject: [PATCH 2/4] misc/pvpanic: Add pvpanic driver framework
Date:   Thu, 29 Oct 2020 13:43:05 +0200
Message-Id: <1603971787-16784-3-git-send-email-mihai.carabas@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1603971787-16784-1-git-send-email-mihai.carabas@oracle.com>
References: <1603971787-16784-1-git-send-email-mihai.carabas@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9788 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 bulkscore=0
 spamscore=0 adultscore=0 malwarescore=0 mlxlogscore=999 suspectscore=2
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010290091
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9788 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 malwarescore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 spamscore=0 phishscore=0 clxscore=1011 suspectscore=2
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010290092
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Hao <peng.hao2@zte.com.cn>

Add pvpanic driver framework and split the original pvpanic acpi/of
driver as the two separate files and modify code to adapt the framework.

Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
Signed-off-by: Mihai Carabas <mihai.carabas@oracle.com>
---
 drivers/misc/pvpanic/Kconfig        |  19 ++++
 drivers/misc/pvpanic/Makefile       |   2 +
 drivers/misc/pvpanic/pvpanic-acpi.c |  77 ++++++++++++++++
 drivers/misc/pvpanic/pvpanic-of.c   |  53 +++++++++++
 drivers/misc/pvpanic/pvpanic.c      | 177 ++++++++++++------------------------
 drivers/misc/pvpanic/pvpanic.h      |  15 +++
 6 files changed, 224 insertions(+), 119 deletions(-)
 create mode 100644 drivers/misc/pvpanic/pvpanic-acpi.c
 create mode 100644 drivers/misc/pvpanic/pvpanic-of.c
 create mode 100644 drivers/misc/pvpanic/pvpanic.h

diff --git a/drivers/misc/pvpanic/Kconfig b/drivers/misc/pvpanic/Kconfig
index 3e612c6..0c0c0b2 100644
--- a/drivers/misc/pvpanic/Kconfig
+++ b/drivers/misc/pvpanic/Kconfig
@@ -5,3 +5,22 @@ config PVPANIC
 	  This driver provides support for the pvpanic device.  pvpanic is
 	  a paravirtualized device provided by QEMU; it lets a virtual machine
 	  (guest) communicate panic events to the host.
+
+if PVPANIC
+
+config PVPANIC_ACPI
+	tristate "pvpanic acpi driver"
+	depends on ACPI
+	default PVPANIC
+	help
+	  This driver is one specific driver for pvpanic driver framework.
+	  It provides an acpi device as pvpanic device.
+
+config PVPANIC_OF
+	tristate "pvpanic mmio driver"
+	depends on OF
+	help
+	  This driver is one specific driver for pvpanic driver framework.
+	  It provides a mmio device as pvpanic device.
+
+endif
diff --git a/drivers/misc/pvpanic/Makefile b/drivers/misc/pvpanic/Makefile
index b8e6dc5..ffd11b1 100644
--- a/drivers/misc/pvpanic/Makefile
+++ b/drivers/misc/pvpanic/Makefile
@@ -3,3 +3,5 @@
 # Copyright (c) 2018 ZTE Ltd.
 
 obj-$(CONFIG_PVPANIC)            += pvpanic.o
+obj-$(CONFIG_PVPANIC_ACPI)       += pvpanic-acpi.o
+obj-$(CONFIG_PVPANIC_OF)         += pvpanic-of.o
diff --git a/drivers/misc/pvpanic/pvpanic-acpi.c b/drivers/misc/pvpanic/pvpanic-acpi.c
new file mode 100644
index 00000000..8d10924
--- /dev/null
+++ b/drivers/misc/pvpanic/pvpanic-acpi.c
@@ -0,0 +1,77 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ *  pvpanic acpi driver.
+ *
+ *  Copyright (C) 2019 ZTE Ltd.
+ *  Author: Peng Hao
+ */
+#include <linux/acpi.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/types.h>
+#include "pvpanic.h"
+
+static int pvpanic_add(struct acpi_device *device);
+static int pvpanic_remove(struct acpi_device *device);
+
+static const struct acpi_device_id pvpanic_device_ids[] = {
+	{ "QEMU0001", 0 },
+	{ "", 0 }
+};
+MODULE_DEVICE_TABLE(acpi, pvpanic_device_ids);
+
+static struct acpi_driver pvpanic_driver = {
+	.name =         "pvpanic",
+	.class =        "QEMU",
+	.ids =          pvpanic_device_ids,
+	.ops =          {
+				.add =          pvpanic_add,
+				.remove =       pvpanic_remove,
+			},
+	.owner =        THIS_MODULE,
+};
+
+static acpi_status
+pvpanic_walk_resources(struct acpi_resource *res, void *context)
+{
+	struct resource r;
+	int ret = 0;
+	struct device *dev = context;
+
+	memset(&r, 0, sizeof(r));
+	if (acpi_dev_resource_io(res, &r) || acpi_dev_resource_memory(res, &r))
+		ret = pvpanic_add_device(dev, &r);
+
+	if (!ret)
+		return AE_OK;
+
+	return AE_ERROR;
+}
+static int pvpanic_add(struct acpi_device *device)
+{
+	int ret;
+	acpi_status status;
+
+	ret = acpi_bus_get_status(device);
+	if (ret < 0)
+		return ret;
+
+	if (!device->status.enabled || !device->status.functional)
+		return -ENODEV;
+
+	status = acpi_walk_resources(device->handle, METHOD_NAME__CRS,
+				     pvpanic_walk_resources, &device->dev);
+
+	if (ACPI_FAILURE(status))
+		return -ENODEV;
+
+	return 0;
+}
+
+static int pvpanic_remove(struct acpi_device *device)
+{
+	pvpanic_remove_device();
+	return 0;
+}
+
+module_acpi_driver(pvpanic_driver);
diff --git a/drivers/misc/pvpanic/pvpanic-of.c b/drivers/misc/pvpanic/pvpanic-of.c
new file mode 100644
index 00000000..73ca5f3
--- /dev/null
+++ b/drivers/misc/pvpanic/pvpanic-of.c
@@ -0,0 +1,53 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ *  pvpanic of driver.
+ *
+ *  Copyright (C) 2019 ZTE Ltd.
+ *  Author: Peng Hao <peng.hao2@zte.com.cn>
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/platform_device.h>
+#include <linux/types.h>
+#include "pvpanic.h"
+
+static int pvpanic_mmio_probe(struct platform_device *pdev)
+{
+	struct resource *res;
+	int ret;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res)
+		return -EINVAL;
+
+	ret = pvpanic_add_device(&pdev->dev, res);
+	if (ret)
+		return -ENODEV;
+
+	return 0;
+}
+
+static int pvpanic_mmio_remove(struct platform_device *pdev)
+{
+	pvpanic_remove_device();
+	return 0;
+}
+
+static const struct of_device_id pvpanic_mmio_match[] = {
+	{ .compatible = "qemu,pvpanic-mmio", },
+	{}
+};
+
+static struct platform_driver pvpanic_mmio_driver = {
+	.driver = {
+		.name = "pvpanic-mmio",
+		.of_match_table = pvpanic_mmio_match,
+	},
+	.probe = pvpanic_mmio_probe,
+	.remove = pvpanic_mmio_remove,
+};
+
+module_platform_driver(pvpanic_mmio_driver);
diff --git a/drivers/misc/pvpanic/pvpanic.c b/drivers/misc/pvpanic/pvpanic.c
index e16a5e5..4c831f5 100644
--- a/drivers/misc/pvpanic/pvpanic.c
+++ b/drivers/misc/pvpanic/pvpanic.c
@@ -8,17 +8,19 @@
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
-#include <linux/acpi.h>
+#include <linux/io.h>
 #include <linux/kernel.h>
 #include <linux/kexec.h>
 #include <linux/module.h>
-#include <linux/of.h>
-#include <linux/of_address.h>
 #include <linux/platform_device.h>
 #include <linux/types.h>
 #include <uapi/misc/pvpanic.h>
 
-static void __iomem *base;
+static struct {
+	struct platform_device *pdev;
+	void __iomem *base;
+	bool is_ioport;
+} pvpanic_data;
 
 MODULE_AUTHOR("Hu Tao <hutao@cn.fujitsu.com>");
 MODULE_DESCRIPTION("pvpanic device driver");
@@ -27,7 +29,7 @@
 static void
 pvpanic_send_event(unsigned int event)
 {
-	iowrite8(event, base);
+	iowrite8(event, pvpanic_data.base);
 }
 
 static int
@@ -49,148 +51,85 @@
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
+int pvpanic_add_device(struct device *dev, struct resource *res)
 {
+	struct platform_device *pdev;
 	int ret;
 
-	ret = acpi_bus_get_status(device);
-	if (ret < 0)
-		return ret;
+	pdev = platform_device_alloc("pvpanic", -1);
+	if (!pdev)
+		return -ENOMEM;
 
-	if (!device->status.enabled || !device->status.functional)
-		return -ENODEV;
+	pdev->dev.parent = dev;
 
-	acpi_walk_resources(device->handle, METHOD_NAME__CRS,
-			    pvpanic_walk_resources, NULL);
+	ret = platform_device_add_resources(pdev, res, 1);
+	if (ret)
+		goto err;
 
-	if (!base)
-		return -ENODEV;
-
-	atomic_notifier_chain_register(&panic_notifier_list,
-				       &pvpanic_panic_nb);
+	ret = platform_device_add(pdev);
+	if (ret)
+		goto err;
+	pvpanic_data.pdev = pdev;
 
 	return 0;
+err:
+	platform_device_put(pdev);
+	return ret;
 }
+EXPORT_SYMBOL_GPL(pvpanic_add_device);
 
-static int pvpanic_remove(struct acpi_device *device)
+void pvpanic_remove_device(void)
 {
-
-	atomic_notifier_chain_unregister(&panic_notifier_list,
-					 &pvpanic_panic_nb);
-	iounmap(base);
-
-	return 0;
+	platform_device_unregister(pvpanic_data.pdev);
+	pvpanic_data.pdev = NULL;
 }
+EXPORT_SYMBOL_GPL(pvpanic_remove_device);
 
-static int pvpanic_register_acpi_driver(void)
+static int pvpanic_platform_probe(struct platform_device *pdev)
 {
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
-static int pvpanic_mmio_probe(struct platform_device *pdev)
-{
-	base = devm_platform_ioremap_resource(pdev, 0);
-	if (IS_ERR(base))
-		return PTR_ERR(base);
+	struct device *dev = &pdev->dev;
+	struct resource *res;
+	void __iomem *base;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (res) {
+		base = devm_ioremap_resource(dev, res);
+		if (IS_ERR(base))
+			return -ENODEV;
+	} else {
+		res = platform_get_resource(pdev, IORESOURCE_IO, 0);
+		if (!res)
+			return -ENODEV;
+
+		base = ioport_map(res->start, resource_size(res));
+		if (!base)
+			return -ENODEV;
+		pvpanic_data.is_ioport = true;
+	}
 
+	pvpanic_data.base = base;
 	atomic_notifier_chain_register(&panic_notifier_list,
 				       &pvpanic_panic_nb);
 
 	return 0;
 }
 
-static int pvpanic_mmio_remove(struct platform_device *pdev)
+static int pvpanic_platform_remove(struct platform_device *pdev)
 {
-
 	atomic_notifier_chain_unregister(&panic_notifier_list,
 					 &pvpanic_panic_nb);
+	if (pvpanic_data.is_ioport)
+		iounmap(pvpanic_data.base);
 
 	return 0;
 }
 
-static const struct of_device_id pvpanic_mmio_match[] = {
-	{ .compatible = "qemu,pvpanic-mmio", },
-	{}
-};
-
-static struct platform_driver pvpanic_mmio_driver = {
+static struct platform_driver pvpanic_driver = {
+	.probe = pvpanic_platform_probe,
+	.remove = pvpanic_platform_remove,
 	.driver = {
-		.name = "pvpanic-mmio",
-		.of_match_table = pvpanic_mmio_match,
-	},
-	.probe = pvpanic_mmio_probe,
-	.remove = pvpanic_mmio_remove,
+		.name = "pvpanic",
+	}
 };
 
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
+module_platform_driver(pvpanic_driver);
diff --git a/drivers/misc/pvpanic/pvpanic.h b/drivers/misc/pvpanic/pvpanic.h
new file mode 100644
index 00000000..5823d72
--- /dev/null
+++ b/drivers/misc/pvpanic/pvpanic.h
@@ -0,0 +1,15 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/* pvpanic driver framework header file
+ *
+ * Copyright (C) 2019 ZTE Ltd.
+ *
+ * Author: Peng Hao <peng.hao2@zte.com.cn>
+ */
+
+#ifndef __DRIVERS_MISC_PVPANIC_H
+#define __DRIVERS_MISC_PVPANIC_H
+
+extern int pvpanic_add_device(struct device *dev, struct resource *res);
+extern void pvpanic_remove_device(void);
+
+#endif
-- 
1.8.3.1

