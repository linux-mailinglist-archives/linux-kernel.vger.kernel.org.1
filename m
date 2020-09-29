Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 677F427C024
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 10:55:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727916AbgI2Iz2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 04:55:28 -0400
Received: from inva021.nxp.com ([92.121.34.21]:53912 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727795AbgI2IzJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 04:55:09 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id B28CC200313;
        Tue, 29 Sep 2020 10:55:07 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id A53C720161A;
        Tue, 29 Sep 2020 10:55:07 +0200 (CEST)
Received: from fsr-ub1864-111.ea.freescale.net (fsr-ub1864-111.ea.freescale.net [10.171.82.141])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 4DF4C2032C;
        Tue, 29 Sep 2020 10:55:07 +0200 (CEST)
From:   Diana Craciun <diana.craciun@oss.nxp.com>
To:     linux-kernel@vger.kernel.org, laurentiu.tudor@nxp.com
Cc:     stuyoder@gmail.com, leoyang.li@nxp.com, gregkh@linuxfoundation.org,
        linux-arm-kernel@lists.infradead.org,
        Diana Craciun <diana.craciun@oss.nxp.com>
Subject: [PATCH v5 07/13] bus/fsl-mc: Export dprc_scan/dprc_remove functions to be used by multiple entities
Date:   Tue, 29 Sep 2020 11:54:35 +0300
Message-Id: <20200929085441.17448-8-diana.craciun@oss.nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200929085441.17448-1-diana.craciun@oss.nxp.com>
References: <20200929085441.17448-1-diana.craciun@oss.nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the DPRC scan function is used only by the bus driver.
But the same functionality will be needed by the VFIO driver.
To support this, the dprc scan function was exported and a little
bit adjusted to fit both scenarios. Also the scan mutex initialization
is done when the bus object is created, not in dprc_probe in order
to be used by both VFIO and bus driver.
Similarily dprc_remove_devices is exported to be used by VFIO.

Signed-off-by: Diana Craciun <diana.craciun@oss.nxp.com>
---
 drivers/bus/fsl-mc/dprc-driver.c | 26 +++++++++++---------------
 drivers/bus/fsl-mc/fsl-mc-bus.c  |  1 +
 include/linux/fsl/mc.h           |  7 +++++++
 3 files changed, 19 insertions(+), 15 deletions(-)

diff --git a/drivers/bus/fsl-mc/dprc-driver.c b/drivers/bus/fsl-mc/dprc-driver.c
index 3d850515e3e5..dde8fe965e30 100644
--- a/drivers/bus/fsl-mc/dprc-driver.c
+++ b/drivers/bus/fsl-mc/dprc-driver.c
@@ -81,9 +81,9 @@ static int __fsl_mc_device_remove(struct device *dev, void *data)
  * the MC by removing devices that represent MC objects that have
  * been dynamically removed in the physical DPRC.
  */
-static void dprc_remove_devices(struct fsl_mc_device *mc_bus_dev,
-				struct fsl_mc_obj_desc *obj_desc_array,
-				int num_child_objects_in_mc)
+void dprc_remove_devices(struct fsl_mc_device *mc_bus_dev,
+			 struct fsl_mc_obj_desc *obj_desc_array,
+			 int num_child_objects_in_mc)
 {
 	if (num_child_objects_in_mc != 0) {
 		/*
@@ -105,6 +105,7 @@ static void dprc_remove_devices(struct fsl_mc_device *mc_bus_dev,
 				      __fsl_mc_device_remove);
 	}
 }
+EXPORT_SYMBOL_GPL(dprc_remove_devices);
 
 static int __fsl_mc_device_match(struct device *dev, void *data)
 {
@@ -354,9 +355,10 @@ static int dprc_scan_objects(struct fsl_mc_device *mc_bus_dev,
  * bus driver with the actual state of the MC by adding and removing
  * devices as appropriate.
  */
-static int dprc_scan_container(struct fsl_mc_device *mc_bus_dev)
+int dprc_scan_container(struct fsl_mc_device *mc_bus_dev,
+			bool alloc_interrupts)
 {
-	int error;
+	int error = 0;
 	struct fsl_mc_bus *mc_bus = to_fsl_mc_bus(mc_bus_dev);
 
 	fsl_mc_init_all_resource_pools(mc_bus_dev);
@@ -365,16 +367,12 @@ static int dprc_scan_container(struct fsl_mc_device *mc_bus_dev)
 	 * Discover objects in the DPRC:
 	 */
 	mutex_lock(&mc_bus->scan_mutex);
-	error = dprc_scan_objects(mc_bus_dev, true);
+	error = dprc_scan_objects(mc_bus_dev, alloc_interrupts);
 	mutex_unlock(&mc_bus->scan_mutex);
-	if (error < 0) {
-		fsl_mc_cleanup_all_resource_pools(mc_bus_dev);
-		return error;
-	}
 
-	return 0;
+	return error;
 }
-
+EXPORT_SYMBOL_GPL(dprc_scan_container);
 /**
  * dprc_irq0_handler - Regular ISR for DPRC interrupt 0
  *
@@ -683,12 +681,10 @@ static int dprc_probe(struct fsl_mc_device *mc_dev)
 		goto error_cleanup_open;
 	}
 
-	mutex_init(&mc_bus->scan_mutex);
-
 	/*
 	 * Discover MC objects in DPRC object:
 	 */
-	error = dprc_scan_container(mc_dev);
+	error = dprc_scan_container(mc_dev, true);
 	if (error < 0)
 		goto error_cleanup_open;
 
diff --git a/drivers/bus/fsl-mc/fsl-mc-bus.c b/drivers/bus/fsl-mc/fsl-mc-bus.c
index 1bb70a92167e..32f194814b08 100644
--- a/drivers/bus/fsl-mc/fsl-mc-bus.c
+++ b/drivers/bus/fsl-mc/fsl-mc-bus.c
@@ -678,6 +678,7 @@ int fsl_mc_device_add(struct fsl_mc_obj_desc *obj_desc,
 		if (!mc_bus)
 			return -ENOMEM;
 
+		mutex_init(&mc_bus->scan_mutex);
 		mc_dev = &mc_bus->mc_dev;
 	} else {
 		/*
diff --git a/include/linux/fsl/mc.h b/include/linux/fsl/mc.h
index 1d8800acf21f..da11171bc38f 100644
--- a/include/linux/fsl/mc.h
+++ b/include/linux/fsl/mc.h
@@ -531,6 +531,13 @@ int dprc_reset_container(struct fsl_mc_io *mc_io,
 			 int child_container_id,
 			 u32 options);
 
+int dprc_scan_container(struct fsl_mc_device *mc_bus_dev,
+			bool alloc_interrupts);
+
+void dprc_remove_devices(struct fsl_mc_device *mc_bus_dev,
+			 struct fsl_mc_obj_desc *obj_desc_array,
+			 int num_child_objects_in_mc);
+
 /*
  * Data Path Buffer Pool (DPBP) API
  * Contains initialization APIs and runtime control APIs for DPBP
-- 
2.17.1

