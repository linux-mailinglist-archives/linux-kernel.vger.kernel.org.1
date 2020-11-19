Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 749E52B9397
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 14:23:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726974AbgKSNXZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 08:23:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726105AbgKSNXY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 08:23:24 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA1CFC0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 05:23:24 -0800 (PST)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1kfjuE-0004Ho-PP; Thu, 19 Nov 2020 14:23:22 +0100
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1kfjuE-0005Ix-5U; Thu, 19 Nov 2020 14:23:22 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thorsten Scherer <t.scherer@eckelmann.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Pengutronix Kernel Team <kernel@pengutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] siox: Use bus_type functions for probe, remote and shutdown
Date:   Thu, 19 Nov 2020 14:23:10 +0100
Message-Id: <20201119132311.2604232-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.28.0
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

The eventual goal is to get rid of the callbacks in struct
device_driver.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/siox/siox-core.c | 39 +++++++++++++++++++++------------------
 1 file changed, 21 insertions(+), 18 deletions(-)

diff --git a/drivers/siox/siox-core.c b/drivers/siox/siox-core.c
index f8c08fb9891d..7b3a2b63304b 100644
--- a/drivers/siox/siox-core.c
+++ b/drivers/siox/siox-core.c
@@ -512,41 +512,49 @@ static int siox_match(struct device *dev, struct device_driver *drv)
 	return 1;
 }
 
-static struct bus_type siox_bus_type = {
-	.name = "siox",
-	.match = siox_match,
-};
-
-static int siox_driver_probe(struct device *dev)
+static int siox_probe(struct device *dev)
 {
 	struct siox_driver *sdriver = to_siox_driver(dev->driver);
 	struct siox_device *sdevice = to_siox_device(dev);
-	int ret;
+	int ret = 0;
+
+	if (sdriver->probe)
+		ret = sdriver->probe(sdevice);
 
-	ret = sdriver->probe(sdevice);
 	return ret;
 }
 
-static int siox_driver_remove(struct device *dev)
+static int siox_remove(struct device *dev)
 {
 	struct siox_driver *sdriver =
 		container_of(dev->driver, struct siox_driver, driver);
 	struct siox_device *sdevice = to_siox_device(dev);
-	int ret;
+	int ret = 0;
+
+	if (sdriver->remove)
+		ret = sdriver->remove(sdevice);
 
-	ret = sdriver->remove(sdevice);
 	return ret;
 }
 
-static void siox_driver_shutdown(struct device *dev)
+static void siox_shutdown(struct device *dev)
 {
 	struct siox_driver *sdriver =
 		container_of(dev->driver, struct siox_driver, driver);
 	struct siox_device *sdevice = to_siox_device(dev);
 
-	sdriver->shutdown(sdevice);
+	if (sdriver->shutdown)
+		sdriver->shutdown(sdevice);
 }
 
+static struct bus_type siox_bus_type = {
+	.name = "siox",
+	.match = siox_match,
+	.probe = siox_probe,
+	.remove = siox_remove,
+	.shutdown = siox_shutdown,
+};
+
 static ssize_t active_show(struct device *dev,
 			   struct device_attribute *attr, char *buf)
 {
@@ -892,11 +900,6 @@ int __siox_driver_register(struct siox_driver *sdriver, struct module *owner)
 	sdriver->driver.bus = &siox_bus_type;
 
 	if (sdriver->probe)
-		sdriver->driver.probe = siox_driver_probe;
-	if (sdriver->remove)
-		sdriver->driver.remove = siox_driver_remove;
-	if (sdriver->shutdown)
-		sdriver->driver.shutdown = siox_driver_shutdown;
 
 	ret = driver_register(&sdriver->driver);
 	if (ret)
-- 
2.28.0

