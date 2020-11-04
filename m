Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A3962A5FB6
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 09:36:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728865AbgKDIgv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 03:36:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:56478 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728522AbgKDIgt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 03:36:49 -0500
Received: from ogabbay-VM.habana-labs.com (unknown [213.57.90.10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BD3A62074B;
        Wed,  4 Nov 2020 08:36:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604479006;
        bh=C15askM/B/PYmczrHoBo4uBCalTn3fArQtY+4UgVNBA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GbP8n8gPZqRk/dQwzbMI3w04dSM7xYKCBlYmsTSQvXWgZcCZw7XzmTdPO+WHkIMIX
         HC8wTcEInsnnDO6H1NId8Ssqe2HpIEqUJwG69kNWXD0oj+yWD4dVYhtLeY3adnLtbU
         2jbEx8Ri6q1XN4Nw6MW4UHWRhmu1TuSVSXqwbAUc=
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     SW_Drivers@habana.ai, Ofir Bitton <obitton@habana.ai>
Subject: [PATCH 2/2] habanalabs/gaudi: add support for FW security
Date:   Wed,  4 Nov 2020 10:36:30 +0200
Message-Id: <20201104083630.28402-8-ogabbay@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201104083630.28402-1-ogabbay@kernel.org>
References: <20201104083630.28402-1-ogabbay@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ofir Bitton <obitton@habana.ai>

Skip relevant HW configurations once FW security is enabled
because these configurations are being performed by FW.

Signed-off-by: Ofir Bitton <obitton@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/gaudi/gaudi.c         | 123 ++++++++++++------
 .../misc/habanalabs/gaudi/gaudi_security.c    |  83 ++++++------
 2 files changed, 128 insertions(+), 78 deletions(-)

diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index e874c1765922..9017c712766c 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -1410,7 +1410,8 @@ static int gaudi_alloc_cpu_accessible_dma_mem(struct hl_device *hdev)
 	hdev->cpu_pci_msb_addr =
 		GAUDI_CPU_PCI_MSB_ADDR(hdev->cpu_accessible_dma_address);
 
-	GAUDI_PCI_TO_CPU_ADDR(hdev->cpu_accessible_dma_address);
+	if (hdev->asic_prop.fw_security_disabled)
+		GAUDI_PCI_TO_CPU_ADDR(hdev->cpu_accessible_dma_address);
 
 free_dma_mem_arr:
 	for (j = 0 ; j < i ; j++)
@@ -1564,8 +1565,9 @@ static int gaudi_sw_init(struct hl_device *hdev)
 free_cpu_accessible_dma_pool:
 	gen_pool_destroy(hdev->cpu_accessible_dma_pool);
 free_cpu_dma_mem:
-	GAUDI_CPU_TO_PCI_ADDR(hdev->cpu_accessible_dma_address,
-				hdev->cpu_pci_msb_addr);
+	if (hdev->asic_prop.fw_security_disabled)
+		GAUDI_CPU_TO_PCI_ADDR(hdev->cpu_accessible_dma_address,
+					hdev->cpu_pci_msb_addr);
 	hdev->asic_funcs->asic_dma_free_coherent(hdev,
 			HL_CPU_ACCESSIBLE_MEM_SIZE,
 			hdev->cpu_accessible_dma_mem,
@@ -1585,8 +1587,10 @@ static int gaudi_sw_fini(struct hl_device *hdev)
 
 	gen_pool_destroy(hdev->cpu_accessible_dma_pool);
 
-	GAUDI_CPU_TO_PCI_ADDR(hdev->cpu_accessible_dma_address,
+	if (hdev->asic_prop.fw_security_disabled)
+		GAUDI_CPU_TO_PCI_ADDR(hdev->cpu_accessible_dma_address,
 					hdev->cpu_pci_msb_addr);
+
 	hdev->asic_funcs->asic_dma_free_coherent(hdev,
 			HL_CPU_ACCESSIBLE_MEM_SIZE,
 			hdev->cpu_accessible_dma_mem,
@@ -1772,6 +1776,14 @@ static void gaudi_init_scrambler_sram(struct hl_device *hdev)
 {
 	struct gaudi_device *gaudi = hdev->asic_specific;
 
+	if (!hdev->asic_prop.fw_security_disabled)
+		return;
+
+	if (hdev->asic_prop.fw_security_status_valid &&
+			(hdev->asic_prop.fw_app_security_map &
+					CPU_BOOT_DEV_STS0_SRAM_SCR_EN))
+		return;
+
 	if (gaudi->hw_cap_initialized & HW_CAP_SRAM_SCRAMBLER)
 		return;
 
@@ -1836,6 +1848,14 @@ static void gaudi_init_scrambler_hbm(struct hl_device *hdev)
 {
 	struct gaudi_device *gaudi = hdev->asic_specific;
 
+	if (!hdev->asic_prop.fw_security_disabled)
+		return;
+
+	if (hdev->asic_prop.fw_security_status_valid &&
+			(hdev->asic_prop.fw_boot_cpu_security_map &
+					CPU_BOOT_DEV_STS0_DRAM_SCR_EN))
+		return;
+
 	if (gaudi->hw_cap_initialized & HW_CAP_HBM_SCRAMBLER)
 		return;
 
@@ -1898,6 +1918,14 @@ static void gaudi_init_scrambler_hbm(struct hl_device *hdev)
 
 static void gaudi_init_e2e(struct hl_device *hdev)
 {
+	if (!hdev->asic_prop.fw_security_disabled)
+		return;
+
+	if (hdev->asic_prop.fw_security_status_valid &&
+			(hdev->asic_prop.fw_boot_cpu_security_map &
+					CPU_BOOT_DEV_STS0_E2E_CRED_EN))
+		return;
+
 	WREG32(mmSIF_RTR_CTRL_0_E2E_HBM_WR_SIZE, 247 >> 3);
 	WREG32(mmSIF_RTR_CTRL_0_E2E_HBM_RD_SIZE, 785 >> 3);
 	WREG32(mmSIF_RTR_CTRL_0_E2E_PCI_WR_SIZE, 49);
@@ -2265,6 +2293,14 @@ static void gaudi_init_hbm_cred(struct hl_device *hdev)
 {
 	uint32_t hbm0_wr, hbm1_wr, hbm0_rd, hbm1_rd;
 
+	if (!hdev->asic_prop.fw_security_disabled)
+		return;
+
+	if (hdev->asic_prop.fw_security_status_valid &&
+			(hdev->asic_prop.fw_boot_cpu_security_map &
+					CPU_BOOT_DEV_STS0_HBM_CRED_EN))
+		return;
+
 	hbm0_wr = 0x33333333;
 	hbm0_rd = 0x77777777;
 	hbm1_wr = 0x55555555;
@@ -3606,7 +3642,8 @@ static int gaudi_init_cpu(struct hl_device *hdev)
 	 * The device CPU works with 40 bits addresses.
 	 * This register sets the extension to 50 bits.
 	 */
-	WREG32(mmCPU_IF_CPU_MSB_ADDR, hdev->cpu_pci_msb_addr);
+	if (hdev->asic_prop.fw_security_disabled)
+		WREG32(mmCPU_IF_CPU_MSB_ADDR, hdev->cpu_pci_msb_addr);
 
 	rc = hl_fw_init_cpu(hdev, mmPSOC_GLOBAL_CONF_CPU_BOOT_STATUS,
 			mmPSOC_GLOBAL_CONF_KMD_MSG_TO_CPU,
@@ -3691,17 +3728,19 @@ static void gaudi_pre_hw_init(struct hl_device *hdev)
 	/* Perform read from the device to make sure device is up */
 	RREG32(mmPCIE_DBI_DEVICE_ID_VENDOR_ID_REG);
 
-	/* Set the access through PCI bars (Linux driver only) as
-	 * secured
-	 */
-	WREG32(mmPCIE_WRAP_LBW_PROT_OVR,
-			(PCIE_WRAP_LBW_PROT_OVR_RD_EN_MASK |
-			PCIE_WRAP_LBW_PROT_OVR_WR_EN_MASK));
+	if (hdev->asic_prop.fw_security_disabled) {
+		/* Set the access through PCI bars (Linux driver only) as
+		 * secured
+		 */
+		WREG32(mmPCIE_WRAP_LBW_PROT_OVR,
+				(PCIE_WRAP_LBW_PROT_OVR_RD_EN_MASK |
+				PCIE_WRAP_LBW_PROT_OVR_WR_EN_MASK));
 
-	/* Perform read to flush the waiting writes to ensure
-	 * configuration was set in the device
-	 */
-	RREG32(mmPCIE_WRAP_LBW_PROT_OVR);
+		/* Perform read to flush the waiting writes to ensure
+		 * configuration was set in the device
+		 */
+		RREG32(mmPCIE_WRAP_LBW_PROT_OVR);
+	}
 
 	/*
 	 * Let's mark in the H/W that we have reached this point. We check
@@ -3710,32 +3749,33 @@ static void gaudi_pre_hw_init(struct hl_device *hdev)
 	 * cleared by the H/W upon H/W reset
 	 */
 	WREG32(mmHW_STATE, HL_DEVICE_HW_STATE_DIRTY);
+	if (hdev->asic_prop.fw_security_disabled) {
+		/* Configure the reset registers. Must be done as early as
+		 * possible in case we fail during H/W initialization
+		 */
+		WREG32(mmPSOC_GLOBAL_CONF_SOFT_RST_CFG_H,
+						(CFG_RST_H_DMA_MASK |
+						CFG_RST_H_MME_MASK |
+						CFG_RST_H_SM_MASK |
+						CFG_RST_H_TPC_7_MASK));
 
-	/* Configure the reset registers. Must be done as early as possible
-	 * in case we fail during H/W initialization
-	 */
-	WREG32(mmPSOC_GLOBAL_CONF_SOFT_RST_CFG_H,
-					(CFG_RST_H_DMA_MASK |
-					CFG_RST_H_MME_MASK |
-					CFG_RST_H_SM_MASK |
-					CFG_RST_H_TPC_7_MASK));
-
-	WREG32(mmPSOC_GLOBAL_CONF_SOFT_RST_CFG_L, CFG_RST_L_TPC_MASK);
-
-	WREG32(mmPSOC_GLOBAL_CONF_SW_ALL_RST_CFG_H,
-					(CFG_RST_H_HBM_MASK |
-					CFG_RST_H_TPC_7_MASK |
-					CFG_RST_H_NIC_MASK |
-					CFG_RST_H_SM_MASK |
-					CFG_RST_H_DMA_MASK |
-					CFG_RST_H_MME_MASK |
-					CFG_RST_H_CPU_MASK |
-					CFG_RST_H_MMU_MASK));
-
-	WREG32(mmPSOC_GLOBAL_CONF_SW_ALL_RST_CFG_L,
-					(CFG_RST_L_IF_MASK |
-					CFG_RST_L_PSOC_MASK |
-					CFG_RST_L_TPC_MASK));
+		WREG32(mmPSOC_GLOBAL_CONF_SOFT_RST_CFG_L, CFG_RST_L_TPC_MASK);
+
+		WREG32(mmPSOC_GLOBAL_CONF_SW_ALL_RST_CFG_H,
+						(CFG_RST_H_HBM_MASK |
+						CFG_RST_H_TPC_7_MASK |
+						CFG_RST_H_NIC_MASK |
+						CFG_RST_H_SM_MASK |
+						CFG_RST_H_DMA_MASK |
+						CFG_RST_H_MME_MASK |
+						CFG_RST_H_CPU_MASK |
+						CFG_RST_H_MMU_MASK));
+
+		WREG32(mmPSOC_GLOBAL_CONF_SW_ALL_RST_CFG_L,
+						(CFG_RST_L_IF_MASK |
+						CFG_RST_L_PSOC_MASK |
+						CFG_RST_L_TPC_MASK));
+	}
 }
 
 static int gaudi_hw_init(struct hl_device *hdev)
@@ -3851,7 +3891,8 @@ static void gaudi_hw_fini(struct hl_device *hdev, bool hard_reset)
 	WREG32(mmPSOC_GLOBAL_CONF_BOOT_STRAP_PINS, boot_strap & ~0x2);
 
 	/* Restart BTL/BLR upon hard-reset */
-	WREG32(mmPSOC_GLOBAL_CONF_BOOT_SEQ_RE_START, 1);
+	if (hdev->asic_prop.fw_security_disabled)
+		WREG32(mmPSOC_GLOBAL_CONF_BOOT_SEQ_RE_START, 1);
 
 	WREG32(mmPSOC_GLOBAL_CONF_SW_ALL_RST,
 			1 << PSOC_GLOBAL_CONF_SW_ALL_RST_IND_SHIFT);
diff --git a/drivers/misc/habanalabs/gaudi/gaudi_security.c b/drivers/misc/habanalabs/gaudi/gaudi_security.c
index 8a921ab56557..e10181692d0b 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi_security.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi_security.c
@@ -1448,21 +1448,23 @@ static void gaudi_init_dma_protection_bits(struct hl_device *hdev)
 	u32 pb_addr, mask;
 	u8 word_offset;
 
-	gaudi_pb_set_block(hdev, mmDMA_IF_E_S_BASE);
-	gaudi_pb_set_block(hdev, mmDMA_IF_E_S_DOWN_CH0_BASE);
-	gaudi_pb_set_block(hdev, mmDMA_IF_E_S_DOWN_CH1_BASE);
-	gaudi_pb_set_block(hdev, mmDMA_E_PLL_BASE);
-	gaudi_pb_set_block(hdev, mmDMA_IF_E_S_DOWN_BASE);
-
-	gaudi_pb_set_block(hdev, mmDMA_IF_W_N_BASE);
-	gaudi_pb_set_block(hdev, mmDMA_IF_W_N_DOWN_CH0_BASE);
-	gaudi_pb_set_block(hdev, mmDMA_IF_W_N_DOWN_CH1_BASE);
-	gaudi_pb_set_block(hdev, mmDMA_IF_W_N_DOWN_BASE);
-
-	gaudi_pb_set_block(hdev, mmDMA_IF_E_N_BASE);
-	gaudi_pb_set_block(hdev, mmDMA_IF_E_N_DOWN_CH0_BASE);
-	gaudi_pb_set_block(hdev, mmDMA_IF_E_N_DOWN_CH1_BASE);
-	gaudi_pb_set_block(hdev, mmDMA_IF_E_N_DOWN_BASE);
+	if (hdev->asic_prop.fw_security_disabled) {
+		gaudi_pb_set_block(hdev, mmDMA_IF_E_S_BASE);
+		gaudi_pb_set_block(hdev, mmDMA_IF_E_S_DOWN_CH0_BASE);
+		gaudi_pb_set_block(hdev, mmDMA_IF_E_S_DOWN_CH1_BASE);
+		gaudi_pb_set_block(hdev, mmDMA_E_PLL_BASE);
+		gaudi_pb_set_block(hdev, mmDMA_IF_E_S_DOWN_BASE);
+
+		gaudi_pb_set_block(hdev, mmDMA_IF_W_N_BASE);
+		gaudi_pb_set_block(hdev, mmDMA_IF_W_N_DOWN_CH0_BASE);
+		gaudi_pb_set_block(hdev, mmDMA_IF_W_N_DOWN_CH1_BASE);
+		gaudi_pb_set_block(hdev, mmDMA_IF_W_N_DOWN_BASE);
+
+		gaudi_pb_set_block(hdev, mmDMA_IF_E_N_BASE);
+		gaudi_pb_set_block(hdev, mmDMA_IF_E_N_DOWN_CH0_BASE);
+		gaudi_pb_set_block(hdev, mmDMA_IF_E_N_DOWN_CH1_BASE);
+		gaudi_pb_set_block(hdev, mmDMA_IF_E_N_DOWN_BASE);
+	}
 
 	WREG32(mmDMA0_QM_BASE - CFG_BASE + PROT_BITS_OFFS + 0x7C, 0);
 	WREG32(mmDMA1_QM_BASE - CFG_BASE + PROT_BITS_OFFS + 0x7C, 0);
@@ -9133,14 +9135,16 @@ static void gaudi_init_tpc_protection_bits(struct hl_device *hdev)
 	u32 pb_addr, mask;
 	u8 word_offset;
 
-	gaudi_pb_set_block(hdev, mmTPC0_E2E_CRED_BASE);
-	gaudi_pb_set_block(hdev, mmTPC1_E2E_CRED_BASE);
-	gaudi_pb_set_block(hdev, mmTPC2_E2E_CRED_BASE);
-	gaudi_pb_set_block(hdev, mmTPC3_E2E_CRED_BASE);
-	gaudi_pb_set_block(hdev, mmTPC4_E2E_CRED_BASE);
-	gaudi_pb_set_block(hdev, mmTPC5_E2E_CRED_BASE);
-	gaudi_pb_set_block(hdev, mmTPC6_E2E_CRED_BASE);
-	gaudi_pb_set_block(hdev, mmTPC7_E2E_CRED_BASE);
+	if (hdev->asic_prop.fw_security_disabled) {
+		gaudi_pb_set_block(hdev, mmTPC0_E2E_CRED_BASE);
+		gaudi_pb_set_block(hdev, mmTPC1_E2E_CRED_BASE);
+		gaudi_pb_set_block(hdev, mmTPC2_E2E_CRED_BASE);
+		gaudi_pb_set_block(hdev, mmTPC3_E2E_CRED_BASE);
+		gaudi_pb_set_block(hdev, mmTPC4_E2E_CRED_BASE);
+		gaudi_pb_set_block(hdev, mmTPC5_E2E_CRED_BASE);
+		gaudi_pb_set_block(hdev, mmTPC6_E2E_CRED_BASE);
+		gaudi_pb_set_block(hdev, mmTPC7_E2E_CRED_BASE);
+	}
 
 	WREG32(mmTPC0_QM_BASE - CFG_BASE + PROT_BITS_OFFS + 0x7C, 0);
 	WREG32(mmTPC0_CFG_BASE - CFG_BASE + PROT_BITS_OFFS + 0x7C, 0);
@@ -12822,11 +12826,13 @@ static void gaudi_init_protection_bits(struct hl_device *hdev)
 	 * secured
 	 */
 
-	gaudi_pb_set_block(hdev, mmIF_E_PLL_BASE);
-	gaudi_pb_set_block(hdev, mmMESH_W_PLL_BASE);
-	gaudi_pb_set_block(hdev, mmSRAM_W_PLL_BASE);
-	gaudi_pb_set_block(hdev, mmMESH_E_PLL_BASE);
-	gaudi_pb_set_block(hdev, mmSRAM_E_PLL_BASE);
+	if (hdev->asic_prop.fw_security_disabled) {
+		gaudi_pb_set_block(hdev, mmIF_E_PLL_BASE);
+		gaudi_pb_set_block(hdev, mmMESH_W_PLL_BASE);
+		gaudi_pb_set_block(hdev, mmSRAM_W_PLL_BASE);
+		gaudi_pb_set_block(hdev, mmMESH_E_PLL_BASE);
+		gaudi_pb_set_block(hdev, mmSRAM_E_PLL_BASE);
+	}
 
 	gaudi_init_dma_protection_bits(hdev);
 
@@ -13025,17 +13031,20 @@ void gaudi_init_security(struct hl_device *hdev)
 	 * property configuration of MME SBAB and ACC to be non-privileged and
 	 * non-secured
 	 */
-	WREG32(mmMME0_SBAB_PROT, 0x2);
-	WREG32(mmMME0_ACC_PROT, 0x2);
-	WREG32(mmMME1_SBAB_PROT, 0x2);
-	WREG32(mmMME1_ACC_PROT, 0x2);
-	WREG32(mmMME2_SBAB_PROT, 0x2);
-	WREG32(mmMME2_ACC_PROT, 0x2);
-	WREG32(mmMME3_SBAB_PROT, 0x2);
-	WREG32(mmMME3_ACC_PROT, 0x2);
+	if (hdev->asic_prop.fw_security_disabled) {
+		WREG32(mmMME0_SBAB_PROT, 0x2);
+		WREG32(mmMME0_ACC_PROT, 0x2);
+		WREG32(mmMME1_SBAB_PROT, 0x2);
+		WREG32(mmMME1_ACC_PROT, 0x2);
+		WREG32(mmMME2_SBAB_PROT, 0x2);
+		WREG32(mmMME2_ACC_PROT, 0x2);
+		WREG32(mmMME3_SBAB_PROT, 0x2);
+		WREG32(mmMME3_ACC_PROT, 0x2);
+	}
 
 	/* On RAZWI, 0 will be returned from RR and 0xBABA0BAD from PB */
-	WREG32(0xC01B28, 0x1);
+	if (hdev->asic_prop.fw_security_disabled)
+		WREG32(0xC01B28, 0x1);
 
 	gaudi_init_range_registers_lbw(hdev);
 
-- 
2.17.1

