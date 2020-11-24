Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 298472C2305
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 11:34:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732103AbgKXKdI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 05:33:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731247AbgKXKdG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 05:33:06 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47966C0613D6
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 02:33:06 -0800 (PST)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1khVd6-0005CH-5Q; Tue, 24 Nov 2020 11:33:00 +0100
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1khVd5-0001AX-Hi; Tue, 24 Nov 2020 11:32:59 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Russell King <linux@armlinux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh@kernel.org>, kernel@pengutronix.de,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] amba: reorder functions
Date:   Tue, 24 Nov 2020 11:32:39 +0100
Message-Id: <20201124103242.2971199-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.29.2
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

Put helpers (here: amba_get_enable_pclk and amba_put_disable_pclk) at
the top of the file and then define callbacks directly before the
structs they are used in; in the same order.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/amba/bus.c | 77 +++++++++++++++++++++++-----------------------
 1 file changed, 39 insertions(+), 38 deletions(-)

diff --git a/drivers/amba/bus.c b/drivers/amba/bus.c
index ecc304149067..8658e0533b67 100644
--- a/drivers/amba/bus.c
+++ b/drivers/amba/bus.c
@@ -56,31 +56,28 @@ amba_lookup(const struct amba_id *table, struct amba_device *dev)
 	return NULL;
 }
 
-static int amba_match(struct device *dev, struct device_driver *drv)
+static int amba_get_enable_pclk(struct amba_device *pcdev)
 {
-	struct amba_device *pcdev = to_amba_device(dev);
-	struct amba_driver *pcdrv = to_amba_driver(drv);
+	int ret;
 
-	/* When driver_override is set, only bind to the matching driver */
-	if (pcdev->driver_override)
-		return !strcmp(pcdev->driver_override, drv->name);
+	pcdev->pclk = clk_get(&pcdev->dev, "apb_pclk");
+	if (IS_ERR(pcdev->pclk))
+		return PTR_ERR(pcdev->pclk);
 
-	return amba_lookup(pcdrv->id_table, pcdev) != NULL;
+	ret = clk_prepare_enable(pcdev->pclk);
+	if (ret)
+		clk_put(pcdev->pclk);
+
+	return ret;
 }
 
-static int amba_uevent(struct device *dev, struct kobj_uevent_env *env)
+static void amba_put_disable_pclk(struct amba_device *pcdev)
 {
-	struct amba_device *pcdev = to_amba_device(dev);
-	int retval = 0;
-
-	retval = add_uevent_var(env, "AMBA_ID=%08x", pcdev->periphid);
-	if (retval)
-		return retval;
-
-	retval = add_uevent_var(env, "MODALIAS=amba:d%08X", pcdev->periphid);
-	return retval;
+	clk_disable_unprepare(pcdev->pclk);
+	clk_put(pcdev->pclk);
 }
 
+
 static ssize_t driver_override_show(struct device *_dev,
 				    struct device_attribute *attr, char *buf)
 {
@@ -152,6 +149,31 @@ static struct attribute *amba_dev_attrs[] = {
 };
 ATTRIBUTE_GROUPS(amba_dev);
 
+static int amba_match(struct device *dev, struct device_driver *drv)
+{
+	struct amba_device *pcdev = to_amba_device(dev);
+	struct amba_driver *pcdrv = to_amba_driver(drv);
+
+	/* When driver_override is set, only bind to the matching driver */
+	if (pcdev->driver_override)
+		return !strcmp(pcdev->driver_override, drv->name);
+
+	return amba_lookup(pcdrv->id_table, pcdev) != NULL;
+}
+
+static int amba_uevent(struct device *dev, struct kobj_uevent_env *env)
+{
+	struct amba_device *pcdev = to_amba_device(dev);
+	int retval = 0;
+
+	retval = add_uevent_var(env, "AMBA_ID=%08x", pcdev->periphid);
+	if (retval)
+		return retval;
+
+	retval = add_uevent_var(env, "MODALIAS=amba:d%08X", pcdev->periphid);
+	return retval;
+}
+
 #ifdef CONFIG_PM
 /*
  * Hooks to provide runtime PM of the pclk (bus clock).  It is safe to
@@ -229,27 +251,6 @@ static int __init amba_init(void)
 
 postcore_initcall(amba_init);
 
-static int amba_get_enable_pclk(struct amba_device *pcdev)
-{
-	int ret;
-
-	pcdev->pclk = clk_get(&pcdev->dev, "apb_pclk");
-	if (IS_ERR(pcdev->pclk))
-		return PTR_ERR(pcdev->pclk);
-
-	ret = clk_prepare_enable(pcdev->pclk);
-	if (ret)
-		clk_put(pcdev->pclk);
-
-	return ret;
-}
-
-static void amba_put_disable_pclk(struct amba_device *pcdev)
-{
-	clk_disable_unprepare(pcdev->pclk);
-	clk_put(pcdev->pclk);
-}
-
 /*
  * These are the device model conversion veneers; they convert the
  * device model structures to our more specific structures.

base-commit: 95065cb54210eba86bed10cb2118041524d54573
-- 
2.29.2

