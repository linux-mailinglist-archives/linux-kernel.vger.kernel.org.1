Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BA4C27C028
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 10:55:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727970AbgI2Izp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 04:55:45 -0400
Received: from inva021.nxp.com ([92.121.34.21]:53790 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726064AbgI2IzI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 04:55:08 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 703BB200C87;
        Tue, 29 Sep 2020 10:55:06 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 63D072000AA;
        Tue, 29 Sep 2020 10:55:06 +0200 (CEST)
Received: from fsr-ub1864-111.ea.freescale.net (fsr-ub1864-111.ea.freescale.net [10.171.82.141])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 0BDFA2032C;
        Tue, 29 Sep 2020 10:55:06 +0200 (CEST)
From:   Diana Craciun <diana.craciun@oss.nxp.com>
To:     linux-kernel@vger.kernel.org, laurentiu.tudor@nxp.com
Cc:     stuyoder@gmail.com, leoyang.li@nxp.com, gregkh@linuxfoundation.org,
        linux-arm-kernel@lists.infradead.org,
        Diana Craciun <diana.craciun@oss.nxp.com>
Subject: [PATCH v5 04/13] bus/fsl-mc: Set the QMAN/BMAN region flags
Date:   Tue, 29 Sep 2020 11:54:32 +0300
Message-Id: <20200929085441.17448-5-diana.craciun@oss.nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200929085441.17448-1-diana.craciun@oss.nxp.com>
References: <20200929085441.17448-1-diana.craciun@oss.nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The QMAN region is memory mapped, so it should be of type
IORESOURCE_MEM. The region flags bits were wrongly used to
pass additional information. Use the bus specific bits for
this purpose.

Signed-off-by: Diana Craciun <diana.craciun@oss.nxp.com>
---
 drivers/bus/fsl-mc/fsl-mc-bus.c     | 7 ++-----
 drivers/bus/fsl-mc/fsl-mc-private.h | 6 ------
 include/linux/fsl/mc.h              | 8 ++++++++
 3 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/drivers/bus/fsl-mc/fsl-mc-bus.c b/drivers/bus/fsl-mc/fsl-mc-bus.c
index 9a884936e53e..1bb70a92167e 100644
--- a/drivers/bus/fsl-mc/fsl-mc-bus.c
+++ b/drivers/bus/fsl-mc/fsl-mc-bus.c
@@ -615,11 +615,8 @@ static int fsl_mc_device_get_mmio_regions(struct fsl_mc_device *mc_dev,
 
 		regions[i].end = regions[i].start + region_desc.size - 1;
 		regions[i].name = "fsl-mc object MMIO region";
-		regions[i].flags = IORESOURCE_IO;
-		if (region_desc.flags & DPRC_REGION_CACHEABLE)
-			regions[i].flags |= IORESOURCE_CACHEABLE;
-		if (region_desc.flags & DPRC_REGION_SHAREABLE)
-			regions[i].flags |= IORESOURCE_MEM;
+		regions[i].flags = region_desc.flags & IORESOURCE_BITS;
+		regions[i].flags |= IORESOURCE_MEM;
 	}
 
 	mc_dev->regions = regions;
diff --git a/drivers/bus/fsl-mc/fsl-mc-private.h b/drivers/bus/fsl-mc/fsl-mc-private.h
index 7a46a12eb747..9f200731b274 100644
--- a/drivers/bus/fsl-mc/fsl-mc-private.h
+++ b/drivers/bus/fsl-mc/fsl-mc-private.h
@@ -358,12 +358,6 @@ int dprc_set_obj_irq(struct fsl_mc_io *mc_io,
 		     int obj_id,
 		     u8 irq_index,
 		     struct dprc_irq_cfg *irq_cfg);
-
-/* Region flags */
-/* Cacheable - Indicates that region should be mapped as cacheable */
-#define DPRC_REGION_CACHEABLE	0x00000001
-#define DPRC_REGION_SHAREABLE	0x00000002
-
 /**
  * enum dprc_region_type - Region type
  * @DPRC_REGION_TYPE_MC_PORTAL: MC portal region
diff --git a/include/linux/fsl/mc.h b/include/linux/fsl/mc.h
index 3b5f0c98636d..03a5d16dde73 100644
--- a/include/linux/fsl/mc.h
+++ b/include/linux/fsl/mc.h
@@ -3,6 +3,7 @@
  * Freescale Management Complex (MC) bus public interface
  *
  * Copyright (C) 2014-2016 Freescale Semiconductor, Inc.
+ * Copyright 2019-2020 NXP
  * Author: German Rivera <German.Rivera@freescale.com>
  *
  */
@@ -148,6 +149,13 @@ struct fsl_mc_obj_desc {
  */
 #define FSL_MC_IS_DPRC	0x0001
 
+/* Region flags */
+/* Indicates that region can be mapped as cacheable */
+#define FSL_MC_REGION_CACHEABLE	0x00000001
+
+/* Indicates that region can be mapped as shareable */
+#define FSL_MC_REGION_SHAREABLE	0x00000002
+
 /**
  * struct fsl_mc_device - MC object device object
  * @dev: Linux driver model device object
-- 
2.17.1

