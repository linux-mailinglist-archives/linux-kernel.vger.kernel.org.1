Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB78127C029
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 10:55:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727959AbgI2Izn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 04:55:43 -0400
Received: from inva021.nxp.com ([92.121.34.21]:53878 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727781AbgI2IzI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 04:55:08 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 4999220117A;
        Tue, 29 Sep 2020 10:55:07 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 3CDC12015EB;
        Tue, 29 Sep 2020 10:55:07 +0200 (CEST)
Received: from fsr-ub1864-111.ea.freescale.net (fsr-ub1864-111.ea.freescale.net [10.171.82.141])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id D63CF2032C;
        Tue, 29 Sep 2020 10:55:06 +0200 (CEST)
From:   Diana Craciun <diana.craciun@oss.nxp.com>
To:     linux-kernel@vger.kernel.org, laurentiu.tudor@nxp.com
Cc:     stuyoder@gmail.com, leoyang.li@nxp.com, gregkh@linuxfoundation.org,
        linux-arm-kernel@lists.infradead.org,
        Bharat Bhushan <Bharat.Bhushan@nxp.com>,
        Diana Craciun <diana.craciun@oss.nxp.com>
Subject: [PATCH v5 06/13] bus/fsl-mc: Add dprc-reset-container support
Date:   Tue, 29 Sep 2020 11:54:34 +0300
Message-Id: <20200929085441.17448-7-diana.craciun@oss.nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200929085441.17448-1-diana.craciun@oss.nxp.com>
References: <20200929085441.17448-1-diana.craciun@oss.nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bharat Bhushan <Bharat.Bhushan@nxp.com>

DPRC reset is required by VFIO-mc in order to stop a device
to further generate DMA transactions.

Signed-off-by: Bharat Bhushan <Bharat.Bhushan@nxp.com>
Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
Signed-off-by: Diana Craciun <diana.craciun@oss.nxp.com>
---
 drivers/bus/fsl-mc/dprc.c           | 71 +++++++++++++++++++++++++++++
 drivers/bus/fsl-mc/fsl-mc-private.h |  7 +++
 include/linux/fsl/mc.h              |  7 +++
 3 files changed, 85 insertions(+)

diff --git a/drivers/bus/fsl-mc/dprc.c b/drivers/bus/fsl-mc/dprc.c
index e76f2c76f4c8..2448a723eb28 100644
--- a/drivers/bus/fsl-mc/dprc.c
+++ b/drivers/bus/fsl-mc/dprc.c
@@ -80,6 +80,77 @@ int dprc_close(struct fsl_mc_io *mc_io,
 }
 EXPORT_SYMBOL_GPL(dprc_close);
 
+/**
+ * dprc_reset_container - Reset child container.
+ * @mc_io:	Pointer to MC portal's I/O object
+ * @cmd_flags:	Command flags; one or more of 'MC_CMD_FLAG_'
+ * @token:	Token of DPRC object
+ * @child_container_id:	ID of the container to reset
+ * @options: 32 bit options:
+ *   - 0 (no bits set) - all the objects inside the container are
+ *     reset. The child containers are entered recursively and the
+ *     objects reset. All the objects (including the child containers)
+ *     are closed.
+ *   - bit 0 set - all the objects inside the container are reset.
+ *     However the child containers are not entered recursively.
+ *     This option is supported for API versions >= 6.5
+ * In case a software context crashes or becomes non-responsive, the parent
+ * may wish to reset its resources container before the software context is
+ * restarted.
+ *
+ * This routine informs all objects assigned to the child container that the
+ * container is being reset, so they may perform any cleanup operations that are
+ * needed. All objects handles that were owned by the child container shall be
+ * closed.
+ *
+ * Note that such request may be submitted even if the child software context
+ * has not crashed, but the resulting object cleanup operations will not be
+ * aware of that.
+ *
+ * Return:	'0' on Success; Error code otherwise.
+ */
+int dprc_reset_container(struct fsl_mc_io *mc_io,
+			 u32 cmd_flags,
+			 u16 token,
+			 int child_container_id,
+			 u32 options)
+{
+	struct fsl_mc_command cmd = { 0 };
+	struct dprc_cmd_reset_container *cmd_params;
+	u32 cmdid = DPRC_CMDID_RESET_CONT;
+	int err;
+
+	/*
+	 * If the DPRC object version was not yet cached, cache it now.
+	 * Otherwise use the already cached value.
+	 */
+	if (!dprc_major_ver && !dprc_minor_ver) {
+		err = dprc_get_api_version(mc_io, 0,
+				&dprc_major_ver,
+				&dprc_minor_ver);
+		if (err)
+			return err;
+	}
+
+	/*
+	 * MC API 6.5 introduced a new field in the command used to pass
+	 * some flags.
+	 * Bit 0 indicates that the child containers are not recursively reset.
+	 */
+	if (dprc_major_ver > 6 || (dprc_major_ver == 6 && dprc_minor_ver >= 5))
+		cmdid = DPRC_CMDID_RESET_CONT_V2;
+
+	/* prepare command */
+	cmd.header = mc_encode_cmd_header(cmdid, cmd_flags, token);
+	cmd_params = (struct dprc_cmd_reset_container *)cmd.params;
+	cmd_params->child_container_id = cpu_to_le32(child_container_id);
+	cmd_params->options = cpu_to_le32(options);
+
+	/* send command to mc*/
+	return mc_send_command(mc_io, &cmd);
+}
+EXPORT_SYMBOL_GPL(dprc_reset_container);
+
 /**
  * dprc_set_irq() - Set IRQ information for the DPRC to trigger an interrupt.
  * @mc_io:	Pointer to MC portal's I/O object
diff --git a/drivers/bus/fsl-mc/fsl-mc-private.h b/drivers/bus/fsl-mc/fsl-mc-private.h
index 9f200731b274..5f7e762d517c 100644
--- a/drivers/bus/fsl-mc/fsl-mc-private.h
+++ b/drivers/bus/fsl-mc/fsl-mc-private.h
@@ -91,6 +91,8 @@ int dpmcp_reset(struct fsl_mc_io *mc_io,
 #define DPRC_CMDID_GET_API_VERSION              DPRC_CMD(0xa05)
 
 #define DPRC_CMDID_GET_ATTR                     DPRC_CMD(0x004)
+#define DPRC_CMDID_RESET_CONT                   DPRC_CMD(0x005)
+#define DPRC_CMDID_RESET_CONT_V2                DPRC_CMD_V2(0x005)
 
 #define DPRC_CMDID_SET_IRQ                      DPRC_CMD(0x010)
 #define DPRC_CMDID_SET_IRQ_ENABLE               DPRC_CMD(0x012)
@@ -111,6 +113,11 @@ struct dprc_cmd_open {
 	__le32 container_id;
 };
 
+struct dprc_cmd_reset_container {
+	__le32 child_container_id;
+	__le32 options;
+};
+
 struct dprc_cmd_set_irq {
 	/* cmd word 0 */
 	__le32 irq_val;
diff --git a/include/linux/fsl/mc.h b/include/linux/fsl/mc.h
index 03a5d16dde73..1d8800acf21f 100644
--- a/include/linux/fsl/mc.h
+++ b/include/linux/fsl/mc.h
@@ -524,6 +524,13 @@ static inline bool is_fsl_mc_bus_dpdmai(const struct fsl_mc_device *mc_dev)
 	return mc_dev->dev.type == &fsl_mc_bus_dpdmai_type;
 }
 
+#define DPRC_RESET_OPTION_NON_RECURSIVE                0x00000001
+int dprc_reset_container(struct fsl_mc_io *mc_io,
+			 u32 cmd_flags,
+			 u16 token,
+			 int child_container_id,
+			 u32 options);
+
 /*
  * Data Path Buffer Pool (DPBP) API
  * Contains initialization APIs and runtime control APIs for DPBP
-- 
2.17.1

