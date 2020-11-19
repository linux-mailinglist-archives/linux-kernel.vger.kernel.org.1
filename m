Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 092002B9396
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 14:23:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727059AbgKSNXZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 08:23:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726691AbgKSNXY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 08:23:24 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B65CBC0613D4
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 05:23:24 -0800 (PST)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1kfjuE-0004IH-PP; Thu, 19 Nov 2020 14:23:22 +0100
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1kfjuE-0005J0-Bn; Thu, 19 Nov 2020 14:23:22 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thorsten Scherer <t.scherer@eckelmann.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Pengutronix Kernel Team <kernel@pengutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] siox: Make remove callback return void
Date:   Thu, 19 Nov 2020 14:23:11 +0100
Message-Id: <20201119132311.2604232-2-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201119132311.2604232-1-u.kleine-koenig@pengutronix.de>
References: <20201119132311.2604232-1-u.kleine-koenig@pengutronix.de>
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

The driver core ignores the return value of the remove callback, so
don't give siox drivers the chance to provide a value.

As there only siox driver only allocates devm-managed resources in
.probe, there is no .remove callback to fix.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/siox/siox-core.c | 5 ++---
 include/linux/siox.h     | 2 +-
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/siox/siox-core.c b/drivers/siox/siox-core.c
index 7b3a2b63304b..b4ad87ca1838 100644
--- a/drivers/siox/siox-core.c
+++ b/drivers/siox/siox-core.c
@@ -529,12 +529,11 @@ static int siox_remove(struct device *dev)
 	struct siox_driver *sdriver =
 		container_of(dev->driver, struct siox_driver, driver);
 	struct siox_device *sdevice = to_siox_device(dev);
-	int ret = 0;
 
 	if (sdriver->remove)
-		ret = sdriver->remove(sdevice);
+		sdriver->remove(sdevice);
 
-	return ret;
+	return 0;
 }
 
 static void siox_shutdown(struct device *dev)
diff --git a/include/linux/siox.h b/include/linux/siox.h
index da7225bf1877..6bfbda3f634c 100644
--- a/include/linux/siox.h
+++ b/include/linux/siox.h
@@ -36,7 +36,7 @@ bool siox_device_connected(struct siox_device *sdevice);
 
 struct siox_driver {
 	int (*probe)(struct siox_device *sdevice);
-	int (*remove)(struct siox_device *sdevice);
+	void (*remove)(struct siox_device *sdevice);
 	void (*shutdown)(struct siox_device *sdevice);
 
 	/*
-- 
2.28.0

