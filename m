Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC9A1304E83
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 02:18:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404508AbhA0Aco (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 19:32:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392882AbhAZRkK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 12:40:10 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6C10C061574
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 09:39:29 -0800 (PST)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1l4Rg8-00045u-5B; Tue, 26 Jan 2021 17:58:56 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1l4Rg5-0003hn-PE; Tue, 26 Jan 2021 17:58:53 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Russell King <linux@armlinux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH v3 5/5] amba: Make use of bus_type functions
Date:   Tue, 26 Jan 2021 17:58:35 +0100
Message-Id: <20210126165835.687514-6-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210126165835.687514-1-u.kleine-koenig@pengutronix.de>
References: <20210126165835.687514-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of assigning the needed functions for each driver separately do it
only once in amba_bustype. Move the definition of the functions to their
proper place among the other callbacks used there. Note that the bus's
shutdown function might be called for unbound devices, too, so it needs
additional guarding.

This prepares getting rid of these callbacks in struct device_driver.

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
Reviewed-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/amba/bus.c | 158 +++++++++++++++++++++++----------------------
 1 file changed, 81 insertions(+), 77 deletions(-)

diff --git a/drivers/amba/bus.c b/drivers/amba/bus.c
index 48b5d4b4e889..939ca220bf78 100644
--- a/drivers/amba/bus.c
+++ b/drivers/amba/bus.c
@@ -174,6 +174,84 @@ static int amba_uevent(struct device *dev, struct kobj_uevent_env *env)
 	return retval;
 }
 
+/*
+ * These are the device model conversion veneers; they convert the
+ * device model structures to our more specific structures.
+ */
+static int amba_probe(struct device *dev)
+{
+	struct amba_device *pcdev = to_amba_device(dev);
+	struct amba_driver *pcdrv = to_amba_driver(dev->driver);
+	const struct amba_id *id = amba_lookup(pcdrv->id_table, pcdev);
+	int ret;
+
+	do {
+		ret = of_clk_set_defaults(dev->of_node, false);
+		if (ret < 0)
+			break;
+
+		ret = dev_pm_domain_attach(dev, true);
+		if (ret)
+			break;
+
+		ret = amba_get_enable_pclk(pcdev);
+		if (ret) {
+			dev_pm_domain_detach(dev, true);
+			break;
+		}
+
+		pm_runtime_get_noresume(dev);
+		pm_runtime_set_active(dev);
+		pm_runtime_enable(dev);
+
+		ret = pcdrv->probe(pcdev, id);
+		if (ret == 0)
+			break;
+
+		pm_runtime_disable(dev);
+		pm_runtime_set_suspended(dev);
+		pm_runtime_put_noidle(dev);
+
+		amba_put_disable_pclk(pcdev);
+		dev_pm_domain_detach(dev, true);
+	} while (0);
+
+	return ret;
+}
+
+static int amba_remove(struct device *dev)
+{
+	struct amba_device *pcdev = to_amba_device(dev);
+	struct amba_driver *drv = to_amba_driver(dev->driver);
+
+	pm_runtime_get_sync(dev);
+	if (drv->remove)
+		drv->remove(pcdev);
+	pm_runtime_put_noidle(dev);
+
+	/* Undo the runtime PM settings in amba_probe() */
+	pm_runtime_disable(dev);
+	pm_runtime_set_suspended(dev);
+	pm_runtime_put_noidle(dev);
+
+	amba_put_disable_pclk(pcdev);
+	dev_pm_domain_detach(dev, true);
+
+	return 0;
+}
+
+static void amba_shutdown(struct device *dev)
+{
+	struct amba_driver *drv;
+
+	if (!dev->driver)
+		return;
+
+	drv = to_amba_driver(dev->driver);
+	if (drv->shutdown)
+		drv->shutdown(to_amba_device(dev));
+}
+
 #ifdef CONFIG_PM
 /*
  * Hooks to provide runtime PM of the pclk (bus clock).  It is safe to
@@ -239,6 +317,9 @@ struct bus_type amba_bustype = {
 	.dev_groups	= amba_dev_groups,
 	.match		= amba_match,
 	.uevent		= amba_uevent,
+	.probe		= amba_probe,
+	.remove		= amba_remove,
+	.shutdown	= amba_shutdown,
 	.dma_configure	= platform_dma_configure,
 	.pm		= &amba_pm,
 };
@@ -251,80 +332,6 @@ static int __init amba_init(void)
 
 postcore_initcall(amba_init);
 
-/*
- * These are the device model conversion veneers; they convert the
- * device model structures to our more specific structures.
- */
-static int amba_probe(struct device *dev)
-{
-	struct amba_device *pcdev = to_amba_device(dev);
-	struct amba_driver *pcdrv = to_amba_driver(dev->driver);
-	const struct amba_id *id = amba_lookup(pcdrv->id_table, pcdev);
-	int ret;
-
-	do {
-		ret = of_clk_set_defaults(dev->of_node, false);
-		if (ret < 0)
-			break;
-
-		ret = dev_pm_domain_attach(dev, true);
-		if (ret)
-			break;
-
-		ret = amba_get_enable_pclk(pcdev);
-		if (ret) {
-			dev_pm_domain_detach(dev, true);
-			break;
-		}
-
-		pm_runtime_get_noresume(dev);
-		pm_runtime_set_active(dev);
-		pm_runtime_enable(dev);
-
-		ret = pcdrv->probe(pcdev, id);
-		if (ret == 0)
-			break;
-
-		pm_runtime_disable(dev);
-		pm_runtime_set_suspended(dev);
-		pm_runtime_put_noidle(dev);
-
-		amba_put_disable_pclk(pcdev);
-		dev_pm_domain_detach(dev, true);
-	} while (0);
-
-	return ret;
-}
-
-static int amba_remove(struct device *dev)
-{
-	struct amba_device *pcdev = to_amba_device(dev);
-	struct amba_driver *drv = to_amba_driver(dev->driver);
-
-	pm_runtime_get_sync(dev);
-	if (drv->remove)
-		drv->remove(pcdev);
-	pm_runtime_put_noidle(dev);
-
-	/* Undo the runtime PM settings in amba_probe() */
-	pm_runtime_disable(dev);
-	pm_runtime_set_suspended(dev);
-	pm_runtime_put_noidle(dev);
-
-	amba_put_disable_pclk(pcdev);
-	dev_pm_domain_detach(dev, true);
-
-	return 0;
-}
-
-static void amba_shutdown(struct device *dev)
-{
-	struct amba_driver *drv = to_amba_driver(dev->driver);
-
-	if (drv->shutdown)
-		drv->shutdown(to_amba_device(dev));
-}
-
 /**
  *	amba_driver_register - register an AMBA device driver
  *	@drv: amba device driver structure
@@ -339,9 +346,6 @@ int amba_driver_register(struct amba_driver *drv)
 		return -EINVAL;
 
 	drv->drv.bus = &amba_bustype;
-	drv->drv.probe = amba_probe;
-	drv->drv.remove = amba_remove;
-	drv->drv.shutdown = amba_shutdown;
 
 	return driver_register(&drv->drv);
 }
-- 
2.29.2

