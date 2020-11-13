Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83CA72B1792
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 09:53:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726279AbgKMIxi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 03:53:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726202AbgKMIxg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 03:53:36 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09818C0613D6
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 00:53:36 -0800 (PST)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1kdUpq-0007HS-LX; Fri, 13 Nov 2020 09:53:34 +0100
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1kdUpq-0000GR-Ag; Fri, 13 Nov 2020 09:53:34 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>
Subject: [PATCH 2/2] platform: Rename devm_platform_ioremap_resource to make the implicit request_mem explicit
Date:   Fri, 13 Nov 2020 09:53:27 +0100
Message-Id: <20201113085327.125041-3-u.kleine-koenig@pengutronix.de>
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

devm_ioremap_resource() and so devm_platform_ioremap_resource() et al also
include a call to devm_request_mem(). Make this explicit in their name
to make this difference compared to devm_ioremap() more obvious.

This follows the similar rename of devm_ioremap_resource in the previous
commit.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 .../driver-api/driver-model/devres.rst        |  2 +-
 drivers/base/platform.c                       | 26 +++++------
 include/linux/device.h                        |  3 +-
 include/linux/platform_device.h               | 43 +++++++++++++++++--
 4 files changed, 56 insertions(+), 18 deletions(-)

diff --git a/Documentation/driver-api/driver-model/devres.rst b/Documentation/driver-api/driver-model/devres.rst
index 65f9f44d5c39..6dd5c219f11e 100644
--- a/Documentation/driver-api/driver-model/devres.rst
+++ b/Documentation/driver-api/driver-model/devres.rst
@@ -311,7 +311,7 @@ IOMAP
   devm_ioremap_wc()
   devm_request_ioremap_resource() : checks resource, requests memory region, ioremaps
   devm_request_ioremap_resource_wc()
-  devm_platform_ioremap_resource() : calls devm_ioremap_resource() for platform device
+  devm_platform_request_ioremap_resource() : calls devm_request_ioremap_resource() for platform device
   devm_platform_ioremap_resource_wc()
   devm_platform_ioremap_resource_byname()
   devm_platform_get_and_ioremap_resource()
diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index 88aef93eb4dd..5a451121a9e0 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -65,8 +65,8 @@ EXPORT_SYMBOL_GPL(platform_get_resource);
 
 #ifdef CONFIG_HAS_IOMEM
 /**
- * devm_platform_get_and_ioremap_resource - call devm_ioremap_resource() for a
- *					    platform device and get resource
+ * devm_platform_get_request_and_ioremap_resource - call devm_ioremap_resource() for a
+ *						    platform device and get resource
  *
  * @pdev: platform device to use both for memory resource lookup as well as
  *        resource management
@@ -77,17 +77,17 @@ EXPORT_SYMBOL_GPL(platform_get_resource);
  * on failure.
  */
 void __iomem *
-devm_platform_get_and_ioremap_resource(struct platform_device *pdev,
-				unsigned int index, struct resource **res)
+devm_platform_get_request_and_ioremap_resource(struct platform_device *pdev,
+					       unsigned int index, struct resource **res)
 {
 	struct resource *r;
 
 	r = platform_get_resource(pdev, IORESOURCE_MEM, index);
 	if (res)
 		*res = r;
-	return devm_ioremap_resource(&pdev->dev, r);
+	return devm_request_ioremap_resource(&pdev->dev, r);
 }
-EXPORT_SYMBOL_GPL(devm_platform_get_and_ioremap_resource);
+EXPORT_SYMBOL_GPL(devm_platform_get_request_and_ioremap_resource);
 
 /**
  * devm_platform_ioremap_resource - call devm_ioremap_resource() for a platform
@@ -100,12 +100,12 @@ EXPORT_SYMBOL_GPL(devm_platform_get_and_ioremap_resource);
  * Return: a pointer to the remapped memory or an ERR_PTR() encoded error code
  * on failure.
  */
-void __iomem *devm_platform_ioremap_resource(struct platform_device *pdev,
-					     unsigned int index)
+void __iomem *devm_platform_request_ioremap_resource(struct platform_device *pdev,
+						     unsigned int index)
 {
-	return devm_platform_get_and_ioremap_resource(pdev, index, NULL);
+	return devm_platform_get_request_and_ioremap_resource(pdev, index, NULL);
 }
-EXPORT_SYMBOL_GPL(devm_platform_ioremap_resource);
+EXPORT_SYMBOL_GPL(devm_platform_request_ioremap_resource);
 
 /**
  * devm_platform_ioremap_resource_wc - write-combined variant of
@@ -118,13 +118,13 @@ EXPORT_SYMBOL_GPL(devm_platform_ioremap_resource);
  * Return: a pointer to the remapped memory or an ERR_PTR() encoded error code
  * on failure.
  */
-void __iomem *devm_platform_ioremap_resource_wc(struct platform_device *pdev,
-						unsigned int index)
+void __iomem *devm_platform_request_ioremap_resource_wc(struct platform_device *pdev,
+							unsigned int index)
 {
 	struct resource *res;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, index);
-	return devm_ioremap_resource_wc(&pdev->dev, res);
+	return devm_request_ioremap_resource_wc(&pdev->dev, res);
 }
 
 /**
diff --git a/include/linux/device.h b/include/linux/device.h
index 927992549db9..3679a42f94a9 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -245,7 +245,8 @@ void __iomem *devm_request_ioremap_resource(struct device *dev,
 /*
  * devm_ioremap_resource() was the initial name chosen for
  * devm_request_ioremap_resource(). Please stick to the latter for clearer
- * semantics.
+ * semantics. When converting consider using
+ * devm_platform_request_ioremap_resource().
  */
 static inline void __iomem *
 devm_ioremap_resource(struct device *dev, const struct resource *res)
diff --git a/include/linux/platform_device.h b/include/linux/platform_device.h
index 77a2aada106d..87b21f8c7daa 100644
--- a/include/linux/platform_device.h
+++ b/include/linux/platform_device.h
@@ -55,15 +55,52 @@ extern struct resource *platform_get_resource(struct platform_device *,
 extern struct device *
 platform_find_device_by_driver(struct device *start,
 			       const struct device_driver *drv);
+
 extern void __iomem *
+devm_platform_get_request_and_ioremap_resource(struct platform_device *pdev,
+					       unsigned int index, struct resource **res);
+/*
+ * devm_platform_get_and_ioremap_resource() was the initial name chosen for
+ * devm_platform_get_request_and_ioremap_resource(). Please stick to the latter
+ * for clearer semantics.
+ */
+static inline void __iomem *
 devm_platform_get_and_ioremap_resource(struct platform_device *pdev,
-				unsigned int index, struct resource **res);
+				       unsigned int index, struct resource **res)
+{
+	return devm_platform_get_request_and_ioremap_resource(pdev, index, res);
+}
+
 extern void __iomem *
+devm_platform_request_ioremap_resource(struct platform_device *pdev,
+				       unsigned int index);
+/*
+ * devm_platform_ioremap_resource() was the initial name chosen for
+ * devm_platform_request_ioremap_resource(). Please stick to the latter for
+ * clearer semantics.
+ */
+static inline void __iomem *
 devm_platform_ioremap_resource(struct platform_device *pdev,
-			       unsigned int index);
+							  unsigned int index)
+{
+	return devm_platform_request_ioremap_resource(pdev, index);
+}
+
 extern void __iomem *
+devm_platform_request_ioremap_resource_wc(struct platform_device *pdev,
+					  unsigned int index);
+/*
+ * devm_platform_ioremap_resource_wc() was the initial name chosen for
+ * devm_platform_request_ioremap_resource_wc(). Please stick to the latter for
+ * clearer semantics.
+ */
+static inline void __iomem *
 devm_platform_ioremap_resource_wc(struct platform_device *pdev,
-				  unsigned int index);
+				  unsigned int index)
+{
+	return devm_platform_request_ioremap_resource_wc(pdev, index);
+}
+
 extern void __iomem *
 devm_platform_ioremap_resource_byname(struct platform_device *pdev,
 				      const char *name);
-- 
2.28.0

