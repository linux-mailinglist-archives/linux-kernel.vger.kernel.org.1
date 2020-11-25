Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A30712C3C32
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 10:32:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727874AbgKYJbS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 04:31:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726973AbgKYJbQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 04:31:16 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25FD7C0613D6
        for <linux-kernel@vger.kernel.org>; Wed, 25 Nov 2020 01:31:16 -0800 (PST)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1khr8r-00037o-4C; Wed, 25 Nov 2020 10:31:13 +0100
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1khr8q-00074H-Je; Wed, 25 Nov 2020 10:31:12 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thorsten Scherer <t.scherer@eckelmann.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: [PATCH v3 1/2] siox: Use bus_type functions for probe, remove and shutdown
Date:   Wed, 25 Nov 2020 10:31:05 +0100
Message-Id: <20201125093106.240643-2-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201125093106.240643-1-u.kleine-koenig@pengutronix.de>
References: <20201125093106.240643-1-u.kleine-koenig@pengutronix.de>
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

Acked-by: Thorsten Scherer <t.scherer@eckelmann.de>
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/siox/siox-core.c | 49 ++++++++++++++++++++--------------------
 1 file changed, 25 insertions(+), 24 deletions(-)

diff --git a/drivers/siox/siox-core.c b/drivers/siox/siox-core.c
index f8c08fb9891d..b56cdcb52967 100644
--- a/drivers/siox/siox-core.c
+++ b/drivers/siox/siox-core.c
@@ -512,41 +512,48 @@ static int siox_match(struct device *dev, struct device_driver *drv)
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
 
-	ret = sdriver->probe(sdevice);
-	return ret;
+	return sdriver->probe(sdevice);
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
-	struct siox_driver *sdriver =
-		container_of(dev->driver, struct siox_driver, driver);
 	struct siox_device *sdevice = to_siox_device(dev);
+	struct siox_driver *sdriver;
 
-	sdriver->shutdown(sdevice);
+	if (!dev->driver)
+		return;
+
+	sdriver = container_of(dev->driver, struct siox_driver, driver);
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
@@ -882,7 +889,8 @@ int __siox_driver_register(struct siox_driver *sdriver, struct module *owner)
 	if (unlikely(!siox_is_registered))
 		return -EPROBE_DEFER;
 
-	if (!sdriver->set_data && !sdriver->get_data) {
+	if (!sdriver->probe ||
+	    (!sdriver->set_data && !sdriver->get_data)) {
 		pr_err("Driver %s doesn't provide needed callbacks\n",
 		       sdriver->driver.name);
 		return -EINVAL;
@@ -891,13 +899,6 @@ int __siox_driver_register(struct siox_driver *sdriver, struct module *owner)
 	sdriver->driver.owner = owner;
 	sdriver->driver.bus = &siox_bus_type;
 
-	if (sdriver->probe)
-		sdriver->driver.probe = siox_driver_probe;
-	if (sdriver->remove)
-		sdriver->driver.remove = siox_driver_remove;
-	if (sdriver->shutdown)
-		sdriver->driver.shutdown = siox_driver_shutdown;
-
 	ret = driver_register(&sdriver->driver);
 	if (ret)
 		pr_err("Failed to register siox driver %s (%d)\n",
-- 
2.29.2

