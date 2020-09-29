Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFC4727C025
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 10:55:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727925AbgI2Iz3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 04:55:29 -0400
Received: from inva020.nxp.com ([92.121.34.13]:59808 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727826AbgI2IzJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 04:55:09 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 20C6B1A124D;
        Tue, 29 Sep 2020 10:55:08 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 13E521A124A;
        Tue, 29 Sep 2020 10:55:08 +0200 (CEST)
Received: from fsr-ub1864-111.ea.freescale.net (fsr-ub1864-111.ea.freescale.net [10.171.82.141])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id B5B1F2032C;
        Tue, 29 Sep 2020 10:55:07 +0200 (CEST)
From:   Diana Craciun <diana.craciun@oss.nxp.com>
To:     linux-kernel@vger.kernel.org, laurentiu.tudor@nxp.com
Cc:     stuyoder@gmail.com, leoyang.li@nxp.com, gregkh@linuxfoundation.org,
        linux-arm-kernel@lists.infradead.org,
        Diana Craciun <diana.craciun@oss.nxp.com>
Subject: [PATCH v5 08/13] bus/fsl-mc: Export a cleanup function for DPRC
Date:   Tue, 29 Sep 2020 11:54:36 +0300
Message-Id: <20200929085441.17448-9-diana.craciun@oss.nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200929085441.17448-1-diana.craciun@oss.nxp.com>
References: <20200929085441.17448-1-diana.craciun@oss.nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Create and export a cleanup function for DPRC. The function
is used by the DPRC driver, but it will be used by the VFIO
driver as well.

Signed-off-by: Diana Craciun <diana.craciun@oss.nxp.com>
---
 drivers/bus/fsl-mc/dprc-driver.c | 62 ++++++++++++++++++++++++--------
 include/linux/fsl/mc.h           |  2 ++
 2 files changed, 49 insertions(+), 15 deletions(-)

diff --git a/drivers/bus/fsl-mc/dprc-driver.c b/drivers/bus/fsl-mc/dprc-driver.c
index dde8fe965e30..516119c8121a 100644
--- a/drivers/bus/fsl-mc/dprc-driver.c
+++ b/drivers/bus/fsl-mc/dprc-driver.c
@@ -728,33 +728,26 @@ static void dprc_teardown_irq(struct fsl_mc_device *mc_dev)
 }
 
 /**
- * dprc_remove - callback invoked when a DPRC is being unbound from this driver
+ * dprc_cleanup - function that cleanups a DPRC
  *
  * @mc_dev: Pointer to fsl-mc device representing the DPRC
  *
- * It removes the DPRC's child objects from Linux (not from the MC) and
- * closes the DPRC device in the MC.
- * It tears down the interrupts that were configured for the DPRC device.
+ * It closes the DPRC device in the MC.
  * It destroys the interrupt pool associated with this MC bus.
  */
-static int dprc_remove(struct fsl_mc_device *mc_dev)
+
+int dprc_cleanup(struct fsl_mc_device *mc_dev)
 {
 	int error;
 	struct fsl_mc_bus *mc_bus = to_fsl_mc_bus(mc_dev);
 
-	if (!is_fsl_mc_bus_dprc(mc_dev))
-		return -EINVAL;
-	if (!mc_dev->mc_io)
-		return -EINVAL;
 
-	if (!mc_bus->irq_resources)
+	/* this function should be called only for DPRCs, it
+	 * is an error to call it for regular objects
+	 */
+	if (!is_fsl_mc_bus_dprc(mc_dev))
 		return -EINVAL;
 
-	if (dev_get_msi_domain(&mc_dev->dev))
-		dprc_teardown_irq(mc_dev);
-
-	device_for_each_child(&mc_dev->dev, NULL, __fsl_mc_device_remove);
-
 	if (dev_get_msi_domain(&mc_dev->dev)) {
 		fsl_mc_cleanup_irq_pool(mc_bus);
 		dev_set_msi_domain(&mc_dev->dev, NULL);
@@ -762,6 +755,14 @@ static int dprc_remove(struct fsl_mc_device *mc_dev)
 
 	fsl_mc_cleanup_all_resource_pools(mc_dev);
 
+	/* if this step fails we cannot go further with cleanup as there is no way of
+	 * communicating with the firmware
+	 */
+	if (!mc_dev->mc_io) {
+		dev_err(&mc_dev->dev, "mc_io is NULL, tear down cannot be performed in firmware\n");
+		return -EINVAL;
+	}
+
 	error = dprc_close(mc_dev->mc_io, 0, mc_dev->mc_handle);
 	if (error < 0)
 		dev_err(&mc_dev->dev, "dprc_close() failed: %d\n", error);
@@ -771,6 +772,37 @@ static int dprc_remove(struct fsl_mc_device *mc_dev)
 		mc_dev->mc_io = NULL;
 	}
 
+	return 0;
+}
+EXPORT_SYMBOL_GPL(dprc_cleanup);
+
+/**
+ * dprc_remove - callback invoked when a DPRC is being unbound from this driver
+ *
+ * @mc_dev: Pointer to fsl-mc device representing the DPRC
+ *
+ * It removes the DPRC's child objects from Linux (not from the MC) and
+ * closes the DPRC device in the MC.
+ * It tears down the interrupts that were configured for the DPRC device.
+ * It destroys the interrupt pool associated with this MC bus.
+ */
+static int dprc_remove(struct fsl_mc_device *mc_dev)
+{
+	struct fsl_mc_bus *mc_bus = to_fsl_mc_bus(mc_dev);
+
+	if (!is_fsl_mc_bus_dprc(mc_dev))
+		return -EINVAL;
+
+	if (!mc_bus->irq_resources)
+		return -EINVAL;
+
+	if (dev_get_msi_domain(&mc_dev->dev))
+		dprc_teardown_irq(mc_dev);
+
+	device_for_each_child(&mc_dev->dev, NULL, __fsl_mc_device_remove);
+
+	dprc_cleanup(mc_dev);
+
 	dev_info(&mc_dev->dev, "DPRC device unbound from driver");
 	return 0;
 }
diff --git a/include/linux/fsl/mc.h b/include/linux/fsl/mc.h
index da11171bc38f..5519a510b8c9 100644
--- a/include/linux/fsl/mc.h
+++ b/include/linux/fsl/mc.h
@@ -538,6 +538,8 @@ void dprc_remove_devices(struct fsl_mc_device *mc_bus_dev,
 			 struct fsl_mc_obj_desc *obj_desc_array,
 			 int num_child_objects_in_mc);
 
+int dprc_cleanup(struct fsl_mc_device *mc_dev);
+
 /*
  * Data Path Buffer Pool (DPBP) API
  * Contains initialization APIs and runtime control APIs for DPBP
-- 
2.17.1

