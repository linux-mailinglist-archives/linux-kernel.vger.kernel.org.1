Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A6371C838D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 May 2020 09:36:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726763AbgEGHgL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 May 2020 03:36:11 -0400
Received: from inva021.nxp.com ([92.121.34.21]:50208 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726069AbgEGHfs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 03:35:48 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 1367D200F16;
        Thu,  7 May 2020 09:35:46 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 07152200F10;
        Thu,  7 May 2020 09:35:46 +0200 (CEST)
Received: from fsr-ub1864-111.ea.freescale.net (fsr-ub1864-111.ea.freescale.net [10.171.82.141])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id ACB52203C5;
        Thu,  7 May 2020 09:35:45 +0200 (CEST)
From:   Diana Craciun <diana.craciun@oss.nxp.com>
To:     linux-kernel@vger.kernel.org
Cc:     laurentiu.tudor@nxp.com, stuyoder@gmail.com, leoyang.li@nxp.com,
        linux-arm-kernel@lists.infradead.org, gregkh@linuxfoundation.org,
        Diana Craciun <diana.craciun@oss.nxp.com>
Subject: [PATCH v2 07/12] bus/fsl-mc: Export a dprc scan function to be used by multiple entities
Date:   Thu,  7 May 2020 10:34:26 +0300
Message-Id: <20200507073431.2710-8-diana.craciun@oss.nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200507073431.2710-1-diana.craciun@oss.nxp.com>
References: <20200507073431.2710-1-diana.craciun@oss.nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the DPRC scan function is used only by the bus driver.
But the same functionality will be needed by the VFIO driver.
To support this, the dprc scan function was exported and a little
bit adjusted to fit both scenarios. Also the scan mutex initialization
is done when the bus object is created, not in dprc_probe in order
to be used by both VFIO and bus driver.

Signed-off-by: Diana Craciun <diana.craciun@oss.nxp.com>
---
 drivers/bus/fsl-mc/dprc-driver.c | 19 +++++++------------
 drivers/bus/fsl-mc/fsl-mc-bus.c  |  1 +
 include/linux/fsl/mc.h           |  3 +++
 3 files changed, 11 insertions(+), 12 deletions(-)

diff --git a/drivers/bus/fsl-mc/dprc-driver.c b/drivers/bus/fsl-mc/dprc-driver.c
index 7a8061224df8..4f7fa5127844 100644
--- a/drivers/bus/fsl-mc/dprc-driver.c
+++ b/drivers/bus/fsl-mc/dprc-driver.c
@@ -331,9 +331,10 @@ static int dprc_scan_objects(struct fsl_mc_device *mc_bus_dev,
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
@@ -342,16 +343,12 @@ static int dprc_scan_container(struct fsl_mc_device *mc_bus_dev)
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
@@ -675,12 +672,10 @@ static int dprc_probe(struct fsl_mc_device *mc_dev)
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
index df96f1602361..bf4f01ddf846 100644
--- a/drivers/bus/fsl-mc/fsl-mc-bus.c
+++ b/drivers/bus/fsl-mc/fsl-mc-bus.c
@@ -636,6 +636,7 @@ int fsl_mc_device_add(struct fsl_mc_obj_desc *obj_desc,
 		if (!mc_bus)
 			return -ENOMEM;
 
+		mutex_init(&mc_bus->scan_mutex);
 		mc_dev = &mc_bus->mc_dev;
 	} else {
 		/*
diff --git a/include/linux/fsl/mc.h b/include/linux/fsl/mc.h
index 805a19516338..4c95e2dcf350 100644
--- a/include/linux/fsl/mc.h
+++ b/include/linux/fsl/mc.h
@@ -493,6 +493,9 @@ int dprc_reset_container(struct fsl_mc_io *mc_io,
 			 int child_container_id,
 			 u32 options);
 
+int dprc_scan_container(struct fsl_mc_device *mc_bus_dev,
+			bool alloc_interrupts);
+
 /*
  * Data Path Buffer Pool (DPBP) API
  * Contains initialization APIs and runtime control APIs for DPBP
-- 
2.17.1

