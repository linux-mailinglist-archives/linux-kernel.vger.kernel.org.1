Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0515D2B9725
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 17:02:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729017AbgKSPze (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 10:55:34 -0500
Received: from mga18.intel.com ([134.134.136.126]:43268 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728981AbgKSPza (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 10:55:30 -0500
IronPort-SDR: 920jDYbZ219Fts/sIMl4O13BMBLkXsa/2o3ESr5U/Czp80jJ3LKwutPNjgUp4ZMEIXrdaYVsMo
 /Jfhx4RoqC3w==
X-IronPort-AV: E=McAfee;i="6000,8403,9809"; a="159081203"
X-IronPort-AV: E=Sophos;i="5.78,490,1599548400"; 
   d="scan'208";a="159081203"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2020 07:55:29 -0800
IronPort-SDR: G8TcV6ImCSuAneZhTkDqZvGHHSI1BkCY+7j5eqger2kLOsPjYcxVMbUfLvF0taaSHtaNGGQo3L
 c2KHVbI/a4hA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,353,1599548400"; 
   d="scan'208";a="431281602"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 19 Nov 2020 07:55:27 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 2B4CB655; Thu, 19 Nov 2020 17:55:24 +0200 (EET)
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     Yehezkel Bernat <YehezkelShB@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Andreas Noever <andreas.noever@gmail.com>,
        Lukas Wunner <lukas@wunner.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH 10/12] thunderbolt: Move constants for USB4 router operations to tb_regs.h
Date:   Thu, 19 Nov 2020 18:55:21 +0300
Message-Id: <20201119155523.41332-11-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201119155523.41332-1-mika.westerberg@linux.intel.com>
References: <20201119155523.41332-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We are going to use these in subsequent patch so make them available
outside of usb4.c.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/thunderbolt/tb_regs.h | 13 +++++++++++++
 drivers/thunderbolt/usb4.c    | 12 ------------
 2 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/drivers/thunderbolt/tb_regs.h b/drivers/thunderbolt/tb_regs.h
index 67cb173a2f8e..ae427a953489 100644
--- a/drivers/thunderbolt/tb_regs.h
+++ b/drivers/thunderbolt/tb_regs.h
@@ -217,6 +217,19 @@ struct tb_regs_switch_header {
 #define ROUTER_CS_26_ONS			BIT(30)
 #define ROUTER_CS_26_OV				BIT(31)
 
+/* USB4 router operations opcodes */
+enum usb4_switch_op {
+	USB4_SWITCH_OP_QUERY_DP_RESOURCE = 0x10,
+	USB4_SWITCH_OP_ALLOC_DP_RESOURCE = 0x11,
+	USB4_SWITCH_OP_DEALLOC_DP_RESOURCE = 0x12,
+	USB4_SWITCH_OP_NVM_WRITE = 0x20,
+	USB4_SWITCH_OP_NVM_AUTH = 0x21,
+	USB4_SWITCH_OP_NVM_READ = 0x22,
+	USB4_SWITCH_OP_NVM_SET_OFFSET = 0x23,
+	USB4_SWITCH_OP_DROM_READ = 0x24,
+	USB4_SWITCH_OP_NVM_SECTOR_SIZE = 0x25,
+};
+
 /* Router TMU configuration */
 #define TMU_RTR_CS_0				0x00
 #define TMU_RTR_CS_0_TD				BIT(27)
diff --git a/drivers/thunderbolt/usb4.c b/drivers/thunderbolt/usb4.c
index cbf1c0536360..6a0aa83a1ac8 100644
--- a/drivers/thunderbolt/usb4.c
+++ b/drivers/thunderbolt/usb4.c
@@ -16,18 +16,6 @@
 #define USB4_DATA_DWORDS		16
 #define USB4_DATA_RETRIES		3
 
-enum usb4_switch_op {
-	USB4_SWITCH_OP_QUERY_DP_RESOURCE = 0x10,
-	USB4_SWITCH_OP_ALLOC_DP_RESOURCE = 0x11,
-	USB4_SWITCH_OP_DEALLOC_DP_RESOURCE = 0x12,
-	USB4_SWITCH_OP_NVM_WRITE = 0x20,
-	USB4_SWITCH_OP_NVM_AUTH = 0x21,
-	USB4_SWITCH_OP_NVM_READ = 0x22,
-	USB4_SWITCH_OP_NVM_SET_OFFSET = 0x23,
-	USB4_SWITCH_OP_DROM_READ = 0x24,
-	USB4_SWITCH_OP_NVM_SECTOR_SIZE = 0x25,
-};
-
 enum usb4_sb_target {
 	USB4_SB_TARGET_ROUTER,
 	USB4_SB_TARGET_PARTNER,
-- 
2.29.2

