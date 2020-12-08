Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 957342D2E74
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 16:41:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730052AbgLHPkd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 10:40:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:44288 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729471AbgLHPkd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 10:40:33 -0500
From:   Oded Gabbay <ogabbay@kernel.org>
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     linux-kernel@vger.kernel.org
Cc:     SW_Drivers@habana.ai, Ofir Bitton <obitton@habana.ai>
Subject: [PATCH] habanalabs: full FW hard reset support
Date:   Tue,  8 Dec 2020 17:39:44 +0200
Message-Id: <20201208153947.18678-1-ogabbay@kernel.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ofir Bitton <obitton@habana.ai>

Driver must fetch FW hard reset capability at every FW boot stage:
preboot, CPU boot, CPU application.
If hard reset is triggered, driver will take into consideration
only the last capability received.

Signed-off-by: Ofir Bitton <obitton@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/firmware_if.c | 51 +++++++++++++++-----
 1 file changed, 38 insertions(+), 13 deletions(-)

diff --git a/drivers/misc/habanalabs/common/firmware_if.c b/drivers/misc/habanalabs/common/firmware_if.c
index c970bfc6db66..7720b48c6239 100644
--- a/drivers/misc/habanalabs/common/firmware_if.c
+++ b/drivers/misc/habanalabs/common/firmware_if.c
@@ -629,32 +629,34 @@ int hl_fw_read_preboot_status(struct hl_device *hdev, u32 cpu_boot_status_reg,
 	/* We read security status multiple times during boot:
 	 * 1. preboot - a. Check whether the security status bits are valid
 	 *              b. Check whether fw security is enabled
-	 *              c. Check whether hard reset is done by fw
-	 * 2. boot cpu - we get boot cpu security status
-	 * 3. FW application - we get FW application security status
+	 *              c. Check whether hard reset is done by preboot
+	 * 2. boot cpu - a. Fetch boot cpu security status
+	 *               b. Check whether hard reset is done by boot cpu
+	 * 3. FW application - a. Fetch fw application security status
+	 *                     b. Check whether hard reset is done by fw app
 	 *
 	 * Preboot:
 	 * Check security status bit (CPU_BOOT_DEV_STS0_ENABLED), if it is set
 	 * check security enabled bit (CPU_BOOT_DEV_STS0_SECURITY_EN)
 	 */
 	if (security_status & CPU_BOOT_DEV_STS0_ENABLED) {
-		hdev->asic_prop.fw_security_status_valid = 1;
+		prop->fw_security_status_valid = 1;
 
 		if (!(security_status & CPU_BOOT_DEV_STS0_SECURITY_EN))
 			prop->fw_security_disabled = true;
 
 		if (security_status & CPU_BOOT_DEV_STS0_FW_HARD_RST_EN)
-			hdev->asic_prop.hard_reset_done_by_fw = true;
+			prop->hard_reset_done_by_fw = true;
 	} else {
-		hdev->asic_prop.fw_security_status_valid = 0;
+		prop->fw_security_status_valid = 0;
 		prop->fw_security_disabled = true;
 	}
 
-	dev_dbg(hdev->dev, "Firmware hard-reset is %s\n",
-		hdev->asic_prop.hard_reset_done_by_fw ? "enabled" : "disabled");
+	dev_dbg(hdev->dev, "Firmware preboot hard-reset is %s\n",
+			prop->hard_reset_done_by_fw ? "enabled" : "disabled");
 
 	dev_info(hdev->dev, "firmware-level security is %s\n",
-		prop->fw_security_disabled ? "disabled" : "enabled");
+			prop->fw_security_disabled ? "disabled" : "enabled");
 
 	return 0;
 }
@@ -664,6 +666,7 @@ int hl_fw_init_cpu(struct hl_device *hdev, u32 cpu_boot_status_reg,
 			u32 cpu_security_boot_status_reg, u32 boot_err0_reg,
 			bool skip_bmc, u32 cpu_timeout, u32 boot_fit_timeout)
 {
+	struct asic_fixed_properties *prop = &hdev->asic_prop;
 	u32 status;
 	int rc;
 
@@ -732,11 +735,22 @@ int hl_fw_init_cpu(struct hl_device *hdev, u32 cpu_boot_status_reg,
 	/* Read U-Boot version now in case we will later fail */
 	hdev->asic_funcs->read_device_fw_version(hdev, FW_COMP_UBOOT);
 
+	/* Clear reset status since we need to read it again from boot CPU */
+	prop->hard_reset_done_by_fw = false;
+
 	/* Read boot_cpu security bits */
-	if (hdev->asic_prop.fw_security_status_valid)
-		hdev->asic_prop.fw_boot_cpu_security_map =
+	if (prop->fw_security_status_valid) {
+		prop->fw_boot_cpu_security_map =
 				RREG32(cpu_security_boot_status_reg);
 
+		if (prop->fw_boot_cpu_security_map &
+				CPU_BOOT_DEV_STS0_FW_HARD_RST_EN)
+			prop->hard_reset_done_by_fw = true;
+	}
+
+	dev_dbg(hdev->dev, "Firmware boot CPU hard-reset is %s\n",
+			prop->hard_reset_done_by_fw ? "enabled" : "disabled");
+
 	if (rc) {
 		detect_cpu_boot_status(hdev, status);
 		rc = -EIO;
@@ -805,11 +819,22 @@ int hl_fw_init_cpu(struct hl_device *hdev, u32 cpu_boot_status_reg,
 		goto out;
 	}
 
+	/* Clear reset status since we need to read again from app */
+	prop->hard_reset_done_by_fw = false;
+
 	/* Read FW application security bits */
-	if (hdev->asic_prop.fw_security_status_valid)
-		hdev->asic_prop.fw_app_security_map =
+	if (prop->fw_security_status_valid) {
+		prop->fw_app_security_map =
 				RREG32(cpu_security_boot_status_reg);
 
+		if (prop->fw_app_security_map &
+				CPU_BOOT_DEV_STS0_FW_HARD_RST_EN)
+			prop->hard_reset_done_by_fw = true;
+	}
+
+	dev_dbg(hdev->dev, "Firmware application CPU hard-reset is %s\n",
+			prop->hard_reset_done_by_fw ? "enabled" : "disabled");
+
 	dev_info(hdev->dev, "Successfully loaded firmware to device\n");
 
 out:
-- 
2.17.1

