Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 844752B9728
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 17:02:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729042AbgKSPzr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 10:55:47 -0500
Received: from mga14.intel.com ([192.55.52.115]:40299 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728977AbgKSPza (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 10:55:30 -0500
IronPort-SDR: WVngobTcoKgpt+1hh2hh22uk4nP7s3l4MqgnDICU6b368O7PpJWuzSlY6cFVluZGUVdipNdnrA
 1gkR+l/oI9aQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9809"; a="170527262"
X-IronPort-AV: E=Sophos;i="5.78,490,1599548400"; 
   d="scan'208";a="170527262"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2020 07:55:28 -0800
IronPort-SDR: 9XhocN6aeFPcnfxXG+7zGw8A0uYnrAaCjEeq2iBRj3w2KkFxhEruTBgHhwTSvYQ/8GzHtd8jl1
 rSBWzV0IIOuw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,490,1599548400"; 
   d="scan'208";a="360049791"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 19 Nov 2020 07:55:27 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 0A2455A7; Thu, 19 Nov 2020 17:55:24 +0200 (EET)
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     Yehezkel Bernat <YehezkelShB@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Andreas Noever <andreas.noever@gmail.com>,
        Lukas Wunner <lukas@wunner.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH 07/12] thunderbolt: Pass metadata directly to usb4_switch_op()
Date:   Thu, 19 Nov 2020 18:55:18 +0300
Message-Id: <20201119155523.41332-8-mika.westerberg@linux.intel.com>
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
either based on the connection manager implementation. For this reason
pass metadata directly to usb4_switch_op().

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/thunderbolt/usb4.c | 77 ++++++++++++++------------------------
 1 file changed, 28 insertions(+), 49 deletions(-)

diff --git a/drivers/thunderbolt/usb4.c b/drivers/thunderbolt/usb4.c
index d88e28eee975..5f3237d66987 100644
--- a/drivers/thunderbolt/usb4.c
+++ b/drivers/thunderbolt/usb4.c
@@ -92,16 +92,6 @@ static int usb4_switch_op_write_data(struct tb_switch *sw, const void *data,
 	return tb_sw_write(sw, data, TB_CFG_SWITCH, ROUTER_CS_9, dwords);
 }
 
-static int usb4_switch_op_read_metadata(struct tb_switch *sw, u32 *metadata)
-{
-	return tb_sw_read(sw, metadata, TB_CFG_SWITCH, ROUTER_CS_25, 1);
-}
-
-static int usb4_switch_op_write_metadata(struct tb_switch *sw, u32 metadata)
-{
-	return tb_sw_write(sw, &metadata, TB_CFG_SWITCH, ROUTER_CS_25, 1);
-}
-
 static int usb4_do_read_data(u16 address, void *buf, size_t size,
 			     read_block_fn read_block, void *read_block_data)
 {
@@ -171,11 +161,18 @@ static int usb4_do_write_data(unsigned int address, const void *buf, size_t size
 	return 0;
 }
 
-static int usb4_switch_op(struct tb_switch *sw, u16 opcode, u8 *status)
+static int usb4_switch_op(struct tb_switch *sw, u16 opcode, u32 *metadata,
+			  u8 *status)
 {
 	u32 val;
 	int ret;
 
+	if (metadata) {
+		ret = tb_sw_write(sw, metadata, TB_CFG_SWITCH, ROUTER_CS_25, 1);
+		if (ret)
+			return ret;
+	}
+
 	val = opcode | ROUTER_CS_26_OV;
 	ret = tb_sw_write(sw, &val, TB_CFG_SWITCH, ROUTER_CS_26, 1);
 	if (ret)
@@ -195,7 +192,9 @@ static int usb4_switch_op(struct tb_switch *sw, u16 opcode, u8 *status)
 	if (status)
 		*status = (val & ROUTER_CS_26_STATUS_MASK) >>
 			ROUTER_CS_26_STATUS_SHIFT;
-	return 0;
+
+	return metadata ?
+		tb_sw_read(sw, metadata, TB_CFG_SWITCH, ROUTER_CS_25, 1) : 0;
 }
 
 static void usb4_switch_check_wakes(struct tb_switch *sw)
@@ -350,11 +349,7 @@ static int usb4_switch_drom_read_block(void *data,
 	metadata |= (dwaddress << USB4_DROM_ADDRESS_SHIFT) &
 		USB4_DROM_ADDRESS_MASK;
 
-	ret = usb4_switch_op_write_metadata(sw, metadata);
-	if (ret)
-		return ret;
-
-	ret = usb4_switch_op(sw, USB4_SWITCH_OP_DROM_READ, &status);
+	ret = usb4_switch_op(sw, USB4_SWITCH_OP_DROM_READ, &metadata, &status);
 	if (ret)
 		return ret;
 
@@ -510,17 +505,14 @@ int usb4_switch_nvm_sector_size(struct tb_switch *sw)
 	u8 status;
 	int ret;
 
-	ret = usb4_switch_op(sw, USB4_SWITCH_OP_NVM_SECTOR_SIZE, &status);
+	ret = usb4_switch_op(sw, USB4_SWITCH_OP_NVM_SECTOR_SIZE, &metadata,
+			     &status);
 	if (ret)
 		return ret;
 
 	if (status)
 		return status == 0x2 ? -EOPNOTSUPP : -EIO;
 
-	ret = usb4_switch_op_read_metadata(sw, &metadata);
-	if (ret)
-		return ret;
-
 	return metadata & USB4_NVM_SECTOR_SIZE_MASK;
 }
 
@@ -537,11 +529,7 @@ static int usb4_switch_nvm_read_block(void *data,
 	metadata |= (dwaddress << USB4_NVM_READ_OFFSET_SHIFT) &
 		   USB4_NVM_READ_OFFSET_MASK;
 
-	ret = usb4_switch_op_write_metadata(sw, metadata);
-	if (ret)
-		return ret;
-
-	ret = usb4_switch_op(sw, USB4_SWITCH_OP_NVM_READ, &status);
+	ret = usb4_switch_op(sw, USB4_SWITCH_OP_NVM_READ, &metadata, &status);
 	if (ret)
 		return ret;
 
@@ -579,11 +567,8 @@ static int usb4_switch_nvm_set_offset(struct tb_switch *sw,
 	metadata = (dwaddress << USB4_NVM_SET_OFFSET_SHIFT) &
 		   USB4_NVM_SET_OFFSET_MASK;
 
-	ret = usb4_switch_op_write_metadata(sw, metadata);
-	if (ret)
-		return ret;
-
-	ret = usb4_switch_op(sw, USB4_SWITCH_OP_NVM_SET_OFFSET, &status);
+	ret = usb4_switch_op(sw, USB4_SWITCH_OP_NVM_SET_OFFSET, &metadata,
+			     &status);
 	if (ret)
 		return ret;
 
@@ -601,7 +586,7 @@ static int usb4_switch_nvm_write_next_block(void *data, const void *buf,
 	if (ret)
 		return ret;
 
-	ret = usb4_switch_op(sw, USB4_SWITCH_OP_NVM_WRITE, &status);
+	ret = usb4_switch_op(sw, USB4_SWITCH_OP_NVM_WRITE, NULL, &status);
 	if (ret)
 		return ret;
 
@@ -648,7 +633,7 @@ int usb4_switch_nvm_authenticate(struct tb_switch *sw)
 {
 	int ret;
 
-	ret = usb4_switch_op(sw, USB4_SWITCH_OP_NVM_AUTH, NULL);
+	ret = usb4_switch_op(sw, USB4_SWITCH_OP_NVM_AUTH, NULL, NULL);
 	switch (ret) {
 	/*
 	 * The router is power cycled once NVM_AUTH is started so it is
@@ -714,14 +699,12 @@ int usb4_switch_nvm_authenticate_status(struct tb_switch *sw, u32 *status)
  */
 bool usb4_switch_query_dp_resource(struct tb_switch *sw, struct tb_port *in)
 {
+	u32 metadata = in->port;
 	u8 status;
 	int ret;
 
-	ret = usb4_switch_op_write_metadata(sw, in->port);
-	if (ret)
-		return false;
-
-	ret = usb4_switch_op(sw, USB4_SWITCH_OP_QUERY_DP_RESOURCE, &status);
+	ret = usb4_switch_op(sw, USB4_SWITCH_OP_QUERY_DP_RESOURCE, &metadata,
+			     &status);
 	/*
 	 * If DP resource allocation is not supported assume it is
 	 * always available.
@@ -746,14 +729,12 @@ bool usb4_switch_query_dp_resource(struct tb_switch *sw, struct tb_port *in)
  */
 int usb4_switch_alloc_dp_resource(struct tb_switch *sw, struct tb_port *in)
 {
+	u32 metadata = in->port;
 	u8 status;
 	int ret;
 
-	ret = usb4_switch_op_write_metadata(sw, in->port);
-	if (ret)
-		return ret;
-
-	ret = usb4_switch_op(sw, USB4_SWITCH_OP_ALLOC_DP_RESOURCE, &status);
+	ret = usb4_switch_op(sw, USB4_SWITCH_OP_ALLOC_DP_RESOURCE, &metadata,
+			     &status);
 	if (ret == -EOPNOTSUPP)
 		return 0;
 	else if (ret)
@@ -771,14 +752,12 @@ int usb4_switch_alloc_dp_resource(struct tb_switch *sw, struct tb_port *in)
  */
 int usb4_switch_dealloc_dp_resource(struct tb_switch *sw, struct tb_port *in)
 {
+	u32 metadata = in->port;
 	u8 status;
 	int ret;
 
-	ret = usb4_switch_op_write_metadata(sw, in->port);
-	if (ret)
-		return ret;
-
-	ret = usb4_switch_op(sw, USB4_SWITCH_OP_DEALLOC_DP_RESOURCE, &status);
+	ret = usb4_switch_op(sw, USB4_SWITCH_OP_DEALLOC_DP_RESOURCE, &metadata,
+			     &status);
 	if (ret == -EOPNOTSUPP)
 		return 0;
 	else if (ret)
-- 
2.29.2

