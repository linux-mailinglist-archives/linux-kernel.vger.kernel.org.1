Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2E942B9729
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 17:02:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729052AbgKSPzs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 10:55:48 -0500
Received: from mga02.intel.com ([134.134.136.20]:65086 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728978AbgKSPz3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 10:55:29 -0500
IronPort-SDR: yrDgdPmheLt/Q7wjkmksXN1LyZQdBgUj0jtOAFs9YyPozIz3dQxlDElAWGJRZ9m1zfAuWv97xn
 PbqDRAd9VzeQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9809"; a="158342915"
X-IronPort-AV: E=Sophos;i="5.78,490,1599548400"; 
   d="scan'208";a="158342915"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2020 07:55:28 -0800
IronPort-SDR: wjBDfLOZkffhE0pr8pS3fFoebc5SQpo9q1kltCBcUgokdYxi3UI50CLGE36j51D9o2R3HUqeQd
 93GrZf6eo7IA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,490,1599548400"; 
   d="scan'208";a="533220952"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga006.fm.intel.com with ESMTP; 19 Nov 2020 07:55:27 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id F2FD74FF; Thu, 19 Nov 2020 17:55:23 +0200 (EET)
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     Yehezkel Bernat <YehezkelShB@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Andreas Noever <andreas.noever@gmail.com>,
        Lukas Wunner <lukas@wunner.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH 06/12] thunderbolt: Perform USB4 router NVM upgrade in two phases
Date:   Thu, 19 Nov 2020 18:55:17 +0300
Message-Id: <20201119155523.41332-7-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201119155523.41332-1-mika.westerberg@linux.intel.com>
References: <20201119155523.41332-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The currect code expects that the router returns back the status of the
NVM authentication immediately. When tested against a real USB4 device
what happens is that the router is reset and only after that the result
is updated in the ROUTER_CS_26 register status field. This also seems to
align better what the spec suggests.

For this reason do the same what we already do with the Thunderbolt 3
devices and perform the NVM upgrade in two phases. First start the
NVM_AUTH router operation and once the router is added back after the
reset read the status in ROUTER_CS_26 and expose it to the userspace
accordingly.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/thunderbolt/switch.c  | 20 ++++++++--
 drivers/thunderbolt/tb.h      |  1 +
 drivers/thunderbolt/tb_regs.h |  1 +
 drivers/thunderbolt/usb4.c    | 75 +++++++++++++++++++++++++++--------
 4 files changed, 77 insertions(+), 20 deletions(-)

diff --git a/drivers/thunderbolt/switch.c b/drivers/thunderbolt/switch.c
index cdfd8cccfe19..a8572f49d3ad 100644
--- a/drivers/thunderbolt/switch.c
+++ b/drivers/thunderbolt/switch.c
@@ -2160,6 +2160,7 @@ static int tb_switch_add_dma_port(struct tb_switch *sw)
 
 		fallthrough;
 	case 3:
+	case 4:
 		ret = tb_switch_set_uuid(sw);
 		if (ret)
 			return ret;
@@ -2175,6 +2176,22 @@ static int tb_switch_add_dma_port(struct tb_switch *sw)
 		break;
 	}
 
+	if (sw->no_nvm_upgrade)
+		return 0;
+
+	if (tb_switch_is_usb4(sw)) {
+		ret = usb4_switch_nvm_authenticate_status(sw, &status);
+		if (ret)
+			return ret;
+
+		if (status) {
+			tb_sw_info(sw, "switch flash authentication failed\n");
+			nvm_set_auth_status(sw, status);
+		}
+
+		return 0;
+	}
+
 	/* Root switch DMA port requires running firmware */
 	if (!tb_route(sw) && !tb_switch_is_icm(sw))
 		return 0;
@@ -2183,9 +2200,6 @@ static int tb_switch_add_dma_port(struct tb_switch *sw)
 	if (!sw->dma_port)
 		return 0;
 
-	if (sw->no_nvm_upgrade)
-		return 0;
-
 	/*
 	 * If there is status already set then authentication failed
 	 * when the dma_port_flash_update_auth() returned. Power cycling
diff --git a/drivers/thunderbolt/tb.h b/drivers/thunderbolt/tb.h
index a21000649009..3885f2515aae 100644
--- a/drivers/thunderbolt/tb.h
+++ b/drivers/thunderbolt/tb.h
@@ -972,6 +972,7 @@ int usb4_switch_nvm_read(struct tb_switch *sw, unsigned int address, void *buf,
 int usb4_switch_nvm_write(struct tb_switch *sw, unsigned int address,
 			  const void *buf, size_t size);
 int usb4_switch_nvm_authenticate(struct tb_switch *sw);
+int usb4_switch_nvm_authenticate_status(struct tb_switch *sw, u32 *status);
 bool usb4_switch_query_dp_resource(struct tb_switch *sw, struct tb_port *in);
 int usb4_switch_alloc_dp_resource(struct tb_switch *sw, struct tb_port *in);
 int usb4_switch_dealloc_dp_resource(struct tb_switch *sw, struct tb_port *in);
diff --git a/drivers/thunderbolt/tb_regs.h b/drivers/thunderbolt/tb_regs.h
index e7d9529822fa..67cb173a2f8e 100644
--- a/drivers/thunderbolt/tb_regs.h
+++ b/drivers/thunderbolt/tb_regs.h
@@ -211,6 +211,7 @@ struct tb_regs_switch_header {
 #define ROUTER_CS_9				0x09
 #define ROUTER_CS_25				0x19
 #define ROUTER_CS_26				0x1a
+#define ROUTER_CS_26_OPCODE_MASK		GENMASK(15, 0)
 #define ROUTER_CS_26_STATUS_MASK		GENMASK(29, 24)
 #define ROUTER_CS_26_STATUS_SHIFT		24
 #define ROUTER_CS_26_ONS			BIT(30)
diff --git a/drivers/thunderbolt/usb4.c b/drivers/thunderbolt/usb4.c
index 40f13579a3fe..d88e28eee975 100644
--- a/drivers/thunderbolt/usb4.c
+++ b/drivers/thunderbolt/usb4.c
@@ -192,7 +192,9 @@ static int usb4_switch_op(struct tb_switch *sw, u16 opcode, u8 *status)
 	if (val & ROUTER_CS_26_ONS)
 		return -EOPNOTSUPP;
 
-	*status = (val & ROUTER_CS_26_STATUS_MASK) >> ROUTER_CS_26_STATUS_SHIFT;
+	if (status)
+		*status = (val & ROUTER_CS_26_STATUS_MASK) >>
+			ROUTER_CS_26_STATUS_SHIFT;
 	return 0;
 }
 
@@ -634,32 +636,71 @@ int usb4_switch_nvm_write(struct tb_switch *sw, unsigned int address,
  * @sw: USB4 router
  *
  * After the new NVM has been written via usb4_switch_nvm_write(), this
- * function triggers NVM authentication process. If the authentication
- * is successful the router is power cycled and the new NVM starts
+ * function triggers NVM authentication process. The router gets power
+ * cycled and if the authentication is successful the new NVM starts
  * running. In case of failure returns negative errno.
+ *
+ * The caller should call usb4_switch_nvm_authenticate_status() to read
+ * the status of the authentication after power cycle. It should be the
+ * first router operation to avoid the status being lost.
  */
 int usb4_switch_nvm_authenticate(struct tb_switch *sw)
 {
-	u8 status = 0;
 	int ret;
 
-	ret = usb4_switch_op(sw, USB4_SWITCH_OP_NVM_AUTH, &status);
+	ret = usb4_switch_op(sw, USB4_SWITCH_OP_NVM_AUTH, NULL);
+	switch (ret) {
+	/*
+	 * The router is power cycled once NVM_AUTH is started so it is
+	 * expected to get any of the following errors back.
+	 */
+	case -EACCES:
+	case -ENOTCONN:
+	case -ETIMEDOUT:
+		return 0;
+
+	default:
+		return ret;
+	}
+}
+
+/**
+ * usb4_switch_nvm_authenticate_status() - Read status of last NVM authenticate
+ * @sw: USB4 router
+ * @status: Status code of the operation
+ *
+ * The function checks if there is status available from the last NVM
+ * authenticate router operation. If there is status then %0 is returned
+ * and the status code is placed in @status. Returns negative errno in case
+ * of failure.
+ *
+ * Must be called before any other router operation.
+ */
+int usb4_switch_nvm_authenticate_status(struct tb_switch *sw, u32 *status)
+{
+	u16 opcode;
+	u32 val;
+	int ret;
+
+	ret = tb_sw_read(sw, &val, TB_CFG_SWITCH, ROUTER_CS_26, 1);
 	if (ret)
 		return ret;
 
-	switch (status) {
-	case 0x0:
-		tb_sw_dbg(sw, "NVM authentication successful\n");
-		return 0;
-	case 0x1:
-		return -EINVAL;
-	case 0x2:
-		return -EAGAIN;
-	case 0x3:
-		return -EOPNOTSUPP;
-	default:
-		return -EIO;
+	/* Check that the opcode is correct */
+	opcode = val & ROUTER_CS_26_OPCODE_MASK;
+	if (opcode == USB4_SWITCH_OP_NVM_AUTH) {
+		if (val & ROUTER_CS_26_OV)
+			return -EBUSY;
+		if (val & ROUTER_CS_26_ONS)
+			return -EOPNOTSUPP;
+
+		*status = (val & ROUTER_CS_26_STATUS_MASK) >>
+			ROUTER_CS_26_STATUS_SHIFT;
+	} else {
+		*status = 0;
 	}
+
+	return 0;
 }
 
 /**
-- 
2.29.2

