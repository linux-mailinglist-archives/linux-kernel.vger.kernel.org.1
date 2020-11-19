Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2BBF2B92C0
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 13:50:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727166AbgKSMqV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 07:46:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726712AbgKSMqU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 07:46:20 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1E98C0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 04:46:19 -0800 (PST)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1kfjKL-00084n-Qp; Thu, 19 Nov 2020 13:46:17 +0100
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1kfjKK-0003ga-4g; Thu, 19 Nov 2020 13:46:16 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki " <rafael@kernel.org>
Cc:     kernel@pengutronix.de, linux-kernel@vger.kernel.org,
        Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [PATCH 2/3] driver core: platform: change logic implementing platform_driver_probe
Date:   Thu, 19 Nov 2020 13:46:10 +0100
Message-Id: <20201119124611.2573057-2-u.kleine-koenig@pengutronix.de>
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

Instead of overwriting the core driver's probe function handle probing
devices for drivers loaded by platform_driver_probe() in the platform
driver probe function.

The intended goal is to not have to change the probe function to
simplify converting the platform bus to use bus functions.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/base/platform.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index b36ab5831cb6..b847f5f8f992 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -743,12 +743,25 @@ struct platform_device *platform_device_register_full(
 }
 EXPORT_SYMBOL_GPL(platform_device_register_full);
 
+static int platform_probe_fail(struct platform_device *pdev);
+
 static int platform_drv_probe(struct device *_dev)
 {
 	struct platform_driver *drv = to_platform_driver(_dev->driver);
 	struct platform_device *dev = to_platform_device(_dev);
 	int ret;
 
+	/*
+	 * A driver registered using platform_driver_probe() cannot be bound
+	 * again later because the probe function usually lives in __init code
+	 * and so is gone. For these drivers .probe is set to
+	 * platform_probe_fail in __platform_driver_probe(). Don't even
+	 * prepare clocks and PM domains for these to match the traditional
+	 * behaviour.
+	 */
+	if (unlikely(drv->probe == platform_probe_fail))
+		return -ENXIO;
+
 	ret = of_clk_set_defaults(_dev->of_node, false);
 	if (ret < 0)
 		return ret;
@@ -822,7 +835,7 @@ void platform_driver_unregister(struct platform_driver *drv)
 }
 EXPORT_SYMBOL_GPL(platform_driver_unregister);
 
-static int platform_drv_probe_fail(struct device *_dev)
+static int platform_probe_fail(struct platform_device *pdev)
 {
 	return -ENXIO;
 }
@@ -887,10 +900,9 @@ int __init_or_module __platform_driver_probe(struct platform_driver *drv,
 	 * new devices fail.
 	 */
 	spin_lock(&drv->driver.bus->p->klist_drivers.k_lock);
-	drv->probe = NULL;
+	drv->probe = platform_probe_fail;
 	if (code == 0 && list_empty(&drv->driver.p->klist_devices.k_list))
 		retval = -ENODEV;
-	drv->driver.probe = platform_drv_probe_fail;
 	spin_unlock(&drv->driver.bus->p->klist_drivers.k_lock);
 
 	if (code != retval)
-- 
2.28.0

