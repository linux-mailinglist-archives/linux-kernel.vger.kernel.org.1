Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 351DF27C02A
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 10:55:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727945AbgI2Izl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 04:55:41 -0400
Received: from inva021.nxp.com ([92.121.34.21]:53832 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727766AbgI2IzI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 04:55:08 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id D4F19201097;
        Tue, 29 Sep 2020 10:55:06 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id C5EC120117A;
        Tue, 29 Sep 2020 10:55:06 +0200 (CEST)
Received: from fsr-ub1864-111.ea.freescale.net (fsr-ub1864-111.ea.freescale.net [10.171.82.141])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 737D62032C;
        Tue, 29 Sep 2020 10:55:06 +0200 (CEST)
From:   Diana Craciun <diana.craciun@oss.nxp.com>
To:     linux-kernel@vger.kernel.org, laurentiu.tudor@nxp.com
Cc:     stuyoder@gmail.com, leoyang.li@nxp.com, gregkh@linuxfoundation.org,
        linux-arm-kernel@lists.infradead.org,
        Diana Craciun <diana.craciun@oss.nxp.com>
Subject: [PATCH v5 05/13] bus/fsl-mc: Cache the DPRC API version
Date:   Tue, 29 Sep 2020 11:54:33 +0300
Message-Id: <20200929085441.17448-6-diana.craciun@oss.nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200929085441.17448-1-diana.craciun@oss.nxp.com>
References: <20200929085441.17448-1-diana.craciun@oss.nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are already firmware API commands that have multiple
versions. For each multiple version command, another command
to retrieve the API version is issued. This may introduce an important
overhead. The version does not change while the system is running,
so the DPRC API version can be safely cached.

Signed-off-by: Diana Craciun <diana.craciun@oss.nxp.com>
---
 drivers/bus/fsl-mc/dprc.c | 30 +++++++++++++++++++++---------
 1 file changed, 21 insertions(+), 9 deletions(-)

diff --git a/drivers/bus/fsl-mc/dprc.c b/drivers/bus/fsl-mc/dprc.c
index 602f030d84eb..e76f2c76f4c8 100644
--- a/drivers/bus/fsl-mc/dprc.c
+++ b/drivers/bus/fsl-mc/dprc.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
 /*
  * Copyright 2013-2016 Freescale Semiconductor Inc.
+ * Copyright 2020 NXP
  *
  */
 #include <linux/kernel.h>
@@ -8,6 +9,13 @@
 
 #include "fsl-mc-private.h"
 
+/*
+ * cache the DPRC version to reduce the number of commands
+ * towards the mc firmware
+ */
+static u16 dprc_major_ver;
+static u16 dprc_minor_ver;
+
 /**
  * dprc_open() - Open DPRC object for use
  * @mc_io:	Pointer to MC portal's I/O object
@@ -443,15 +451,19 @@ int dprc_get_obj_region(struct fsl_mc_io *mc_io,
 	struct fsl_mc_command cmd = { 0 };
 	struct dprc_cmd_get_obj_region *cmd_params;
 	struct dprc_rsp_get_obj_region *rsp_params;
-	u16 major_ver, minor_ver;
 	int err;
 
-	/* prepare command */
-	err = dprc_get_api_version(mc_io, 0,
-				     &major_ver,
-				     &minor_ver);
-	if (err)
-		return err;
+    /*
+     * If the DPRC object version was not yet cached, cache it now.
+     * Otherwise use the already cached value.
+     */
+	if (!dprc_major_ver && !dprc_minor_ver) {
+		err = dprc_get_api_version(mc_io, 0,
+				      &dprc_major_ver,
+				      &dprc_minor_ver);
+		if (err)
+			return err;
+	}
 
 	/**
 	 * MC API version 6.3 introduced a new field to the region
@@ -459,7 +471,7 @@ int dprc_get_obj_region(struct fsl_mc_io *mc_io,
 	 * address is set to zero to indicate it needs to be obtained elsewhere
 	 * (typically the device tree).
 	 */
-	if (major_ver > 6 || (major_ver == 6 && minor_ver >= 3))
+	if (dprc_major_ver > 6 || (dprc_major_ver == 6 && dprc_minor_ver >= 3))
 		cmd.header =
 			mc_encode_cmd_header(DPRC_CMDID_GET_OBJ_REG_V2,
 					     cmd_flags, token);
@@ -483,7 +495,7 @@ int dprc_get_obj_region(struct fsl_mc_io *mc_io,
 	rsp_params = (struct dprc_rsp_get_obj_region *)cmd.params;
 	region_desc->base_offset = le64_to_cpu(rsp_params->base_offset);
 	region_desc->size = le32_to_cpu(rsp_params->size);
-	if (major_ver > 6 || (major_ver == 6 && minor_ver >= 3))
+	if (dprc_major_ver > 6 || (dprc_major_ver == 6 && dprc_minor_ver >= 3))
 		region_desc->base_address = le64_to_cpu(rsp_params->base_addr);
 	else
 		region_desc->base_address = 0;
-- 
2.17.1

