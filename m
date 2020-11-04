Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18B4E2A5FB2
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 09:36:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728361AbgKDIgg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 03:36:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:56252 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725812AbgKDIgg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 03:36:36 -0500
Received: from ogabbay-VM.habana-labs.com (unknown [213.57.90.10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9B3F620732;
        Wed,  4 Nov 2020 08:36:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604478995;
        bh=eHqqB7Wjk0mwlmZZbjgMM+oTvloJygVbISJrge5k7V8=;
        h=From:To:Cc:Subject:Date:From;
        b=gU8mTHdNiAPeZqySloBqOvxuvk12gtfgUd2my0pxyFKH1tNlxOhT4kDOiYLuhOQ6j
         jVyTvWcg2h+oJtPj/2W4RVyJQKK1ynOvvLF2TjNYm95F0kLQTZCm3qjyECg761Pz1y
         N4hapSghPcqafOBmV8RIRUZTOTC/yFDomgLtO37Q=
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     SW_Drivers@habana.ai, Ofir Bitton <obitton@habana.ai>
Subject: [PATCH] habanalabs: advanced FW loading
Date:   Wed,  4 Nov 2020 10:36:23 +0200
Message-Id: <20201104083630.28402-1-ogabbay@kernel.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ofir Bitton <obitton@habana.ai>

Today driver is able to load a whole FW binary into a specific
location on ASIC. We add support for loading sections from the
same FW binary into different loactions.

Signed-off-by: Ofir Bitton <obitton@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/firmware_if.c | 21 ++++++++++++++++----
 drivers/misc/habanalabs/common/habanalabs.h  |  2 +-
 drivers/misc/habanalabs/gaudi/gaudi.c        |  4 ++--
 drivers/misc/habanalabs/goya/goya.c          |  4 ++--
 4 files changed, 22 insertions(+), 9 deletions(-)

diff --git a/drivers/misc/habanalabs/common/firmware_if.c b/drivers/misc/habanalabs/common/firmware_if.c
index 1340afa8ce3b..647606f6cc2a 100644
--- a/drivers/misc/habanalabs/common/firmware_if.c
+++ b/drivers/misc/habanalabs/common/firmware_if.c
@@ -20,16 +20,18 @@
  * @hdev: pointer to hl_device structure.
  * @fw_name: the firmware image name
  * @dst: IO memory mapped address space to copy firmware to
+ * @src_offset: offset in src FW to copy from
+ * @size: amount of bytes to copy (0 to copy the whole binary)
  *
  * Copy fw code from firmware file to device memory.
  *
  * Return: 0 on success, non-zero for failure.
  */
 int hl_fw_load_fw_to_device(struct hl_device *hdev, const char *fw_name,
-				void __iomem *dst)
+				void __iomem *dst, u32 src_offset, u32 size)
 {
 	const struct firmware *fw;
-	const u64 *fw_data;
+	const void *fw_data;
 	size_t fw_size;
 	int rc;
 
@@ -57,9 +59,20 @@ int hl_fw_load_fw_to_device(struct hl_device *hdev, const char *fw_name,
 		goto out;
 	}
 
-	fw_data = (const u64 *) fw->data;
+	if (size - src_offset > fw_size) {
+		dev_err(hdev->dev,
+			"size to copy(%u) and offset(%u) are invalid\n",
+			size, src_offset);
+		rc = -EINVAL;
+		goto out;
+	}
+
+	if (size)
+		fw_size = size;
+
+	fw_data = (const void *) fw->data;
 
-	memcpy_toio(dst, fw_data, fw_size);
+	memcpy_toio(dst, fw_data + src_offset, fw_size);
 
 out:
 	release_firmware(fw);
diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index 70d166e4fe09..2b17c13a2e34 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -2028,7 +2028,7 @@ int hl_mmu_if_set_funcs(struct hl_device *hdev);
 void hl_mmu_v1_set_funcs(struct hl_device *hdev);
 
 int hl_fw_load_fw_to_device(struct hl_device *hdev, const char *fw_name,
-				void __iomem *dst);
+				void __iomem *dst, u32 src_offset, u32 size);
 int hl_fw_send_pci_access_msg(struct hl_device *hdev, u32 opcode);
 int hl_fw_send_cpu_message(struct hl_device *hdev, u32 hw_queue_id, u32 *msg,
 				u16 len, u32 timeout, long *result);
diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index 8b02d6341b4c..d8fdcae542c0 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -3541,7 +3541,7 @@ static int gaudi_load_firmware_to_device(struct hl_device *hdev)
 
 	dst = hdev->pcie_bar[HBM_BAR_ID] + LINUX_FW_OFFSET;
 
-	return hl_fw_load_fw_to_device(hdev, GAUDI_LINUX_FW_FILE, dst);
+	return hl_fw_load_fw_to_device(hdev, GAUDI_LINUX_FW_FILE, dst, 0, 0);
 }
 
 static int gaudi_load_boot_fit_to_device(struct hl_device *hdev)
@@ -3550,7 +3550,7 @@ static int gaudi_load_boot_fit_to_device(struct hl_device *hdev)
 
 	dst = hdev->pcie_bar[SRAM_BAR_ID] + BOOT_FIT_SRAM_OFFSET;
 
-	return hl_fw_load_fw_to_device(hdev, GAUDI_BOOT_FIT_FILE, dst);
+	return hl_fw_load_fw_to_device(hdev, GAUDI_BOOT_FIT_FILE, dst, 0, 0);
 }
 
 static void gaudi_read_device_fw_version(struct hl_device *hdev,
diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index 0afce8a834af..49075d994bbc 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -2315,7 +2315,7 @@ static int goya_load_firmware_to_device(struct hl_device *hdev)
 
 	dst = hdev->pcie_bar[DDR_BAR_ID] + LINUX_FW_OFFSET;
 
-	return hl_fw_load_fw_to_device(hdev, GOYA_LINUX_FW_FILE, dst);
+	return hl_fw_load_fw_to_device(hdev, GOYA_LINUX_FW_FILE, dst, 0, 0);
 }
 
 /*
@@ -2332,7 +2332,7 @@ static int goya_load_boot_fit_to_device(struct hl_device *hdev)
 
 	dst = hdev->pcie_bar[SRAM_CFG_BAR_ID] + BOOT_FIT_SRAM_OFFSET;
 
-	return hl_fw_load_fw_to_device(hdev, GOYA_BOOT_FIT_FILE, dst);
+	return hl_fw_load_fw_to_device(hdev, GOYA_BOOT_FIT_FILE, dst, 0, 0);
 }
 
 /*
-- 
2.17.1

