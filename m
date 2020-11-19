Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 361E12B92BF
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 13:50:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727189AbgKSMqV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 07:46:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726853AbgKSMqU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 07:46:20 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFF9EC0613D4
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 04:46:19 -0800 (PST)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1kfjKL-00084o-Qp; Thu, 19 Nov 2020 13:46:17 +0100
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1kfjKK-0003gd-BH; Thu, 19 Nov 2020 13:46:16 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki " <rafael@kernel.org>
Cc:     kernel@pengutronix.de, linux-kernel@vger.kernel.org,
        Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [PATCH 3/3] driver core: platform: use bus_type functions
Date:   Thu, 19 Nov 2020 13:46:11 +0100
Message-Id: <20201119124611.2573057-3-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201119124611.2573057-1-u.kleine-koenig@pengutronix.de>
References: <20201119124611.2573057-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This works towards the goal mentioned in 2006 in commit 594c8281f905
("[PATCH] Add bus_type probe, remove, shutdown methods.").

The functions are moved to where the other bus_type functions are
defined and renamed to match the already established naming scheme.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/base/platform.c | 132 ++++++++++++++++++++--------------------
 1 file changed, 65 insertions(+), 67 deletions(-)

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index b847f5f8f992..8ad06daa2eaa 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -743,70 +743,6 @@ struct platform_device *platform_device_register_full(
 }
 EXPORT_SYMBOL_GPL(platform_device_register_full);
 
-static int platform_probe_fail(struct platform_device *pdev);
-
-static int platform_drv_probe(struct device *_dev)
-{
-	struct platform_driver *drv = to_platform_driver(_dev->driver);
-	struct platform_device *dev = to_platform_device(_dev);
-	int ret;
-
-	/*
-	 * A driver registered using platform_driver_probe() cannot be bound
-	 * again later because the probe function usually lives in __init code
-	 * and so is gone. For these drivers .probe is set to
-	 * platform_probe_fail in __platform_driver_probe(). Don't even
-	 * prepare clocks and PM domains for these to match the traditional
-	 * behaviour.
-	 */
-	if (unlikely(drv->probe == platform_probe_fail))
-		return -ENXIO;
-
-	ret = of_clk_set_defaults(_dev->of_node, false);
-	if (ret < 0)
-		return ret;
-
-	ret = dev_pm_domain_attach(_dev, true);
-	if (ret)
-		goto out;
-
-	if (drv->probe) {
-		ret = drv->probe(dev);
-		if (ret)
-			dev_pm_domain_detach(_dev, true);
-	}
-
-out:
-	if (drv->prevent_deferred_probe && ret == -EPROBE_DEFER) {
-		dev_warn(_dev, "probe deferral not supported\n");
-		ret = -ENXIO;
-	}
-
-	return ret;
-}
-
-static int platform_drv_remove(struct device *_dev)
-{
-	struct platform_driver *drv = to_platform_driver(_dev->driver);
-	struct platform_device *dev = to_platform_device(_dev);
-	int ret = 0;
-
-	if (drv->remove)
-		ret = drv->remove(dev);
-	dev_pm_domain_detach(_dev, true);
-
-	return ret;
-}
-
-static void platform_drv_shutdown(struct device *_dev)
-{
-	struct platform_driver *drv = to_platform_driver(_dev->driver);
-	struct platform_device *dev = to_platform_device(_dev);
-
-	if (drv->shutdown)
-		drv->shutdown(dev);
-}
-
 /**
  * __platform_driver_register - register a driver for platform-level devices
  * @drv: platform driver structure
@@ -817,9 +753,6 @@ int __platform_driver_register(struct platform_driver *drv,
 {
 	drv->driver.owner = owner;
 	drv->driver.bus = &platform_bus_type;
-	drv->driver.probe = platform_drv_probe;
-	drv->driver.remove = platform_drv_remove;
-	drv->driver.shutdown = platform_drv_shutdown;
 
 	return driver_register(&drv->driver);
 }
@@ -1349,6 +1282,68 @@ static int platform_uevent(struct device *dev, struct kobj_uevent_env *env)
 	return 0;
 }
 
+static int platform_probe(struct device *_dev)
+{
+	struct platform_driver *drv = to_platform_driver(_dev->driver);
+	struct platform_device *dev = to_platform_device(_dev);
+	int ret;
+
+	/*
+	 * A driver registered using platform_driver_probe() cannot be bound
+	 * again later because the probe function usually lives in __init code
+	 * and so is gone. For these drivers .probe is set to
+	 * platform_probe_fail in __platform_driver_probe(). Don't even prepare
+	 * clocks and PM domains for these to match the traditional behaviour.
+	 */
+	if (unlikely(drv->probe == platform_probe_fail))
+		return -ENXIO;
+
+	ret = of_clk_set_defaults(_dev->of_node, false);
+	if (ret < 0)
+		return ret;
+
+	ret = dev_pm_domain_attach(_dev, true);
+	if (ret)
+		goto out;
+
+	if (drv->probe) {
+		ret = drv->probe(dev);
+		if (ret)
+			dev_pm_domain_detach(_dev, true);
+	}
+
+out:
+	if (drv->prevent_deferred_probe && ret == -EPROBE_DEFER) {
+		dev_warn(_dev, "probe deferral not supported\n");
+		ret = -ENXIO;
+	}
+
+	return ret;
+}
+
+static int platform_remove(struct device *_dev)
+{
+	struct platform_driver *drv = to_platform_driver(_dev->driver);
+	struct platform_device *dev = to_platform_device(_dev);
+	int ret = 0;
+
+	if (drv->remove)
+		ret = drv->remove(dev);
+	dev_pm_domain_detach(_dev, true);
+
+	return ret;
+}
+
+static void platform_shutdown(struct device *_dev)
+{
+	struct platform_driver *drv = to_platform_driver(_dev->driver);
+	struct platform_device *dev = to_platform_device(_dev);
+
+	if (drv->shutdown)
+		drv->shutdown(dev);
+}
+
+
 int platform_dma_configure(struct device *dev)
 {
 	enum dev_dma_attr attr;
@@ -1375,6 +1370,9 @@ struct bus_type platform_bus_type = {
 	.dev_groups	= platform_dev_groups,
 	.match		= platform_match,
 	.uevent		= platform_uevent,
+	.probe		= platform_probe,
+	.remove		= platform_remove,
+	.shutdown	= platform_shutdown,
 	.dma_configure	= platform_dma_configure,
 	.pm		= &platform_dev_pm_ops,
 };
-- 
2.28.0

