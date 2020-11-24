Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 891182C2304
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 11:34:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732096AbgKXKdH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 05:33:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731275AbgKXKdG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 05:33:06 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48F13C0617A6
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 02:33:06 -0800 (PST)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1khVd6-0005CI-5Q; Tue, 24 Nov 2020 11:33:00 +0100
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1khVd5-0001Aa-NC; Tue, 24 Nov 2020 11:32:59 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Russell King <linux@armlinux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh@kernel.org>, kernel@pengutronix.de,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] amba: Fix resource leak for drivers without .remove
Date:   Tue, 24 Nov 2020 11:32:40 +0100
Message-Id: <20201124103242.2971199-2-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201124103242.2971199-1-u.kleine-koenig@pengutronix.de>
References: <20201124103242.2971199-1-u.kleine-koenig@pengutronix.de>
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

Consider an amba driver with a .probe but without a .remove callback (e.g.
pl061_gpio_driver). The function amba_probe() is called to bind a device
and so dev_pm_domain_attach() and others are called. As there is no remove
callback amba_remove() isn't called at unbind time however and so calling
dev_pm_domain_detach() is missed and the pm domain keeps active.

To fix this always use the core driver callbacks and handle missing amba
callbacks there. For probe refuse registration as a driver without probe
doesn't make sense.

Fixes: 7cfe249475fd ("ARM: AMBA: Add pclk support to AMBA bus infrastructure")
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/amba/bus.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/amba/bus.c b/drivers/amba/bus.c
index 8658e0533b67..8c4a42df47c6 100644
--- a/drivers/amba/bus.c
+++ b/drivers/amba/bus.c
@@ -300,10 +300,11 @@ static int amba_remove(struct device *dev)
 {
 	struct amba_device *pcdev = to_amba_device(dev);
 	struct amba_driver *drv = to_amba_driver(dev->driver);
-	int ret;
+	int ret = 0;
 
 	pm_runtime_get_sync(dev);
-	ret = drv->remove(pcdev);
+	if (drv->remove)
+		ret = drv->remove(pcdev);
 	pm_runtime_put_noidle(dev);
 
 	/* Undo the runtime PM settings in amba_probe() */
@@ -320,7 +321,9 @@ static int amba_remove(struct device *dev)
 static void amba_shutdown(struct device *dev)
 {
 	struct amba_driver *drv = to_amba_driver(dev->driver);
-	drv->shutdown(to_amba_device(dev));
+
+	if (drv->shutdown)
+		drv->shutdown(to_amba_device(dev));
 }
 
 /**
@@ -333,12 +336,13 @@ static void amba_shutdown(struct device *dev)
  */
 int amba_driver_register(struct amba_driver *drv)
 {
-	drv->drv.bus = &amba_bustype;
+	if (!drv->probe)
+		return -EINVAL;
 
-#define SETFN(fn)	if (drv->fn) drv->drv.fn = amba_##fn
-	SETFN(probe);
-	SETFN(remove);
-	SETFN(shutdown);
+	drv->drv.bus = &amba_bustype;
+	drv->drv.probe = amba_probe;
+	drv->drv.remove = amba_remove;
+	drv->drv.shutdown = amba_shutdown;
 
 	return driver_register(&drv->drv);
 }
-- 
2.29.2

