Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAF7F28DC4A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 11:02:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727975AbgJNJCP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 05:02:15 -0400
Received: from inva021.nxp.com ([92.121.34.21]:37084 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726111AbgJNJCP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 05:02:15 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id DFCBA20034F;
        Wed, 14 Oct 2020 11:02:12 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id D1C74200271;
        Wed, 14 Oct 2020 11:02:08 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 8873240249;
        Wed, 14 Oct 2020 11:02:03 +0200 (CEST)
From:   Joakim Zhang <qiangqing.zhang@nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Liu Ying <victor.liu@nxp.com>, Peng Fan <peng.fan@nxp.com>,
        Joakim Zhang <qiangqing.zhang@nxp.com>
Subject: [PATCH] firmware: imx: always export scu symbols
Date:   Wed, 14 Oct 2020 16:57:14 +0800
Message-Id: <1602665834-29902-1-git-send-email-qiangqing.zhang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Liu Ying <victor.liu@nxp.com>

Always export scu symbols for both SCU SoCs and non-SCU SoCs to avoid
build error.

Signed-off-by: Liu Ying <victor.liu@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
---
 include/linux/firmware/imx/ipc.h      | 15 +++++++++++++++
 include/linux/firmware/imx/svc/misc.h | 23 +++++++++++++++++++++++
 2 files changed, 38 insertions(+)

diff --git a/include/linux/firmware/imx/ipc.h b/include/linux/firmware/imx/ipc.h
index 891057434858..300fa253fc30 100644
--- a/include/linux/firmware/imx/ipc.h
+++ b/include/linux/firmware/imx/ipc.h
@@ -34,6 +34,7 @@ struct imx_sc_rpc_msg {
 	uint8_t func;
 };
 
+#if IS_ENABLED(CONFIG_IMX_SCU)
 /*
  * This is an function to send an RPC message over an IPC channel.
  * It is called by client-side SCFW API function shims.
@@ -55,4 +56,18 @@ int imx_scu_call_rpc(struct imx_sc_ipc *ipc, void *msg, bool have_resp);
  * @return Returns an error code (0 = success, failed if < 0)
  */
 int imx_scu_get_handle(struct imx_sc_ipc **ipc);
+
+#else
+static inline int
+imx_scu_call_rpc(struct imx_sc_ipc *ipc, void *msg, bool have_resp)
+{
+	return -EIO;
+}
+
+static inline int imx_scu_get_handle(struct imx_sc_ipc **ipc)
+{
+	return -EIO;
+}
+#endif
+
 #endif /* _SC_IPC_H */
diff --git a/include/linux/firmware/imx/svc/misc.h b/include/linux/firmware/imx/svc/misc.h
index 031dd4d3c766..d255048f17de 100644
--- a/include/linux/firmware/imx/svc/misc.h
+++ b/include/linux/firmware/imx/svc/misc.h
@@ -46,6 +46,7 @@ enum imx_misc_func {
  * Control Functions
  */
 
+#if IS_ENABLED(CONFIG_IMX_SCU)
 int imx_sc_misc_set_control(struct imx_sc_ipc *ipc, u32 resource,
 			    u8 ctrl, u32 val);
 
@@ -55,4 +56,26 @@ int imx_sc_misc_get_control(struct imx_sc_ipc *ipc, u32 resource,
 int imx_sc_pm_cpu_start(struct imx_sc_ipc *ipc, u32 resource,
 			bool enable, u64 phys_addr);
 
+#else
+static inline int
+imx_sc_misc_set_control(struct imx_sc_ipc *ipc, u32 resource,
+			u8 ctrl, u32 val)
+{
+	return -EIO;
+}
+
+static inline int
+imx_sc_misc_get_control(struct imx_sc_ipc *ipc, u32 resource,
+			u8 ctrl, u32 *val)
+{
+	return -EIO;
+}
+
+static inline int imx_sc_pm_cpu_start(struct imx_sc_ipc *ipc, u32 resource,
+				      bool enable, u64 phys_addr)
+{
+	return -EIO;
+}
+#endif
+
 #endif /* _SC_MISC_API_H */
-- 
2.17.1

