Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3894A2A65EA
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 15:09:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730146AbgKDOJf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 09:09:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:37720 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729988AbgKDOJa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 09:09:30 -0500
Received: from ogabbay-VM.habana-labs.com (unknown [213.57.90.10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EE4B622280;
        Wed,  4 Nov 2020 14:09:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604498969;
        bh=YmBo6I3iPlFjREJ8ExqC0yQQz/itgRF5fi4AUPqm0z4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rFx491n15SzojDoTM4R5Dc6aXRKwRUKO1VAWVqQ/ij/g/VavvGhelsmMjcUWUE1EW
         ZM0YHWf7VQBzAHV1gw8R4LvtnxGWd01TboXDo6Mt1LcPm6SVdMV7F8/ORkgCVBKVWc
         y+IDFZ8O5QIpogZbTCjeuUOy0xnqoB6mVfVrHUh0=
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     SW_Drivers@habana.ai, farah kassabri <fkassabri@habana.ai>
Subject: [PATCH] habanalabs: reset device upon fw read failure
Date:   Wed,  4 Nov 2020 16:09:04 +0200
Message-Id: <20201104140908.10178-8-ogabbay@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201104140908.10178-1-ogabbay@kernel.org>
References: <20201104140908.10178-1-ogabbay@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: farah kassabri <fkassabri@habana.ai>

failure in reading pre-boot verion is not handled correctly,
upon failure we need to reset the device in order to be able
to reinstall the driver.

Signed-off-by: farah kassabri <fkassabri@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/firmware_if.c |  4 ++-
 drivers/misc/habanalabs/common/habanalabs.h  |  2 +-
 drivers/misc/habanalabs/common/pci.c         |  5 +++-
 drivers/misc/habanalabs/gaudi/gaudi.c        | 27 ++++++++++++--------
 drivers/misc/habanalabs/goya/goya.c          | 22 ++++++++++------
 5 files changed, 38 insertions(+), 22 deletions(-)

diff --git a/drivers/misc/habanalabs/common/firmware_if.c b/drivers/misc/habanalabs/common/firmware_if.c
index fb9d901d5059..2fc12e529241 100644
--- a/drivers/misc/habanalabs/common/firmware_if.c
+++ b/drivers/misc/habanalabs/common/firmware_if.c
@@ -607,7 +607,9 @@ int hl_fw_read_preboot_status(struct hl_device *hdev, u32 cpu_boot_status_reg,
 		return -EIO;
 	}
 
-	hdev->asic_funcs->read_device_fw_version(hdev, FW_COMP_PREBOOT);
+	rc = hdev->asic_funcs->read_device_fw_version(hdev, FW_COMP_PREBOOT);
+	if (rc)
+		return rc;
 
 	security_status = RREG32(cpu_security_boot_status_reg);
 
diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index 9f5a3c07f421..227f1a9552a6 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -927,7 +927,7 @@ struct hl_asic_funcs {
 	void (*ctx_fini)(struct hl_ctx *ctx);
 	int (*get_clk_rate)(struct hl_device *hdev, u32 *cur_clk, u32 *max_clk);
 	u32 (*get_queue_id_for_cq)(struct hl_device *hdev, u32 cq_idx);
-	void (*read_device_fw_version)(struct hl_device *hdev,
+	int (*read_device_fw_version)(struct hl_device *hdev,
 					enum hl_fw_component fwc);
 	int (*load_firmware_to_device)(struct hl_device *hdev);
 	int (*load_boot_fit_to_device)(struct hl_device *hdev);
diff --git a/drivers/misc/habanalabs/common/pci.c b/drivers/misc/habanalabs/common/pci.c
index 211f3190f8d7..02152d85cf19 100644
--- a/drivers/misc/habanalabs/common/pci.c
+++ b/drivers/misc/habanalabs/common/pci.c
@@ -390,8 +390,11 @@ int hl_pci_init(struct hl_device *hdev, u32 cpu_boot_status_reg,
 	rc = hl_fw_read_preboot_status(hdev, cpu_boot_status_reg,
 			cpu_security_boot_status_reg, boot_err0_reg,
 			preboot_ver_timeout);
-	if (rc)
+	if (rc) {
+		dev_err(hdev->dev, "Failed to read preboot version\n");
+		hdev->asic_funcs->hw_fini(hdev, true);
 		goto unmap_pci_bars;
+	}
 
 	return 0;
 
diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index ae73ffb4ad64..8abe46b8d615 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -3615,7 +3615,7 @@ static int gaudi_load_boot_fit_to_device(struct hl_device *hdev)
 	return hl_fw_load_fw_to_device(hdev, GAUDI_BOOT_FIT_FILE, dst, 0, 0);
 }
 
-static void gaudi_read_device_fw_version(struct hl_device *hdev,
+static int gaudi_read_device_fw_version(struct hl_device *hdev,
 					enum hl_fw_component fwc)
 {
 	const char *name;
@@ -3635,7 +3635,7 @@ static void gaudi_read_device_fw_version(struct hl_device *hdev,
 		break;
 	default:
 		dev_warn(hdev->dev, "Undefined FW component: %d\n", fwc);
-		return;
+		return -EIO;
 	}
 
 	ver_off &= ~((u32)SRAM_BASE_ADDR);
@@ -3647,7 +3647,10 @@ static void gaudi_read_device_fw_version(struct hl_device *hdev,
 		dev_err(hdev->dev, "%s version offset (0x%x) is above SRAM\n",
 								name, ver_off);
 		strcpy(dest, "unavailable");
+		return -EIO;
 	}
+
+	return 0;
 }
 
 static int gaudi_init_cpu(struct hl_device *hdev)
@@ -3937,16 +3940,18 @@ static void gaudi_hw_fini(struct hl_device *hdev, bool hard_reset)
 
 	WREG32(mmPSOC_GLOBAL_CONF_BOOT_STRAP_PINS, boot_strap);
 
-	gaudi->hw_cap_initialized &= ~(HW_CAP_CPU | HW_CAP_CPU_Q |
-					HW_CAP_HBM | HW_CAP_PCI_DMA |
-					HW_CAP_MME | HW_CAP_TPC_MASK |
-					HW_CAP_HBM_DMA | HW_CAP_PLL |
-					HW_CAP_NIC_MASK | HW_CAP_MMU |
-					HW_CAP_SRAM_SCRAMBLER |
-					HW_CAP_HBM_SCRAMBLER |
-					HW_CAP_CLK_GATE);
+	if (gaudi) {
+		gaudi->hw_cap_initialized &= ~(HW_CAP_CPU | HW_CAP_CPU_Q |
+				HW_CAP_HBM | HW_CAP_PCI_DMA |
+				HW_CAP_MME | HW_CAP_TPC_MASK |
+				HW_CAP_HBM_DMA | HW_CAP_PLL |
+				HW_CAP_NIC_MASK | HW_CAP_MMU |
+				HW_CAP_SRAM_SCRAMBLER |
+				HW_CAP_HBM_SCRAMBLER |
+				HW_CAP_CLK_GATE);
 
-	memset(gaudi->events_stat, 0, sizeof(gaudi->events_stat));
+		memset(gaudi->events_stat, 0, sizeof(gaudi->events_stat));
+	}
 }
 
 static int gaudi_suspend(struct hl_device *hdev)
diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index 1b81102d1bec..6dea52a50be4 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -2341,7 +2341,7 @@ static int goya_load_boot_fit_to_device(struct hl_device *hdev)
  * FW component passes an offset from SRAM_BASE_ADDR in SCRATCHPAD_xx.
  * The version string should be located by that offset.
  */
-static void goya_read_device_fw_version(struct hl_device *hdev,
+static int goya_read_device_fw_version(struct hl_device *hdev,
 					enum hl_fw_component fwc)
 {
 	const char *name;
@@ -2361,7 +2361,7 @@ static void goya_read_device_fw_version(struct hl_device *hdev,
 		break;
 	default:
 		dev_warn(hdev->dev, "Undefined FW component: %d\n", fwc);
-		return;
+		return -EIO;
 	}
 
 	ver_off &= ~((u32)SRAM_BASE_ADDR);
@@ -2373,7 +2373,11 @@ static void goya_read_device_fw_version(struct hl_device *hdev,
 		dev_err(hdev->dev, "%s version offset (0x%x) is above SRAM\n",
 								name, ver_off);
 		strcpy(dest, "unavailable");
+
+		return -EIO;
 	}
+
+	return 0;
 }
 
 static int goya_init_cpu(struct hl_device *hdev)
@@ -2644,12 +2648,14 @@ static void goya_hw_fini(struct hl_device *hdev, bool hard_reset)
 	WREG32(mmPSOC_GLOBAL_CONF_SW_BTM_FSM,
 			0xA << PSOC_GLOBAL_CONF_SW_BTM_FSM_CTRL_SHIFT);
 
-	goya->hw_cap_initialized &= ~(HW_CAP_CPU | HW_CAP_CPU_Q |
-					HW_CAP_DDR_0 | HW_CAP_DDR_1 |
-					HW_CAP_DMA | HW_CAP_MME |
-					HW_CAP_MMU | HW_CAP_TPC_MBIST |
-					HW_CAP_GOLDEN | HW_CAP_TPC);
-	memset(goya->events_stat, 0, sizeof(goya->events_stat));
+	if (goya) {
+		goya->hw_cap_initialized &= ~(HW_CAP_CPU | HW_CAP_CPU_Q |
+				HW_CAP_DDR_0 | HW_CAP_DDR_1 |
+				HW_CAP_DMA | HW_CAP_MME |
+				HW_CAP_MMU | HW_CAP_TPC_MBIST |
+				HW_CAP_GOLDEN | HW_CAP_TPC);
+		memset(goya->events_stat, 0, sizeof(goya->events_stat));
+	}
 }
 
 int goya_suspend(struct hl_device *hdev)
-- 
2.17.1

