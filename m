Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5672F2A79FC
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 10:04:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730154AbgKEJEr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 04:04:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:48878 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725827AbgKEJEr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 04:04:47 -0500
Received: from ogabbay-VM.habana-labs.com (unknown [213.57.90.10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 11769206FB;
        Thu,  5 Nov 2020 09:04:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604567086;
        bh=A4T81MkZyloNwWCnQc9kSbkNnEXglGBNMByyQjG8RS8=;
        h=From:To:Cc:Subject:Date:From;
        b=eRVnJKEZJnUS0Mo1rKZOnUK+pKlY0wnktbo8WNlqhAWoMVcwBONI0Ep72jeauqRBj
         4yQv0KpgHwt22FfrO2OG9m3+mgMmdzSRFINEIK41qcgilpid8PxAEIh/4zBsGMpj/Z
         c/S4aiBWDjlynqNOY75H+xzDmLUOI4z4Rpk++Spo=
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     SW_Drivers@habana.ai, Ofir Bitton <obitton@habana.ai>
Subject: [PATCH] habanalabs: move HW dirty check to a proper location
Date:   Thu,  5 Nov 2020 11:04:40 +0200
Message-Id: <20201105090440.7968-1-ogabbay@kernel.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ofir Bitton <obitton@habana.ai>

Driver must verify if HW is dirty before trying to fetch preboot
information. Hence, we move this validation to a prior stage of
the boot sequence.

Signed-off-by: Ofir Bitton <obitton@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/device.c       |  7 ----
 drivers/misc/habanalabs/common/habanalabs.h   |  6 +--
 .../misc/habanalabs/common/habanalabs_drv.c   | 12 +++---
 drivers/misc/habanalabs/common/pci.c          | 23 +----------
 drivers/misc/habanalabs/gaudi/gaudi.c         | 35 ++++++++++++-----
 drivers/misc/habanalabs/goya/goya.c           | 38 ++++++++++++++-----
 6 files changed, 63 insertions(+), 58 deletions(-)

diff --git a/drivers/misc/habanalabs/common/device.c b/drivers/misc/habanalabs/common/device.c
index 59308a612b36..348faf31668b 100644
--- a/drivers/misc/habanalabs/common/device.c
+++ b/drivers/misc/habanalabs/common/device.c
@@ -1278,13 +1278,6 @@ int hl_device_init(struct hl_device *hdev, struct class *hclass)
 
 	hl_debugfs_add_device(hdev);
 
-	if (hdev->asic_funcs->get_hw_state(hdev) == HL_DEVICE_HW_STATE_DIRTY) {
-		dev_info(hdev->dev,
-			"H/W state is dirty, must reset before initializing\n");
-		hdev->asic_funcs->halt_engines(hdev, true);
-		hdev->asic_funcs->hw_fini(hdev, true);
-	}
-
 	/*
 	 * From this point, in case of an error, add char devices and create
 	 * sysfs nodes as part of the error flow, to allow debugging.
diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index 9c7594d0ca07..42988f12fb00 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -917,7 +917,6 @@ struct hl_asic_funcs {
 				size_t max_size);
 	int (*send_cpu_message)(struct hl_device *hdev, u32 *msg,
 				u16 len, u32 timeout, long *result);
-	enum hl_device_hw_state (*get_hw_state)(struct hl_device *hdev);
 	int (*pci_bars_map)(struct hl_device *hdev);
 	int (*init_iatu)(struct hl_device *hdev);
 	u32 (*rreg)(struct hl_device *hdev, u32 reg);
@@ -1901,6 +1900,7 @@ struct hl_device {
 	u8				hard_reset_on_fw_events;
 	u8				bmc_enable;
 	u8				rl_enable;
+	u8				reset_on_preboot_fail;
 };
 
 
@@ -2148,9 +2148,7 @@ int hl_pci_set_inbound_region(struct hl_device *hdev, u8 region,
 		struct hl_inbound_pci_region *pci_region);
 int hl_pci_set_outbound_region(struct hl_device *hdev,
 		struct hl_outbound_pci_region *pci_region);
-int hl_pci_init(struct hl_device *hdev, u32 cpu_boot_status_reg,
-		u32 cpu_security_boot_status_reg, u32 boot_err0_reg,
-		u32 preboot_ver_timeout);
+int hl_pci_init(struct hl_device *hdev);
 void hl_pci_fini(struct hl_device *hdev);
 
 long hl_get_frequency(struct hl_device *hdev, u32 pll_index, bool curr);
diff --git a/drivers/misc/habanalabs/common/habanalabs_drv.c b/drivers/misc/habanalabs/common/habanalabs_drv.c
index aac798f3296e..6bbb6bca6860 100644
--- a/drivers/misc/habanalabs/common/habanalabs_drv.c
+++ b/drivers/misc/habanalabs/common/habanalabs_drv.c
@@ -234,20 +234,20 @@ int hl_device_open_ctrl(struct inode *inode, struct file *filp)
 
 static void set_driver_behavior_per_device(struct hl_device *hdev)
 {
-	hdev->mmu_enable = 1;
 	hdev->cpu_enable = 1;
-	hdev->fw_loading = 1;
+	hdev->fw_loading = FW_TYPE_ALL_TYPES;
 	hdev->cpu_queues_enable = 1;
 	hdev->heartbeat = 1;
+	hdev->mmu_enable = 1;
 	hdev->clock_gating_mask = ULONG_MAX;
-
-	hdev->reset_pcilink = 0;
-	hdev->axi_drain = 0;
 	hdev->sram_scrambler_enable = 1;
 	hdev->dram_scrambler_enable = 1;
 	hdev->bmc_enable = 1;
 	hdev->hard_reset_on_fw_events = 1;
-	hdev->fw_loading = FW_TYPE_ALL_TYPES;
+	hdev->reset_on_preboot_fail = 1;
+
+	hdev->reset_pcilink = 0;
+	hdev->axi_drain = 0;
 }
 
 /*
diff --git a/drivers/misc/habanalabs/common/pci.c b/drivers/misc/habanalabs/common/pci.c
index 02152d85cf19..923b2606e29f 100644
--- a/drivers/misc/habanalabs/common/pci.c
+++ b/drivers/misc/habanalabs/common/pci.c
@@ -338,20 +338,12 @@ static int hl_pci_set_dma_mask(struct hl_device *hdev)
 /**
  * hl_pci_init() - PCI initialization code.
  * @hdev: Pointer to hl_device structure.
- * @cpu_boot_status_reg: status register of the device's CPU
- * @cpu_security_boot_status_reg: status register of device's CPU security
- *                                configuration
- * @boot_err0_reg: boot error register of the device's CPU
- * @preboot_ver_timeout: how much to wait before bailing out on reading
- *                       the preboot version
  *
  * Set DMA masks, initialize the PCI controller and map the PCI BARs.
  *
  * Return: 0 on success, non-zero for failure.
  */
-int hl_pci_init(struct hl_device *hdev, u32 cpu_boot_status_reg,
-		u32 cpu_security_boot_status_reg, u32 boot_err0_reg,
-		u32 preboot_ver_timeout)
+int hl_pci_init(struct hl_device *hdev)
 {
 	struct pci_dev *pdev = hdev->pdev;
 	int rc;
@@ -383,19 +375,6 @@ int hl_pci_init(struct hl_device *hdev, u32 cpu_boot_status_reg,
 	if (rc)
 		goto unmap_pci_bars;
 
-	/* Before continuing in the initialization, we need to read the preboot
-	 * version to determine whether we run with a security-enabled firmware
-	 * The check will be done in each ASIC's specific code
-	 */
-	rc = hl_fw_read_preboot_status(hdev, cpu_boot_status_reg,
-			cpu_security_boot_status_reg, boot_err0_reg,
-			preboot_ver_timeout);
-	if (rc) {
-		dev_err(hdev->dev, "Failed to read preboot version\n");
-		hdev->asic_funcs->hw_fini(hdev, true);
-		goto unmap_pci_bars;
-	}
-
 	return 0;
 
 unmap_pci_bars:
diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index e206b5ba1a06..086d8363f3ae 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -604,6 +604,11 @@ static int gaudi_init_iatu(struct hl_device *hdev)
 	return rc;
 }
 
+static enum hl_device_hw_state gaudi_get_hw_state(struct hl_device *hdev)
+{
+	return RREG32(mmHW_STATE);
+}
+
 static int gaudi_early_init(struct hl_device *hdev)
 {
 	struct asic_fixed_properties *prop = &hdev->asic_prop;
@@ -641,14 +646,32 @@ static int gaudi_early_init(struct hl_device *hdev)
 
 	prop->dram_pci_bar_size = pci_resource_len(pdev, HBM_BAR_ID);
 
-	rc = hl_pci_init(hdev, mmPSOC_GLOBAL_CONF_CPU_BOOT_STATUS,
-			mmCPU_BOOT_DEV_STS0, mmCPU_BOOT_ERR0,
-			GAUDI_BOOT_FIT_REQ_TIMEOUT_USEC);
+	rc = hl_pci_init(hdev);
 	if (rc)
 		goto free_queue_props;
 
+	if (gaudi_get_hw_state(hdev) == HL_DEVICE_HW_STATE_DIRTY) {
+		dev_info(hdev->dev,
+			"H/W state is dirty, must reset before initializing\n");
+		hdev->asic_funcs->hw_fini(hdev, true);
+	}
+
+	/* Before continuing in the initialization, we need to read the preboot
+	 * version to determine whether we run with a security-enabled firmware
+	 */
+	rc = hl_fw_read_preboot_status(hdev, mmPSOC_GLOBAL_CONF_CPU_BOOT_STATUS,
+			mmCPU_BOOT_DEV_STS0, mmCPU_BOOT_ERR0,
+			GAUDI_BOOT_FIT_REQ_TIMEOUT_USEC);
+	if (rc) {
+		if (hdev->reset_on_preboot_fail)
+			hdev->asic_funcs->hw_fini(hdev, true);
+		goto pci_fini;
+	}
+
 	return 0;
 
+pci_fini:
+	hl_pci_fini(hdev);
 free_queue_props:
 	kfree(hdev->asic_prop.hw_queues_props);
 	return rc;
@@ -7702,11 +7725,6 @@ static int gaudi_run_tpc_kernel(struct hl_device *hdev, u64 tpc_kernel,
 	return 0;
 }
 
-static enum hl_device_hw_state gaudi_get_hw_state(struct hl_device *hdev)
-{
-	return RREG32(mmHW_STATE);
-}
-
 static int gaudi_internal_cb_pool_init(struct hl_device *hdev,
 		struct hl_ctx *ctx)
 {
@@ -8263,7 +8281,6 @@ static const struct hl_asic_funcs gaudi_funcs = {
 	.get_pci_id = gaudi_get_pci_id,
 	.get_eeprom_data = gaudi_get_eeprom_data,
 	.send_cpu_message = gaudi_send_cpu_message,
-	.get_hw_state = gaudi_get_hw_state,
 	.pci_bars_map = gaudi_pci_bars_map,
 	.init_iatu = gaudi_init_iatu,
 	.rreg = hl_rreg,
diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index d7ceda7dd048..002fc53fb39d 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -553,6 +553,11 @@ static int goya_init_iatu(struct hl_device *hdev)
 	return rc;
 }
 
+static enum hl_device_hw_state goya_get_hw_state(struct hl_device *hdev)
+{
+	return RREG32(mmHW_STATE);
+}
+
 /*
  * goya_early_init - GOYA early initialization code
  *
@@ -602,12 +607,28 @@ static int goya_early_init(struct hl_device *hdev)
 
 	prop->dram_pci_bar_size = pci_resource_len(pdev, DDR_BAR_ID);
 
-	rc = hl_pci_init(hdev, mmPSOC_GLOBAL_CONF_CPU_BOOT_STATUS,
-			mmCPU_BOOT_DEV_STS0, mmCPU_BOOT_ERR0,
-			GOYA_BOOT_FIT_REQ_TIMEOUT_USEC);
+	rc = hl_pci_init(hdev);
 	if (rc)
 		goto free_queue_props;
 
+	if (goya_get_hw_state(hdev) == HL_DEVICE_HW_STATE_DIRTY) {
+		dev_info(hdev->dev,
+			"H/W state is dirty, must reset before initializing\n");
+		hdev->asic_funcs->hw_fini(hdev, true);
+	}
+
+	/* Before continuing in the initialization, we need to read the preboot
+	 * version to determine whether we run with a security-enabled firmware
+	 */
+	rc = hl_fw_read_preboot_status(hdev, mmPSOC_GLOBAL_CONF_CPU_BOOT_STATUS,
+			mmCPU_BOOT_DEV_STS0, mmCPU_BOOT_ERR0,
+			GOYA_BOOT_FIT_REQ_TIMEOUT_USEC);
+	if (rc) {
+		if (hdev->reset_on_preboot_fail)
+			hdev->asic_funcs->hw_fini(hdev, true);
+		goto pci_fini;
+	}
+
 	if (!hdev->pldm) {
 		val = RREG32(mmPSOC_GLOBAL_CONF_BOOT_STRAP_PINS);
 		if (val & PSOC_GLOBAL_CONF_BOOT_STRAP_PINS_SRIOV_EN_MASK)
@@ -617,6 +638,8 @@ static int goya_early_init(struct hl_device *hdev)
 
 	return 0;
 
+pci_fini:
+	hl_pci_fini(hdev);
 free_queue_props:
 	kfree(hdev->asic_prop.hw_queues_props);
 	return rc;
@@ -2630,7 +2653,7 @@ static void goya_hw_fini(struct hl_device *hdev, bool hard_reset)
 			"Timeout while waiting for device to reset 0x%x\n",
 			status);
 
-	if (!hard_reset) {
+	if (!hard_reset && goya) {
 		goya->hw_cap_initialized &= ~(HW_CAP_DMA | HW_CAP_MME |
 						HW_CAP_GOLDEN | HW_CAP_TPC);
 		WREG32(mmGIC_DISTRIBUTOR__5_GICD_SETSPI_NSR,
@@ -2651,6 +2674,7 @@ static void goya_hw_fini(struct hl_device *hdev, bool hard_reset)
 				HW_CAP_DMA | HW_CAP_MME |
 				HW_CAP_MMU | HW_CAP_TPC_MBIST |
 				HW_CAP_GOLDEN | HW_CAP_TPC);
+
 		memset(goya->events_stat, 0, sizeof(goya->events_stat));
 	}
 }
@@ -5274,11 +5298,6 @@ static int goya_get_eeprom_data(struct hl_device *hdev, void *data,
 	return hl_fw_get_eeprom_data(hdev, data, max_size);
 }
 
-static enum hl_device_hw_state goya_get_hw_state(struct hl_device *hdev)
-{
-	return RREG32(mmHW_STATE);
-}
-
 static int goya_ctx_init(struct hl_ctx *ctx)
 {
 	return 0;
@@ -5414,7 +5433,6 @@ static const struct hl_asic_funcs goya_funcs = {
 	.get_pci_id = goya_get_pci_id,
 	.get_eeprom_data = goya_get_eeprom_data,
 	.send_cpu_message = goya_send_cpu_message,
-	.get_hw_state = goya_get_hw_state,
 	.pci_bars_map = goya_pci_bars_map,
 	.init_iatu = goya_init_iatu,
 	.rreg = hl_rreg,
-- 
2.17.1

