Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C6852CDCA3
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 18:49:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726869AbgLCRqm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 12:46:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:45564 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726041AbgLCRql (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 12:46:41 -0500
From:   Oded Gabbay <ogabbay@kernel.org>
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     linux-kernel@vger.kernel.org
Cc:     SW_Drivers@habana.ai, Ofir Bitton <obitton@habana.ai>
Subject: [PATCH] habanalabs: preboot hard reset support
Date:   Thu,  3 Dec 2020 19:45:54 +0200
Message-Id: <20201203174554.31472-1-ogabbay@kernel.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ofir Bitton <obitton@habana.ai>

FW hard reset capability indication is now moved to preboot stage.
Driver will check if HW is dirty only after it validated preboot
is up. If HW is dirty, driver will perform a hard reset according
to the FW capability.
In addition, FW defines a new message which driver need to send in
order to initiate a hard reset.

Signed-off-by: Ofir Bitton <obitton@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/firmware_if.c  | 25 ++++++++++---------
 drivers/misc/habanalabs/gaudi/gaudi.c         | 17 +++++++------
 drivers/misc/habanalabs/goya/goya.c           | 12 ++++-----
 .../habanalabs/include/common/hl_boot_if.h    |  2 ++
 4 files changed, 31 insertions(+), 25 deletions(-)

diff --git a/drivers/misc/habanalabs/common/firmware_if.c b/drivers/misc/habanalabs/common/firmware_if.c
index 0e1c629e9800..c970bfc6db66 100644
--- a/drivers/misc/habanalabs/common/firmware_if.c
+++ b/drivers/misc/habanalabs/common/firmware_if.c
@@ -627,7 +627,9 @@ int hl_fw_read_preboot_status(struct hl_device *hdev, u32 cpu_boot_status_reg,
 	security_status = RREG32(cpu_security_boot_status_reg);
 
 	/* We read security status multiple times during boot:
-	 * 1. preboot - we check if fw security feature is supported
+	 * 1. preboot - a. Check whether the security status bits are valid
+	 *              b. Check whether fw security is enabled
+	 *              c. Check whether hard reset is done by fw
 	 * 2. boot cpu - we get boot cpu security status
 	 * 3. FW application - we get FW application security status
 	 *
@@ -637,13 +639,20 @@ int hl_fw_read_preboot_status(struct hl_device *hdev, u32 cpu_boot_status_reg,
 	 */
 	if (security_status & CPU_BOOT_DEV_STS0_ENABLED) {
 		hdev->asic_prop.fw_security_status_valid = 1;
-		prop->fw_security_disabled =
-			!(security_status & CPU_BOOT_DEV_STS0_SECURITY_EN);
+
+		if (!(security_status & CPU_BOOT_DEV_STS0_SECURITY_EN))
+			prop->fw_security_disabled = true;
+
+		if (security_status & CPU_BOOT_DEV_STS0_FW_HARD_RST_EN)
+			hdev->asic_prop.hard_reset_done_by_fw = true;
 	} else {
 		hdev->asic_prop.fw_security_status_valid = 0;
 		prop->fw_security_disabled = true;
 	}
 
+	dev_dbg(hdev->dev, "Firmware hard-reset is %s\n",
+		hdev->asic_prop.hard_reset_done_by_fw ? "enabled" : "disabled");
+
 	dev_info(hdev->dev, "firmware-level security is %s\n",
 		prop->fw_security_disabled ? "disabled" : "enabled");
 
@@ -797,18 +806,10 @@ int hl_fw_init_cpu(struct hl_device *hdev, u32 cpu_boot_status_reg,
 	}
 
 	/* Read FW application security bits */
-	if (hdev->asic_prop.fw_security_status_valid) {
+	if (hdev->asic_prop.fw_security_status_valid)
 		hdev->asic_prop.fw_app_security_map =
 				RREG32(cpu_security_boot_status_reg);
 
-		if (hdev->asic_prop.fw_app_security_map &
-				CPU_BOOT_DEV_STS0_FW_HARD_RST_EN)
-			hdev->asic_prop.hard_reset_done_by_fw = true;
-	}
-
-	dev_dbg(hdev->dev, "Firmware hard-reset is %s\n",
-		hdev->asic_prop.hard_reset_done_by_fw ? "enabled" : "disabled");
-
 	dev_info(hdev->dev, "Successfully loaded firmware to device\n");
 
 out:
diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index 278c4de98e22..e465c158eaeb 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -654,12 +654,6 @@ static int gaudi_early_init(struct hl_device *hdev)
 	if (rc)
 		goto free_queue_props;
 
-	if (gaudi_get_hw_state(hdev) == HL_DEVICE_HW_STATE_DIRTY) {
-		dev_info(hdev->dev,
-			"H/W state is dirty, must reset before initializing\n");
-		hdev->asic_funcs->hw_fini(hdev, true);
-	}
-
 	/* Before continuing in the initialization, we need to read the preboot
 	 * version to determine whether we run with a security-enabled firmware
 	 */
@@ -672,6 +666,12 @@ static int gaudi_early_init(struct hl_device *hdev)
 		goto pci_fini;
 	}
 
+	if (gaudi_get_hw_state(hdev) == HL_DEVICE_HW_STATE_DIRTY) {
+		dev_info(hdev->dev,
+			"H/W state is dirty, must reset before initializing\n");
+		hdev->asic_funcs->hw_fini(hdev, true);
+	}
+
 	return 0;
 
 pci_fini:
@@ -3881,7 +3881,10 @@ static void gaudi_hw_fini(struct hl_device *hdev, bool hard_reset)
 	/* I don't know what is the state of the CPU so make sure it is
 	 * stopped in any means necessary
 	 */
-	WREG32(mmPSOC_GLOBAL_CONF_KMD_MSG_TO_CPU, KMD_MSG_GOTO_WFE);
+	if (hdev->asic_prop.hard_reset_done_by_fw)
+		WREG32(mmPSOC_GLOBAL_CONF_KMD_MSG_TO_CPU, KMD_MSG_RST_DEV);
+	else
+		WREG32(mmPSOC_GLOBAL_CONF_KMD_MSG_TO_CPU, KMD_MSG_GOTO_WFE);
 
 	WREG32(mmGIC_DISTRIBUTOR__5_GICD_SETSPI_NSR, GAUDI_EVENT_HALT_MACHINE);
 
diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index b66fd55accb5..d61177bf36a5 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -613,12 +613,6 @@ static int goya_early_init(struct hl_device *hdev)
 	if (rc)
 		goto free_queue_props;
 
-	if (goya_get_hw_state(hdev) == HL_DEVICE_HW_STATE_DIRTY) {
-		dev_info(hdev->dev,
-			"H/W state is dirty, must reset before initializing\n");
-		hdev->asic_funcs->hw_fini(hdev, true);
-	}
-
 	/* Before continuing in the initialization, we need to read the preboot
 	 * version to determine whether we run with a security-enabled firmware
 	 */
@@ -631,6 +625,12 @@ static int goya_early_init(struct hl_device *hdev)
 		goto pci_fini;
 	}
 
+	if (goya_get_hw_state(hdev) == HL_DEVICE_HW_STATE_DIRTY) {
+		dev_info(hdev->dev,
+			"H/W state is dirty, must reset before initializing\n");
+		hdev->asic_funcs->hw_fini(hdev, true);
+	}
+
 	if (!hdev->pldm) {
 		val = RREG32(mmPSOC_GLOBAL_CONF_BOOT_STRAP_PINS);
 		if (val & PSOC_GLOBAL_CONF_BOOT_STRAP_PINS_SRIOV_EN_MASK)
diff --git a/drivers/misc/habanalabs/include/common/hl_boot_if.h b/drivers/misc/habanalabs/include/common/hl_boot_if.h
index e5801ecf0cb2..755c4800f002 100644
--- a/drivers/misc/habanalabs/include/common/hl_boot_if.h
+++ b/drivers/misc/habanalabs/include/common/hl_boot_if.h
@@ -204,6 +204,8 @@ enum kmd_msg {
 	KMD_MSG_GOTO_WFE,
 	KMD_MSG_FIT_RDY,
 	KMD_MSG_SKIP_BMC,
+	RESERVED,
+	KMD_MSG_RST_DEV,
 };
 
 enum cpu_msg_status {
-- 
2.17.1

