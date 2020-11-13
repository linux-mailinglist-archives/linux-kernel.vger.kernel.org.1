Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 160C12B1791
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 09:53:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726255AbgKMIxh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 03:53:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726149AbgKMIxg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 03:53:36 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0012C0613D1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 00:53:35 -0800 (PST)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1kdUpq-0007HR-FM; Fri, 13 Nov 2020 09:53:34 +0100
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1kdUpq-0000GO-55; Fri, 13 Nov 2020 09:53:34 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>
Subject: [PATCH 1/2] base: Rename devm_ioremap_resource to make the implicit request_mem explicit
Date:   Fri, 13 Nov 2020 09:53:26 +0100
Message-Id: <20201113085327.125041-2-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201113085327.125041-1-u.kleine-koenig@pengutronix.de>
References: <20201113070343.lhcsbyvi5baxn3lq@pengutronix.de>
 <20201113085327.125041-1-u.kleine-koenig@pengutronix.de>
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

The main difference between devm_ioremap() and devm_ioremap_resource()
(apart from the different way to pass the area to map) is that the latter
also calls devm_request_mem() which is unintuitive and yields problems
like https://lore.kernel.org/r/1555670144-24220-1-git-send-email-aisheng.dong@nxp.com .

So rename devm_ioremap_resource and it's relative devm_ioremap_resource_wc
to include "request" in their name.

Until all users are converted, provide wrappers with the old name.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 .../driver-api/driver-model/devres.rst        |  4 +--
 include/linux/device.h                        | 31 ++++++++++++++++---
 lib/devres.c                                  | 18 +++++------
 3 files changed, 38 insertions(+), 15 deletions(-)

diff --git a/Documentation/driver-api/driver-model/devres.rst b/Documentation/driver-api/driver-model/devres.rst
index bb676570acc3..65f9f44d5c39 100644
--- a/Documentation/driver-api/driver-model/devres.rst
+++ b/Documentation/driver-api/driver-model/devres.rst
@@ -309,8 +309,8 @@ IOMAP
   devm_ioremap()
   devm_ioremap_uc()
   devm_ioremap_wc()
-  devm_ioremap_resource() : checks resource, requests memory region, ioremaps
-  devm_ioremap_resource_wc()
+  devm_request_ioremap_resource() : checks resource, requests memory region, ioremaps
+  devm_request_ioremap_resource_wc()
   devm_platform_ioremap_resource() : calls devm_ioremap_resource() for platform device
   devm_platform_ioremap_resource_wc()
   devm_platform_ioremap_resource_byname()
diff --git a/include/linux/device.h b/include/linux/device.h
index 5ed101be7b2e..927992549db9 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -240,10 +240,33 @@ unsigned long devm_get_free_pages(struct device *dev,
 				  gfp_t gfp_mask, unsigned int order);
 void devm_free_pages(struct device *dev, unsigned long addr);
 
-void __iomem *devm_ioremap_resource(struct device *dev,
-				    const struct resource *res);
-void __iomem *devm_ioremap_resource_wc(struct device *dev,
-				       const struct resource *res);
+void __iomem *devm_request_ioremap_resource(struct device *dev,
+					    const struct resource *res);
+/*
+ * devm_ioremap_resource() was the initial name chosen for
+ * devm_request_ioremap_resource(). Please stick to the latter for clearer
+ * semantics.
+ */
+static inline void __iomem *
+devm_ioremap_resource(struct device *dev, const struct resource *res)
+{
+	return devm_request_ioremap_resource(dev, res);
+}
+
+void __iomem *devm_request_ioremap_resource_wc(struct device *dev,
+					       const struct resource *res);
+
+/*
+ * devm_ioremap_resource_wc() was the initial name chosen for
+ * devm_request_ioremap_resource_wc(). Please stick to the latter for clearer
+ * semantics.
+ */
+static inline void __iomem *
+devm_ioremap_resource_wc(struct device *dev,
+			 const struct resource *res)
+{
+	return devm_request_ioremap_resource_wc(dev, res);
+}
 
 void __iomem *devm_of_iomap(struct device *dev,
 			    struct device_node *node, int index,
diff --git a/lib/devres.c b/lib/devres.c
index 2a4ff5d64288..907588f1a5b7 100644
--- a/lib/devres.c
+++ b/lib/devres.c
@@ -114,8 +114,8 @@ void devm_iounmap(struct device *dev, void __iomem *addr)
 EXPORT_SYMBOL(devm_iounmap);
 
 static void __iomem *
-__devm_ioremap_resource(struct device *dev, const struct resource *res,
-			enum devm_ioremap_type type)
+__devm_request_ioremap_resource(struct device *dev, const struct resource *res,
+				enum devm_ioremap_type type)
 {
 	resource_size_t size;
 	void __iomem *dest_ptr;
@@ -172,12 +172,12 @@ __devm_ioremap_resource(struct device *dev, const struct resource *res,
  * Return: a pointer to the remapped memory or an ERR_PTR() encoded error code
  * on failure.
  */
-void __iomem *devm_ioremap_resource(struct device *dev,
-				    const struct resource *res)
+void __iomem *devm_request_ioremap_resource(struct device *dev,
+					    const struct resource *res)
 {
-	return __devm_ioremap_resource(dev, res, DEVM_IOREMAP);
+	return __devm_request_ioremap_resource(dev, res, DEVM_IOREMAP);
 }
-EXPORT_SYMBOL(devm_ioremap_resource);
+EXPORT_SYMBOL(devm_request_ioremap_resource);
 
 /**
  * devm_ioremap_resource_wc() - write-combined variant of
@@ -188,10 +188,10 @@ EXPORT_SYMBOL(devm_ioremap_resource);
  * Return: a pointer to the remapped memory or an ERR_PTR() encoded error code
  * on failure.
  */
-void __iomem *devm_ioremap_resource_wc(struct device *dev,
-				       const struct resource *res)
+void __iomem *devm_request_ioremap_resource_wc(struct device *dev,
+					       const struct resource *res)
 {
-	return __devm_ioremap_resource(dev, res, DEVM_IOREMAP_WC);
+	return __devm_request_ioremap_resource(dev, res, DEVM_IOREMAP_WC);
 }
 
 /*
-- 
2.28.0

