Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DDB82AAC4C
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Nov 2020 17:52:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728720AbgKHQvj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Nov 2020 11:51:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:33664 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728631AbgKHQvh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Nov 2020 11:51:37 -0500
Received: from ogabbay-VM.habana-labs.com (unknown [213.57.90.10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6363D206F4;
        Sun,  8 Nov 2020 16:51:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604854296;
        bh=A89gBpSxuOJx9KLYOPvOWEQIvg8ik95vstY7qjaNDa0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dDhU/+zxfl15rf0nuOSjV6ZyRrvmDYfYg7n40euGL/ZpR7urOZ18BdUSrvUFWNuza
         kFECTxu2udzpBWclcHqTd66Wp6TApLQG10Sb/+OjwtdJP5LQvb97k1nd8UO6r2TR0T
         UIq+Xn13NHqiCRJcEaGwuNlNRquVL6mNwr79ahJI=
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     SW_Drivers@habana.ai, Ofir Bitton <obitton@habana.ai>
Subject: [PATCH] habanalabs: refactor mmu va_range db structure
Date:   Sun,  8 Nov 2020 18:51:28 +0200
Message-Id: <20201108165129.13100-2-ogabbay@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201108165129.13100-1-ogabbay@kernel.org>
References: <20201108165129.13100-1-ogabbay@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ofir Bitton <obitton@habana.ai>

Use an array of va_ranges instead of keeping each va_range separately,
we do this for better readability and in order to support access to
a specific range in a much elegant manner.

Signed-off-by: Ofir Bitton <obitton@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/habanalabs.h |  24 ++--
 drivers/misc/habanalabs/common/memory.c     | 130 ++++++++++----------
 2 files changed, 82 insertions(+), 72 deletions(-)

diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index 42988f12fb00..40b566c4b791 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -953,18 +953,33 @@ struct hl_asic_funcs {
 
 #define HL_KERNEL_ASID_ID	0
 
+/**
+ * enum hl_va_range_type - virtual address range type.
+ * @HL_VA_RANGE_TYPE_HOST: range type of host pages
+ * @HL_VA_RANGE_TYPE_HOST_HUGE: range type of host huge pages
+ * @HL_VA_RANGE_TYPE_DRAM: range type of dram pages
+ */
+enum hl_va_range_type {
+	HL_VA_RANGE_TYPE_HOST,
+	HL_VA_RANGE_TYPE_HOST_HUGE,
+	HL_VA_RANGE_TYPE_DRAM,
+	HL_VA_RANGE_TYPE_MAX
+};
+
 /**
  * struct hl_va_range - virtual addresses range.
  * @lock: protects the virtual addresses list.
  * @list: list of virtual addresses blocks available for mappings.
  * @start_addr: range start address.
  * @end_addr: range end address.
+ * @page_size: page size of this va range.
  */
 struct hl_va_range {
 	struct mutex		lock;
 	struct list_head	list;
 	u64			start_addr;
 	u64			end_addr;
+	u32			page_size;
 };
 
 /**
@@ -993,10 +1008,7 @@ struct hl_cs_counters_atomic {
  * @refcount: reference counter for the context. Context is released only when
  *		this hits 0l. It is incremented on CS and CS_WAIT.
  * @cs_pending: array of hl fence objects representing pending CS.
- * @host_va_range: holds available virtual addresses for host mappings.
- * @host_huge_va_range: holds available virtual addresses for host mappings
- *                      with huge pages.
- * @dram_va_range: holds available virtual addresses for DRAM mappings.
+ * @va_range: holds available virtual addresses for host and dram mappings.
  * @mem_hash_lock: protects the mem_hash.
  * @mmu_lock: protects the MMU page tables. Any change to the PGT, modifying the
  *            MMU hash or walking the PGT requires talking this lock.
@@ -1028,9 +1040,7 @@ struct hl_ctx {
 	struct hl_device		*hdev;
 	struct kref			refcount;
 	struct hl_fence			**cs_pending;
-	struct hl_va_range		*host_va_range;
-	struct hl_va_range		*host_huge_va_range;
-	struct hl_va_range		*dram_va_range;
+	struct hl_va_range		*va_range[HL_VA_RANGE_TYPE_MAX];
 	struct mutex			mem_hash_lock;
 	struct mutex			mmu_lock;
 	struct list_head		debugfs_list;
diff --git a/drivers/misc/habanalabs/common/memory.c b/drivers/misc/habanalabs/common/memory.c
index e00ad11dc5f7..02233899336f 100644
--- a/drivers/misc/habanalabs/common/memory.c
+++ b/drivers/misc/habanalabs/common/memory.c
@@ -908,7 +908,7 @@ static int map_device_va(struct hl_ctx *ctx, struct hl_mem_in *args,
 
 		/* get required alignment */
 		if (phys_pg_pack->page_size == page_size) {
-			va_range = ctx->host_va_range;
+			va_range = ctx->va_range[HL_VA_RANGE_TYPE_HOST];
 
 			/*
 			 * huge page alignment may be needed in case of regular
@@ -923,7 +923,7 @@ static int map_device_va(struct hl_ctx *ctx, struct hl_mem_in *args,
 			 * huge page alignment is needed in case of huge page
 			 * mapping
 			 */
-			va_range = ctx->host_huge_va_range;
+			va_range = ctx->va_range[HL_VA_RANGE_TYPE_HOST_HUGE];
 			va_block_align = huge_page_size;
 		}
 	} else {
@@ -948,7 +948,7 @@ static int map_device_va(struct hl_ctx *ctx, struct hl_mem_in *args,
 		hint_addr = args->map_device.hint_addr;
 
 		/* DRAM VA alignment is the same as the DRAM page size */
-		va_range = ctx->dram_va_range;
+		va_range = ctx->va_range[HL_VA_RANGE_TYPE_DRAM];
 		va_block_align = hdev->asic_prop.dmmu.page_size;
 	}
 
@@ -1093,12 +1093,12 @@ static int unmap_device_va(struct hl_ctx *ctx, u64 vaddr, bool ctx_free)
 
 		if (phys_pg_pack->page_size ==
 					hdev->asic_prop.pmmu.page_size)
-			va_range = ctx->host_va_range;
+			va_range = ctx->va_range[HL_VA_RANGE_TYPE_HOST];
 		else
-			va_range = ctx->host_huge_va_range;
+			va_range = ctx->va_range[HL_VA_RANGE_TYPE_HOST_HUGE];
 	} else if (*vm_type == VM_TYPE_PHYS_PACK) {
 		is_userptr = false;
-		va_range = ctx->dram_va_range;
+		va_range = ctx->va_range[HL_VA_RANGE_TYPE_DRAM];
 		phys_pg_pack = hnode->ptr;
 	} else {
 		dev_warn(hdev->dev,
@@ -1556,7 +1556,7 @@ bool hl_userptr_is_pinned(struct hl_device *hdev, u64 addr,
  *   addresses.
  */
 static int va_range_init(struct hl_device *hdev, struct hl_va_range *va_range,
-				u64 start, u64 end)
+				u64 start, u64 end, u32 page_size)
 {
 	int rc;
 
@@ -1586,6 +1586,7 @@ static int va_range_init(struct hl_device *hdev, struct hl_va_range *va_range,
 
 	va_range->start_addr = start;
 	va_range->end_addr = end;
+	va_range->page_size = page_size;
 
 	return 0;
 }
@@ -1598,8 +1599,7 @@ static int va_range_init(struct hl_device *hdev, struct hl_va_range *va_range,
  * This function does the following:
  * - Frees the virtual addresses block list and its lock
  */
-static void va_range_fini(struct hl_device *hdev,
-		struct hl_va_range *va_range)
+static void va_range_fini(struct hl_device *hdev, struct hl_va_range *va_range)
 {
 	mutex_lock(&va_range->lock);
 	clear_va_list_locked(hdev, &va_range->list);
@@ -1629,101 +1629,96 @@ static void va_range_fini(struct hl_device *hdev,
 static int vm_ctx_init_with_ranges(struct hl_ctx *ctx,
 					u64 host_range_start,
 					u64 host_range_end,
+					u32 host_page_size,
 					u64 host_huge_range_start,
 					u64 host_huge_range_end,
+					u32 host_huge_page_size,
 					u64 dram_range_start,
-					u64 dram_range_end)
+					u64 dram_range_end,
+					u32 dram_page_size)
 {
 	struct hl_device *hdev = ctx->hdev;
-	int rc;
-
-	ctx->host_va_range = kzalloc(sizeof(*ctx->host_va_range), GFP_KERNEL);
-	if (!ctx->host_va_range)
-		return -ENOMEM;
-
-	ctx->host_huge_va_range = kzalloc(sizeof(*ctx->host_huge_va_range),
-						GFP_KERNEL);
-	if (!ctx->host_huge_va_range) {
-		rc =  -ENOMEM;
-		goto host_huge_va_range_err;
-	}
-
-	ctx->dram_va_range = kzalloc(sizeof(*ctx->dram_va_range), GFP_KERNEL);
-	if (!ctx->dram_va_range) {
-		rc = -ENOMEM;
-		goto dram_va_range_err;
+	int i, rc;
+
+	for (i = 0 ; i < HL_VA_RANGE_TYPE_MAX ; i++) {
+		ctx->va_range[i] =
+			kzalloc(sizeof(struct hl_va_range), GFP_KERNEL);
+		if (!ctx->va_range[i]) {
+			rc = -ENOMEM;
+			goto free_va_range;
+		}
 	}
 
 	rc = hl_mmu_ctx_init(ctx);
 	if (rc) {
 		dev_err(hdev->dev, "failed to init context %d\n", ctx->asid);
-		goto mmu_ctx_err;
+		goto free_va_range;
 	}
 
 	mutex_init(&ctx->mem_hash_lock);
 	hash_init(ctx->mem_hash);
 
-	mutex_init(&ctx->host_va_range->lock);
+	mutex_init(&ctx->va_range[HL_VA_RANGE_TYPE_HOST]->lock);
 
-	rc = va_range_init(hdev, ctx->host_va_range, host_range_start,
-				host_range_end);
+	rc = va_range_init(hdev, ctx->va_range[HL_VA_RANGE_TYPE_HOST],
+			host_range_start, host_range_end, host_page_size);
 	if (rc) {
 		dev_err(hdev->dev, "failed to init host vm range\n");
-		goto host_page_range_err;
+		goto mmu_ctx_fini;
 	}
 
 	if (hdev->pmmu_huge_range) {
-		mutex_init(&ctx->host_huge_va_range->lock);
+		mutex_init(&ctx->va_range[HL_VA_RANGE_TYPE_HOST_HUGE]->lock);
 
-		rc = va_range_init(hdev, ctx->host_huge_va_range,
-					host_huge_range_start,
-					host_huge_range_end);
+		rc = va_range_init(hdev,
+			ctx->va_range[HL_VA_RANGE_TYPE_HOST_HUGE],
+			host_huge_range_start, host_huge_range_end,
+			host_huge_page_size);
 		if (rc) {
 			dev_err(hdev->dev,
 				"failed to init host huge vm range\n");
-			goto host_hpage_range_err;
+			goto clear_host_va_range;
 		}
 	} else {
-		ctx->host_huge_va_range = ctx->host_va_range;
+		ctx->va_range[HL_VA_RANGE_TYPE_HOST_HUGE] =
+				ctx->va_range[HL_VA_RANGE_TYPE_HOST];
 	}
 
-	mutex_init(&ctx->dram_va_range->lock);
+	mutex_init(&ctx->va_range[HL_VA_RANGE_TYPE_DRAM]->lock);
 
-	rc = va_range_init(hdev, ctx->dram_va_range, dram_range_start,
-			dram_range_end);
+	rc = va_range_init(hdev, ctx->va_range[HL_VA_RANGE_TYPE_DRAM],
+			dram_range_start, dram_range_end, dram_page_size);
 	if (rc) {
 		dev_err(hdev->dev, "failed to init dram vm range\n");
-		goto dram_vm_err;
+		goto clear_host_huge_va_range;
 	}
 
 	hl_debugfs_add_ctx_mem_hash(hdev, ctx);
 
 	return 0;
 
-dram_vm_err:
-	mutex_destroy(&ctx->dram_va_range->lock);
+clear_host_huge_va_range:
+	mutex_destroy(&ctx->va_range[HL_VA_RANGE_TYPE_DRAM]->lock);
 
 	if (hdev->pmmu_huge_range) {
-		mutex_lock(&ctx->host_huge_va_range->lock);
-		clear_va_list_locked(hdev, &ctx->host_huge_va_range->list);
-		mutex_unlock(&ctx->host_huge_va_range->lock);
+		mutex_lock(&ctx->va_range[HL_VA_RANGE_TYPE_HOST_HUGE]->lock);
+		clear_va_list_locked(hdev,
+			&ctx->va_range[HL_VA_RANGE_TYPE_HOST_HUGE]->list);
+		mutex_unlock(&ctx->va_range[HL_VA_RANGE_TYPE_HOST_HUGE]->lock);
 	}
-host_hpage_range_err:
+clear_host_va_range:
 	if (hdev->pmmu_huge_range)
-		mutex_destroy(&ctx->host_huge_va_range->lock);
-	mutex_lock(&ctx->host_va_range->lock);
-	clear_va_list_locked(hdev, &ctx->host_va_range->list);
-	mutex_unlock(&ctx->host_va_range->lock);
-host_page_range_err:
-	mutex_destroy(&ctx->host_va_range->lock);
+		mutex_destroy(&ctx->va_range[HL_VA_RANGE_TYPE_HOST_HUGE]->lock);
+	mutex_lock(&ctx->va_range[HL_VA_RANGE_TYPE_HOST]->lock);
+	clear_va_list_locked(hdev, &ctx->va_range[HL_VA_RANGE_TYPE_HOST]->list);
+	mutex_unlock(&ctx->va_range[HL_VA_RANGE_TYPE_HOST]->lock);
+mmu_ctx_fini:
+	mutex_destroy(&ctx->va_range[HL_VA_RANGE_TYPE_HOST]->lock);
 	mutex_destroy(&ctx->mem_hash_lock);
 	hl_mmu_ctx_fini(ctx);
-mmu_ctx_err:
-	kfree(ctx->dram_va_range);
-dram_va_range_err:
-	kfree(ctx->host_huge_va_range);
-host_huge_va_range_err:
-	kfree(ctx->host_va_range);
+free_va_range:
+	for (i = 0 ; i < HL_VA_RANGE_TYPE_MAX ; i++)
+		kfree(ctx->va_range[i]);
 
 	return rc;
 }
@@ -1733,6 +1728,7 @@ int hl_vm_ctx_init(struct hl_ctx *ctx)
 	struct asic_fixed_properties *prop = &ctx->hdev->asic_prop;
 	u64 host_range_start, host_range_end, host_huge_range_start,
 		host_huge_range_end, dram_range_start, dram_range_end;
+	u32 host_page_size, host_huge_page_size, dram_page_size;
 
 	atomic64_set(&ctx->dram_phys_mem, 0);
 
@@ -1748,14 +1744,18 @@ int hl_vm_ctx_init(struct hl_ctx *ctx)
 
 	dram_range_start = prop->dmmu.start_addr;
 	dram_range_end = prop->dmmu.end_addr;
+	dram_page_size = prop->dmmu.page_size;
 	host_range_start = prop->pmmu.start_addr;
 	host_range_end = prop->pmmu.end_addr;
+	host_page_size = prop->pmmu.page_size;
 	host_huge_range_start = prop->pmmu_huge.start_addr;
 	host_huge_range_end = prop->pmmu_huge.end_addr;
+	host_huge_page_size = prop->pmmu_huge.page_size;
 
 	return vm_ctx_init_with_ranges(ctx, host_range_start, host_range_end,
-				host_huge_range_start, host_huge_range_end,
-				dram_range_start, dram_range_end);
+			host_page_size, host_huge_range_start,
+			host_huge_range_end, host_huge_page_size,
+			dram_range_start, dram_range_end, dram_page_size);
 }
 
 /*
@@ -1824,10 +1824,10 @@ void hl_vm_ctx_fini(struct hl_ctx *ctx)
 		}
 	spin_unlock(&vm->idr_lock);
 
-	va_range_fini(hdev, ctx->dram_va_range);
+	va_range_fini(hdev, ctx->va_range[HL_VA_RANGE_TYPE_DRAM]);
 	if (hdev->pmmu_huge_range)
-		va_range_fini(hdev, ctx->host_huge_va_range);
-	va_range_fini(hdev, ctx->host_va_range);
+		va_range_fini(hdev, ctx->va_range[HL_VA_RANGE_TYPE_HOST_HUGE]);
+	va_range_fini(hdev, ctx->va_range[HL_VA_RANGE_TYPE_HOST]);
 
 	mutex_destroy(&ctx->mem_hash_lock);
 	hl_mmu_ctx_fini(ctx);
-- 
2.17.1

