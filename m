Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE32F2CDCA6
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 18:49:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731119AbgLCRq5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 12:46:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:45606 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729344AbgLCRqz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 12:46:55 -0500
From:   Oded Gabbay <ogabbay@kernel.org>
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     linux-kernel@vger.kernel.org
Cc:     SW_Drivers@habana.ai, Alon Mizrahi <amizrahi@habana.ai>
Subject: [PATCH 3/3] habanalabs: remove generic gaudi get_pll_freq function
Date:   Thu,  3 Dec 2020 19:46:05 +0200
Message-Id: <20201203174605.31530-3-ogabbay@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201203174605.31530-1-ogabbay@kernel.org>
References: <20201203174605.31530-1-ogabbay@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alon Mizrahi <amizrahi@habana.ai>

As we only fetch the CPU_PLL frequency in gaudi, we don't need a
generic get_pll_frequency function which takes a pll index as input

Signed-off-by: Alon Mizrahi <amizrahi@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 .../misc/habanalabs/common/habanalabs_ioctl.c |   2 +-
 drivers/misc/habanalabs/gaudi/gaudi.c         | 126 ++++++------------
 drivers/misc/habanalabs/gaudi/gaudiP.h        |   7 -
 3 files changed, 41 insertions(+), 94 deletions(-)

diff --git a/drivers/misc/habanalabs/common/habanalabs_ioctl.c b/drivers/misc/habanalabs/common/habanalabs_ioctl.c
index a9927a06c5ea..a0c0d20f6f8f 100644
--- a/drivers/misc/habanalabs/common/habanalabs_ioctl.c
+++ b/drivers/misc/habanalabs/common/habanalabs_ioctl.c
@@ -406,7 +406,7 @@ static int total_energy_consumption_info(struct hl_fpriv *hpriv,
 static int pll_frequency_info(struct hl_fpriv *hpriv, struct hl_info_args *args)
 {
 	struct hl_device *hdev = hpriv->hdev;
-	struct hl_pll_frequency_info freq_info = {};
+	struct hl_pll_frequency_info freq_info = { {0} };
 	u32 max_size = args->return_size;
 	void __user *out = (void __user *) (uintptr_t) args->return_pointer;
 	int rc;
diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index 1f1926607c5e..278c4de98e22 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -151,19 +151,6 @@ static const u16 gaudi_packet_sizes[MAX_PACKET_ID] = {
 	[PACKET_LOAD_AND_EXE]	= sizeof(struct packet_load_and_exe)
 };
 
-static const u32 gaudi_pll_base_addresses[GAUDI_PLL_MAX] = {
-	[CPU_PLL] = mmPSOC_CPU_PLL_NR,
-	[PCI_PLL] = mmPSOC_PCI_PLL_NR,
-	[SRAM_PLL] = mmSRAM_W_PLL_NR,
-	[HBM_PLL] = mmPSOC_HBM_PLL_NR,
-	[NIC_PLL] = mmNIC0_PLL_NR,
-	[DMA_PLL] = mmDMA_W_PLL_NR,
-	[MESH_PLL] = mmMESH_W_PLL_NR,
-	[MME_PLL] = mmPSOC_MME_PLL_NR,
-	[TPC_PLL] = mmPSOC_TPC_PLL_NR,
-	[IF_PLL] = mmIF_W_PLL_NR
-};
-
 static inline bool validate_packet_id(enum packet_id id)
 {
 	switch (id) {
@@ -703,93 +690,60 @@ static int gaudi_early_fini(struct hl_device *hdev)
 }
 
 /**
- * gaudi_fetch_pll_frequency - Fetch PLL frequency values
+ * gaudi_fetch_psoc_frequency - Fetch PSOC frequency values
  *
  * @hdev: pointer to hl_device structure
- * @pll_index: index of the pll to fetch frequency from
- * @pll_freq: pointer to store the pll frequency in MHz in each of the available
- *            outputs. if a certain output is not available a 0 will be set
  *
  */
-static int gaudi_fetch_pll_frequency(struct hl_device *hdev,
-				enum gaudi_pll_index pll_index,
-				u16 *pll_freq_arr)
+static int gaudi_fetch_psoc_frequency(struct hl_device *hdev)
 {
-	u32 nr = 0, nf = 0, od = 0, pll_clk = 0, div_fctr, div_sel,
-			pll_base_addr = gaudi_pll_base_addresses[pll_index];
-	u16 freq = 0;
-	int i, rc;
-
-	if (hdev->asic_prop.fw_security_status_valid &&
-			(hdev->asic_prop.fw_app_security_map &
-					CPU_BOOT_DEV_STS0_PLL_INFO_EN)) {
-		rc = hl_fw_cpucp_pll_info_get(hdev, pll_index, pll_freq_arr);
+	struct asic_fixed_properties *prop = &hdev->asic_prop;
+	u32 nr = 0, nf = 0, od = 0, div_fctr = 0, pll_clk, div_sel;
+	u16 pll_freq_arr[HL_PLL_NUM_OUTPUTS], freq;
+	int rc;
 
-		if (rc)
-			return rc;
-	} else if (hdev->asic_prop.fw_security_disabled) {
+	if (hdev->asic_prop.fw_security_disabled) {
 		/* Backward compatibility */
-		nr = RREG32(pll_base_addr + PLL_NR_OFFSET);
-		nf = RREG32(pll_base_addr + PLL_NF_OFFSET);
-		od = RREG32(pll_base_addr + PLL_OD_OFFSET);
-
-		for (i = 0; i < HL_PLL_NUM_OUTPUTS; i++) {
-			div_fctr = RREG32(pll_base_addr +
-					PLL_DIV_FACTOR_0_OFFSET + i * 4);
-			div_sel = RREG32(pll_base_addr +
-					PLL_DIV_SEL_0_OFFSET + i * 4);
+		div_fctr = RREG32(mmPSOC_CPU_PLL_DIV_FACTOR_2);
+		div_sel = RREG32(mmPSOC_CPU_PLL_DIV_SEL_2);
+		nr = RREG32(mmPSOC_CPU_PLL_NR);
+		nf = RREG32(mmPSOC_CPU_PLL_NF);
+		od = RREG32(mmPSOC_CPU_PLL_OD);
 
-			if (div_sel == DIV_SEL_REF_CLK ||
+		if (div_sel == DIV_SEL_REF_CLK ||
 				div_sel == DIV_SEL_DIVIDED_REF) {
-				if (div_sel == DIV_SEL_REF_CLK)
-					freq = PLL_REF_CLK;
-				else
-					freq = PLL_REF_CLK / (div_fctr + 1);
-			} else if (div_sel == DIV_SEL_PLL_CLK ||
-					div_sel == DIV_SEL_DIVIDED_PLL) {
-				pll_clk = PLL_REF_CLK * (nf + 1) /
-						((nr + 1) * (od + 1));
-				if (div_sel == DIV_SEL_PLL_CLK)
-					freq = pll_clk;
-				else
-					freq = pll_clk / (div_fctr + 1);
-			} else {
-				dev_warn(hdev->dev,
-					"Received invalid div select value: %d",
-					div_sel);
-			}
-
-			pll_freq_arr[i] = freq;
+			if (div_sel == DIV_SEL_REF_CLK)
+				freq = PLL_REF_CLK;
+			else
+				freq = PLL_REF_CLK / (div_fctr + 1);
+		} else if (div_sel == DIV_SEL_PLL_CLK ||
+			div_sel == DIV_SEL_DIVIDED_PLL) {
+			pll_clk = PLL_REF_CLK * (nf + 1) /
+					((nr + 1) * (od + 1));
+			if (div_sel == DIV_SEL_PLL_CLK)
+				freq = pll_clk;
+			else
+				freq = pll_clk / (div_fctr + 1);
+		} else {
+			dev_warn(hdev->dev,
+				"Received invalid div select value: %d",
+				div_sel);
+			freq = 0;
 		}
 	} else {
-		dev_err(hdev->dev, "Failed to fetch PLL frequency values\n");
-		return -EIO;
-	}
-
-	return 0;
-}
+		rc = hl_fw_cpucp_pll_info_get(hdev, CPU_PLL, pll_freq_arr);
 
-/**
- * gaudi_fetch_psoc_frequency - Fetch PSOC frequency values
- *
- * @hdev: pointer to hl_device structure
- *
- */
-static int gaudi_fetch_psoc_frequency(struct hl_device *hdev)
-{
-	struct asic_fixed_properties *prop = &hdev->asic_prop;
-	u16 pll_freq[HL_PLL_NUM_OUTPUTS];
-	int rc;
+		if (rc)
+			return rc;
 
-	rc = gaudi_fetch_pll_frequency(hdev, CPU_PLL, pll_freq);
-	if (rc)
-		return rc;
+		freq = pll_freq_arr[2];
+	}
 
-	prop->psoc_timestamp_frequency = pll_freq[2];
-	prop->psoc_pci_pll_nr = 0;
-	prop->psoc_pci_pll_nf = 0;
-	prop->psoc_pci_pll_od = 0;
-	prop->psoc_pci_pll_div_factor = 0;
+	prop->psoc_timestamp_frequency = freq;
+	prop->psoc_pci_pll_nr = nr;
+	prop->psoc_pci_pll_nf = nf;
+	prop->psoc_pci_pll_od = od;
+	prop->psoc_pci_pll_div_factor = div_fctr;
 
 	return 0;
 }
diff --git a/drivers/misc/habanalabs/gaudi/gaudiP.h b/drivers/misc/habanalabs/gaudi/gaudiP.h
index f2d91f4fcffe..a7ab2d7e57d4 100644
--- a/drivers/misc/habanalabs/gaudi/gaudiP.h
+++ b/drivers/misc/habanalabs/gaudi/gaudiP.h
@@ -105,13 +105,6 @@
 #define MME_ACC_OFFSET		(mmMME1_ACC_BASE - mmMME0_ACC_BASE)
 #define SRAM_BANK_OFFSET	(mmSRAM_Y0_X1_RTR_BASE - mmSRAM_Y0_X0_RTR_BASE)
 
-#define PLL_NR_OFFSET		0
-#define PLL_NF_OFFSET		(mmPSOC_CPU_PLL_NF - mmPSOC_CPU_PLL_NR)
-#define PLL_OD_OFFSET		(mmPSOC_CPU_PLL_OD - mmPSOC_CPU_PLL_NR)
-#define PLL_DIV_FACTOR_0_OFFSET	(mmPSOC_CPU_PLL_DIV_FACTOR_0 - \
-				mmPSOC_CPU_PLL_NR)
-#define PLL_DIV_SEL_0_OFFSET	(mmPSOC_CPU_PLL_DIV_SEL_0 - mmPSOC_CPU_PLL_NR)
-
 #define NUM_OF_SOB_IN_BLOCK		\
 	(((mmSYNC_MNGR_E_N_SYNC_MNGR_OBJS_SOB_OBJ_2047 - \
 	mmSYNC_MNGR_E_N_SYNC_MNGR_OBJS_SOB_OBJ_0) + 4) >> 2)
-- 
2.17.1

