Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C382D2E74D8
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Dec 2020 22:39:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726492AbgL2Vhk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Dec 2020 16:37:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:43392 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726263AbgL2Vhj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Dec 2020 16:37:39 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 80A2E207C8;
        Tue, 29 Dec 2020 21:36:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609277818;
        bh=KYHvLVuoG+llb/+nnT5NusOUMq6ZTYMSqPR+qfvNmhw=;
        h=From:To:Cc:Subject:Date:From;
        b=NGLi8Qh0q7zb+PN4ocqdPEw7I/hykCUOJmIGVd2/JsZudfxYFULNs+3U4tFLhpkQS
         H++YpQFCY39Pyap5zHKkjFkrawRFP6jMJ1hjmGhe74wc1RDQLj7M5zzp8+lYK9qGju
         DDS5iE2R+/PUbqM88Op38jg4/dJ3UYKYRDzJAwSPTLdKXoARvDkNUgmNWHJRHaRn/0
         qikWcrcOiK1OG8iMlqa3IwPHrPjib10vlpGK6+w1SPxCrKou4tdMzwANcQJ7C1UvkT
         C0bvLjlZ7EufRP5xiHOHv40Be9li3LwGjejnykHpaiQAwvVi3IwhnBsD+WiBch0vvY
         lcXi+omG8Q1ug==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Alon Mizrahi <amizrahi@habana.ai>
Subject: [PATCH 1/8] habanalabs: replace WARN/WARN_ON with dev_crit in driver
Date:   Tue, 29 Dec 2020 23:36:46 +0200
Message-Id: <20201229213653.29749-1-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alon Mizrahi <amizrahi@habana.ai>

Often WARN is defined in data-centers as BUG and we would like to
avoid hanging the entire server on some internal error of the driver
(important as it might be).

Therefore, use dev_crit instead.

Signed-off-by: Alon Mizrahi <amizrahi@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/asid.c              |  6 ++++--
 drivers/misc/habanalabs/common/command_buffer.c    |  8 +++++---
 .../misc/habanalabs/common/command_submission.c    |  4 ++--
 drivers/misc/habanalabs/common/device.c            |  3 ++-
 drivers/misc/habanalabs/common/mmu.c               |  7 ++++---
 drivers/misc/habanalabs/gaudi/gaudi.c              | 14 +++++++-------
 drivers/misc/habanalabs/goya/goya.c                | 14 +++++++-------
 7 files changed, 31 insertions(+), 25 deletions(-)

diff --git a/drivers/misc/habanalabs/common/asid.c b/drivers/misc/habanalabs/common/asid.c
index a2fdf31cf27c..ede04c032b6e 100644
--- a/drivers/misc/habanalabs/common/asid.c
+++ b/drivers/misc/habanalabs/common/asid.c
@@ -50,8 +50,10 @@ unsigned long hl_asid_alloc(struct hl_device *hdev)
 
 void hl_asid_free(struct hl_device *hdev, unsigned long asid)
 {
-	if (WARN((asid == 0 || asid >= hdev->asic_prop.max_asid),
-						"Invalid ASID %lu", asid))
+	if (asid == HL_KERNEL_ASID_ID || asid >= hdev->asic_prop.max_asid) {
+		dev_crit(hdev->dev, "Invalid ASID %lu", asid);
 		return;
+	}
+
 	clear_bit(asid, hdev->asid_bitmap);
 }
diff --git a/drivers/misc/habanalabs/common/command_buffer.c b/drivers/misc/habanalabs/common/command_buffer.c
index 6f6a904ab6ca..d9adb9a5e4d8 100644
--- a/drivers/misc/habanalabs/common/command_buffer.c
+++ b/drivers/misc/habanalabs/common/command_buffer.c
@@ -635,10 +635,12 @@ struct hl_cb *hl_cb_kernel_create(struct hl_device *hdev, u32 cb_size,
 
 	cb_handle >>= PAGE_SHIFT;
 	cb = hl_cb_get(hdev, &hdev->kernel_cb_mgr, (u32) cb_handle);
-	/* hl_cb_get should never fail here so use kernel WARN */
-	WARN(!cb, "Kernel CB handle invalid 0x%x\n", (u32) cb_handle);
-	if (!cb)
+	/* hl_cb_get should never fail here */
+	if (!cb) {
+		dev_crit(hdev->dev, "Kernel CB handle invalid 0x%x\n",
+				(u32) cb_handle);
 		goto destroy_cb;
+	}
 
 	return cb;
 
diff --git a/drivers/misc/habanalabs/common/command_submission.c b/drivers/misc/habanalabs/common/command_submission.c
index 348b0ecb4489..f7fac82ac41d 100644
--- a/drivers/misc/habanalabs/common/command_submission.c
+++ b/drivers/misc/habanalabs/common/command_submission.c
@@ -48,8 +48,8 @@ void hl_sob_reset_error(struct kref *ref)
 	struct hl_device *hdev = hw_sob->hdev;
 
 	dev_crit(hdev->dev,
-			"SOB release shouldn't be called here, q_idx: %d, sob_id: %d\n",
-			hw_sob->q_idx, hw_sob->sob_id);
+		"SOB release shouldn't be called here, q_idx: %d, sob_id: %d\n",
+		hw_sob->q_idx, hw_sob->sob_id);
 }
 
 /**
diff --git a/drivers/misc/habanalabs/common/device.c b/drivers/misc/habanalabs/common/device.c
index d5b7e94350d6..9ef77a2a34ec 100644
--- a/drivers/misc/habanalabs/common/device.c
+++ b/drivers/misc/habanalabs/common/device.c
@@ -1485,7 +1485,8 @@ void hl_device_fini(struct hl_device *hdev)
 		usleep_range(50, 200);
 		rc = atomic_cmpxchg(&hdev->in_reset, 0, 1);
 		if (ktime_compare(ktime_get(), timeout) > 0) {
-			WARN(1, "Failed to remove device because reset function did not finish\n");
+			dev_crit(hdev->dev,
+				"Failed to remove device because reset function did not finish\n");
 			return;
 		}
 	}
diff --git a/drivers/misc/habanalabs/common/mmu.c b/drivers/misc/habanalabs/common/mmu.c
index 33ae953d3a36..8ca265420545 100644
--- a/drivers/misc/habanalabs/common/mmu.c
+++ b/drivers/misc/habanalabs/common/mmu.c
@@ -261,9 +261,10 @@ int hl_mmu_map_page(struct hl_ctx *ctx, u64 virt_addr, u64 phys_addr,
 		return -EFAULT;
 	}
 
-	WARN_ONCE((phys_addr & (real_page_size - 1)),
-		"Mapping 0x%llx with page size of 0x%x is erroneous! Address must be divisible by page size",
-		phys_addr, real_page_size);
+	if (phys_addr & (real_page_size - 1))
+		dev_crit(hdev->dev,
+			"Mapping 0x%llx with page size of 0x%x is erroneous! Address must be divisible by page size",
+			phys_addr, real_page_size);
 
 	npages = page_size / real_page_size;
 	real_virt_addr = virt_addr;
diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index 3bd51b0a38b3..712d40bea107 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -5307,10 +5307,10 @@ static int gaudi_parse_cb_mmu(struct hl_device *hdev,
 	patched_cb_handle >>= PAGE_SHIFT;
 	parser->patched_cb = hl_cb_get(hdev, &hdev->kernel_cb_mgr,
 				(u32) patched_cb_handle);
-	/* hl_cb_get should never fail here so use kernel WARN */
-	WARN(!parser->patched_cb, "DMA CB handle invalid 0x%x\n",
-			(u32) patched_cb_handle);
+	/* hl_cb_get should never fail */
 	if (!parser->patched_cb) {
+		dev_crit(hdev->dev, "DMA CB handle invalid 0x%x\n",
+			(u32) patched_cb_handle);
 		rc = -EFAULT;
 		goto out;
 	}
@@ -5379,10 +5379,10 @@ static int gaudi_parse_cb_no_mmu(struct hl_device *hdev,
 	patched_cb_handle >>= PAGE_SHIFT;
 	parser->patched_cb = hl_cb_get(hdev, &hdev->kernel_cb_mgr,
 				(u32) patched_cb_handle);
-	/* hl_cb_get should never fail here so use kernel WARN */
-	WARN(!parser->patched_cb, "DMA CB handle invalid 0x%x\n",
-			(u32) patched_cb_handle);
+	/* hl_cb_get should never fail here */
 	if (!parser->patched_cb) {
+		dev_crit(hdev->dev, "DMA CB handle invalid 0x%x\n",
+				(u32) patched_cb_handle);
 		rc = -EFAULT;
 		goto out;
 	}
@@ -5927,7 +5927,7 @@ static void gaudi_mmu_prepare(struct hl_device *hdev, u32 asid)
 		return;
 
 	if (asid & ~DMA0_QM_GLBL_NON_SECURE_PROPS_0_ASID_MASK) {
-		WARN(1, "asid %u is too big\n", asid);
+		dev_crit(hdev->dev, "asid %u is too big\n", asid);
 		return;
 	}
 
diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index dc32091d9b4b..da12462bd888 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -3875,10 +3875,10 @@ static int goya_parse_cb_mmu(struct hl_device *hdev,
 	patched_cb_handle >>= PAGE_SHIFT;
 	parser->patched_cb = hl_cb_get(hdev, &hdev->kernel_cb_mgr,
 				(u32) patched_cb_handle);
-	/* hl_cb_get should never fail here so use kernel WARN */
-	WARN(!parser->patched_cb, "DMA CB handle invalid 0x%x\n",
-			(u32) patched_cb_handle);
+	/* hl_cb_get should never fail here */
 	if (!parser->patched_cb) {
+		dev_crit(hdev->dev, "DMA CB handle invalid 0x%x\n",
+			(u32) patched_cb_handle);
 		rc = -EFAULT;
 		goto out;
 	}
@@ -3947,10 +3947,10 @@ static int goya_parse_cb_no_mmu(struct hl_device *hdev,
 	patched_cb_handle >>= PAGE_SHIFT;
 	parser->patched_cb = hl_cb_get(hdev, &hdev->kernel_cb_mgr,
 				(u32) patched_cb_handle);
-	/* hl_cb_get should never fail here so use kernel WARN */
-	WARN(!parser->patched_cb, "DMA CB handle invalid 0x%x\n",
-			(u32) patched_cb_handle);
+	/* hl_cb_get should never fail here */
 	if (!parser->patched_cb) {
+		dev_crit(hdev->dev, "DMA CB handle invalid 0x%x\n",
+			(u32) patched_cb_handle);
 		rc = -EFAULT;
 		goto out;
 	}
@@ -5041,7 +5041,7 @@ static void goya_mmu_prepare(struct hl_device *hdev, u32 asid)
 		return;
 
 	if (asid & ~MME_QM_GLBL_SECURE_PROPS_ASID_MASK) {
-		WARN(1, "asid %u is too big\n", asid);
+		dev_crit(hdev->dev, "asid %u is too big\n", asid);
 		return;
 	}
 
-- 
2.25.1

