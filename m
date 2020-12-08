Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E7CA2D2E75
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 16:41:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730094AbgLHPke (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 10:40:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:44292 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729334AbgLHPke (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 10:40:34 -0500
From:   Oded Gabbay <ogabbay@kernel.org>
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     linux-kernel@vger.kernel.org
Cc:     SW_Drivers@habana.ai
Subject: [PATCH] habanalabs/gaudi: disable CGM at HW initialization
Date:   Tue,  8 Dec 2020 17:39:45 +0200
Message-Id: <20201208153947.18678-2-ogabbay@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201208153947.18678-1-ogabbay@kernel.org>
References: <20201208153947.18678-1-ogabbay@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case the clock gating was enabled in preboot we need to disable it
at the H/W initialization stage before touching the MME/TPC registers.
Otherwise, the ASIC can get stuck. If the security is enabled in
the firmware level, the CGM is always disabled and the driver can't
enable it.

Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/gaudi/gaudi.c              | 14 +++++++++++---
 .../misc/habanalabs/include/common/hl_boot_if.h    |  5 +++++
 2 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index 65895ba075fe..f316b898e8e0 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -2403,8 +2403,6 @@ static void gaudi_init_golden_registers(struct hl_device *hdev)
 	gaudi_init_e2e(hdev);
 	gaudi_init_hbm_cred(hdev);
 
-	hdev->asic_funcs->disable_clock_gating(hdev);
-
 	for (tpc_id = 0, tpc_offset = 0;
 				tpc_id < TPC_NUMBER_OF_ENGINES;
 				tpc_id++, tpc_offset += TPC_CFG_OFFSET) {
@@ -3416,6 +3414,9 @@ static void gaudi_set_clock_gating(struct hl_device *hdev)
 	if (hdev->in_debug)
 		return;
 
+	if (!hdev->asic_prop.fw_security_disabled)
+		return;
+
 	for (i = GAUDI_PCI_DMA_1, qman_offset = 0 ; i < GAUDI_HBM_DMA_1 ; i++) {
 		enable = !!(hdev->clock_gating_mask &
 				(BIT_ULL(gaudi_dma_assignment[i])));
@@ -3467,7 +3468,7 @@ static void gaudi_disable_clock_gating(struct hl_device *hdev)
 	u32 qman_offset;
 	int i;
 
-	if (!(gaudi->hw_cap_initialized & HW_CAP_CLK_GATE))
+	if (!hdev->asic_prop.fw_security_disabled)
 		return;
 
 	for (i = 0, qman_offset = 0 ; i < DMA_NUMBER_OF_CHANNELS ; i++) {
@@ -3801,6 +3802,13 @@ static int gaudi_hw_init(struct hl_device *hdev)
 		return rc;
 	}
 
+	/* In case the clock gating was enabled in preboot we need to disable
+	 * it here before touching the MME/TPC registers.
+	 * There is no need to take clk gating mutex because when this function
+	 * runs, no other relevant code can run
+	 */
+	hdev->asic_funcs->disable_clock_gating(hdev);
+
 	/* SRAM scrambler must be initialized after CPU is running from HBM */
 	gaudi_init_scrambler_sram(hdev);
 
diff --git a/drivers/misc/habanalabs/include/common/hl_boot_if.h b/drivers/misc/habanalabs/include/common/hl_boot_if.h
index 755c4800f002..7cb5f2d3e565 100644
--- a/drivers/misc/habanalabs/include/common/hl_boot_if.h
+++ b/drivers/misc/habanalabs/include/common/hl_boot_if.h
@@ -150,6 +150,10 @@
  * CPU_BOOT_DEV_STS0_PLL_INFO_EN	FW retrieval of PLL info is enabled.
  *					Initialized in: linux
  *
+ * CPU_BOOT_DEV_STS0_CLK_GATE_EN	Clock Gating enabled.
+ *					FW initialized Clock Gating.
+ *					Initialized in: preboot
+ *
  * CPU_BOOT_DEV_STS0_ENABLED		Device status register enabled.
  *					This is a main indication that the
  *					running FW populates the device status
@@ -171,6 +175,7 @@
 #define CPU_BOOT_DEV_STS0_DRAM_SCR_EN			(1 << 9)
 #define CPU_BOOT_DEV_STS0_FW_HARD_RST_EN		(1 << 10)
 #define CPU_BOOT_DEV_STS0_PLL_INFO_EN			(1 << 11)
+#define CPU_BOOT_DEV_STS0_CLK_GATE_EN			(1 << 13)
 #define CPU_BOOT_DEV_STS0_ENABLED			(1 << 31)
 
 enum cpu_boot_status {
-- 
2.17.1

