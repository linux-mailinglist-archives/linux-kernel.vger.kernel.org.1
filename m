Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC0C527C023
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 10:55:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727904AbgI2IzY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 04:55:24 -0400
Received: from inva020.nxp.com ([92.121.34.13]:59928 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727856AbgI2IzL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 04:55:11 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id C7BA71A124A;
        Tue, 29 Sep 2020 10:55:09 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id BAE1C1A1244;
        Tue, 29 Sep 2020 10:55:09 +0200 (CEST)
Received: from fsr-ub1864-111.ea.freescale.net (fsr-ub1864-111.ea.freescale.net [10.171.82.141])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 5FFE92032C;
        Tue, 29 Sep 2020 10:55:09 +0200 (CEST)
From:   Diana Craciun <diana.craciun@oss.nxp.com>
To:     linux-kernel@vger.kernel.org, laurentiu.tudor@nxp.com
Cc:     stuyoder@gmail.com, leoyang.li@nxp.com, gregkh@linuxfoundation.org,
        linux-arm-kernel@lists.infradead.org,
        Bharat Bhushan <Bharat.Bhushan@nxp.com>,
        Diana Craciun <diana.craciun@oss.nxp.com>
Subject: [PATCH v5 12/13] bus/fsl-mc: Extend ICID size from 16bit to 32bit
Date:   Tue, 29 Sep 2020 11:54:40 +0300
Message-Id: <20200929085441.17448-13-diana.craciun@oss.nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200929085441.17448-1-diana.craciun@oss.nxp.com>
References: <20200929085441.17448-1-diana.craciun@oss.nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bharat Bhushan <Bharat.Bhushan@nxp.com>

In virtual machines the device-id range is defined
between 0x10000-0x20000. The reason for using such a
large range is to avoid overlapping with the PCI range.

Signed-off-by: Bharat Bhushan <Bharat.Bhushan@nxp.com>
Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
Signed-off-by: Diana Craciun <diana.craciun@oss.nxp.com>
---
 drivers/bus/fsl-mc/dprc.c           | 2 +-
 drivers/bus/fsl-mc/fsl-mc-bus.c     | 2 +-
 drivers/bus/fsl-mc/fsl-mc-private.h | 5 ++---
 include/linux/fsl/mc.h              | 2 +-
 4 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/bus/fsl-mc/dprc.c b/drivers/bus/fsl-mc/dprc.c
index 2448a723eb28..650808799a29 100644
--- a/drivers/bus/fsl-mc/dprc.c
+++ b/drivers/bus/fsl-mc/dprc.c
@@ -360,7 +360,7 @@ int dprc_get_attributes(struct fsl_mc_io *mc_io,
 	/* retrieve response parameters */
 	rsp_params = (struct dprc_rsp_get_attributes *)cmd.params;
 	attr->container_id = le32_to_cpu(rsp_params->container_id);
-	attr->icid = le16_to_cpu(rsp_params->icid);
+	attr->icid = le32_to_cpu(rsp_params->icid);
 	attr->options = le32_to_cpu(rsp_params->options);
 	attr->portal_id = le32_to_cpu(rsp_params->portal_id);
 
diff --git a/drivers/bus/fsl-mc/fsl-mc-bus.c b/drivers/bus/fsl-mc/fsl-mc-bus.c
index 32f194814b08..d375bb585749 100644
--- a/drivers/bus/fsl-mc/fsl-mc-bus.c
+++ b/drivers/bus/fsl-mc/fsl-mc-bus.c
@@ -503,7 +503,7 @@ static int get_dprc_attr(struct fsl_mc_io *mc_io,
 }
 
 static int get_dprc_icid(struct fsl_mc_io *mc_io,
-			 int container_id, u16 *icid)
+			 int container_id, u32 *icid)
 {
 	struct dprc_attributes attr;
 	int error;
diff --git a/drivers/bus/fsl-mc/fsl-mc-private.h b/drivers/bus/fsl-mc/fsl-mc-private.h
index ffe709a3f0f8..3e9f9c778631 100644
--- a/drivers/bus/fsl-mc/fsl-mc-private.h
+++ b/drivers/bus/fsl-mc/fsl-mc-private.h
@@ -159,8 +159,7 @@ struct dprc_cmd_clear_irq_status {
 struct dprc_rsp_get_attributes {
 	/* response word 0 */
 	__le32 container_id;
-	__le16 icid;
-	__le16 pad;
+	__le32 icid;
 	/* response word 1 */
 	__le32 options;
 	__le32 portal_id;
@@ -337,7 +336,7 @@ int dprc_clear_irq_status(struct fsl_mc_io *mc_io,
  */
 struct dprc_attributes {
 	int container_id;
-	u16 icid;
+	u32 icid;
 	int portal_id;
 	u64 options;
 };
diff --git a/include/linux/fsl/mc.h b/include/linux/fsl/mc.h
index f791fe38c251..db244874e834 100644
--- a/include/linux/fsl/mc.h
+++ b/include/linux/fsl/mc.h
@@ -195,7 +195,7 @@ struct fsl_mc_device {
 	struct device dev;
 	u64 dma_mask;
 	u16 flags;
-	u16 icid;
+	u32 icid;
 	u16 mc_handle;
 	struct fsl_mc_io *mc_io;
 	struct fsl_mc_obj_desc obj_desc;
-- 
2.17.1

