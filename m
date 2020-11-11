Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0D7E2AF95B
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 20:59:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727132AbgKKT71 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 14:59:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:39068 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726111AbgKKT71 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 14:59:27 -0500
Received: from ogabbay-VM.habana-labs.com (unknown [213.57.90.10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B9E40207F7;
        Wed, 11 Nov 2020 19:59:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605124765;
        bh=n5eWrnULMTsdUYMLIt4zsJx5VcTYvz+pG4dbjld/e6g=;
        h=From:To:Cc:Subject:Date:From;
        b=vTpUz8CFXnFq1UxN0/mmJYuMCH/LSfqych9AzCBDM8i+H8wmcBkmbs5OdG6qwSfsQ
         6aS8hbFEeHUhhB+Tr/D9HufqFMEmCvHws0ZQWmFpHFXMsf0LmRC6j9ciXg82i1LDJA
         yxFleLw2HhBmeErjFeXLeswl4RywWmOL9zRXwMLY=
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     SW_Drivers@habana.ai, Ofir Bitton <obitton@habana.ai>
Subject: [PATCH] habanalabs: fetch hard reset capability from FW
Date:   Wed, 11 Nov 2020 21:59:18 +0200
Message-Id: <20201111195920.18338-1-ogabbay@kernel.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ofir Bitton <obitton@habana.ai>

Driver must fetch FW hard reset capability during boot time,
in order to skip the hard reset flow if necessary.

Signed-off-by: Ofir Bitton <obitton@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/firmware_if.c  | 10 ++++++-
 drivers/misc/habanalabs/common/habanalabs.h   |  2 ++
 drivers/misc/habanalabs/gaudi/gaudi.c         |  1 +
 drivers/misc/habanalabs/goya/goya.c           |  1 +
 .../habanalabs/include/common/hl_boot_if.h    | 30 ++++++++++++-------
 5 files changed, 32 insertions(+), 12 deletions(-)

diff --git a/drivers/misc/habanalabs/common/firmware_if.c b/drivers/misc/habanalabs/common/firmware_if.c
index 2fc12e529241..b5464cd34071 100644
--- a/drivers/misc/habanalabs/common/firmware_if.c
+++ b/drivers/misc/habanalabs/common/firmware_if.c
@@ -784,10 +784,18 @@ int hl_fw_init_cpu(struct hl_device *hdev, u32 cpu_boot_status_reg,
 	}
 
 	/* Read FW application security bits */
-	if (hdev->asic_prop.fw_security_status_valid)
+	if (hdev->asic_prop.fw_security_status_valid) {
 		hdev->asic_prop.fw_app_security_map =
 				RREG32(cpu_security_boot_status_reg);
 
+		if (hdev->asic_prop.fw_app_security_map &
+				CPU_BOOT_DEV_STS0_FW_HARD_RST_EN)
+			hdev->asic_prop.hard_reset_done_by_fw = true;
+	}
+
+	dev_info(hdev->dev, "Firmware hard-reset is %s\n",
+		hdev->asic_prop.hard_reset_done_by_fw ? "enabled" : "disabled");
+
 	dev_info(hdev->dev, "Successfully loaded firmware to device\n");
 
 out:
diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index a1d82de60ef6..eeb78381177b 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -412,6 +412,7 @@ struct hl_mmu_properties {
  * @fw_security_status_valid: security status bits are valid and can be fetched
  *                            from BOOT_DEV_STS0
  * @dram_supports_virtual_memory: is there an MMU towards the DRAM
+ * @hard_reset_done_by_fw: true if firmware is handling hard reset flow
  */
 struct asic_fixed_properties {
 	struct hw_queue_properties	*hw_queues_props;
@@ -469,6 +470,7 @@ struct asic_fixed_properties {
 	u8				fw_security_disabled;
 	u8				fw_security_status_valid;
 	u8				dram_supports_virtual_memory;
+	u8				hard_reset_done_by_fw;
 };
 
 /**
diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index 8d6cffd28381..6d54a4574284 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -518,6 +518,7 @@ static int gaudi_get_fixed_properties(struct hl_device *hdev)
 	/* disable fw security for now, set it in a later stage */
 	prop->fw_security_disabled = true;
 	prop->fw_security_status_valid = false;
+	prop->hard_reset_done_by_fw = false;
 
 	return 0;
 }
diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index bf21f05f7849..3398b4cc1298 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -458,6 +458,7 @@ int goya_get_fixed_properties(struct hl_device *hdev)
 	/* disable fw security for now, set it in a later stage */
 	prop->fw_security_disabled = true;
 	prop->fw_security_status_valid = false;
+	prop->hard_reset_done_by_fw = false;
 
 	return 0;
 }
diff --git a/drivers/misc/habanalabs/include/common/hl_boot_if.h b/drivers/misc/habanalabs/include/common/hl_boot_if.h
index d928ad93cd80..60916780df35 100644
--- a/drivers/misc/habanalabs/include/common/hl_boot_if.h
+++ b/drivers/misc/habanalabs/include/common/hl_boot_if.h
@@ -84,45 +84,52 @@
  *					device is indicated as security enabled,
  *					registers are protected, and device
  *					uses keys for image verification.
- *					Initialized at: preboot
+ *					Initialized in: preboot
  *
  * CPU_BOOT_DEV_STS0_DEBUG_EN		Debug is enabled.
  *					Enabled when JTAG or DEBUG is enabled
  *					in FW.
- *					Initialized at: preboot
+ *					Initialized in: preboot
  *
  * CPU_BOOT_DEV_STS0_WATCHDOG_EN	Watchdog is enabled.
  *					Watchdog is enabled in FW.
- *					Initialized at: preboot
+ *					Initialized in: preboot
  *
  * CPU_BOOT_DEV_STS0_DRAM_INIT_EN	DRAM initialization is enabled.
  *					DRAM initialization has been done in FW.
- *					Initialized at: u-boot
+ *					Initialized in: u-boot
  *
  * CPU_BOOT_DEV_STS0_BMC_WAIT_EN	Waiting for BMC data enabled.
  *					If set, it means that during boot,
  *					FW waited for BMC data.
- *					Initialized at: u-boot
+ *					Initialized in: u-boot
  *
  * CPU_BOOT_DEV_STS0_E2E_CRED_EN	E2E credits initialized.
  *					FW initialized E2E credits.
- *					Initialized at: u-boot
+ *					Initialized in: u-boot
  *
  * CPU_BOOT_DEV_STS0_HBM_CRED_EN	HBM credits initialized.
  *					FW initialized HBM credits.
- *					Initialized at: u-boot
+ *					Initialized in: u-boot
  *
  * CPU_BOOT_DEV_STS0_RL_EN		Rate limiter initialized.
  *					FW initialized rate limiter.
- *					Initialized at: u-boot
+ *					Initialized in: u-boot
  *
  * CPU_BOOT_DEV_STS0_SRAM_SCR_EN	SRAM scrambler enabled.
  *					FW initialized SRAM scrambler.
- *					Initialized at: linux
+ *					Initialized in: linux
  *
  * CPU_BOOT_DEV_STS0_DRAM_SCR_EN	DRAM scrambler enabled.
  *					FW initialized DRAM scrambler.
- *					Initialized at: u-boot
+ *					Initialized in: u-boot
+ *
+ * CPU_BOOT_DEV_STS0_FW_HARD_RST_EN	FW hard reset procedure is enabled.
+ *					FW has the hard reset procedure
+ *					implemented. This means that FW will
+ *					perform hard reset procedure on
+ *					receiving the halt-machine event.
+ *					Initialized in: linux
  *
  * CPU_BOOT_DEV_STS0_ENABLED		Device status register enabled.
  *					This is a main indication that the
@@ -130,7 +137,7 @@
  *					register. Meaning the device status
  *					bits are not garbage, but actual
  *					statuses.
- *					Initialized at: preboot
+ *					Initialized in: preboot
  */
 #define CPU_BOOT_DEV_STS0_SECURITY_EN			(1 << 0)
 #define CPU_BOOT_DEV_STS0_DEBUG_EN			(1 << 1)
@@ -142,6 +149,7 @@
 #define CPU_BOOT_DEV_STS0_RL_EN				(1 << 7)
 #define CPU_BOOT_DEV_STS0_SRAM_SCR_EN			(1 << 8)
 #define CPU_BOOT_DEV_STS0_DRAM_SCR_EN			(1 << 9)
+#define CPU_BOOT_DEV_STS0_FW_HARD_RST_EN		(1 << 10)
 #define CPU_BOOT_DEV_STS0_ENABLED			(1 << 31)
 
 enum cpu_boot_status {
-- 
2.17.1

