Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16B712B9723
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 17:02:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729001AbgKSPzc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 10:55:32 -0500
Received: from mga11.intel.com ([192.55.52.93]:44831 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728979AbgKSPza (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 10:55:30 -0500
IronPort-SDR: 3umBE1YTtILOX2YpyMP/6SO5mcTjz4D9iPdQa1b2lKoHewj4Gvwls/VFavO7Y1yxtQaUvd47Uq
 sYChQJSQrzaw==
X-IronPort-AV: E=McAfee;i="6000,8403,9809"; a="167799005"
X-IronPort-AV: E=Sophos;i="5.78,490,1599548400"; 
   d="scan'208";a="167799005"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2020 07:55:29 -0800
IronPort-SDR: wO//GlWhIEhf7xdWhI40dRRXF+YFbqudb328W9psRuRZSDC81V6VOCTeOhpLobaeZTY2nd0Z/y
 Ywr55FBa2pcg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,490,1599548400"; 
   d="scan'208";a="534823252"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 19 Nov 2020 07:55:27 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 20649642; Thu, 19 Nov 2020 17:55:24 +0200 (EET)
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     Yehezkel Bernat <YehezkelShB@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Andreas Noever <andreas.noever@gmail.com>,
        Lukas Wunner <lukas@wunner.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH 09/12] thunderbolt: Add connection manager specific hooks for USB4 router operations
Date:   Thu, 19 Nov 2020 18:55:20 +0300
Message-Id: <20201119155523.41332-10-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201119155523.41332-1-mika.westerberg@linux.intel.com>
References: <20201119155523.41332-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Intel USB4 host routers that run the firmware based connection manager
(ICM) may implement a proxy for USB4 router operations. This is to avoid
the firmware to race with the OS driver, as both may need to run these
operations.

This adds two new connection manager specific callbacks which, if
provided, get called instead of the native USB4 router operation.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/thunderbolt/tb.h   | 13 ++++++++++
 drivers/thunderbolt/usb4.c | 50 +++++++++++++++++++++++++++++++++-----
 2 files changed, 57 insertions(+), 6 deletions(-)

diff --git a/drivers/thunderbolt/tb.h b/drivers/thunderbolt/tb.h
index 3885f2515aae..d19dbc8e9457 100644
--- a/drivers/thunderbolt/tb.h
+++ b/drivers/thunderbolt/tb.h
@@ -367,6 +367,14 @@ struct tb_path {
  * @disconnect_pcie_paths: Disconnects PCIe paths before NVM update
  * @approve_xdomain_paths: Approve (establish) XDomain DMA paths
  * @disconnect_xdomain_paths: Disconnect XDomain DMA paths
+ * @usb4_switch_op: Optional proxy for USB4 router operations. If set
+ *		    this will be called whenever USB4 router operation is
+ *		    performed. If this returns %-EOPNOTSUPP then the
+ *		    native USB4 router operation is called.
+ * @usb4_switch_nvm_authenticate_status: Optional callback that the CM
+ *					 implementation can be used to
+ *					 return status of USB4 NVM_AUTH
+ *					 router operation.
  */
 struct tb_cm_ops {
 	int (*driver_ready)(struct tb *tb);
@@ -393,6 +401,11 @@ struct tb_cm_ops {
 	int (*disconnect_pcie_paths)(struct tb *tb);
 	int (*approve_xdomain_paths)(struct tb *tb, struct tb_xdomain *xd);
 	int (*disconnect_xdomain_paths)(struct tb *tb, struct tb_xdomain *xd);
+	int (*usb4_switch_op)(struct tb_switch *sw, u16 opcode, u32 *metadata,
+			      u8 *status, const void *tx_data, size_t tx_data_len,
+			      void *rx_data, size_t rx_data_len);
+	int (*usb4_switch_nvm_authenticate_status)(struct tb_switch *sw,
+						   u32 *status);
 };
 
 static inline void *tb_priv(struct tb *tb)
diff --git a/drivers/thunderbolt/usb4.c b/drivers/thunderbolt/usb4.c
index c1bb5ec6e1db..cbf1c0536360 100644
--- a/drivers/thunderbolt/usb4.c
+++ b/drivers/thunderbolt/usb4.c
@@ -143,16 +143,14 @@ static int usb4_do_write_data(unsigned int address, const void *buf, size_t size
 	return 0;
 }
 
-static int __usb4_switch_op(struct tb_switch *sw, u16 opcode, u32 *metadata,
-			    u8 *status, const void *tx_data, size_t tx_dwords,
-			    void *rx_data, size_t rx_dwords)
+static int usb4_native_switch_op(struct tb_switch *sw, u16 opcode,
+				 u32 *metadata, u8 *status,
+				 const void *tx_data, size_t tx_dwords,
+				 void *rx_data, size_t rx_dwords)
 {
 	u32 val;
 	int ret;
 
-	if (tx_dwords > USB4_DATA_DWORDS || rx_dwords > USB4_DATA_DWORDS)
-		return -EINVAL;
-
 	if (metadata) {
 		ret = tb_sw_write(sw, metadata, TB_CFG_SWITCH, ROUTER_CS_25, 1);
 		if (ret)
@@ -200,6 +198,39 @@ static int __usb4_switch_op(struct tb_switch *sw, u16 opcode, u32 *metadata,
 	return 0;
 }
 
+static int __usb4_switch_op(struct tb_switch *sw, u16 opcode, u32 *metadata,
+			    u8 *status, const void *tx_data, size_t tx_dwords,
+			    void *rx_data, size_t rx_dwords)
+{
+	const struct tb_cm_ops *cm_ops = sw->tb->cm_ops;
+
+	if (tx_dwords > USB4_DATA_DWORDS || rx_dwords > USB4_DATA_DWORDS)
+		return -EINVAL;
+
+	/*
+	 * If the connection manager implementation provides USB4 router
+	 * operation proxy callback, call it here instead of running the
+	 * operation natively.
+	 */
+	if (cm_ops->usb4_switch_op) {
+		int ret;
+
+		ret = cm_ops->usb4_switch_op(sw, opcode, metadata, status,
+					     tx_data, tx_dwords, rx_data,
+					     rx_dwords);
+		if (ret != -EOPNOTSUPP)
+			return ret;
+
+		/*
+		 * If the proxy was not supported then run the native
+		 * router operation instead.
+		 */
+	}
+
+	return usb4_native_switch_op(sw, opcode, metadata, status, tx_data,
+				     tx_dwords, rx_data, rx_dwords);
+}
+
 static inline int usb4_switch_op(struct tb_switch *sw, u16 opcode,
 				 u32 *metadata, u8 *status)
 {
@@ -674,10 +705,17 @@ int usb4_switch_nvm_authenticate(struct tb_switch *sw)
  */
 int usb4_switch_nvm_authenticate_status(struct tb_switch *sw, u32 *status)
 {
+	const struct tb_cm_ops *cm_ops = sw->tb->cm_ops;
 	u16 opcode;
 	u32 val;
 	int ret;
 
+	if (cm_ops->usb4_switch_nvm_authenticate_status) {
+		ret = cm_ops->usb4_switch_nvm_authenticate_status(sw, status);
+		if (ret != -EOPNOTSUPP)
+			return ret;
+	}
+
 	ret = tb_sw_read(sw, &val, TB_CFG_SWITCH, ROUTER_CS_26, 1);
 	if (ret)
 		return ret;
-- 
2.29.2

