Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 905DF2A5FB3
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 09:36:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728508AbgKDIgk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 03:36:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:56268 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725812AbgKDIgj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 03:36:39 -0500
Received: from ogabbay-VM.habana-labs.com (unknown [213.57.90.10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 45C102074B;
        Wed,  4 Nov 2020 08:36:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604478997;
        bh=jP1KXwTMcaj+vf8LIiDkAAuJ834rE05DSDTB7oR+ueI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rD2VIkZgiormnKhoinb2FIxKDkNdDQByIvqUhjzJNWhGwjrrC0sbWAYCOWKTGuUj2
         p1eBAxm2l0v3Bf6tOFIp+eVxxzf0Sy8Cg9DYT4U1KERzPy05M3mPycYL48M/uV+zeg
         3Rple25hPewznLIjjn3+nIr+kTqxjeq4r4D4r9vE=
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     SW_Drivers@habana.ai, Ofir Bitton <obitton@habana.ai>
Subject: [PATCH 1/2] habanalabs: fetch security indication from FW
Date:   Wed,  4 Nov 2020 10:36:24 +0200
Message-Id: <20201104083630.28402-2-ogabbay@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201104083630.28402-1-ogabbay@kernel.org>
References: <20201104083630.28402-1-ogabbay@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ofir Bitton <obitton@habana.ai>

Add support for fetching security indication from FW.
This indication is needed in order to skip unnecessary
initializations done by FW.

Signed-off-by: Ofir Bitton <obitton@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/firmware_if.c  | 60 ++++++++++++---
 drivers/misc/habanalabs/common/habanalabs.h   | 23 ++++--
 drivers/misc/habanalabs/common/pci.c          | 10 ++-
 drivers/misc/habanalabs/gaudi/gaudi.c         | 15 ++--
 drivers/misc/habanalabs/goya/goya.c           | 17 +++--
 .../misc/habanalabs/include/common/cpucp_if.h | 30 ++++++++
 .../habanalabs/include/common/hl_boot_if.h    | 74 +++++++++++++++++++
 .../habanalabs/include/gaudi/gaudi_reg_map.h  |  2 +
 .../habanalabs/include/goya/goya_reg_map.h    |  2 +
 9 files changed, 204 insertions(+), 29 deletions(-)

diff --git a/drivers/misc/habanalabs/common/firmware_if.c b/drivers/misc/habanalabs/common/firmware_if.c
index 647606f6cc2a..8de6a8690b1b 100644
--- a/drivers/misc/habanalabs/common/firmware_if.c
+++ b/drivers/misc/habanalabs/common/firmware_if.c
@@ -448,9 +448,10 @@ int hl_fw_cpucp_total_energy_get(struct hl_device *hdev, u64 *total_energy)
 	return rc;
 }
 
-static void fw_read_errors(struct hl_device *hdev, u32 boot_err0_reg)
+static void fw_read_errors(struct hl_device *hdev, u32 boot_err0_reg,
+		u32 cpu_security_boot_status_reg)
 {
-	u32 err_val;
+	u32 err_val, security_val;
 
 	/* Some of the firmware status codes are deprecated in newer f/w
 	 * versions. In those versions, the errors are reported
@@ -485,6 +486,11 @@ static void fw_read_errors(struct hl_device *hdev, u32 boot_err0_reg)
 	if (err_val & CPU_BOOT_ERR0_NIC_FW_FAIL)
 		dev_err(hdev->dev,
 			"Device boot error - NIC F/W initialization failed\n");
+
+	security_val = RREG32(cpu_security_boot_status_reg);
+	if (security_val & CPU_BOOT_DEV_STS0_ENABLED)
+		dev_info(hdev->dev, "Device security status %#x\n",
+				security_val);
 }
 
 static void detect_cpu_boot_status(struct hl_device *hdev, u32 status)
@@ -537,10 +543,12 @@ static void detect_cpu_boot_status(struct hl_device *hdev, u32 status)
 	}
 }
 
-int hl_fw_read_preboot_ver(struct hl_device *hdev, u32 cpu_boot_status_reg,
-				u32 boot_err0_reg, u32 timeout)
+int hl_fw_read_preboot_status(struct hl_device *hdev, u32 cpu_boot_status_reg,
+		u32 cpu_security_boot_status_reg, u32 boot_err0_reg,
+		u32 timeout)
 {
-	u32 status;
+	struct asic_fixed_properties *prop = &hdev->asic_prop;
+	u32 status, security_status;
 	int rc;
 
 	if (!hdev->cpu_enable)
@@ -570,19 +578,43 @@ int hl_fw_read_preboot_ver(struct hl_device *hdev, u32 cpu_boot_status_reg,
 	if (rc) {
 		dev_err(hdev->dev, "Failed to read preboot version\n");
 		detect_cpu_boot_status(hdev, status);
-		fw_read_errors(hdev, boot_err0_reg);
+		fw_read_errors(hdev, boot_err0_reg,
+				cpu_security_boot_status_reg);
 		return -EIO;
 	}
 
 	hdev->asic_funcs->read_device_fw_version(hdev, FW_COMP_PREBOOT);
 
+	security_status = RREG32(cpu_security_boot_status_reg);
+
+	/* We read security status multiple times during boot:
+	 * 1. preboot - we check if fw security feature is supported
+	 * 2. boot cpu - we get boot cpu security status
+	 * 3. FW application - we get FW application security status
+	 *
+	 * Preboot:
+	 * Check security status bit (CPU_BOOT_DEV_STS0_ENABLED), if it is set
+	 * check security enabled bit (CPU_BOOT_DEV_STS0_SECURITY_EN)
+	 */
+	if (security_status & CPU_BOOT_DEV_STS0_ENABLED) {
+		hdev->asic_prop.fw_security_status_valid = 1;
+		prop->fw_security_disabled =
+			!(security_status & CPU_BOOT_DEV_STS0_SECURITY_EN);
+	} else {
+		hdev->asic_prop.fw_security_status_valid = 0;
+		prop->fw_security_disabled = true;
+	}
+
+	dev_info(hdev->dev, "firmware-level security is %s\n",
+		prop->fw_security_disabled ? "disabled" : "enabled");
+
 	return 0;
 }
 
 int hl_fw_init_cpu(struct hl_device *hdev, u32 cpu_boot_status_reg,
 			u32 msg_to_cpu_reg, u32 cpu_msg_status_reg,
-			u32 boot_err0_reg, bool skip_bmc,
-			u32 cpu_timeout, u32 boot_fit_timeout)
+			u32 cpu_security_boot_status_reg, u32 boot_err0_reg,
+			bool skip_bmc, u32 cpu_timeout, u32 boot_fit_timeout)
 {
 	u32 status;
 	int rc;
@@ -652,6 +684,11 @@ int hl_fw_init_cpu(struct hl_device *hdev, u32 cpu_boot_status_reg,
 	/* Read U-Boot version now in case we will later fail */
 	hdev->asic_funcs->read_device_fw_version(hdev, FW_COMP_UBOOT);
 
+	/* Read boot_cpu security bits */
+	if (hdev->asic_prop.fw_security_status_valid)
+		hdev->asic_prop.fw_boot_cpu_security_map =
+				RREG32(cpu_security_boot_status_reg);
+
 	if (rc) {
 		detect_cpu_boot_status(hdev, status);
 		rc = -EIO;
@@ -720,10 +757,15 @@ int hl_fw_init_cpu(struct hl_device *hdev, u32 cpu_boot_status_reg,
 		goto out;
 	}
 
+	/* Read FW application security bits */
+	if (hdev->asic_prop.fw_security_status_valid)
+		hdev->asic_prop.fw_app_security_map =
+				RREG32(cpu_security_boot_status_reg);
+
 	dev_info(hdev->dev, "Successfully loaded firmware to device\n");
 
 out:
-	fw_read_errors(hdev, boot_err0_reg);
+	fw_read_errors(hdev, boot_err0_reg, cpu_security_boot_status_reg);
 
 	return rc;
 }
diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index 0fe108eef1a4..d814ff69eb01 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -372,6 +372,12 @@ struct hl_mmu_properties {
  * @cb_pool_cb_size: size of each CB in the CB pool.
  * @max_pending_cs: maximum of concurrent pending command submissions
  * @max_queues: maximum amount of queues in the system
+ * @fw_boot_cpu_security_map: bitmap representation of boot cpu security status
+ *                            reported by FW, bit description can be found in
+ *                            CPU_BOOT_DEV_STS*
+ * @fw_app_security_map: bitmap representation of application security status
+ *                       reported by FW, bit description can be found in
+ *                       CPU_BOOT_DEV_STS*
  * @collective_first_sob: first sync object available for collective use
  * @collective_first_mon: first monitor available for collective use
  * @sync_stream_first_sob: first sync object available for sync stream use
@@ -382,6 +388,8 @@ struct hl_mmu_properties {
  * @completion_queues_count: number of completion queues.
  * @fw_security_disabled: true if security measures are disabled in firmware,
  *                        false otherwise
+ * @fw_security_status_valid: security status bits are valid and can be fetched
+ *                            from BOOT_DEV_STS0
  */
 struct asic_fixed_properties {
 	struct hw_queue_properties	*hw_queues_props;
@@ -426,6 +434,8 @@ struct asic_fixed_properties {
 	u32				cb_pool_cb_size;
 	u32				max_pending_cs;
 	u32				max_queues;
+	u32				fw_boot_cpu_security_map;
+	u32				fw_app_security_map;
 	u16				collective_first_sob;
 	u16				collective_first_mon;
 	u16				sync_stream_first_sob;
@@ -435,6 +445,7 @@ struct asic_fixed_properties {
 	u8				tpc_enabled_mask;
 	u8				completion_queues_count;
 	u8				fw_security_disabled;
+	u8				fw_security_status_valid;
 };
 
 /**
@@ -2050,10 +2061,11 @@ int hl_fw_cpucp_total_energy_get(struct hl_device *hdev,
 			u64 *total_energy);
 int hl_fw_init_cpu(struct hl_device *hdev, u32 cpu_boot_status_reg,
 			u32 msg_to_cpu_reg, u32 cpu_msg_status_reg,
-			u32 boot_err0_reg, bool skip_bmc,
-			u32 cpu_timeout, u32 boot_fit_timeout);
-int hl_fw_read_preboot_ver(struct hl_device *hdev, u32 cpu_boot_status_reg,
-				u32 boot_err0_reg, u32 timeout);
+			u32 cpu_security_boot_status_reg, u32 boot_err0_reg,
+			bool skip_bmc, u32 cpu_timeout, u32 boot_fit_timeout);
+int hl_fw_read_preboot_status(struct hl_device *hdev, u32 cpu_boot_status_reg,
+		u32 cpu_security_boot_status_reg, u32 boot_err0_reg,
+		u32 timeout);
 
 int hl_pci_bars_map(struct hl_device *hdev, const char * const name[3],
 			bool is_wc[3]);
@@ -2063,7 +2075,8 @@ int hl_pci_set_inbound_region(struct hl_device *hdev, u8 region,
 int hl_pci_set_outbound_region(struct hl_device *hdev,
 		struct hl_outbound_pci_region *pci_region);
 int hl_pci_init(struct hl_device *hdev, u32 cpu_boot_status_reg,
-		u32 boot_err0_reg, u32 preboot_ver_timeout);
+		u32 cpu_security_boot_status_reg, u32 boot_err0_reg,
+		u32 preboot_ver_timeout);
 void hl_pci_fini(struct hl_device *hdev);
 
 long hl_get_frequency(struct hl_device *hdev, u32 pll_index, bool curr);
diff --git a/drivers/misc/habanalabs/common/pci.c b/drivers/misc/habanalabs/common/pci.c
index 4327e5704ebb..211f3190f8d7 100644
--- a/drivers/misc/habanalabs/common/pci.c
+++ b/drivers/misc/habanalabs/common/pci.c
@@ -339,6 +339,8 @@ static int hl_pci_set_dma_mask(struct hl_device *hdev)
  * hl_pci_init() - PCI initialization code.
  * @hdev: Pointer to hl_device structure.
  * @cpu_boot_status_reg: status register of the device's CPU
+ * @cpu_security_boot_status_reg: status register of device's CPU security
+ *                                configuration
  * @boot_err0_reg: boot error register of the device's CPU
  * @preboot_ver_timeout: how much to wait before bailing out on reading
  *                       the preboot version
@@ -348,7 +350,8 @@ static int hl_pci_set_dma_mask(struct hl_device *hdev)
  * Return: 0 on success, non-zero for failure.
  */
 int hl_pci_init(struct hl_device *hdev, u32 cpu_boot_status_reg,
-		u32 boot_err0_reg, u32 preboot_ver_timeout)
+		u32 cpu_security_boot_status_reg, u32 boot_err0_reg,
+		u32 preboot_ver_timeout)
 {
 	struct pci_dev *pdev = hdev->pdev;
 	int rc;
@@ -384,8 +387,9 @@ int hl_pci_init(struct hl_device *hdev, u32 cpu_boot_status_reg,
 	 * version to determine whether we run with a security-enabled firmware
 	 * The check will be done in each ASIC's specific code
 	 */
-	rc = hl_fw_read_preboot_ver(hdev, cpu_boot_status_reg, boot_err0_reg,
-					preboot_ver_timeout);
+	rc = hl_fw_read_preboot_status(hdev, cpu_boot_status_reg,
+			cpu_security_boot_status_reg, boot_err0_reg,
+			preboot_ver_timeout);
 	if (rc)
 		goto unmap_pci_bars;
 
diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index e5a2b7da0a20..e874c1765922 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -514,6 +514,10 @@ static int gaudi_get_fixed_properties(struct hl_device *hdev)
 			prop->sync_stream_first_mon +
 			(num_sync_stream_queues * HL_RSVD_MONS);
 
+	/* disable fw security for now, set it in a later stage */
+	prop->fw_security_disabled = true;
+	prop->fw_security_status_valid = false;
+
 	return 0;
 }
 
@@ -638,13 +642,13 @@ static int gaudi_early_init(struct hl_device *hdev)
 	prop->dram_pci_bar_size = pci_resource_len(pdev, HBM_BAR_ID);
 
 	rc = hl_pci_init(hdev, mmPSOC_GLOBAL_CONF_CPU_BOOT_STATUS,
-			mmCPU_BOOT_ERR0, GAUDI_BOOT_FIT_REQ_TIMEOUT_USEC);
+			mmCPU_BOOT_DEV_STS0, mmCPU_BOOT_ERR0,
+			GAUDI_BOOT_FIT_REQ_TIMEOUT_USEC);
 	if (rc)
 		goto free_queue_props;
 
-	/* GAUDI Firmware does not yet support security */
-	prop->fw_security_disabled = true;
-	dev_info(hdev->dev, "firmware-level security is disabled\n");
+	dev_info(hdev->dev, "firmware-level security is %s\n",
+		hdev->asic_prop.fw_security_disabled ? "disabled" : "enabled");
 
 	return 0;
 
@@ -2319,7 +2323,6 @@ static void gaudi_init_golden_registers(struct hl_device *hdev)
 	int tpc_id, i;
 
 	gaudi_init_e2e(hdev);
-
 	gaudi_init_hbm_cred(hdev);
 
 	hdev->asic_funcs->disable_clock_gating(hdev);
@@ -3608,7 +3611,7 @@ static int gaudi_init_cpu(struct hl_device *hdev)
 	rc = hl_fw_init_cpu(hdev, mmPSOC_GLOBAL_CONF_CPU_BOOT_STATUS,
 			mmPSOC_GLOBAL_CONF_KMD_MSG_TO_CPU,
 			mmCPU_CMD_STATUS_TO_HOST,
-			mmCPU_BOOT_ERR0,
+			mmCPU_BOOT_DEV_STS0, mmCPU_BOOT_ERR0,
 			!hdev->bmc_enable, GAUDI_CPU_TIMEOUT_USEC,
 			GAUDI_BOOT_FIT_REQ_TIMEOUT_USEC);
 
diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index 49075d994bbc..5b0f02a1b8ee 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -456,6 +456,10 @@ int goya_get_fixed_properties(struct hl_device *hdev)
 
 	prop->max_pending_cs = GOYA_MAX_PENDING_CS;
 
+	/* disable fw security for now, set it in a later stage */
+	prop->fw_security_disabled = true;
+	prop->fw_security_status_valid = false;
+
 	return 0;
 }
 
@@ -601,14 +605,11 @@ static int goya_early_init(struct hl_device *hdev)
 	prop->dram_pci_bar_size = pci_resource_len(pdev, DDR_BAR_ID);
 
 	rc = hl_pci_init(hdev, mmPSOC_GLOBAL_CONF_CPU_BOOT_STATUS,
-			mmCPU_BOOT_ERR0, GOYA_BOOT_FIT_REQ_TIMEOUT_USEC);
+			mmCPU_BOOT_DEV_STS0, mmCPU_BOOT_ERR0,
+			GOYA_BOOT_FIT_REQ_TIMEOUT_USEC);
 	if (rc)
 		goto free_queue_props;
 
-	/* Goya Firmware does not support security */
-	prop->fw_security_disabled = true;
-	dev_info(hdev->dev, "firmware-level security is disabled\n");
-
 	if (!hdev->pldm) {
 		val = RREG32(mmPSOC_GLOBAL_CONF_BOOT_STRAP_PINS);
 		if (val & PSOC_GLOBAL_CONF_BOOT_STRAP_PINS_SRIOV_EN_MASK)
@@ -616,6 +617,9 @@ static int goya_early_init(struct hl_device *hdev)
 				"PCI strap is not configured correctly, PCI bus errors may occur\n");
 	}
 
+	dev_info(hdev->dev, "firmware-level security is %s\n",
+		hdev->asic_prop.fw_security_disabled ? "disabled" : "enabled");
+
 	return 0;
 
 free_queue_props:
@@ -2397,7 +2401,8 @@ static int goya_init_cpu(struct hl_device *hdev)
 
 	rc = hl_fw_init_cpu(hdev, mmPSOC_GLOBAL_CONF_CPU_BOOT_STATUS,
 			mmPSOC_GLOBAL_CONF_UBOOT_MAGIC,
-			mmCPU_CMD_STATUS_TO_HOST, mmCPU_BOOT_ERR0,
+			mmCPU_CMD_STATUS_TO_HOST,
+			mmCPU_BOOT_DEV_STS0, mmCPU_BOOT_ERR0,
 			false, GOYA_CPU_TIMEOUT_USEC,
 			GOYA_BOOT_FIT_REQ_TIMEOUT_USEC);
 
diff --git a/drivers/misc/habanalabs/include/common/cpucp_if.h b/drivers/misc/habanalabs/include/common/cpucp_if.h
index 782b8b8636be..1c1e2b394457 100644
--- a/drivers/misc/habanalabs/include/common/cpucp_if.h
+++ b/drivers/misc/habanalabs/include/common/cpucp_if.h
@@ -420,6 +420,29 @@ enum cpucp_card_types {
 	cpucp_card_type_pmc
 };
 
+#define CPUCP_SEC_CONF_ENABLED_SHIFT	0
+#define CPUCP_SEC_CONF_ENABLED_MASK	0x00000001
+
+#define CPUCP_SEC_CONF_FLASH_WP_SHIFT	1
+#define CPUCP_SEC_CONF_FLASH_WP_MASK	0x00000002
+
+#define CPUCP_SEC_CONF_EEPROM_WP_SHIFT	2
+#define CPUCP_SEC_CONF_EEPROM_WP_MASK	0x00000004
+
+/**
+ * struct cpucp_security_info - Security information.
+ * @config: configuration bit field
+ * @keys_num: number of stored keys
+ * @revoked_keys: revoked keys bit field
+ * @min_svn: minimal security version
+ */
+struct cpucp_security_info {
+	__u8 config;
+	__u8 keys_num;
+	__u8 revoked_keys;
+	__u8 min_svn;
+};
+
 /**
  * struct cpucp_info - Info from CpuCP that is necessary to the host's driver
  * @sensors: available sensors description.
@@ -435,6 +458,7 @@ enum cpucp_card_types {
  * @cpucp_version: CpuCP S/W version.
  * @dram_size: available DRAM size.
  * @card_name: card name that will be displayed in HWMON subsystem on the host
+ * @sec_info: security information
  */
 struct cpucp_info {
 	struct cpucp_sensor sensors[CPUCP_MAX_SENSORS];
@@ -450,6 +474,12 @@ struct cpucp_info {
 	__le32 reserved2;
 	__le64 dram_size;
 	char card_name[CARD_NAME_MAX_LEN];
+	__le64 reserved3;
+	__le64 reserved4;
+	__u8 reserved5;
+	__u8 pad[7];
+	struct cpucp_security_info sec_info;
+	__le32 reserved6;
 };
 
 struct cpucp_mac_addr {
diff --git a/drivers/misc/habanalabs/include/common/hl_boot_if.h b/drivers/misc/habanalabs/include/common/hl_boot_if.h
index bb67cafc6e00..d928ad93cd80 100644
--- a/drivers/misc/habanalabs/include/common/hl_boot_if.h
+++ b/drivers/misc/habanalabs/include/common/hl_boot_if.h
@@ -53,6 +53,9 @@
  *					trust), boot authentication (chain of
  *					trust), data packets authentication.
  *
+ * CPU_BOOT_ERR0_EFUSE_FAIL		Reading from eFuse failed.
+ *					The PCI device ID might be wrong.
+ *
  * CPU_BOOT_ERR0_ENABLED		Error registers enabled.
  *					This is a main indication that the
  *					running FW populates the error
@@ -68,8 +71,79 @@
 #define CPU_BOOT_ERR0_NIC_FW_FAIL		(1 << 6)
 #define CPU_BOOT_ERR0_SECURITY_NOT_RDY		(1 << 7)
 #define CPU_BOOT_ERR0_SECURITY_FAIL		(1 << 8)
+#define CPU_BOOT_ERR0_EFUSE_FAIL		(1 << 9)
 #define CPU_BOOT_ERR0_ENABLED			(1 << 31)
 
+/*
+ * BOOT DEVICE STATUS bits in BOOT_DEVICE_STS registers
+ *
+ * CPU_BOOT_DEV_STS0_SECURITY_EN	Security is Enabled.
+ *					This is an indication for security
+ *					enabled in FW, which means that
+ *					all conditions for security are met:
+ *					device is indicated as security enabled,
+ *					registers are protected, and device
+ *					uses keys for image verification.
+ *					Initialized at: preboot
+ *
+ * CPU_BOOT_DEV_STS0_DEBUG_EN		Debug is enabled.
+ *					Enabled when JTAG or DEBUG is enabled
+ *					in FW.
+ *					Initialized at: preboot
+ *
+ * CPU_BOOT_DEV_STS0_WATCHDOG_EN	Watchdog is enabled.
+ *					Watchdog is enabled in FW.
+ *					Initialized at: preboot
+ *
+ * CPU_BOOT_DEV_STS0_DRAM_INIT_EN	DRAM initialization is enabled.
+ *					DRAM initialization has been done in FW.
+ *					Initialized at: u-boot
+ *
+ * CPU_BOOT_DEV_STS0_BMC_WAIT_EN	Waiting for BMC data enabled.
+ *					If set, it means that during boot,
+ *					FW waited for BMC data.
+ *					Initialized at: u-boot
+ *
+ * CPU_BOOT_DEV_STS0_E2E_CRED_EN	E2E credits initialized.
+ *					FW initialized E2E credits.
+ *					Initialized at: u-boot
+ *
+ * CPU_BOOT_DEV_STS0_HBM_CRED_EN	HBM credits initialized.
+ *					FW initialized HBM credits.
+ *					Initialized at: u-boot
+ *
+ * CPU_BOOT_DEV_STS0_RL_EN		Rate limiter initialized.
+ *					FW initialized rate limiter.
+ *					Initialized at: u-boot
+ *
+ * CPU_BOOT_DEV_STS0_SRAM_SCR_EN	SRAM scrambler enabled.
+ *					FW initialized SRAM scrambler.
+ *					Initialized at: linux
+ *
+ * CPU_BOOT_DEV_STS0_DRAM_SCR_EN	DRAM scrambler enabled.
+ *					FW initialized DRAM scrambler.
+ *					Initialized at: u-boot
+ *
+ * CPU_BOOT_DEV_STS0_ENABLED		Device status register enabled.
+ *					This is a main indication that the
+ *					running FW populates the device status
+ *					register. Meaning the device status
+ *					bits are not garbage, but actual
+ *					statuses.
+ *					Initialized at: preboot
+ */
+#define CPU_BOOT_DEV_STS0_SECURITY_EN			(1 << 0)
+#define CPU_BOOT_DEV_STS0_DEBUG_EN			(1 << 1)
+#define CPU_BOOT_DEV_STS0_WATCHDOG_EN			(1 << 2)
+#define CPU_BOOT_DEV_STS0_DRAM_INIT_EN			(1 << 3)
+#define CPU_BOOT_DEV_STS0_BMC_WAIT_EN			(1 << 4)
+#define CPU_BOOT_DEV_STS0_E2E_CRED_EN			(1 << 5)
+#define CPU_BOOT_DEV_STS0_HBM_CRED_EN			(1 << 6)
+#define CPU_BOOT_DEV_STS0_RL_EN				(1 << 7)
+#define CPU_BOOT_DEV_STS0_SRAM_SCR_EN			(1 << 8)
+#define CPU_BOOT_DEV_STS0_DRAM_SCR_EN			(1 << 9)
+#define CPU_BOOT_DEV_STS0_ENABLED			(1 << 31)
+
 enum cpu_boot_status {
 	CPU_BOOT_STATUS_NA = 0,		/* Default value after reset of chip */
 	CPU_BOOT_STATUS_IN_WFE = 1,
diff --git a/drivers/misc/habanalabs/include/gaudi/gaudi_reg_map.h b/drivers/misc/habanalabs/include/gaudi/gaudi_reg_map.h
index 977fb341a6e7..137afedf5f15 100644
--- a/drivers/misc/habanalabs/include/gaudi/gaudi_reg_map.h
+++ b/drivers/misc/habanalabs/include/gaudi/gaudi_reg_map.h
@@ -12,6 +12,8 @@
  * PSOC scratch-pad registers
  */
 #define mmHW_STATE			mmPSOC_GLOBAL_CONF_SCRATCHPAD_0
+#define mmCPU_BOOT_DEV_STS0		mmPSOC_GLOBAL_CONF_SCRATCHPAD_20
+#define mmCPU_BOOT_DEV_STS1		mmPSOC_GLOBAL_CONF_SCRATCHPAD_21
 #define mmFUSE_VER_OFFSET		mmPSOC_GLOBAL_CONF_SCRATCHPAD_22
 #define mmCPU_CMD_STATUS_TO_HOST	mmPSOC_GLOBAL_CONF_SCRATCHPAD_23
 #define mmCPU_BOOT_ERR0			mmPSOC_GLOBAL_CONF_SCRATCHPAD_24
diff --git a/drivers/misc/habanalabs/include/goya/goya_reg_map.h b/drivers/misc/habanalabs/include/goya/goya_reg_map.h
index e56124265a05..f3ab282cafa4 100644
--- a/drivers/misc/habanalabs/include/goya/goya_reg_map.h
+++ b/drivers/misc/habanalabs/include/goya/goya_reg_map.h
@@ -22,6 +22,8 @@
 #define mmCPU_CQ_BASE_ADDR_LOW		mmPSOC_GLOBAL_CONF_SCRATCHPAD_8
 #define mmCPU_CQ_BASE_ADDR_HIGH		mmPSOC_GLOBAL_CONF_SCRATCHPAD_9
 #define mmCPU_CQ_LENGTH			mmPSOC_GLOBAL_CONF_SCRATCHPAD_10
+#define mmCPU_BOOT_DEV_STS0		mmPSOC_GLOBAL_CONF_SCRATCHPAD_20
+#define mmCPU_BOOT_DEV_STS1		mmPSOC_GLOBAL_CONF_SCRATCHPAD_21
 #define mmFUSE_VER_OFFSET		mmPSOC_GLOBAL_CONF_SCRATCHPAD_22
 #define mmCPU_CMD_STATUS_TO_HOST	mmPSOC_GLOBAL_CONF_SCRATCHPAD_23
 #define mmCPU_BOOT_ERR0			mmPSOC_GLOBAL_CONF_SCRATCHPAD_24
-- 
2.17.1

