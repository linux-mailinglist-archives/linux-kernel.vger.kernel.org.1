Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8F7627C01C
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 10:55:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727855AbgI2IzK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 04:55:10 -0400
Received: from inva021.nxp.com ([92.121.34.21]:53774 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727650AbgI2IzH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 04:55:07 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 91A4620106C;
        Tue, 29 Sep 2020 10:55:05 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 84CD72000AA;
        Tue, 29 Sep 2020 10:55:05 +0200 (CEST)
Received: from fsr-ub1864-111.ea.freescale.net (fsr-ub1864-111.ea.freescale.net [10.171.82.141])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 2F5BD2037B;
        Tue, 29 Sep 2020 10:55:05 +0200 (CEST)
From:   Diana Craciun <diana.craciun@oss.nxp.com>
To:     linux-kernel@vger.kernel.org, laurentiu.tudor@nxp.com
Cc:     stuyoder@gmail.com, leoyang.li@nxp.com, gregkh@linuxfoundation.org,
        linux-arm-kernel@lists.infradead.org,
        Diana Craciun <diana.craciun@oss.nxp.com>
Subject: [PATCH v5 02/13] bus/fsl-mc: Add a new parameter to dprc_scan_objects function
Date:   Tue, 29 Sep 2020 11:54:30 +0300
Message-Id: <20200929085441.17448-3-diana.craciun@oss.nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200929085441.17448-1-diana.craciun@oss.nxp.com>
References: <20200929085441.17448-1-diana.craciun@oss.nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prepare the dprc_scan_objects function to be used by
the VFIO mc driver code. The function is used to scan the mc
objects by the bus driver. The same functionality is
needed by the VFIO mc driver, but in this case the
interrupt configuration is delayed until the userspace
configures the interrupts. In order to use the same function
in both drivers add a new parameter.

Signed-off-by: Diana Craciun <diana.craciun@oss.nxp.com>
---
 drivers/bus/fsl-mc/dprc-driver.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/bus/fsl-mc/dprc-driver.c b/drivers/bus/fsl-mc/dprc-driver.c
index 54c576d68122..3d850515e3e5 100644
--- a/drivers/bus/fsl-mc/dprc-driver.c
+++ b/drivers/bus/fsl-mc/dprc-driver.c
@@ -221,6 +221,8 @@ static void dprc_add_new_devices(struct fsl_mc_device *mc_bus_dev,
  * dprc_scan_objects - Discover objects in a DPRC
  *
  * @mc_bus_dev: pointer to the fsl-mc device that represents a DPRC object
+ * @alloc_interrupts: if true the function allocates the interrupt pool,
+ * otherwise the interrupt allocation is delayed
  *
  * Detects objects added and removed from a DPRC and synchronizes the
  * state of the Linux bus driver, MC by adding and removing
@@ -234,7 +236,8 @@ static void dprc_add_new_devices(struct fsl_mc_device *mc_bus_dev,
  * populated before they can get allocation requests from probe callbacks
  * of the device drivers for the non-allocatable devices.
  */
-static int dprc_scan_objects(struct fsl_mc_device *mc_bus_dev)
+static int dprc_scan_objects(struct fsl_mc_device *mc_bus_dev,
+			    bool alloc_interrupts)
 {
 	int num_child_objects;
 	int dprc_get_obj_failures;
@@ -322,7 +325,7 @@ static int dprc_scan_objects(struct fsl_mc_device *mc_bus_dev)
 				 irq_count, FSL_MC_IRQ_POOL_MAX_TOTAL_IRQS);
 		}
 
-		if (!mc_bus->irq_resources) {
+		if (alloc_interrupts && !mc_bus->irq_resources) {
 			error = fsl_mc_populate_irq_pool(mc_bus,
 				FSL_MC_IRQ_POOL_MAX_TOTAL_IRQS);
 			if (error < 0)
@@ -362,7 +365,7 @@ static int dprc_scan_container(struct fsl_mc_device *mc_bus_dev)
 	 * Discover objects in the DPRC:
 	 */
 	mutex_lock(&mc_bus->scan_mutex);
-	error = dprc_scan_objects(mc_bus_dev);
+	error = dprc_scan_objects(mc_bus_dev, true);
 	mutex_unlock(&mc_bus->scan_mutex);
 	if (error < 0) {
 		fsl_mc_cleanup_all_resource_pools(mc_bus_dev);
@@ -432,7 +435,7 @@ static irqreturn_t dprc_irq0_handler_thread(int irq_num, void *arg)
 		      DPRC_IRQ_EVENT_OBJ_DESTROYED |
 		      DPRC_IRQ_EVENT_OBJ_CREATED)) {
 
-		error = dprc_scan_objects(mc_dev);
+		error = dprc_scan_objects(mc_dev, true);
 		if (error < 0) {
 			/*
 			 * If the error is -ENXIO, we ignore it, as it indicates
-- 
2.17.1

