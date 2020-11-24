Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4E702C293F
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 15:19:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388777AbgKXOSm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 09:18:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388682AbgKXOSl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 09:18:41 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09F6AC0613D6
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 06:18:41 -0800 (PST)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1khZ9T-00080P-1y; Tue, 24 Nov 2020 15:18:39 +0100
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1khZ9S-0001pm-ON; Tue, 24 Nov 2020 15:18:38 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thorsten Scherer <t.scherer@eckelmann.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: [PATCH v2 2/2] siox: Make remove callback return void
Date:   Tue, 24 Nov 2020 15:18:34 +0100
Message-Id: <20201124141834.3096325-3-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201124141834.3096325-1-u.kleine-koenig@pengutronix.de>
References: <20201124141834.3096325-1-u.kleine-koenig@pengutronix.de>
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

All siox drivers only allocate devm-managed resources in
.probe, so there is no .remove callback to fix.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/siox/siox-core.c | 5 ++---
 include/linux/siox.h     | 2 +-
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/siox/siox-core.c b/drivers/siox/siox-core.c
index b56cdcb52967..1794ff0106bc 100644
--- a/drivers/siox/siox-core.c
+++ b/drivers/siox/siox-core.c
@@ -525,12 +525,11 @@ static int siox_remove(struct device *dev)
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
2.29.2

