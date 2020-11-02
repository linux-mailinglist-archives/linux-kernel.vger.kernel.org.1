Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 128712A34C7
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 21:01:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726908AbgKBUAg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 15:00:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:38384 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726020AbgKBTtc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 14:49:32 -0500
Received: from ogabbay-VM.habana-labs.com (unknown [213.57.90.10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 19DB720731;
        Mon,  2 Nov 2020 19:49:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604346572;
        bh=33A36bpWYhwfvTWUU5z11172Lssvbj7fT71IgFOFSOk=;
        h=From:To:Cc:Subject:Date:From;
        b=uCICQ3SJZIK8IbUhifCox9lqUQtQ1JfUzHvG1IIPk7kZSOAoSdywpJMn/1a/JQOMP
         +FwmnzO8pYPkoGWrHUc4OJCibmsfgdLRTUNNq7mcXMmyiOZV64/0Lx8o4qSpJVElUM
         PoWDFaJybB4cTVjBKCwAoPm4mSa6Sp2JVSFs1qbM=
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     SW_Drivers@habana.ai
Subject: [PATCH] habanalabs: support multiple types of firmwares
Date:   Mon,  2 Nov 2020 21:49:27 +0200
Message-Id: <20201102194927.868-1-ogabbay@kernel.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver now loads the firmware in two stages. For debugging purposes
we need to support situations where only the first stage firmware is
loaded.

Therefore, use a bitmask to determine which F/W is loaded

Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/firmware_if.c    |  9 +++++++--
 drivers/misc/habanalabs/common/habanalabs.h     | 14 +++++++++++++-
 drivers/misc/habanalabs/common/habanalabs_drv.c |  1 +
 3 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/drivers/misc/habanalabs/common/firmware_if.c b/drivers/misc/habanalabs/common/firmware_if.c
index cd41c7ceb0e7..1340afa8ce3b 100644
--- a/drivers/misc/habanalabs/common/firmware_if.c
+++ b/drivers/misc/habanalabs/common/firmware_if.c
@@ -574,6 +574,9 @@ int hl_fw_init_cpu(struct hl_device *hdev, u32 cpu_boot_status_reg,
 	u32 status;
 	int rc;
 
+	if (!(hdev->fw_loading & FW_TYPE_BOOT_CPU))
+		return 0;
+
 	dev_info(hdev->dev, "Going to wait for device boot (up to %lds)\n",
 		cpu_timeout / USEC_PER_SEC);
 
@@ -631,6 +634,8 @@ int hl_fw_init_cpu(struct hl_device *hdev, u32 cpu_boot_status_reg,
 		10000,
 		cpu_timeout);
 
+	dev_dbg(hdev->dev, "uboot status = %d\n", status);
+
 	/* Read U-Boot version now in case we will later fail */
 	hdev->asic_funcs->read_device_fw_version(hdev, FW_COMP_UBOOT);
 
@@ -640,8 +645,8 @@ int hl_fw_init_cpu(struct hl_device *hdev, u32 cpu_boot_status_reg,
 		goto out;
 	}
 
-	if (!hdev->fw_loading) {
-		dev_info(hdev->dev, "Skip loading FW\n");
+	if (!(hdev->fw_loading & FW_TYPE_LINUX)) {
+		dev_info(hdev->dev, "Skip loading Linux F/W\n");
 		goto out;
 	}
 
diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index d7cf833a20bc..d12f11bdaacf 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -124,6 +124,18 @@ enum hl_fw_component {
 	FW_COMP_PREBOOT
 };
 
+/**
+ * enum hl_fw_types - F/W types to load
+ * @FW_TYPE_LINUX: Linux image for device CPU
+ * @FW_TYPE_BOOT_CPU: Boot image for device CPU
+ * @FW_TYPE_ALL_TYPES: Mask for all types
+ */
+enum hl_fw_types {
+	FW_TYPE_LINUX = 0x1,
+	FW_TYPE_BOOT_CPU = 0x2,
+	FW_TYPE_ALL_TYPES = (FW_TYPE_LINUX | FW_TYPE_BOOT_CPU)
+};
+
 /**
  * enum hl_queue_type - Supported QUEUE types.
  * @QUEUE_TYPE_NA: queue is not available.
@@ -1709,12 +1721,12 @@ struct hl_device {
 	u8				supports_cb_mapping;
 
 	/* Parameters for bring-up */
+	u64				fw_loading;
 	u8				mmu_enable;
 	u8				mmu_huge_page_opt;
 	u8				cpu_enable;
 	u8				reset_pcilink;
 	u8				cpu_queues_enable;
-	u8				fw_loading;
 	u8				pldm;
 	u8				axi_drain;
 	u8				sram_scrambler_enable;
diff --git a/drivers/misc/habanalabs/common/habanalabs_drv.c b/drivers/misc/habanalabs/common/habanalabs_drv.c
index f9067d3ef437..4c49d6cefa98 100644
--- a/drivers/misc/habanalabs/common/habanalabs_drv.c
+++ b/drivers/misc/habanalabs/common/habanalabs_drv.c
@@ -241,6 +241,7 @@ static void set_driver_behavior_per_device(struct hl_device *hdev)
 	hdev->dram_scrambler_enable = 1;
 	hdev->bmc_enable = 1;
 	hdev->hard_reset_on_fw_events = 1;
+	hdev->fw_loading = FW_TYPE_ALL_TYPES;
 }
 
 /*
-- 
2.17.1

