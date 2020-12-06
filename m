Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 629B72D05EF
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Dec 2020 17:31:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727264AbgLFQ3Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Dec 2020 11:29:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:44424 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726186AbgLFQ3X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Dec 2020 11:29:23 -0500
From:   Oded Gabbay <ogabbay@kernel.org>
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     linux-kernel@vger.kernel.org
Cc:     SW_Drivers@habana.ai, Ofir Bitton <obitton@habana.ai>
Subject: [PATCH] habanalabs: Init the VM module for kernel context
Date:   Sun,  6 Dec 2020 18:28:32 +0200
Message-Id: <20201206162835.4088-3-ogabbay@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201206162835.4088-1-ogabbay@kernel.org>
References: <20201206162835.4088-1-ogabbay@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ofir Bitton <obitton@habana.ai>

In order for reserving VA ranges for kernel memory, we need
to allow the VM module to be initiated with kernel context.

Signed-off-by: Ofir Bitton <obitton@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/context.c | 16 +++++++++++++---
 drivers/misc/habanalabs/common/device.c  | 15 ++++++++++-----
 drivers/misc/habanalabs/common/memory.c  |  3 ++-
 drivers/misc/habanalabs/gaudi/gaudi.c    | 10 ++++------
 4 files changed, 29 insertions(+), 15 deletions(-)

diff --git a/drivers/misc/habanalabs/common/context.c b/drivers/misc/habanalabs/common/context.c
index f65e6559149b..3d86b83f4ca6 100644
--- a/drivers/misc/habanalabs/common/context.c
+++ b/drivers/misc/habanalabs/common/context.c
@@ -56,6 +56,8 @@ static void hl_ctx_fini(struct hl_ctx *ctx)
 				idle_mask);
 	} else {
 		dev_dbg(hdev->dev, "closing kernel context\n");
+		hdev->asic_funcs->ctx_fini(ctx);
+		hl_vm_ctx_fini(ctx);
 		hl_mmu_ctx_fini(ctx);
 	}
 }
@@ -151,11 +153,18 @@ int hl_ctx_init(struct hl_device *hdev, struct hl_ctx *ctx, bool is_kernel_ctx)
 
 	if (is_kernel_ctx) {
 		ctx->asid = HL_KERNEL_ASID_ID; /* Kernel driver gets ASID 0 */
-		rc = hl_mmu_ctx_init(ctx);
+		rc = hl_vm_ctx_init(ctx);
 		if (rc) {
-			dev_err(hdev->dev, "Failed to init mmu ctx module\n");
+			dev_err(hdev->dev, "Failed to init mem ctx module\n");
+			rc = -ENOMEM;
 			goto err_free_cs_pending;
 		}
+
+		rc = hdev->asic_funcs->ctx_init(ctx);
+		if (rc) {
+			dev_err(hdev->dev, "ctx_init failed\n");
+			goto err_vm_ctx_fini;
+		}
 	} else {
 		ctx->asid = hl_asid_alloc(hdev);
 		if (!ctx->asid) {
@@ -194,7 +203,8 @@ int hl_ctx_init(struct hl_device *hdev, struct hl_ctx *ctx, bool is_kernel_ctx)
 err_vm_ctx_fini:
 	hl_vm_ctx_fini(ctx);
 err_asid_free:
-	hl_asid_free(hdev, ctx->asid);
+	if (ctx->asid != HL_KERNEL_ASID_ID)
+		hl_asid_free(hdev, ctx->asid);
 err_free_cs_pending:
 	kfree(ctx->cs_pending);
 
diff --git a/drivers/misc/habanalabs/common/device.c b/drivers/misc/habanalabs/common/device.c
index 59212706a836..671d1eb41146 100644
--- a/drivers/misc/habanalabs/common/device.c
+++ b/drivers/misc/habanalabs/common/device.c
@@ -1310,11 +1310,16 @@ int hl_device_init(struct hl_device *hdev, struct class *hclass)
 
 	hdev->compute_ctx = NULL;
 
+	hl_debugfs_add_device(hdev);
+
+	/* debugfs nodes are created in hl_ctx_init so it must be called after
+	 * hl_debugfs_add_device.
+	 */
 	rc = hl_ctx_init(hdev, hdev->kernel_ctx, true);
 	if (rc) {
 		dev_err(hdev->dev, "failed to initialize kernel context\n");
 		kfree(hdev->kernel_ctx);
-		goto mmu_fini;
+		goto remove_device_from_debugfs;
 	}
 
 	rc = hl_cb_pool_init(hdev);
@@ -1323,8 +1328,6 @@ int hl_device_init(struct hl_device *hdev, struct class *hclass)
 		goto release_ctx;
 	}
 
-	hl_debugfs_add_device(hdev);
-
 	/*
 	 * From this point, in case of an error, add char devices and create
 	 * sysfs nodes as part of the error flow, to allow debugging.
@@ -1413,6 +1416,8 @@ int hl_device_init(struct hl_device *hdev, struct class *hclass)
 	if (hl_ctx_put(hdev->kernel_ctx) != 1)
 		dev_err(hdev->dev,
 			"kernel ctx is still alive on initialization failure\n");
+remove_device_from_debugfs:
+	hl_debugfs_remove_device(hdev);
 mmu_fini:
 	hl_mmu_fini(hdev);
 eq_fini:
@@ -1502,8 +1507,6 @@ void hl_device_fini(struct hl_device *hdev)
 
 	device_late_fini(hdev);
 
-	hl_debugfs_remove_device(hdev);
-
 	/*
 	 * Halt the engines and disable interrupts so we won't get any more
 	 * completions from H/W and we won't have any accesses from the
@@ -1535,6 +1538,8 @@ void hl_device_fini(struct hl_device *hdev)
 	if ((hdev->kernel_ctx) && (hl_ctx_put(hdev->kernel_ctx) != 1))
 		dev_err(hdev->dev, "kernel ctx is still alive\n");
 
+	hl_debugfs_remove_device(hdev);
+
 	hl_vm_fini(hdev);
 
 	hl_mmu_fini(hdev);
diff --git a/drivers/misc/habanalabs/common/memory.c b/drivers/misc/habanalabs/common/memory.c
index d4a94a1c3eef..c16c829bfbf2 100644
--- a/drivers/misc/habanalabs/common/memory.c
+++ b/drivers/misc/habanalabs/common/memory.c
@@ -1923,7 +1923,8 @@ void hl_vm_ctx_fini(struct hl_ctx *ctx)
 	 * because the user notifies us on allocations. If the user is no more,
 	 * all DRAM is available
 	 */
-	if (!ctx->hdev->asic_prop.dram_supports_virtual_memory)
+	if (ctx->asid != HL_KERNEL_ASID_ID &&
+			!ctx->hdev->asic_prop.dram_supports_virtual_memory)
 		atomic64_set(&ctx->hdev->dram_used_mem, 0);
 }
 
diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index 4776dfed9098..658d180d3d4d 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -7849,18 +7849,16 @@ static void gaudi_internal_cb_pool_fini(struct hl_device *hdev,
 
 static int gaudi_ctx_init(struct hl_ctx *ctx)
 {
+	if (ctx->asid == HL_KERNEL_ASID_ID)
+		return 0;
+
 	gaudi_mmu_prepare(ctx->hdev, ctx->asid);
 	return gaudi_internal_cb_pool_init(ctx->hdev, ctx);
 }
 
 static void gaudi_ctx_fini(struct hl_ctx *ctx)
 {
-	struct hl_device *hdev = ctx->hdev;
-
-	/* Gaudi will NEVER support more then a single compute context.
-	 * Therefore, don't clear anything unless it is the compute context
-	 */
-	if (hdev->compute_ctx != ctx)
+	if (ctx->asid == HL_KERNEL_ASID_ID)
 		return;
 
 	gaudi_internal_cb_pool_fini(ctx->hdev, ctx);
-- 
2.17.1

