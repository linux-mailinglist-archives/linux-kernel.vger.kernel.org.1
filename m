Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F8192E83CF
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jan 2021 14:19:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727181AbhAANRO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jan 2021 08:17:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:48314 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726747AbhAANRN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jan 2021 08:17:13 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id B59B722228;
        Fri,  1 Jan 2021 13:16:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609506992;
        bh=socxqtyQrcubgboaOlCXyLqRdKyPQnd05JTgcqR9H6s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=E7VcjgexWHpWIUB2GTMDIO7b81+6fwGLwc5oc0TxpF60ZgGnld4m+ax8yIkowfAaC
         yqb5xAvtaTKJi7hTVNa9yckhVlY3bAFQtj0BgOkQKITxqJQeqDF2WHbX1MkYx18HOG
         v0aCnoKCRvYUlOCnaPmv5nLIljq5s/4C0xnenEt1zuKv7540CrgyAzV4B2Eg4doBl3
         8Zaoz7DrltpjUwHba1zUC0vpIRY/ndoGZOeW0DTKXtaggO4sCF5r3KspDjohAaoU4B
         1ydkoyYxPdo4ZaQtynXb0rpbG/hbDZYUACLanQ2iI9v92x15wn2D4VVTt9UDPmFyq0
         qDUpezTMIAJGQ==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ofir Bitton <obitton@habana.ai>
Subject: [PATCH 2/2] habanalabs: read device boot errors after cpucp is up
Date:   Fri,  1 Jan 2021 15:16:26 +0200
Message-Id: <20210101131626.4636-2-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210101131626.4636-1-ogabbay@kernel.org>
References: <20210101131626.4636-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ofir Bitton <obitton@habana.ai>

Boot cpu can report errors in various boot stages.
Current implementaion does not take into consideration errors
reported in late stages, hence we will check for errors at the most
late stage when fetching cpucp information.

Signed-off-by: Ofir Bitton <obitton@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/firmware_if.c  | 126 ++++++++++--------
 drivers/misc/habanalabs/common/habanalabs.h   |   3 +-
 drivers/misc/habanalabs/gaudi/gaudi.c         |   2 +-
 drivers/misc/habanalabs/goya/goya.c           |   2 +-
 .../habanalabs/include/common/hl_boot_if.h    |   3 +
 5 files changed, 80 insertions(+), 56 deletions(-)

diff --git a/drivers/misc/habanalabs/common/firmware_if.c b/drivers/misc/habanalabs/common/firmware_if.c
index 94dda314233b..a6ea5bbeb699 100644
--- a/drivers/misc/habanalabs/common/firmware_if.c
+++ b/drivers/misc/habanalabs/common/firmware_if.c
@@ -279,8 +279,68 @@ int hl_fw_send_heartbeat(struct hl_device *hdev)
 	return rc;
 }
 
+static int fw_read_errors(struct hl_device *hdev, u32 boot_err0_reg,
+		u32 cpu_security_boot_status_reg)
+{
+	u32 err_val, security_val;
+
+	/* Some of the firmware status codes are deprecated in newer f/w
+	 * versions. In those versions, the errors are reported
+	 * in different registers. Therefore, we need to check those
+	 * registers and print the exact errors. Moreover, there
+	 * may be multiple errors, so we need to report on each error
+	 * separately. Some of the error codes might indicate a state
+	 * that is not an error per-se, but it is an error in production
+	 * environment
+	 */
+	err_val = RREG32(boot_err0_reg);
+	if (!(err_val & CPU_BOOT_ERR0_ENABLED))
+		return 0;
+
+	if (err_val & CPU_BOOT_ERR0_DRAM_INIT_FAIL)
+		dev_err(hdev->dev,
+			"Device boot error - DRAM initialization failed\n");
+	if (err_val & CPU_BOOT_ERR0_FIT_CORRUPTED)
+		dev_err(hdev->dev, "Device boot error - FIT image corrupted\n");
+	if (err_val & CPU_BOOT_ERR0_TS_INIT_FAIL)
+		dev_err(hdev->dev,
+			"Device boot error - Thermal Sensor initialization failed\n");
+	if (err_val & CPU_BOOT_ERR0_DRAM_SKIPPED)
+		dev_warn(hdev->dev,
+			"Device boot warning - Skipped DRAM initialization\n");
+	if (err_val & CPU_BOOT_ERR0_BMC_WAIT_SKIPPED)
+		dev_warn(hdev->dev,
+			"Device boot error - Skipped waiting for BMC\n");
+	if (err_val & CPU_BOOT_ERR0_NIC_DATA_NOT_RDY)
+		dev_err(hdev->dev,
+			"Device boot error - Serdes data from BMC not available\n");
+	if (err_val & CPU_BOOT_ERR0_NIC_FW_FAIL)
+		dev_err(hdev->dev,
+			"Device boot error - NIC F/W initialization failed\n");
+	if (err_val & CPU_BOOT_ERR0_SECURITY_NOT_RDY)
+		dev_warn(hdev->dev,
+			"Device boot warning - security not ready\n");
+	if (err_val & CPU_BOOT_ERR0_SECURITY_FAIL)
+		dev_err(hdev->dev, "Device boot error - security failure\n");
+	if (err_val & CPU_BOOT_ERR0_EFUSE_FAIL)
+		dev_err(hdev->dev, "Device boot error - eFuse failure\n");
+	if (err_val & CPU_BOOT_ERR0_PLL_FAIL)
+		dev_err(hdev->dev, "Device boot error - PLL failure\n");
+
+	security_val = RREG32(cpu_security_boot_status_reg);
+	if (security_val & CPU_BOOT_DEV_STS0_ENABLED)
+		dev_dbg(hdev->dev, "Device security status %#x\n",
+				security_val);
+
+	if (err_val & ~CPU_BOOT_ERR0_ENABLED)
+		return -EIO;
+
+	return 0;
+}
+
 int hl_fw_cpucp_info_get(struct hl_device *hdev,
-			u32 cpu_security_boot_status_reg)
+			u32 cpu_security_boot_status_reg,
+			u32 boot_err0_reg)
 {
 	struct asic_fixed_properties *prop = &hdev->asic_prop;
 	struct cpucp_packet pkt = {};
@@ -314,6 +374,12 @@ int hl_fw_cpucp_info_get(struct hl_device *hdev,
 		goto out;
 	}
 
+	rc = fw_read_errors(hdev, boot_err0_reg, cpu_security_boot_status_reg);
+	if (rc) {
+		dev_err(hdev->dev, "Errors in device boot\n");
+		goto out;
+	}
+
 	memcpy(&prop->cpucp_info, cpucp_info_cpu_addr,
 			sizeof(prop->cpucp_info));
 
@@ -478,58 +544,6 @@ int hl_fw_cpucp_pll_info_get(struct hl_device *hdev, u16 pll_index,
 	return rc;
 }
 
-static void fw_read_errors(struct hl_device *hdev, u32 boot_err0_reg,
-		u32 cpu_security_boot_status_reg)
-{
-	u32 err_val, security_val;
-
-	/* Some of the firmware status codes are deprecated in newer f/w
-	 * versions. In those versions, the errors are reported
-	 * in different registers. Therefore, we need to check those
-	 * registers and print the exact errors. Moreover, there
-	 * may be multiple errors, so we need to report on each error
-	 * separately. Some of the error codes might indicate a state
-	 * that is not an error per-se, but it is an error in production
-	 * environment
-	 */
-	err_val = RREG32(boot_err0_reg);
-	if (!(err_val & CPU_BOOT_ERR0_ENABLED))
-		return;
-
-	if (err_val & CPU_BOOT_ERR0_DRAM_INIT_FAIL)
-		dev_err(hdev->dev,
-			"Device boot error - DRAM initialization failed\n");
-	if (err_val & CPU_BOOT_ERR0_FIT_CORRUPTED)
-		dev_err(hdev->dev, "Device boot error - FIT image corrupted\n");
-	if (err_val & CPU_BOOT_ERR0_TS_INIT_FAIL)
-		dev_err(hdev->dev,
-			"Device boot error - Thermal Sensor initialization failed\n");
-	if (err_val & CPU_BOOT_ERR0_DRAM_SKIPPED)
-		dev_warn(hdev->dev,
-			"Device boot warning - Skipped DRAM initialization\n");
-	if (err_val & CPU_BOOT_ERR0_BMC_WAIT_SKIPPED)
-		dev_warn(hdev->dev,
-			"Device boot error - Skipped waiting for BMC\n");
-	if (err_val & CPU_BOOT_ERR0_NIC_DATA_NOT_RDY)
-		dev_err(hdev->dev,
-			"Device boot error - Serdes data from BMC not available\n");
-	if (err_val & CPU_BOOT_ERR0_NIC_FW_FAIL)
-		dev_err(hdev->dev,
-			"Device boot error - NIC F/W initialization failed\n");
-	if (err_val & CPU_BOOT_ERR0_SECURITY_NOT_RDY)
-		dev_warn(hdev->dev,
-			"Device boot warning - security not ready\n");
-	if (err_val & CPU_BOOT_ERR0_SECURITY_FAIL)
-		dev_err(hdev->dev, "Device boot error - security failure\n");
-	if (err_val & CPU_BOOT_ERR0_EFUSE_FAIL)
-		dev_err(hdev->dev, "Device boot error - eFuse failure\n");
-
-	security_val = RREG32(cpu_security_boot_status_reg);
-	if (security_val & CPU_BOOT_DEV_STS0_ENABLED)
-		dev_dbg(hdev->dev, "Device security status %#x\n",
-				security_val);
-}
-
 static void detect_cpu_boot_status(struct hl_device *hdev, u32 status)
 {
 	/* Some of the status codes below are deprecated in newer f/w
@@ -828,6 +842,10 @@ int hl_fw_init_cpu(struct hl_device *hdev, u32 cpu_boot_status_reg,
 		goto out;
 	}
 
+	rc = fw_read_errors(hdev, boot_err0_reg, cpu_security_boot_status_reg);
+	if (rc)
+		return rc;
+
 	/* Clear reset status since we need to read again from app */
 	prop->hard_reset_done_by_fw = false;
 
@@ -850,6 +868,8 @@ int hl_fw_init_cpu(struct hl_device *hdev, u32 cpu_boot_status_reg,
 
 	dev_info(hdev->dev, "Successfully loaded firmware to device\n");
 
+	return 0;
+
 out:
 	fw_read_errors(hdev, boot_err0_reg, cpu_security_boot_status_reg);
 
diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index 554633cc9474..537545df531a 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -2208,7 +2208,8 @@ void hl_fw_cpu_accessible_dma_pool_free(struct hl_device *hdev, size_t size,
 					void *vaddr);
 int hl_fw_send_heartbeat(struct hl_device *hdev);
 int hl_fw_cpucp_info_get(struct hl_device *hdev,
-			u32 cpu_security_boot_status_reg);
+			u32 cpu_security_boot_status_reg,
+			u32 boot_err0_reg);
 int hl_fw_get_eeprom_data(struct hl_device *hdev, void *data, size_t max_size);
 int hl_fw_cpucp_pci_counters_get(struct hl_device *hdev,
 		struct hl_info_pci_counters *counters);
diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index 44f470e11f78..f9a99872a56e 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -7450,7 +7450,7 @@ static int gaudi_cpucp_info_get(struct hl_device *hdev)
 	if (!(gaudi->hw_cap_initialized & HW_CAP_CPU_Q))
 		return 0;
 
-	rc = hl_fw_cpucp_info_get(hdev, mmCPU_BOOT_DEV_STS0);
+	rc = hl_fw_cpucp_info_get(hdev, mmCPU_BOOT_DEV_STS0, mmCPU_BOOT_ERR0);
 	if (rc)
 		return rc;
 
diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index 748b57036080..86da0401b6ea 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -5149,7 +5149,7 @@ int goya_cpucp_info_get(struct hl_device *hdev)
 	if (!(goya->hw_cap_initialized & HW_CAP_CPU_Q))
 		return 0;
 
-	rc = hl_fw_cpucp_info_get(hdev, mmCPU_BOOT_DEV_STS0);
+	rc = hl_fw_cpucp_info_get(hdev, mmCPU_BOOT_DEV_STS0, mmCPU_BOOT_ERR0);
 	if (rc)
 		return rc;
 
diff --git a/drivers/misc/habanalabs/include/common/hl_boot_if.h b/drivers/misc/habanalabs/include/common/hl_boot_if.h
index 93552d6b59b3..e29c77bdea07 100644
--- a/drivers/misc/habanalabs/include/common/hl_boot_if.h
+++ b/drivers/misc/habanalabs/include/common/hl_boot_if.h
@@ -69,6 +69,8 @@
  *					image has failed to match expected
  *					checksum. Trying to program image again
  *					might solve this.
+ * CPU_BOOT_ERR0_PLL_FAIL		PLL settings failed, meaning that one
+ *					of the PLLs remained in REF_CLK
  *
  * CPU_BOOT_ERR0_ENABLED		Error registers enabled.
  *					This is a main indication that the
@@ -88,6 +90,7 @@
 #define CPU_BOOT_ERR0_EFUSE_FAIL		(1 << 9)
 #define CPU_BOOT_ERR0_PRI_IMG_VER_FAIL		(1 << 10)
 #define CPU_BOOT_ERR0_SEC_IMG_VER_FAIL		(1 << 11)
+#define CPU_BOOT_ERR0_PLL_FAIL			(1 << 12)
 #define CPU_BOOT_ERR0_ENABLED			(1 << 31)
 
 /*
-- 
2.25.1

