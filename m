Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB2012BB81C
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 22:10:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730801AbgKTVGd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 16:06:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:44090 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727170AbgKTVGd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 16:06:33 -0500
Received: from ogabbay-VM.habana-labs.com (unknown [213.57.90.10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 12CB222227;
        Fri, 20 Nov 2020 21:06:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605906392;
        bh=a52AT4w6BLCyz/JA7sc1y+6FbHW4mqUPiFZmmt2/xoM=;
        h=From:To:Cc:Subject:Date:From;
        b=gVbR0MgJq0Tws3SX/EE4Ll8lDPPfI9Mf6N/fRGoxorLD447gFflws/IBxaWBJ1xlI
         7/TgWiqOZ95BTd/XVcendrAscsyx4OWNrC6IqCT1lUtj2+REn5ixA6sV1dfgxzha+J
         BkYa2VjAaCKsY/6pWQ5lJoGZ025Z2hyIfMlDspHU=
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     SW_Drivers@habana.ai
Subject: [PATCH] habanalabs: update firmware files
Date:   Fri, 20 Nov 2020 23:06:27 +0200
Message-Id: <20201120210627.22487-1-ogabbay@kernel.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update various firmware header files with new defines.

Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 .../misc/habanalabs/include/common/hl_boot_if.h | 17 +++++++++++++++++
 .../misc/habanalabs/include/gaudi/gaudi_fw_if.h |  3 ++-
 .../misc/habanalabs/include/goya/goya_fw_if.h   |  3 ++-
 3 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/habanalabs/include/common/hl_boot_if.h b/drivers/misc/habanalabs/include/common/hl_boot_if.h
index 68ac15c53f37..e5801ecf0cb2 100644
--- a/drivers/misc/habanalabs/include/common/hl_boot_if.h
+++ b/drivers/misc/habanalabs/include/common/hl_boot_if.h
@@ -56,6 +56,20 @@
  * CPU_BOOT_ERR0_EFUSE_FAIL		Reading from eFuse failed.
  *					The PCI device ID might be wrong.
  *
+ * CPU_BOOT_ERR0_PRI_IMG_VER_FAIL	Verification of primary image failed.
+ *					It mean that ppboot checksum
+ *					verification for the preboot primary
+ *					image has failed to match expected
+ *					checksum. Trying to program image again
+ *					might solve this.
+ *
+ * CPU_BOOT_ERR0_SEC_IMG_VER_FAIL	Verification of secondary image failed.
+ *					It mean that ppboot checksum
+ *					verification for the preboot secondary
+ *					image has failed to match expected
+ *					checksum. Trying to program image again
+ *					might solve this.
+ *
  * CPU_BOOT_ERR0_ENABLED		Error registers enabled.
  *					This is a main indication that the
  *					running FW populates the error
@@ -72,6 +86,8 @@
 #define CPU_BOOT_ERR0_SECURITY_NOT_RDY		(1 << 7)
 #define CPU_BOOT_ERR0_SECURITY_FAIL		(1 << 8)
 #define CPU_BOOT_ERR0_EFUSE_FAIL		(1 << 9)
+#define CPU_BOOT_ERR0_PRI_IMG_VER_FAIL		(1 << 10)
+#define CPU_BOOT_ERR0_SEC_IMG_VER_FAIL		(1 << 11)
 #define CPU_BOOT_ERR0_ENABLED			(1 << 31)
 
 /*
@@ -141,6 +157,7 @@
  *					bits are not garbage, but actual
  *					statuses.
  *					Initialized in: preboot
+ *
  */
 #define CPU_BOOT_DEV_STS0_SECURITY_EN			(1 << 0)
 #define CPU_BOOT_DEV_STS0_DEBUG_EN			(1 << 1)
diff --git a/drivers/misc/habanalabs/include/gaudi/gaudi_fw_if.h b/drivers/misc/habanalabs/include/gaudi/gaudi_fw_if.h
index d61a4c87b765..25acd9e87e20 100644
--- a/drivers/misc/habanalabs/include/gaudi/gaudi_fw_if.h
+++ b/drivers/misc/habanalabs/include/gaudi/gaudi_fw_if.h
@@ -30,7 +30,8 @@ enum gaudi_pll_index {
 	MESH_PLL,
 	MME_PLL,
 	TPC_PLL,
-	IF_PLL
+	IF_PLL,
+	PLL_MAX
 };
 
 enum gaudi_nic_axi_error {
diff --git a/drivers/misc/habanalabs/include/goya/goya_fw_if.h b/drivers/misc/habanalabs/include/goya/goya_fw_if.h
index 0fa80fe9f6cc..daf8d8cd14be 100644
--- a/drivers/misc/habanalabs/include/goya/goya_fw_if.h
+++ b/drivers/misc/habanalabs/include/goya/goya_fw_if.h
@@ -22,7 +22,8 @@ enum goya_pll_index {
 	MME_PLL,
 	PCI_PLL,
 	EMMC_PLL,
-	TPC_PLL
+	TPC_PLL,
+	PLL_MAX
 };
 
 #define GOYA_PLL_FREQ_LOW		50000000 /* 50 MHz */
-- 
2.17.1

