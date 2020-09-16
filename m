Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7F9726C904
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 21:02:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728320AbgIPTCc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 15:02:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727505AbgIPRsr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 13:48:47 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BFDFC00868B
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 06:43:44 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id w5so6971690wrp.8
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 06:43:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rrc0cMrqep5zIJ3+WkFuP3n7AMNEQdbuwOxCzK4HgVU=;
        b=r60QreXef/WPGbm+ys+sO9b8i7TQfwSjuMCeA09KkH7uh56KatyiHrdFQs9PZt/l9R
         aK1DADv0sbGs71vpAzC6NQUCSbq5PsoTQWXiF/MZOxDc1eQrv699yuvoWEYLYewut1aH
         624NNEA/evsgNFszOuG+DxmxHjKPlsWOVNiELiWn9MxzBojrwMKfPqli+mgwdOTvo+kl
         TqTm65iHrGoFSdUt7z0fLuDaaUhHqtYfKd1CjiUwWU5BQCBKqIrRWz3P3HFErN0VOwcH
         6upyjjmhjnN9NUFiPPrbXhn9rqCK9OKfvONHh/Ps/sLdnSEd8EWCyeu3NEju+F7YCsP9
         kUVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=rrc0cMrqep5zIJ3+WkFuP3n7AMNEQdbuwOxCzK4HgVU=;
        b=WAL5x2rffXKnue4afSaMBh/I4Wa+p2YjJtLb09iRr/hi8vhGjDGjTxMad/l1G9Qi9f
         YZqKjJjwFC7cgfTGDtBd8wHRLwK1TofI0C1P6rC98/RznFMZdMs0TEOZkHZcexU9vem2
         Cd1F3LqvFVzlp4HDJJZ5FWHU2Iks/954dWvVwHDqTB6By8WZWNWGy1C6crN0ygqJbsXW
         pTImFEvsD0MI2IOPO+uRoGmI8fiuTYNkzGzJnIaDSXiA8llsoNTbOJ5HjjrKi1Hct0VX
         QdlshfKR9vsL6yK0sZh1gVgMCkkU8WmPkkexsOA10vd9TlARFAt3tQssnYTeXXSe+9De
         AZTQ==
X-Gm-Message-State: AOAM531Bozm7IbWqBp6gd0IYCoduVHZqCD77I7Lo74KpVXGPr++/PeXw
        M6mYyVgdDBB3Ue2hVtPPlKg9zXsoIWA=
X-Google-Smtp-Source: ABdhPJyZxONnsugP4kGWCsBQEerAx4ubLwFqUzBpIHqSASlP+uFj++lrXoKZQxMzMSdmN3aLXQQewQ==
X-Received: by 2002:adf:e4c9:: with SMTP id v9mr26109907wrm.375.1600263820447;
        Wed, 16 Sep 2020 06:43:40 -0700 (PDT)
Received: from ogabbay-VM.habana-labs.com ([213.57.90.10])
        by smtp.gmail.com with ESMTPSA id w81sm5658664wmg.47.2020.09.16.06.43.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2020 06:43:39 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     SW_Drivers@habana.ai
Subject: [PATCH 3/3] habanalabs: add indication of security-enabled F/W
Date:   Wed, 16 Sep 2020 16:43:33 +0300
Message-Id: <20200916134333.4029-3-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200916134333.4029-1-oded.gabbay@gmail.com>
References: <20200916134333.4029-1-oded.gabbay@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Future F/W versions will have enhanced security measures and the driver
won't be able to do certain configurations that it always did and those
configurations will be done by the firmware.

We use the firmware's preboot version to determine whether security
measures are enabled or not. Because we need this very early in our code,
the read of the preboot version is moved to the earliest possible place,
right after the device's PCI initialization.

Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 drivers/misc/habanalabs/common/firmware_if.c | 55 +++++++++++++++++---
 drivers/misc/habanalabs/common/habanalabs.h  |  8 ++-
 drivers/misc/habanalabs/common/pci.c         | 16 +++++-
 drivers/misc/habanalabs/gaudi/gaudi.c        | 28 ++++++----
 drivers/misc/habanalabs/goya/goya.c          |  7 ++-
 5 files changed, 94 insertions(+), 20 deletions(-)

diff --git a/drivers/misc/habanalabs/common/firmware_if.c b/drivers/misc/habanalabs/common/firmware_if.c
index 4409962d30ae..cd41c7ceb0e7 100644
--- a/drivers/misc/habanalabs/common/firmware_if.c
+++ b/drivers/misc/habanalabs/common/firmware_if.c
@@ -474,8 +474,11 @@ static void fw_read_errors(struct hl_device *hdev, u32 boot_err0_reg)
 			"Device boot error - NIC F/W initialization failed\n");
 }
 
-static void hl_detect_cpu_boot_status(struct hl_device *hdev, u32 status)
+static void detect_cpu_boot_status(struct hl_device *hdev, u32 status)
 {
+	/* Some of the status codes below are deprecated in newer f/w
+	 * versions but we keep them here for backward compatibility
+	 */
 	switch (status) {
 	case CPU_BOOT_STATUS_NA:
 		dev_err(hdev->dev,
@@ -521,6 +524,48 @@ static void hl_detect_cpu_boot_status(struct hl_device *hdev, u32 status)
 	}
 }
 
+int hl_fw_read_preboot_ver(struct hl_device *hdev, u32 cpu_boot_status_reg,
+				u32 boot_err0_reg, u32 timeout)
+{
+	u32 status;
+	int rc;
+
+	if (!hdev->cpu_enable)
+		return 0;
+
+	/* Need to check two possible scenarios:
+	 *
+	 * CPU_BOOT_STATUS_WAITING_FOR_BOOT_FIT - for newer firmwares where
+	 * the preboot is waiting for the boot fit
+	 *
+	 * All other status values - for older firmwares where the uboot was
+	 * loaded from the FLASH
+	 */
+	rc = hl_poll_timeout(
+		hdev,
+		cpu_boot_status_reg,
+		status,
+		(status == CPU_BOOT_STATUS_IN_UBOOT) ||
+		(status == CPU_BOOT_STATUS_DRAM_RDY) ||
+		(status == CPU_BOOT_STATUS_NIC_FW_RDY) ||
+		(status == CPU_BOOT_STATUS_READY_TO_BOOT) ||
+		(status == CPU_BOOT_STATUS_SRAM_AVAIL) ||
+		(status == CPU_BOOT_STATUS_WAITING_FOR_BOOT_FIT),
+		10000,
+		timeout);
+
+	if (rc) {
+		dev_err(hdev->dev, "Failed to read preboot version\n");
+		detect_cpu_boot_status(hdev, status);
+		fw_read_errors(hdev, boot_err0_reg);
+		return -EIO;
+	}
+
+	hdev->asic_funcs->read_device_fw_version(hdev, FW_COMP_PREBOOT);
+
+	return 0;
+}
+
 int hl_fw_init_cpu(struct hl_device *hdev, u32 cpu_boot_status_reg,
 			u32 msg_to_cpu_reg, u32 cpu_msg_status_reg,
 			u32 boot_err0_reg, bool skip_bmc,
@@ -586,15 +631,11 @@ int hl_fw_init_cpu(struct hl_device *hdev, u32 cpu_boot_status_reg,
 		10000,
 		cpu_timeout);
 
-	/* Read U-Boot, preboot versions now in case we will later fail */
+	/* Read U-Boot version now in case we will later fail */
 	hdev->asic_funcs->read_device_fw_version(hdev, FW_COMP_UBOOT);
-	hdev->asic_funcs->read_device_fw_version(hdev, FW_COMP_PREBOOT);
 
-	/* Some of the status codes below are deprecated in newer f/w
-	 * versions but we keep them here for backward compatibility
-	 */
 	if (rc) {
-		hl_detect_cpu_boot_status(hdev, status);
+		detect_cpu_boot_status(hdev, status);
 		rc = -EIO;
 		goto out;
 	}
diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index eaa9bf3f82a3..80d4d7385ffe 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -320,6 +320,8 @@ struct hl_mmu_properties {
  * @first_available_user_mon: first monitor available for the user
  * @tpc_enabled_mask: which TPCs are enabled.
  * @completion_queues_count: number of completion queues.
+ * @fw_security_disabled: true if security measures are disabled in firmware,
+ *                        false otherwise
  */
 struct asic_fixed_properties {
 	struct hw_queue_properties	*hw_queues_props;
@@ -370,6 +372,7 @@ struct asic_fixed_properties {
 	u16				first_available_user_mon[HL_MAX_DCORES];
 	u8				tpc_enabled_mask;
 	u8				completion_queues_count;
+	u8				fw_security_disabled;
 };
 
 /**
@@ -1933,6 +1936,8 @@ int hl_fw_init_cpu(struct hl_device *hdev, u32 cpu_boot_status_reg,
 			u32 msg_to_cpu_reg, u32 cpu_msg_status_reg,
 			u32 boot_err0_reg, bool skip_bmc,
 			u32 cpu_timeout, u32 boot_fit_timeout);
+int hl_fw_read_preboot_ver(struct hl_device *hdev, u32 cpu_boot_status_reg,
+				u32 boot_err0_reg, u32 timeout);
 
 int hl_pci_bars_map(struct hl_device *hdev, const char * const name[3],
 			bool is_wc[3]);
@@ -1941,7 +1946,8 @@ int hl_pci_set_inbound_region(struct hl_device *hdev, u8 region,
 		struct hl_inbound_pci_region *pci_region);
 int hl_pci_set_outbound_region(struct hl_device *hdev,
 		struct hl_outbound_pci_region *pci_region);
-int hl_pci_init(struct hl_device *hdev);
+int hl_pci_init(struct hl_device *hdev, u32 cpu_boot_status_reg,
+		u32 boot_err0_reg, u32 preboot_ver_timeout);
 void hl_pci_fini(struct hl_device *hdev);
 
 long hl_get_frequency(struct hl_device *hdev, u32 pll_index, bool curr);
diff --git a/drivers/misc/habanalabs/common/pci.c b/drivers/misc/habanalabs/common/pci.c
index 923b2606e29f..4327e5704ebb 100644
--- a/drivers/misc/habanalabs/common/pci.c
+++ b/drivers/misc/habanalabs/common/pci.c
@@ -338,12 +338,17 @@ static int hl_pci_set_dma_mask(struct hl_device *hdev)
 /**
  * hl_pci_init() - PCI initialization code.
  * @hdev: Pointer to hl_device structure.
+ * @cpu_boot_status_reg: status register of the device's CPU
+ * @boot_err0_reg: boot error register of the device's CPU
+ * @preboot_ver_timeout: how much to wait before bailing out on reading
+ *                       the preboot version
  *
  * Set DMA masks, initialize the PCI controller and map the PCI BARs.
  *
  * Return: 0 on success, non-zero for failure.
  */
-int hl_pci_init(struct hl_device *hdev)
+int hl_pci_init(struct hl_device *hdev, u32 cpu_boot_status_reg,
+		u32 boot_err0_reg, u32 preboot_ver_timeout)
 {
 	struct pci_dev *pdev = hdev->pdev;
 	int rc;
@@ -375,6 +380,15 @@ int hl_pci_init(struct hl_device *hdev)
 	if (rc)
 		goto unmap_pci_bars;
 
+	/* Before continuing in the initialization, we need to read the preboot
+	 * version to determine whether we run with a security-enabled firmware
+	 * The check will be done in each ASIC's specific code
+	 */
+	rc = hl_fw_read_preboot_ver(hdev, cpu_boot_status_reg, boot_err0_reg,
+					preboot_ver_timeout);
+	if (rc)
+		goto unmap_pci_bars;
+
 	return 0;
 
 unmap_pci_bars:
diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index 86650be5898f..1b51e670bd4e 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -599,10 +599,15 @@ static int gaudi_early_init(struct hl_device *hdev)
 
 	prop->dram_pci_bar_size = pci_resource_len(pdev, HBM_BAR_ID);
 
-	rc = hl_pci_init(hdev);
+	rc = hl_pci_init(hdev, mmPSOC_GLOBAL_CONF_CPU_BOOT_STATUS,
+			mmCPU_BOOT_ERR0, GAUDI_BOOT_FIT_REQ_TIMEOUT_USEC);
 	if (rc)
 		goto free_queue_props;
 
+	/* GAUDI Firmware does not yet support security */
+	prop->fw_security_disabled = true;
+	dev_info(hdev->dev, "firmware-level security is disabled\n");
+
 	return 0;
 
 free_queue_props:
@@ -2871,6 +2876,18 @@ static void gaudi_pre_hw_init(struct hl_device *hdev)
 	/* Perform read from the device to make sure device is up */
 	RREG32(mmPCIE_DBI_DEVICE_ID_VENDOR_ID_REG);
 
+	/* Set the access through PCI bars (Linux driver only) as
+	 * secured
+	 */
+	WREG32(mmPCIE_WRAP_LBW_PROT_OVR,
+			(PCIE_WRAP_LBW_PROT_OVR_RD_EN_MASK |
+			PCIE_WRAP_LBW_PROT_OVR_WR_EN_MASK));
+
+	/* Perform read to flush the waiting writes to ensure
+	 * configuration was set in the device
+	 */
+	RREG32(mmPCIE_WRAP_LBW_PROT_OVR);
+
 	/*
 	 * Let's mark in the H/W that we have reached this point. We check
 	 * this value in the reset_before_init function to understand whether
@@ -2879,15 +2896,6 @@ static void gaudi_pre_hw_init(struct hl_device *hdev)
 	 */
 	WREG32(mmHW_STATE, HL_DEVICE_HW_STATE_DIRTY);
 
-	/* Set the access through PCI bars (Linux driver only) as secured */
-	WREG32(mmPCIE_WRAP_LBW_PROT_OVR, (PCIE_WRAP_LBW_PROT_OVR_RD_EN_MASK |
-					PCIE_WRAP_LBW_PROT_OVR_WR_EN_MASK));
-
-	/* Perform read to flush the waiting writes to ensure configuration
-	 * was set in the device
-	 */
-	RREG32(mmPCIE_WRAP_LBW_PROT_OVR);
-
 	/* Configure the reset registers. Must be done as early as possible
 	 * in case we fail during H/W initialization
 	 */
diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index 5cddd46a8fb8..5db52064ed9e 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -600,10 +600,15 @@ static int goya_early_init(struct hl_device *hdev)
 
 	prop->dram_pci_bar_size = pci_resource_len(pdev, DDR_BAR_ID);
 
-	rc = hl_pci_init(hdev);
+	rc = hl_pci_init(hdev, mmPSOC_GLOBAL_CONF_CPU_BOOT_STATUS,
+			mmCPU_BOOT_ERR0, GOYA_BOOT_FIT_REQ_TIMEOUT_USEC);
 	if (rc)
 		goto free_queue_props;
 
+	/* Goya Firmware does not support security */
+	prop->fw_security_disabled = true;
+	dev_info(hdev->dev, "firmware-level security is disabled\n");
+
 	if (!hdev->pldm) {
 		val = RREG32(mmPSOC_GLOBAL_CONF_BOOT_STRAP_PINS);
 		if (val & PSOC_GLOBAL_CONF_BOOT_STRAP_PINS_SRIOV_EN_MASK)
-- 
2.17.1

