Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8983A2B7EA5
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 14:54:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726580AbgKRNu7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 08:50:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:38302 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726131AbgKRNu7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 08:50:59 -0500
Received: from ogabbay-VM.habana-labs.com (unknown [213.57.90.10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5B5892065C;
        Wed, 18 Nov 2020 13:50:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605707456;
        bh=J4zd+PHNqUzQVFPmJw860vy70QYGBsOzqUazgv6RJ/k=;
        h=From:To:Cc:Subject:Date:From;
        b=v+osf/S8cIDAJQvda+prv/3IaM/CXW/PE/MplVd54vmQjBcmDnwR42DYq0aReRjkj
         x9xWV228Vk2WZub+xw3FjUA8ZuPGYtwKOvy4AP1ztdLTZC3YHVf+w6tno8mr9pvN9v
         /Bt2ueW3Q1aUr9qPfK/+PDyFT1AEnHvZ0WJfiQGo=
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     SW_Drivers@habana.ai, Alon Mizrahi <amizrahi@habana.ai>
Subject: [PATCH] habanalabs: fetch pll frequency from firmware
Date:   Wed, 18 Nov 2020 15:50:48 +0200
Message-Id: <20201118135050.19621-1-ogabbay@kernel.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alon Mizrahi <amizrahi@habana.ai>

Once firmware security is enabled, driver must fetch pll frequencies
through the firmware message interface instead of reading the registers
directly.

Signed-off-by: Alon Mizrahi <amizrahi@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/firmware_if.c  |  24 ++--
 drivers/misc/habanalabs/common/habanalabs.h   |   9 +-
 .../misc/habanalabs/common/habanalabs_ioctl.c |  22 +++
 drivers/misc/habanalabs/gaudi/gaudi.c         | 135 ++++++++++++------
 drivers/misc/habanalabs/gaudi/gaudiP.h        |   8 ++
 drivers/misc/habanalabs/goya/goya.c           |   2 +-
 .../misc/habanalabs/include/common/cpucp_if.h |  40 +++++-
 .../habanalabs/include/common/hl_boot_if.h    |   4 +
 .../include/gaudi/asic_reg/gaudi_regs.h       |  14 +-
 .../gaudi/asic_reg/psoc_hbm_pll_regs.h        | 114 ---------------
 .../gaudi/asic_reg/psoc_pci_pll_regs.h        | 114 ---------------
 include/uapi/misc/habanalabs.h                |   9 ++
 12 files changed, 199 insertions(+), 296 deletions(-)
 delete mode 100644 drivers/misc/habanalabs/include/gaudi/asic_reg/psoc_hbm_pll_regs.h
 delete mode 100644 drivers/misc/habanalabs/include/gaudi/asic_reg/psoc_pci_pll_regs.h

diff --git a/drivers/misc/habanalabs/common/firmware_if.c b/drivers/misc/habanalabs/common/firmware_if.c
index 8f70d0bbe5e1..c4a8d6ca34bb 100644
--- a/drivers/misc/habanalabs/common/firmware_if.c
+++ b/drivers/misc/habanalabs/common/firmware_if.c
@@ -279,7 +279,8 @@ int hl_fw_send_heartbeat(struct hl_device *hdev)
 	return rc;
 }
 
-int hl_fw_cpucp_info_get(struct hl_device *hdev)
+int hl_fw_cpucp_info_get(struct hl_device *hdev,
+			u32 cpu_security_boot_status_reg)
 {
 	struct asic_fixed_properties *prop = &hdev->asic_prop;
 	struct cpucp_packet pkt = {};
@@ -324,6 +325,11 @@ int hl_fw_cpucp_info_get(struct hl_device *hdev)
 		goto out;
 	}
 
+	/* Read FW application security bits again */
+	if (hdev->asic_prop.fw_security_status_valid)
+		hdev->asic_prop.fw_app_security_map =
+				RREG32(cpu_security_boot_status_reg);
+
 out:
 	hdev->asic_funcs->cpu_accessible_dma_pool_free(hdev,
 			sizeof(struct cpucp_info), cpucp_info_cpu_addr);
@@ -446,10 +452,8 @@ int hl_fw_cpucp_total_energy_get(struct hl_device *hdev, u64 *total_energy)
 	return rc;
 }
 
-int hl_fw_cpucp_pll_info_get(struct hl_device *hdev,
-		enum cpucp_pll_type_attributes pll_type,
-		enum cpucp_pll_reg_attributes pll_reg,
-		u32 *pll_info)
+int hl_fw_cpucp_pll_info_get(struct hl_device *hdev, u16 pll_index,
+		u16 *pll_freq_arr)
 {
 	struct cpucp_packet pkt;
 	u64 result;
@@ -457,17 +461,19 @@ int hl_fw_cpucp_pll_info_get(struct hl_device *hdev,
 
 	memset(&pkt, 0, sizeof(pkt));
 
-	pkt.ctl = cpu_to_le32(CPUCP_PACKET_PLL_REG_GET <<
+	pkt.ctl = cpu_to_le32(CPUCP_PACKET_PLL_INFO_GET <<
 				CPUCP_PKT_CTL_OPCODE_SHIFT);
-	pkt.pll_type = __cpu_to_le16(pll_type);
-	pkt.pll_reg = __cpu_to_le16(pll_reg);
+	pkt.pll_type = __cpu_to_le16(pll_index);
 
 	rc = hdev->asic_funcs->send_cpu_message(hdev, (u32 *) &pkt, sizeof(pkt),
 			HL_CPUCP_INFO_TIMEOUT_USEC, &result);
 	if (rc)
 		dev_err(hdev->dev, "Failed to read PLL info, error %d\n", rc);
 
-	*pll_info = (u32) result;
+	pll_freq_arr[0] = FIELD_GET(CPUCP_PKT_RES_PLL_OUT0_MASK, result);
+	pll_freq_arr[1] = FIELD_GET(CPUCP_PKT_RES_PLL_OUT1_MASK, result);
+	pll_freq_arr[2] = FIELD_GET(CPUCP_PKT_RES_PLL_OUT2_MASK, result);
+	pll_freq_arr[3] = FIELD_GET(CPUCP_PKT_RES_PLL_OUT3_MASK, result);
 
 	return rc;
 }
diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index e1db8301ecbd..9c9c8b24c47a 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -2191,16 +2191,15 @@ void *hl_fw_cpu_accessible_dma_pool_alloc(struct hl_device *hdev, size_t size,
 void hl_fw_cpu_accessible_dma_pool_free(struct hl_device *hdev, size_t size,
 					void *vaddr);
 int hl_fw_send_heartbeat(struct hl_device *hdev);
-int hl_fw_cpucp_info_get(struct hl_device *hdev);
+int hl_fw_cpucp_info_get(struct hl_device *hdev,
+			u32 cpu_security_boot_status_reg);
 int hl_fw_get_eeprom_data(struct hl_device *hdev, void *data, size_t max_size);
 int hl_fw_cpucp_pci_counters_get(struct hl_device *hdev,
 		struct hl_info_pci_counters *counters);
 int hl_fw_cpucp_total_energy_get(struct hl_device *hdev,
 			u64 *total_energy);
-int hl_fw_cpucp_pll_info_get(struct hl_device *hdev,
-		enum cpucp_pll_type_attributes pll_type,
-		enum cpucp_pll_reg_attributes pll_reg,
-		u32 *pll_info);
+int hl_fw_cpucp_pll_info_get(struct hl_device *hdev, u16 pll_index,
+		u16 *pll_freq_arr);
 int hl_fw_init_cpu(struct hl_device *hdev, u32 cpu_boot_status_reg,
 			u32 msg_to_cpu_reg, u32 cpu_msg_status_reg,
 			u32 cpu_security_boot_status_reg, u32 boot_err0_reg,
diff --git a/drivers/misc/habanalabs/common/habanalabs_ioctl.c b/drivers/misc/habanalabs/common/habanalabs_ioctl.c
index ba8217fc9425..32e6af1db4e3 100644
--- a/drivers/misc/habanalabs/common/habanalabs_ioctl.c
+++ b/drivers/misc/habanalabs/common/habanalabs_ioctl.c
@@ -403,6 +403,25 @@ static int total_energy_consumption_info(struct hl_fpriv *hpriv,
 		min((size_t) max_size, sizeof(total_energy))) ? -EFAULT : 0;
 }
 
+static int pll_frequency_info(struct hl_fpriv *hpriv, struct hl_info_args *args)
+{
+	struct hl_device *hdev = hpriv->hdev;
+	struct hl_pll_frequency_info freq_info = {0};
+	u32 max_size = args->return_size;
+	void __user *out = (void __user *) (uintptr_t) args->return_pointer;
+	int rc;
+
+	if ((!max_size) || (!out))
+		return -EINVAL;
+
+	rc = hl_fw_cpucp_pll_info_get(hdev, args->pll_index, freq_info.output);
+	if (rc)
+		return rc;
+
+	return copy_to_user(out, &freq_info,
+		min((size_t) max_size, sizeof(freq_info))) ? -EFAULT : 0;
+}
+
 static int _hl_info_ioctl(struct hl_fpriv *hpriv, void *data,
 				struct device *dev)
 {
@@ -480,6 +499,9 @@ static int _hl_info_ioctl(struct hl_fpriv *hpriv, void *data,
 	case HL_INFO_TOTAL_ENERGY:
 		return total_energy_consumption_info(hpriv, args);
 
+	case HL_INFO_PLL_FREQUENCY:
+		return pll_frequency_info(hpriv, args);
+
 	default:
 		dev_err(dev, "Invalid request %d\n", args->op);
 		rc = -ENOTTY;
diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index c44a883d9787..4d1d57f9cd74 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -103,6 +103,8 @@
 
 #define HBM_SCRUBBING_TIMEOUT_US	1000000 /* 1s */
 
+#define GAUDI_PLL_MAX 10
+
 static const char gaudi_irq_name[GAUDI_MSI_ENTRIES][GAUDI_MAX_STRING_LEN] = {
 		"gaudi cq 0_0", "gaudi cq 0_1", "gaudi cq 0_2", "gaudi cq 0_3",
 		"gaudi cq 1_0", "gaudi cq 1_1", "gaudi cq 1_2", "gaudi cq 1_3",
@@ -149,6 +151,19 @@ static const u16 gaudi_packet_sizes[MAX_PACKET_ID] = {
 	[PACKET_LOAD_AND_EXE]	= sizeof(struct packet_load_and_exe)
 };
 
+static const u32 gaudi_pll_base_addresses[GAUDI_PLL_MAX] = {
+	[CPU_PLL] = mmPSOC_CPU_PLL_NR,
+	[PCI_PLL] = mmPSOC_PCI_PLL_NR,
+	[SRAM_PLL] = mmSRAM_W_PLL_NR,
+	[HBM_PLL] = mmPSOC_HBM_PLL_NR,
+	[NIC_PLL] = mmNIC0_PLL_NR,
+	[DMA_PLL] = mmDMA_W_PLL_NR,
+	[MESH_PLL] = mmMESH_W_PLL_NR,
+	[MME_PLL] = mmPSOC_MME_PLL_NR,
+	[TPC_PLL] = mmPSOC_TPC_PLL_NR,
+	[IF_PLL] = mmIF_W_PLL_NR
+};
+
 static inline bool validate_packet_id(enum packet_id id)
 {
 	switch (id) {
@@ -688,61 +703,93 @@ static int gaudi_early_fini(struct hl_device *hdev)
 }
 
 /**
- * gaudi_fetch_psoc_frequency - Fetch PSOC frequency values
+ * gaudi_fetch_pll_frequency - Fetch PLL frequency values
  *
  * @hdev: pointer to hl_device structure
+ * @pll_index: index of the pll to fetch frequency from
+ * @pll_freq: pointer to store the pll frequency in MHz in each of the available
+ *            outputs. if a certain output is not available a 0 will be set
  *
  */
-static int gaudi_fetch_psoc_frequency(struct hl_device *hdev)
+static int gaudi_fetch_pll_frequency(struct hl_device *hdev,
+				enum gaudi_pll_index pll_index,
+				u16 *pll_freq_arr)
 {
-	struct asic_fixed_properties *prop = &hdev->asic_prop;
-	u32 trace_freq = 0, pll_clk = 0;
-	u32 div_fctr, div_sel, nr, nf, od;
-	int rc;
+	u32 nr = 0, nf = 0, od = 0, pll_clk = 0, div_fctr, div_sel,
+			pll_base_addr = gaudi_pll_base_addresses[pll_index];
+	u16 freq = 0;
+	int i, rc;
+
+	if (hdev->asic_prop.fw_security_status_valid &&
+			(hdev->asic_prop.fw_app_security_map &
+					CPU_BOOT_DEV_STS0_PLL_INFO_EN)) {
+		rc = hl_fw_cpucp_pll_info_get(hdev, pll_index, pll_freq_arr);
 
-	if (hdev->asic_prop.fw_security_disabled) {
-		div_fctr = RREG32(mmPSOC_CPU_PLL_DIV_FACTOR_2);
-		div_sel = RREG32(mmPSOC_CPU_PLL_DIV_SEL_2);
-		nr = RREG32(mmPSOC_CPU_PLL_NR);
-		nf = RREG32(mmPSOC_CPU_PLL_NF);
-		od = RREG32(mmPSOC_CPU_PLL_OD);
-	} else {
-		rc = hl_fw_cpucp_pll_info_get(hdev, cpucp_pll_cpu,
-				cpucp_pll_div_factor_reg, &div_fctr);
-		rc |= hl_fw_cpucp_pll_info_get(hdev, cpucp_pll_cpu,
-				cpucp_pll_div_sel_reg, &div_sel);
-		rc |= hl_fw_cpucp_pll_info_get(hdev, cpucp_pll_cpu,
-				cpucp_pll_nr_reg, &nr);
-		rc |= hl_fw_cpucp_pll_info_get(hdev, cpucp_pll_cpu,
-				cpucp_pll_nf_reg, &nf);
-		rc |= hl_fw_cpucp_pll_info_get(hdev, cpucp_pll_cpu,
-				cpucp_pll_od_reg, &od);
 		if (rc)
 			return rc;
-	}
-
-	if (div_sel == DIV_SEL_REF_CLK || div_sel == DIV_SEL_DIVIDED_REF) {
-		if (div_sel == DIV_SEL_REF_CLK)
-			trace_freq = PLL_REF_CLK;
-		else
-			trace_freq = PLL_REF_CLK / (div_fctr + 1);
-	} else if (div_sel == DIV_SEL_PLL_CLK ||
+	} else if (hdev->asic_prop.fw_security_disabled) {
+		/* Backward compatibility */
+		nr = RREG32(pll_base_addr + PLL_NR_OFFSET);
+		nf = RREG32(pll_base_addr + PLL_NF_OFFSET);
+		od = RREG32(pll_base_addr + PLL_OD_OFFSET);
+
+		for (i = 0; i < HL_PLL_NUM_OUTPUTS; i++) {
+			div_fctr = RREG32(pll_base_addr +
+					PLL_DIV_FACTOR_0_OFFSET + i * 4);
+			div_sel = RREG32(pll_base_addr +
+					PLL_DIV_SEL_0_OFFSET + i * 4);
+
+			if (div_sel == DIV_SEL_REF_CLK ||
+				div_sel == DIV_SEL_DIVIDED_REF) {
+				if (div_sel == DIV_SEL_REF_CLK)
+					freq = PLL_REF_CLK;
+				else
+					freq = PLL_REF_CLK / (div_fctr + 1);
+			} else if (div_sel == DIV_SEL_PLL_CLK ||
 					div_sel == DIV_SEL_DIVIDED_PLL) {
-		pll_clk = PLL_REF_CLK * (nf + 1) / ((nr + 1) * (od + 1));
-		if (div_sel == DIV_SEL_PLL_CLK)
-			trace_freq = pll_clk;
-		else
-			trace_freq = pll_clk / (div_fctr + 1);
+				pll_clk = PLL_REF_CLK * (nf + 1) /
+						((nr + 1) * (od + 1));
+				if (div_sel == DIV_SEL_PLL_CLK)
+					freq = pll_clk;
+				else
+					freq = pll_clk / (div_fctr + 1);
+			} else {
+				dev_warn(hdev->dev,
+					"Received invalid div select value: %d",
+					div_sel);
+			}
+
+			pll_freq_arr[i] = freq;
+		}
 	} else {
-		dev_warn(hdev->dev,
-			"Received invalid div select value: %d", div_sel);
+		dev_err(hdev->dev, "Failed to fetch PLL frequency values\n");
+		return -EIO;
 	}
 
-	prop->psoc_timestamp_frequency = trace_freq;
-	prop->psoc_pci_pll_nr = nr;
-	prop->psoc_pci_pll_nf = nf;
-	prop->psoc_pci_pll_od = od;
-	prop->psoc_pci_pll_div_factor = div_fctr;
+	return 0;
+}
+
+/**
+ * gaudi_fetch_psoc_frequency - Fetch PSOC frequency values
+ *
+ * @hdev: pointer to hl_device structure
+ *
+ */
+static int gaudi_fetch_psoc_frequency(struct hl_device *hdev)
+{
+	struct asic_fixed_properties *prop = &hdev->asic_prop;
+	u16 pll_freq[HL_PLL_NUM_OUTPUTS];
+	int rc;
+
+	rc = gaudi_fetch_pll_frequency(hdev, CPU_PLL, pll_freq);
+	if (rc)
+		return rc;
+
+	prop->psoc_timestamp_frequency = pll_freq[2];
+	prop->psoc_pci_pll_nr = 0;
+	prop->psoc_pci_pll_nf = 0;
+	prop->psoc_pci_pll_od = 0;
+	prop->psoc_pci_pll_div_factor = 0;
 
 	return 0;
 }
@@ -7449,7 +7496,7 @@ static int gaudi_cpucp_info_get(struct hl_device *hdev)
 	if (!(gaudi->hw_cap_initialized & HW_CAP_CPU_Q))
 		return 0;
 
-	rc = hl_fw_cpucp_info_get(hdev);
+	rc = hl_fw_cpucp_info_get(hdev, mmCPU_BOOT_DEV_STS0);
 	if (rc)
 		return rc;
 
diff --git a/drivers/misc/habanalabs/gaudi/gaudiP.h b/drivers/misc/habanalabs/gaudi/gaudiP.h
index 1a5e681c720d..f2d91f4fcffe 100644
--- a/drivers/misc/habanalabs/gaudi/gaudiP.h
+++ b/drivers/misc/habanalabs/gaudi/gaudiP.h
@@ -14,6 +14,7 @@
 #include "../include/gaudi/gaudi_packets.h"
 #include "../include/gaudi/gaudi.h"
 #include "../include/gaudi/gaudi_async_events.h"
+#include "../include/gaudi/gaudi_fw_if.h"
 
 #define NUMBER_OF_EXT_HW_QUEUES		8
 #define NUMBER_OF_CMPLT_QUEUES		NUMBER_OF_EXT_HW_QUEUES
@@ -104,6 +105,13 @@
 #define MME_ACC_OFFSET		(mmMME1_ACC_BASE - mmMME0_ACC_BASE)
 #define SRAM_BANK_OFFSET	(mmSRAM_Y0_X1_RTR_BASE - mmSRAM_Y0_X0_RTR_BASE)
 
+#define PLL_NR_OFFSET		0
+#define PLL_NF_OFFSET		(mmPSOC_CPU_PLL_NF - mmPSOC_CPU_PLL_NR)
+#define PLL_OD_OFFSET		(mmPSOC_CPU_PLL_OD - mmPSOC_CPU_PLL_NR)
+#define PLL_DIV_FACTOR_0_OFFSET	(mmPSOC_CPU_PLL_DIV_FACTOR_0 - \
+				mmPSOC_CPU_PLL_NR)
+#define PLL_DIV_SEL_0_OFFSET	(mmPSOC_CPU_PLL_DIV_SEL_0 - mmPSOC_CPU_PLL_NR)
+
 #define NUM_OF_SOB_IN_BLOCK		\
 	(((mmSYNC_MNGR_E_N_SYNC_MNGR_OBJS_SOB_OBJ_2047 - \
 	mmSYNC_MNGR_E_N_SYNC_MNGR_OBJS_SOB_OBJ_0) + 4) >> 2)
diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index 342227b93778..d91f553b8595 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -5156,7 +5156,7 @@ int goya_cpucp_info_get(struct hl_device *hdev)
 	if (!(goya->hw_cap_initialized & HW_CAP_CPU_Q))
 		return 0;
 
-	rc = hl_fw_cpucp_info_get(hdev);
+	rc = hl_fw_cpucp_info_get(hdev, mmCPU_BOOT_DEV_STS0);
 	if (rc)
 		return rc;
 
diff --git a/drivers/misc/habanalabs/include/common/cpucp_if.h b/drivers/misc/habanalabs/include/common/cpucp_if.h
index 759c068b2b7a..554f82271d5f 100644
--- a/drivers/misc/habanalabs/include/common/cpucp_if.h
+++ b/drivers/misc/habanalabs/include/common/cpucp_if.h
@@ -252,10 +252,26 @@ enum pq_init_status {
  *       The packet's arguments specify the desired sensor and the field to
  *       set.
  *
- * CPUCP_PACKET_PLL_REG_GET
- *       Fetch register of PLL from the required PLL IP.
- *       The packet's arguments specify the PLL IP and the register to get.
- *       Each register is 32-bit value which is returned in result field.
+ * CPUCP_PACKET_PCIE_THROUGHPUT_GET
+ *       Get throughput of PCIe.
+ *       The packet's arguments specify the transaction direction (TX/RX).
+ *       The window measurement is 10[msec], and the return value is in KB/sec.
+ *
+ * CPUCP_PACKET_PCIE_REPLAY_CNT_GET
+ *       Replay count measures number of "replay" events, which is basicly
+ *       number of retries done by PCIe.
+ *
+ * CPUCP_PACKET_TOTAL_ENERGY_GET
+ *       Total Energy is measurement of energy from the time FW Linux
+ *       is loaded. It is calculated by multiplying the average power
+ *       by time (passed from armcp start). The units are in MilliJouls.
+ *
+ * CPUCP_PACKET_PLL_INFO_GET
+ *       Fetch frequencies of PLL from the required PLL IP.
+ *       The packet's arguments specify the device PLL type
+ *       Pll type is the PLL from device pll_index enum.
+ *       The result is composed of 4 outputs, each is 16-bit
+ *       frequency in MHz.
  *
  */
 
@@ -289,7 +305,7 @@ enum cpucp_packet_id {
 	CPUCP_PACKET_PCIE_THROUGHPUT_GET,	/* internal */
 	CPUCP_PACKET_PCIE_REPLAY_CNT_GET,	/* internal */
 	CPUCP_PACKET_TOTAL_ENERGY_GET,		/* internal */
-	CPUCP_PACKET_PLL_REG_GET,		/* internal */
+	CPUCP_PACKET_PLL_INFO_GET,		/* internal */
 };
 
 #define CPUCP_PACKET_FENCE_VAL	0xFE8CE7A5
@@ -300,6 +316,15 @@ enum cpucp_packet_id {
 #define CPUCP_PKT_CTL_OPCODE_SHIFT	16
 #define CPUCP_PKT_CTL_OPCODE_MASK	0x1FFF0000
 
+#define CPUCP_PKT_RES_PLL_OUT0_SHIFT	0
+#define CPUCP_PKT_RES_PLL_OUT0_MASK	0x000000000000FFFF
+#define CPUCP_PKT_RES_PLL_OUT1_SHIFT	16
+#define CPUCP_PKT_RES_PLL_OUT1_MASK	0x00000000FFFF0000
+#define CPUCP_PKT_RES_PLL_OUT2_SHIFT	32
+#define CPUCP_PKT_RES_PLL_OUT2_MASK	0x0000FFFF00000000
+#define CPUCP_PKT_RES_PLL_OUT3_SHIFT	48
+#define CPUCP_PKT_RES_PLL_OUT3_MASK	0xFFFF000000000000
+
 struct cpucp_packet {
 	union {
 		__le64 value;	/* For SET packets */
@@ -324,8 +349,9 @@ struct cpucp_packet {
 			__u8 pad; /* unused */
 		};
 
-		struct {/* For PLL register fetch */
+		struct {/* For PLL info fetch */
 			__le16 pll_type;
+			/* TODO pll_reg is kept temporary before removal */
 			__le16 pll_reg;
 		};
 
@@ -404,6 +430,7 @@ enum cpucp_pcie_throughput_attributes {
 	cpucp_pcie_throughput_rx
 };
 
+/* TODO temporary kept before removal */
 enum cpucp_pll_reg_attributes {
 	cpucp_pll_nr_reg,
 	cpucp_pll_nf_reg,
@@ -412,6 +439,7 @@ enum cpucp_pll_reg_attributes {
 	cpucp_pll_div_sel_reg
 };
 
+/* TODO temporary kept before removal */
 enum cpucp_pll_type_attributes {
 	cpucp_pll_cpu,
 	cpucp_pll_pci,
diff --git a/drivers/misc/habanalabs/include/common/hl_boot_if.h b/drivers/misc/habanalabs/include/common/hl_boot_if.h
index 60916780df35..68ac15c53f37 100644
--- a/drivers/misc/habanalabs/include/common/hl_boot_if.h
+++ b/drivers/misc/habanalabs/include/common/hl_boot_if.h
@@ -131,6 +131,9 @@
  *					receiving the halt-machine event.
  *					Initialized in: linux
  *
+ * CPU_BOOT_DEV_STS0_PLL_INFO_EN	FW retrieval of PLL info is enabled.
+ *					Initialized in: linux
+ *
  * CPU_BOOT_DEV_STS0_ENABLED		Device status register enabled.
  *					This is a main indication that the
  *					running FW populates the device status
@@ -150,6 +153,7 @@
 #define CPU_BOOT_DEV_STS0_SRAM_SCR_EN			(1 << 8)
 #define CPU_BOOT_DEV_STS0_DRAM_SCR_EN			(1 << 9)
 #define CPU_BOOT_DEV_STS0_FW_HARD_RST_EN		(1 << 10)
+#define CPU_BOOT_DEV_STS0_PLL_INFO_EN			(1 << 11)
 #define CPU_BOOT_DEV_STS0_ENABLED			(1 << 31)
 
 enum cpu_boot_status {
diff --git a/drivers/misc/habanalabs/include/gaudi/asic_reg/gaudi_regs.h b/drivers/misc/habanalabs/include/gaudi/asic_reg/gaudi_regs.h
index df21a40691e5..5bb54b34a8ae 100644
--- a/drivers/misc/habanalabs/include/gaudi/asic_reg/gaudi_regs.h
+++ b/drivers/misc/habanalabs/include/gaudi/asic_reg/gaudi_regs.h
@@ -81,6 +81,7 @@
 #include "sif_rtr_ctrl_6_regs.h"
 #include "sif_rtr_ctrl_7_regs.h"
 #include "psoc_etr_regs.h"
+#include "psoc_cpu_pll_regs.h"
 
 #include "dma0_qm_masks.h"
 #include "mme0_qm_masks.h"
@@ -102,9 +103,6 @@
 
 #include "nic0_qm0_masks.h"
 
-#include "psoc_hbm_pll_regs.h"
-#include "psoc_cpu_pll_regs.h"
-
 #define GAUDI_ECC_MEM_SEL_OFFSET		0xF18
 #define GAUDI_ECC_ADDRESS_OFFSET		0xF1C
 #define GAUDI_ECC_SYNDROME_OFFSET		0xF20
@@ -307,4 +305,14 @@
 #define mmPCIE_AUX_FLR_CTRL                                          0xC07394
 #define mmPCIE_AUX_DBI                                               0xC07490
 
+#define mmPSOC_PCI_PLL_NR                                            0xC72100
+#define mmSRAM_W_PLL_NR                                              0x4C8100
+#define mmPSOC_HBM_PLL_NR                                            0xC74100
+#define mmNIC0_PLL_NR                                                0xCF9100
+#define mmDMA_W_PLL_NR                                               0x487100
+#define mmMESH_W_PLL_NR                                              0x4C7100
+#define mmPSOC_MME_PLL_NR                                            0xC71100
+#define mmPSOC_TPC_PLL_NR                                            0xC73100
+#define mmIF_W_PLL_NR                                                0x488100
+
 #endif /* ASIC_REG_GAUDI_REGS_H_ */
diff --git a/drivers/misc/habanalabs/include/gaudi/asic_reg/psoc_hbm_pll_regs.h b/drivers/misc/habanalabs/include/gaudi/asic_reg/psoc_hbm_pll_regs.h
deleted file mode 100644
index 687e2255cb19..000000000000
--- a/drivers/misc/habanalabs/include/gaudi/asic_reg/psoc_hbm_pll_regs.h
+++ /dev/null
@@ -1,114 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0
- *
- * Copyright 2016-2018 HabanaLabs, Ltd.
- * All Rights Reserved.
- *
- */
-
-/************************************
- ** This is an auto-generated file **
- **       DO NOT EDIT BELOW        **
- ************************************/
-
-#ifndef ASIC_REG_PSOC_HBM_PLL_REGS_H_
-#define ASIC_REG_PSOC_HBM_PLL_REGS_H_
-
-/*
- *****************************************
- *   PSOC_HBM_PLL (Prototype: PLL)
- *****************************************
- */
-
-#define mmPSOC_HBM_PLL_NR                                            0xC74100
-
-#define mmPSOC_HBM_PLL_NF                                            0xC74104
-
-#define mmPSOC_HBM_PLL_OD                                            0xC74108
-
-#define mmPSOC_HBM_PLL_NB                                            0xC7410C
-
-#define mmPSOC_HBM_PLL_CFG                                           0xC74110
-
-#define mmPSOC_HBM_PLL_LOSE_MASK                                     0xC74120
-
-#define mmPSOC_HBM_PLL_LOCK_INTR                                     0xC74128
-
-#define mmPSOC_HBM_PLL_LOCK_BYPASS                                   0xC7412C
-
-#define mmPSOC_HBM_PLL_DATA_CHNG                                     0xC74130
-
-#define mmPSOC_HBM_PLL_RST                                           0xC74134
-
-#define mmPSOC_HBM_PLL_SLIP_WD_CNTR                                  0xC74150
-
-#define mmPSOC_HBM_PLL_DIV_FACTOR_0                                  0xC74200
-
-#define mmPSOC_HBM_PLL_DIV_FACTOR_1                                  0xC74204
-
-#define mmPSOC_HBM_PLL_DIV_FACTOR_2                                  0xC74208
-
-#define mmPSOC_HBM_PLL_DIV_FACTOR_3                                  0xC7420C
-
-#define mmPSOC_HBM_PLL_DIV_FACTOR_CMD_0                              0xC74220
-
-#define mmPSOC_HBM_PLL_DIV_FACTOR_CMD_1                              0xC74224
-
-#define mmPSOC_HBM_PLL_DIV_FACTOR_CMD_2                              0xC74228
-
-#define mmPSOC_HBM_PLL_DIV_FACTOR_CMD_3                              0xC7422C
-
-#define mmPSOC_HBM_PLL_DIV_SEL_0                                     0xC74280
-
-#define mmPSOC_HBM_PLL_DIV_SEL_1                                     0xC74284
-
-#define mmPSOC_HBM_PLL_DIV_SEL_2                                     0xC74288
-
-#define mmPSOC_HBM_PLL_DIV_SEL_3                                     0xC7428C
-
-#define mmPSOC_HBM_PLL_DIV_EN_0                                      0xC742A0
-
-#define mmPSOC_HBM_PLL_DIV_EN_1                                      0xC742A4
-
-#define mmPSOC_HBM_PLL_DIV_EN_2                                      0xC742A8
-
-#define mmPSOC_HBM_PLL_DIV_EN_3                                      0xC742AC
-
-#define mmPSOC_HBM_PLL_DIV_FACTOR_BUSY_0                             0xC742C0
-
-#define mmPSOC_HBM_PLL_DIV_FACTOR_BUSY_1                             0xC742C4
-
-#define mmPSOC_HBM_PLL_DIV_FACTOR_BUSY_2                             0xC742C8
-
-#define mmPSOC_HBM_PLL_DIV_FACTOR_BUSY_3                             0xC742CC
-
-#define mmPSOC_HBM_PLL_CLK_GATER                                     0xC74300
-
-#define mmPSOC_HBM_PLL_CLK_RLX_0                                     0xC74310
-
-#define mmPSOC_HBM_PLL_CLK_RLX_1                                     0xC74314
-
-#define mmPSOC_HBM_PLL_CLK_RLX_2                                     0xC74318
-
-#define mmPSOC_HBM_PLL_CLK_RLX_3                                     0xC7431C
-
-#define mmPSOC_HBM_PLL_REF_CNTR_PERIOD                               0xC74400
-
-#define mmPSOC_HBM_PLL_REF_LOW_THRESHOLD                             0xC74410
-
-#define mmPSOC_HBM_PLL_REF_HIGH_THRESHOLD                            0xC74420
-
-#define mmPSOC_HBM_PLL_PLL_NOT_STABLE                                0xC74430
-
-#define mmPSOC_HBM_PLL_FREQ_CALC_EN                                  0xC74440
-
-#define mmPSOC_HBM_PLL_RLX_BITMAP_CFG                                0xC74500
-
-#define mmPSOC_HBM_PLL_RLX_BITMAP_0                                  0xC74510
-
-#define mmPSOC_HBM_PLL_RLX_BITMAP_1                                  0xC74514
-
-#define mmPSOC_HBM_PLL_RLX_BITMAP_2                                  0xC74518
-
-#define mmPSOC_HBM_PLL_RLX_BITMAP_3                                  0xC7451C
-
-#endif /* ASIC_REG_PSOC_HBM_PLL_REGS_H_ */
diff --git a/drivers/misc/habanalabs/include/gaudi/asic_reg/psoc_pci_pll_regs.h b/drivers/misc/habanalabs/include/gaudi/asic_reg/psoc_pci_pll_regs.h
deleted file mode 100644
index 3dc9bb4542dd..000000000000
--- a/drivers/misc/habanalabs/include/gaudi/asic_reg/psoc_pci_pll_regs.h
+++ /dev/null
@@ -1,114 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0
- *
- * Copyright 2016-2018 HabanaLabs, Ltd.
- * All Rights Reserved.
- *
- */
-
-/************************************
- ** This is an auto-generated file **
- **       DO NOT EDIT BELOW        **
- ************************************/
-
-#ifndef ASIC_REG_PSOC_PCI_PLL_REGS_H_
-#define ASIC_REG_PSOC_PCI_PLL_REGS_H_
-
-/*
- *****************************************
- *   PSOC_PCI_PLL (Prototype: PLL)
- *****************************************
- */
-
-#define mmPSOC_PCI_PLL_NR                                            0xC72100
-
-#define mmPSOC_PCI_PLL_NF                                            0xC72104
-
-#define mmPSOC_PCI_PLL_OD                                            0xC72108
-
-#define mmPSOC_PCI_PLL_NB                                            0xC7210C
-
-#define mmPSOC_PCI_PLL_CFG                                           0xC72110
-
-#define mmPSOC_PCI_PLL_LOSE_MASK                                     0xC72120
-
-#define mmPSOC_PCI_PLL_LOCK_INTR                                     0xC72128
-
-#define mmPSOC_PCI_PLL_LOCK_BYPASS                                   0xC7212C
-
-#define mmPSOC_PCI_PLL_DATA_CHNG                                     0xC72130
-
-#define mmPSOC_PCI_PLL_RST                                           0xC72134
-
-#define mmPSOC_PCI_PLL_SLIP_WD_CNTR                                  0xC72150
-
-#define mmPSOC_PCI_PLL_DIV_FACTOR_0                                  0xC72200
-
-#define mmPSOC_PCI_PLL_DIV_FACTOR_1                                  0xC72204
-
-#define mmPSOC_PCI_PLL_DIV_FACTOR_2                                  0xC72208
-
-#define mmPSOC_PCI_PLL_DIV_FACTOR_3                                  0xC7220C
-
-#define mmPSOC_PCI_PLL_DIV_FACTOR_CMD_0                              0xC72220
-
-#define mmPSOC_PCI_PLL_DIV_FACTOR_CMD_1                              0xC72224
-
-#define mmPSOC_PCI_PLL_DIV_FACTOR_CMD_2                              0xC72228
-
-#define mmPSOC_PCI_PLL_DIV_FACTOR_CMD_3                              0xC7222C
-
-#define mmPSOC_PCI_PLL_DIV_SEL_0                                     0xC72280
-
-#define mmPSOC_PCI_PLL_DIV_SEL_1                                     0xC72284
-
-#define mmPSOC_PCI_PLL_DIV_SEL_2                                     0xC72288
-
-#define mmPSOC_PCI_PLL_DIV_SEL_3                                     0xC7228C
-
-#define mmPSOC_PCI_PLL_DIV_EN_0                                      0xC722A0
-
-#define mmPSOC_PCI_PLL_DIV_EN_1                                      0xC722A4
-
-#define mmPSOC_PCI_PLL_DIV_EN_2                                      0xC722A8
-
-#define mmPSOC_PCI_PLL_DIV_EN_3                                      0xC722AC
-
-#define mmPSOC_PCI_PLL_DIV_FACTOR_BUSY_0                             0xC722C0
-
-#define mmPSOC_PCI_PLL_DIV_FACTOR_BUSY_1                             0xC722C4
-
-#define mmPSOC_PCI_PLL_DIV_FACTOR_BUSY_2                             0xC722C8
-
-#define mmPSOC_PCI_PLL_DIV_FACTOR_BUSY_3                             0xC722CC
-
-#define mmPSOC_PCI_PLL_CLK_GATER                                     0xC72300
-
-#define mmPSOC_PCI_PLL_CLK_RLX_0                                     0xC72310
-
-#define mmPSOC_PCI_PLL_CLK_RLX_1                                     0xC72314
-
-#define mmPSOC_PCI_PLL_CLK_RLX_2                                     0xC72318
-
-#define mmPSOC_PCI_PLL_CLK_RLX_3                                     0xC7231C
-
-#define mmPSOC_PCI_PLL_REF_CNTR_PERIOD                               0xC72400
-
-#define mmPSOC_PCI_PLL_REF_LOW_THRESHOLD                             0xC72410
-
-#define mmPSOC_PCI_PLL_REF_HIGH_THRESHOLD                            0xC72420
-
-#define mmPSOC_PCI_PLL_PLL_NOT_STABLE                                0xC72430
-
-#define mmPSOC_PCI_PLL_FREQ_CALC_EN                                  0xC72440
-
-#define mmPSOC_PCI_PLL_RLX_BITMAP_CFG                                0xC72500
-
-#define mmPSOC_PCI_PLL_RLX_BITMAP_0                                  0xC72510
-
-#define mmPSOC_PCI_PLL_RLX_BITMAP_1                                  0xC72514
-
-#define mmPSOC_PCI_PLL_RLX_BITMAP_2                                  0xC72518
-
-#define mmPSOC_PCI_PLL_RLX_BITMAP_3                                  0xC7251C
-
-#endif /* ASIC_REG_PSOC_PCI_PLL_REGS_H_ */
diff --git a/include/uapi/misc/habanalabs.h b/include/uapi/misc/habanalabs.h
index d9cc782aba21..96eea49f48bc 100644
--- a/include/uapi/misc/habanalabs.h
+++ b/include/uapi/misc/habanalabs.h
@@ -295,6 +295,7 @@ enum hl_device_status {
 #define HL_INFO_CLK_THROTTLE_REASON	13
 #define HL_INFO_SYNC_MANAGER		14
 #define HL_INFO_TOTAL_ENERGY		15
+#define HL_INFO_PLL_FREQUENCY		16
 
 #define HL_INFO_VERSION_MAX_LEN	128
 #define HL_INFO_CARD_NAME_MAX_LEN	16
@@ -396,6 +397,12 @@ struct hl_info_energy {
 	__u64 total_energy_consumption;
 };
 
+#define HL_PLL_NUM_OUTPUTS 4
+
+struct hl_pll_frequency_info {
+	__u16 output[HL_PLL_NUM_OUTPUTS];
+};
+
 /**
  * struct hl_info_sync_manager - sync manager information
  * @first_available_sync_object: first available sob
@@ -465,6 +472,8 @@ struct hl_info_args {
 		 * resolution.
 		 */
 		__u32 period_ms;
+		/* PLL frequency retrieval */
+		__u32 pll_index;
 	};
 
 	__u32 pad;
-- 
2.17.1

