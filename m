Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92BC92B9722
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 17:02:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728991AbgKSPzb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 10:55:31 -0500
Received: from mga07.intel.com ([134.134.136.100]:7609 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728983AbgKSPza (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 10:55:30 -0500
IronPort-SDR: TCwrgn92/s0LUsFxOVbN/QHHz0SlFr53Jp+mwrsHstNI6f4tPwQnBlauWfvAbE1LXX3jyWNnYN
 KtR4owDSkV4Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9809"; a="235458413"
X-IronPort-AV: E=Sophos;i="5.78,490,1599548400"; 
   d="scan'208";a="235458413"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2020 07:55:29 -0800
IronPort-SDR: Zpy+pWEg2XsVolh32UMfqxRbedlNZHBKK3TqTVKoVNk0WcURBmM05DvPCblLIBwxd4AcX9lfxj
 PU0MI4W9mnLw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,490,1599548400"; 
   d="scan'208";a="357415203"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga008.jf.intel.com with ESMTP; 19 Nov 2020 07:55:27 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 156F65EF; Thu, 19 Nov 2020 17:55:24 +0200 (EET)
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     Yehezkel Bernat <YehezkelShB@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Andreas Noever <andreas.noever@gmail.com>,
        Lukas Wunner <lukas@wunner.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH 08/12] thunderbolt: Pass TX and RX data directly to usb4_switch_op()
Date:   Thu, 19 Nov 2020 18:55:19 +0300
Message-Id: <20201119155523.41332-9-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201119155523.41332-1-mika.westerberg@linux.intel.com>
References: <20201119155523.41332-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We are going to make usb4_switch_op() to match better the corresponding
firmware (ICM) USB4 router operation proxy interface, so that we can use
either based on the connection manager implementation.

For this reason rename usb4_switch_op() to __usb4_switch_op() that
provides the most complete interface. Then make usb4_switch_op() and
usb4_switch_op_data() call it with correct set of parameters and update
the callers accordingly.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/thunderbolt/usb4.c | 85 +++++++++++++++++++++-----------------
 1 file changed, 48 insertions(+), 37 deletions(-)

diff --git a/drivers/thunderbolt/usb4.c b/drivers/thunderbolt/usb4.c
index 5f3237d66987..c1bb5ec6e1db 100644
--- a/drivers/thunderbolt/usb4.c
+++ b/drivers/thunderbolt/usb4.c
@@ -74,24 +74,6 @@ static int usb4_switch_wait_for_bit(struct tb_switch *sw, u32 offset, u32 bit,
 	return -ETIMEDOUT;
 }
 
-static int usb4_switch_op_read_data(struct tb_switch *sw, void *data,
-				    size_t dwords)
-{
-	if (dwords > USB4_DATA_DWORDS)
-		return -EINVAL;
-
-	return tb_sw_read(sw, data, TB_CFG_SWITCH, ROUTER_CS_9, dwords);
-}
-
-static int usb4_switch_op_write_data(struct tb_switch *sw, const void *data,
-				     size_t dwords)
-{
-	if (dwords > USB4_DATA_DWORDS)
-		return -EINVAL;
-
-	return tb_sw_write(sw, data, TB_CFG_SWITCH, ROUTER_CS_9, dwords);
-}
-
 static int usb4_do_read_data(u16 address, void *buf, size_t size,
 			     read_block_fn read_block, void *read_block_data)
 {
@@ -161,17 +143,27 @@ static int usb4_do_write_data(unsigned int address, const void *buf, size_t size
 	return 0;
 }
 
-static int usb4_switch_op(struct tb_switch *sw, u16 opcode, u32 *metadata,
-			  u8 *status)
+static int __usb4_switch_op(struct tb_switch *sw, u16 opcode, u32 *metadata,
+			    u8 *status, const void *tx_data, size_t tx_dwords,
+			    void *rx_data, size_t rx_dwords)
 {
 	u32 val;
 	int ret;
 
+	if (tx_dwords > USB4_DATA_DWORDS || rx_dwords > USB4_DATA_DWORDS)
+		return -EINVAL;
+
 	if (metadata) {
 		ret = tb_sw_write(sw, metadata, TB_CFG_SWITCH, ROUTER_CS_25, 1);
 		if (ret)
 			return ret;
 	}
+	if (tx_dwords) {
+		ret = tb_sw_write(sw, tx_data, TB_CFG_SWITCH, ROUTER_CS_9,
+				  tx_dwords);
+		if (ret)
+			return ret;
+	}
 
 	val = opcode | ROUTER_CS_26_OV;
 	ret = tb_sw_write(sw, &val, TB_CFG_SWITCH, ROUTER_CS_26, 1);
@@ -193,8 +185,34 @@ static int usb4_switch_op(struct tb_switch *sw, u16 opcode, u32 *metadata,
 		*status = (val & ROUTER_CS_26_STATUS_MASK) >>
 			ROUTER_CS_26_STATUS_SHIFT;
 
-	return metadata ?
-		tb_sw_read(sw, metadata, TB_CFG_SWITCH, ROUTER_CS_25, 1) : 0;
+	if (metadata) {
+		ret = tb_sw_read(sw, metadata, TB_CFG_SWITCH, ROUTER_CS_25, 1);
+		if (ret)
+			return ret;
+	}
+	if (rx_dwords) {
+		ret = tb_sw_read(sw, rx_data, TB_CFG_SWITCH, ROUTER_CS_9,
+				 rx_dwords);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static inline int usb4_switch_op(struct tb_switch *sw, u16 opcode,
+				 u32 *metadata, u8 *status)
+{
+	return __usb4_switch_op(sw, opcode, metadata, status, NULL, 0, NULL, 0);
+}
+
+static inline int usb4_switch_op_data(struct tb_switch *sw, u16 opcode,
+				      u32 *metadata, u8 *status,
+				      const void *tx_data, size_t tx_dwords,
+				      void *rx_data, size_t rx_dwords)
+{
+	return __usb4_switch_op(sw, opcode, metadata, status, tx_data,
+				tx_dwords, rx_data, rx_dwords);
 }
 
 static void usb4_switch_check_wakes(struct tb_switch *sw)
@@ -349,14 +367,12 @@ static int usb4_switch_drom_read_block(void *data,
 	metadata |= (dwaddress << USB4_DROM_ADDRESS_SHIFT) &
 		USB4_DROM_ADDRESS_MASK;
 
-	ret = usb4_switch_op(sw, USB4_SWITCH_OP_DROM_READ, &metadata, &status);
+	ret = usb4_switch_op_data(sw, USB4_SWITCH_OP_DROM_READ, &metadata,
+				  &status, NULL, 0, buf, dwords);
 	if (ret)
 		return ret;
 
-	if (status)
-		return -EIO;
-
-	return usb4_switch_op_read_data(sw, buf, dwords);
+	return status ? -EIO : 0;
 }
 
 /**
@@ -529,14 +545,12 @@ static int usb4_switch_nvm_read_block(void *data,
 	metadata |= (dwaddress << USB4_NVM_READ_OFFSET_SHIFT) &
 		   USB4_NVM_READ_OFFSET_MASK;
 
-	ret = usb4_switch_op(sw, USB4_SWITCH_OP_NVM_READ, &metadata, &status);
+	ret = usb4_switch_op_data(sw, USB4_SWITCH_OP_NVM_READ, &metadata,
+				  &status, NULL, 0, buf, dwords);
 	if (ret)
 		return ret;
 
-	if (status)
-		return -EIO;
-
-	return usb4_switch_op_read_data(sw, buf, dwords);
+	return status ? -EIO : 0;
 }
 
 /**
@@ -582,11 +596,8 @@ static int usb4_switch_nvm_write_next_block(void *data, const void *buf,
 	u8 status;
 	int ret;
 
-	ret = usb4_switch_op_write_data(sw, buf, dwords);
-	if (ret)
-		return ret;
-
-	ret = usb4_switch_op(sw, USB4_SWITCH_OP_NVM_WRITE, NULL, &status);
+	ret = usb4_switch_op_data(sw, USB4_SWITCH_OP_NVM_WRITE, NULL, &status,
+				  buf, dwords, NULL, 0);
 	if (ret)
 		return ret;
 
-- 
2.29.2

