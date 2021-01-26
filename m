Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE9F2304FA0
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 04:21:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235436AbhA0DRq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 22:17:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:40642 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390044AbhAZUlq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 15:41:46 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id B7E34221FC;
        Tue, 26 Jan 2021 20:41:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611693663;
        bh=cExETPQ2nAIvQUq2HKq3vBmh7qSjwyRGqe6E9byeBUU=;
        h=From:To:Cc:Subject:Date:From;
        b=qqZKNxmdB2ZcnJgzel6OnniFKwmqjQIn9ZH/+xump1kQeHEy4mtr+YlqzXQtG5j6V
         pTKtgG/D1bBOA9bJuvVe69qsXzR2Gozh1+5up6bnNW/xnuO/S5g1CNT0+WsTtlPdDk
         30gpzukDBCFLh4/VEviwnaRf1/rxRJ8DsdohzUi6fxfXzYIh4e1ljKElMP0dowC55i
         Rndoc17TCQ5bMj9tj4bZ7LM2qMLFS6PQOdlRBslyNBCnOKPxCNrT4dnTU6tWlARWqu
         leWIqCpk0e1aJO/GtVqXy/29NbnZA7IcjjdIXbBfY6oCXM9t/9nTybgmsRhyeGLkgP
         O+u6CtAP3rC/w==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ohad Sharabi <osharabi@habana.ai>
Subject: [PATCH 1/3] habanalabs: modify device_idle interface
Date:   Tue, 26 Jan 2021 22:40:55 +0200
Message-Id: <20210126204057.329-1-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ohad Sharabi <osharabi@habana.ai>

Currently this API uses single 64 bits mask for engines idle indication.
Recently, it was observed that more bits are needed for some ASICs.
This patch modifies the use of the idle mask and the idle_extensions
mask.

Signed-off-by: Ohad Sharabi <osharabi@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/context.c      |  9 +++--
 drivers/misc/habanalabs/common/debugfs.c      |  2 +-
 drivers/misc/habanalabs/common/habanalabs.h   |  4 +-
 .../misc/habanalabs/common/habanalabs_ioctl.c |  5 ++-
 drivers/misc/habanalabs/gaudi/gaudi.c         | 37 ++++++++-----------
 drivers/misc/habanalabs/goya/goya.c           | 21 +++++------
 include/uapi/misc/habanalabs.h                |  4 +-
 7 files changed, 40 insertions(+), 42 deletions(-)

diff --git a/drivers/misc/habanalabs/common/context.c b/drivers/misc/habanalabs/common/context.c
index 829fe98eed61..cda871afb8f4 100644
--- a/drivers/misc/habanalabs/common/context.c
+++ b/drivers/misc/habanalabs/common/context.c
@@ -12,7 +12,7 @@
 static void hl_ctx_fini(struct hl_ctx *ctx)
 {
 	struct hl_device *hdev = ctx->hdev;
-	u64 idle_mask = 0;
+	u64 idle_mask[HL_BUSY_ENGINES_MASK_EXT_SIZE] = {0};
 	int i;
 
 	/* Release all allocated pending cb's, those cb's were never
@@ -55,10 +55,11 @@ static void hl_ctx_fini(struct hl_ctx *ctx)
 
 		if ((!hdev->pldm) && (hdev->pdev) &&
 				(!hdev->asic_funcs->is_device_idle(hdev,
-							&idle_mask, NULL)))
+					idle_mask,
+					HL_BUSY_ENGINES_MASK_EXT_SIZE, NULL)))
 			dev_notice(hdev->dev,
-				"device not idle after user context is closed (0x%llx)\n",
-				idle_mask);
+					"device not idle after user context is closed (0x%llx, 0x%llx)\n",
+						idle_mask[0], idle_mask[1]);
 	} else {
 		dev_dbg(hdev->dev, "closing kernel context\n");
 		hdev->asic_funcs->ctx_fini(ctx);
diff --git a/drivers/misc/habanalabs/common/debugfs.c b/drivers/misc/habanalabs/common/debugfs.c
index 9e3c1efe56ba..df847a6d19f4 100644
--- a/drivers/misc/habanalabs/common/debugfs.c
+++ b/drivers/misc/habanalabs/common/debugfs.c
@@ -414,7 +414,7 @@ static int engines_show(struct seq_file *s, void *data)
 		return 0;
 	}
 
-	hdev->asic_funcs->is_device_idle(hdev, NULL, s);
+	hdev->asic_funcs->is_device_idle(hdev, NULL, 0, s);
 
 	return 0;
 }
diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index fd2fffd20ba1..be7947d69dfa 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -933,8 +933,8 @@ struct hl_asic_funcs {
 	void (*set_clock_gating)(struct hl_device *hdev);
 	void (*disable_clock_gating)(struct hl_device *hdev);
 	int (*debug_coresight)(struct hl_device *hdev, void *data);
-	bool (*is_device_idle)(struct hl_device *hdev, u64 *mask,
-				struct seq_file *s);
+	bool (*is_device_idle)(struct hl_device *hdev, u64 *mask_arr,
+					u8 mask_len, struct seq_file *s);
 	int (*soft_reset_late_init)(struct hl_device *hdev);
 	void (*hw_queues_lock)(struct hl_device *hdev);
 	void (*hw_queues_unlock)(struct hl_device *hdev);
diff --git a/drivers/misc/habanalabs/common/habanalabs_ioctl.c b/drivers/misc/habanalabs/common/habanalabs_ioctl.c
index 628bdc56dca3..e86f46d4b613 100644
--- a/drivers/misc/habanalabs/common/habanalabs_ioctl.c
+++ b/drivers/misc/habanalabs/common/habanalabs_ioctl.c
@@ -145,9 +145,10 @@ static int hw_idle(struct hl_device *hdev, struct hl_info_args *args)
 		return -EINVAL;
 
 	hw_idle.is_idle = hdev->asic_funcs->is_device_idle(hdev,
-					&hw_idle.busy_engines_mask_ext, NULL);
+					hw_idle.busy_engines_mask_ext,
+					HL_BUSY_ENGINES_MASK_EXT_SIZE, NULL);
 	hw_idle.busy_engines_mask =
-			lower_32_bits(hw_idle.busy_engines_mask_ext);
+			lower_32_bits(hw_idle.busy_engines_mask_ext[0]);
 
 	return copy_to_user(out, &hw_idle,
 		min((size_t) max_size, sizeof(hw_idle))) ? -EFAULT : 0;
diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index e1c6072e5fb3..9a3d2fb477a8 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -4538,7 +4538,6 @@ static int gaudi_scrub_device_mem(struct hl_device *hdev, u64 addr, u64 size)
 {
 	struct asic_fixed_properties *prop = &hdev->asic_prop;
 	struct gaudi_device *gaudi = hdev->asic_specific;
-	u64 idle_mask = 0;
 	int rc = 0;
 	u64 val = 0;
 
@@ -4551,8 +4550,8 @@ static int gaudi_scrub_device_mem(struct hl_device *hdev, u64 addr, u64 size)
 				hdev,
 				mmDMA0_CORE_STS0/* dummy */,
 				val/* dummy */,
-				(hdev->asic_funcs->is_device_idle(hdev,
-						&idle_mask, NULL)),
+				(hdev->asic_funcs->is_device_idle(hdev, NULL,
+						0, NULL)),
 						1000,
 						HBM_SCRUBBING_TIMEOUT_US);
 		if (rc) {
@@ -6423,7 +6422,7 @@ static int gaudi_send_job_on_qman0(struct hl_device *hdev,
 	else
 		timeout = HL_DEVICE_TIMEOUT_USEC;
 
-	if (!hdev->asic_funcs->is_device_idle(hdev, NULL, NULL)) {
+	if (!hdev->asic_funcs->is_device_idle(hdev, NULL, 0, NULL)) {
 		dev_err_ratelimited(hdev->dev,
 			"Can't send driver job on QMAN0 because the device is not idle\n");
 		return -EBUSY;
@@ -7706,13 +7705,14 @@ static int gaudi_cpucp_info_get(struct hl_device *hdev)
 	return 0;
 }
 
-static bool gaudi_is_device_idle(struct hl_device *hdev, u64 *mask,
-					struct seq_file *s)
+static bool gaudi_is_device_idle(struct hl_device *hdev, u64 *mask_arr,
+					u8 mask_len, struct seq_file *s)
 {
 	struct gaudi_device *gaudi = hdev->asic_specific;
 	const char *fmt = "%-5d%-9s%#-14x%#-12x%#x\n";
 	const char *mme_slave_fmt = "%-5d%-9s%-14s%-12s%#x\n";
 	const char *nic_fmt = "%-5d%-9s%#-14x%#x\n";
+	unsigned long *mask = (unsigned long *)mask_arr;
 	u32 qm_glbl_sts0, qm_cgm_sts, dma_core_sts0, tpc_cfg_sts, mme_arch_sts;
 	bool is_idle = true, is_eng_idle, is_slave;
 	u64 offset;
@@ -7738,9 +7738,8 @@ static bool gaudi_is_device_idle(struct hl_device *hdev, u64 *mask,
 				IS_DMA_IDLE(dma_core_sts0);
 		is_idle &= is_eng_idle;
 
-		if (mask)
-			*mask |= ((u64) !is_eng_idle) <<
-					(GAUDI_ENGINE_ID_DMA_0 + dma_id);
+		if (mask && !is_eng_idle)
+			set_bit(GAUDI_ENGINE_ID_DMA_0 + dma_id, mask);
 		if (s)
 			seq_printf(s, fmt, dma_id,
 				is_eng_idle ? "Y" : "N", qm_glbl_sts0,
@@ -7761,9 +7760,8 @@ static bool gaudi_is_device_idle(struct hl_device *hdev, u64 *mask,
 				IS_TPC_IDLE(tpc_cfg_sts);
 		is_idle &= is_eng_idle;
 
-		if (mask)
-			*mask |= ((u64) !is_eng_idle) <<
-						(GAUDI_ENGINE_ID_TPC_0 + i);
+		if (mask && !is_eng_idle)
+			set_bit(GAUDI_ENGINE_ID_TPC_0 + i, mask);
 		if (s)
 			seq_printf(s, fmt, i,
 				is_eng_idle ? "Y" : "N",
@@ -7790,9 +7788,8 @@ static bool gaudi_is_device_idle(struct hl_device *hdev, u64 *mask,
 
 		is_idle &= is_eng_idle;
 
-		if (mask)
-			*mask |= ((u64) !is_eng_idle) <<
-						(GAUDI_ENGINE_ID_MME_0 + i);
+		if (mask && !is_eng_idle)
+			set_bit(GAUDI_ENGINE_ID_MME_0 + i, mask);
 		if (s) {
 			if (!is_slave)
 				seq_printf(s, fmt, i,
@@ -7818,9 +7815,8 @@ static bool gaudi_is_device_idle(struct hl_device *hdev, u64 *mask,
 			is_eng_idle = IS_QM_IDLE(qm_glbl_sts0, qm_cgm_sts);
 			is_idle &= is_eng_idle;
 
-			if (mask)
-				*mask |= ((u64) !is_eng_idle) <<
-						(GAUDI_ENGINE_ID_NIC_0 + port);
+			if (mask && !is_eng_idle)
+				set_bit(GAUDI_ENGINE_ID_NIC_0 + port, mask);
 			if (s)
 				seq_printf(s, nic_fmt, port,
 						is_eng_idle ? "Y" : "N",
@@ -7834,9 +7830,8 @@ static bool gaudi_is_device_idle(struct hl_device *hdev, u64 *mask,
 			is_eng_idle = IS_QM_IDLE(qm_glbl_sts0, qm_cgm_sts);
 			is_idle &= is_eng_idle;
 
-			if (mask)
-				*mask |= ((u64) !is_eng_idle) <<
-						(GAUDI_ENGINE_ID_NIC_0 + port);
+			if (mask && !is_eng_idle)
+				set_bit(GAUDI_ENGINE_ID_NIC_0 + port, mask);
 			if (s)
 				seq_printf(s, nic_fmt, port,
 						is_eng_idle ? "Y" : "N",
diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index 6b4c41188495..a954e7c02375 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -2916,7 +2916,7 @@ static int goya_send_job_on_qman0(struct hl_device *hdev, struct hl_cs_job *job)
 	else
 		timeout = HL_DEVICE_TIMEOUT_USEC;
 
-	if (!hdev->asic_funcs->is_device_idle(hdev, NULL, NULL)) {
+	if (!hdev->asic_funcs->is_device_idle(hdev, NULL, 0, NULL)) {
 		dev_err_ratelimited(hdev->dev,
 			"Can't send driver job on QMAN0 because the device is not idle\n");
 		return -EBUSY;
@@ -5187,11 +5187,12 @@ static void goya_disable_clock_gating(struct hl_device *hdev)
 	/* clock gating not supported in Goya */
 }
 
-static bool goya_is_device_idle(struct hl_device *hdev, u64 *mask,
-				struct seq_file *s)
+static bool goya_is_device_idle(struct hl_device *hdev, u64 *mask_arr,
+					u8 mask_len, struct seq_file *s)
 {
 	const char *fmt = "%-5d%-9s%#-14x%#-16x%#x\n";
 	const char *dma_fmt = "%-5d%-9s%#-14x%#x\n";
+	unsigned long *mask = (unsigned long *)mask_arr;
 	u32 qm_glbl_sts0, cmdq_glbl_sts0, dma_core_sts0, tpc_cfg_sts,
 		mme_arch_sts;
 	bool is_idle = true, is_eng_idle;
@@ -5211,9 +5212,8 @@ static bool goya_is_device_idle(struct hl_device *hdev, u64 *mask,
 				IS_DMA_IDLE(dma_core_sts0);
 		is_idle &= is_eng_idle;
 
-		if (mask)
-			*mask |= ((u64) !is_eng_idle) <<
-						(GOYA_ENGINE_ID_DMA_0 + i);
+		if (mask && !is_eng_idle)
+			set_bit(GOYA_ENGINE_ID_DMA_0 + i, mask);
 		if (s)
 			seq_printf(s, dma_fmt, i, is_eng_idle ? "Y" : "N",
 					qm_glbl_sts0, dma_core_sts0);
@@ -5235,9 +5235,8 @@ static bool goya_is_device_idle(struct hl_device *hdev, u64 *mask,
 				IS_TPC_IDLE(tpc_cfg_sts);
 		is_idle &= is_eng_idle;
 
-		if (mask)
-			*mask |= ((u64) !is_eng_idle) <<
-						(GOYA_ENGINE_ID_TPC_0 + i);
+		if (mask && !is_eng_idle)
+			set_bit(GOYA_ENGINE_ID_TPC_0 + i, mask);
 		if (s)
 			seq_printf(s, fmt, i, is_eng_idle ? "Y" : "N",
 				qm_glbl_sts0, cmdq_glbl_sts0, tpc_cfg_sts);
@@ -5256,8 +5255,8 @@ static bool goya_is_device_idle(struct hl_device *hdev, u64 *mask,
 			IS_MME_IDLE(mme_arch_sts);
 	is_idle &= is_eng_idle;
 
-	if (mask)
-		*mask |= ((u64) !is_eng_idle) << GOYA_ENGINE_ID_MME_0;
+	if (mask && !is_eng_idle)
+		set_bit(GOYA_ENGINE_ID_MME_0, mask);
 	if (s) {
 		seq_printf(s, fmt, 0, is_eng_idle ? "Y" : "N", qm_glbl_sts0,
 				cmdq_glbl_sts0, mme_arch_sts);
diff --git a/include/uapi/misc/habanalabs.h b/include/uapi/misc/habanalabs.h
index b1c09eba8ac2..ebde42b37b43 100644
--- a/include/uapi/misc/habanalabs.h
+++ b/include/uapi/misc/habanalabs.h
@@ -331,6 +331,8 @@ struct hl_info_dram_usage {
 	__u64 ctx_dram_mem;
 };
 
+#define HL_BUSY_ENGINES_MASK_EXT_SIZE	2
+
 struct hl_info_hw_idle {
 	__u32 is_idle;
 	/*
@@ -343,7 +345,7 @@ struct hl_info_hw_idle {
 	 * Extended Bitmask of busy engines.
 	 * Bits definition is according to `enum <chip>_enging_id'.
 	 */
-	__u64 busy_engines_mask_ext;
+	__u64 busy_engines_mask_ext[HL_BUSY_ENGINES_MASK_EXT_SIZE];
 };
 
 struct hl_info_device_status {
-- 
2.25.1

