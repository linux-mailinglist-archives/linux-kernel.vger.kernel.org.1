Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 257C92AC1DF
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 18:10:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731295AbgKIRKL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 12:10:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:32906 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731249AbgKIRKL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 12:10:11 -0500
Received: from ogabbay-VM.habana-labs.com (unknown [213.57.90.10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D744F216C4;
        Mon,  9 Nov 2020 17:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604941810;
        bh=H96RfrC6SLwn8vG8jNliVQ3WJm3uql46dZEkfAyI2qQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IZ/XEe2tUFP0isWyrWU8OeCBZpeodS4t4Ap26+BNcLgTJNFZg8EVFhT2ZqY9JC8Px
         TZDBT+toM/yy0BXWWW6VvqtazkAi08RlzMJNI7Rkv3aPUfQsBXiHvfPpPQ7orb9P5R
         2d+HPxnx03laQd3we8d9JsxHTBb1l2wRVuQp1wgo=
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     SW_Drivers@habana.ai, Ofir Bitton <obitton@habana.ai>
Subject: [PATCH] habanalabs: use host va range for internal pools
Date:   Mon,  9 Nov 2020 19:08:53 +0200
Message-Id: <20201109170853.23683-2-ogabbay@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201109170853.23683-1-ogabbay@kernel.org>
References: <20201109170853.23683-1-ogabbay@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ofir Bitton <obitton@habana.ai>

Instead of using a dedicated va range for each internal pool,
we introduce a new way for reserving a va block from an existing
va range. This is a more generic way of reserving va blocks for
future use.

Signed-off-by: Ofir Bitton <obitton@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/habanalabs.h |  4 ++
 drivers/misc/habanalabs/common/memory.c     | 79 +++++++++++++++++++++
 drivers/misc/habanalabs/gaudi/gaudi.c       | 18 +++--
 drivers/misc/habanalabs/gaudi/gaudiP.h      |  5 +-
 4 files changed, 98 insertions(+), 8 deletions(-)

diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index 87060cd2c525..822f90087e04 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -2109,6 +2109,10 @@ void hl_vm_ctx_fini(struct hl_ctx *ctx);
 int hl_vm_init(struct hl_device *hdev);
 void hl_vm_fini(struct hl_device *hdev);
 
+u64 hl_reserve_va_block(struct hl_device *hdev, struct hl_ctx *ctx,
+		enum hl_va_range_type type, u32 size);
+int hl_unreserve_va_block(struct hl_device *hdev, struct hl_ctx *ctx,
+		u64 start_addr, u64 size);
 int hl_pin_host_memory(struct hl_device *hdev, u64 addr, u64 size,
 			struct hl_userptr *userptr);
 void hl_unpin_host_memory(struct hl_device *hdev, struct hl_userptr *userptr);
diff --git a/drivers/misc/habanalabs/common/memory.c b/drivers/misc/habanalabs/common/memory.c
index 02233899336f..01e93e83d3af 100644
--- a/drivers/misc/habanalabs/common/memory.c
+++ b/drivers/misc/habanalabs/common/memory.c
@@ -620,6 +620,85 @@ static u64 get_va_block(struct hl_device *hdev, struct hl_va_range *va_range,
 	return res_valid_start;
 }
 
+/*
+ * hl_reserve_va_block() - reserve a virtual block of a given size.
+ * @hdev: pointer to the habanalabs device structure.
+ * @ctx: current context
+ * @type: virtual addresses range type.
+ * @size: requested block size.
+ *
+ * This function does the following:
+ * - Iterate on the virtual block list to find a suitable virtual block for the
+ *   given size.
+ * - Reserve the requested block and update the list.
+ * - Return the start address of the virtual block.
+ */
+u64 hl_reserve_va_block(struct hl_device *hdev, struct hl_ctx *ctx,
+		enum hl_va_range_type type, u32 size)
+{
+	return get_va_block(hdev, ctx->va_range[type], size, 0,
+			ctx->va_range[type]->page_size);
+}
+
+/**
+ * hl_get_va_range_type() - get va_range type for the given address and size.
+ * @address: The start address of the area we want to validate.
+ * @size: The size in bytes of the area we want to validate.
+ * @type: returned va_range type
+ *
+ * Return: true if the area is inside a valid range, false otherwise.
+ */
+static int hl_get_va_range_type(struct hl_ctx *ctx, u64 address, u64 size,
+			enum hl_va_range_type *type)
+{
+	int i;
+
+	for (i = 0 ; i < HL_VA_RANGE_TYPE_MAX; i++) {
+		if (hl_mem_area_inside_range(address, size,
+				ctx->va_range[i]->start_addr,
+				ctx->va_range[i]->end_addr)) {
+			*type = i;
+			return 0;
+		}
+	}
+
+	return -EINVAL;
+}
+
+/*
+ * hl_unreserve_va_block - wrapper for add_va_block for unreserving a va block
+ *
+ * @hdev: pointer to the habanalabs device structure
+ * @ctx: current context
+ * @start: start virtual address
+ * @end: end virtual address
+ *
+ * This function does the following:
+ * - Takes the list lock and calls add_va_block_locked
+ */
+int hl_unreserve_va_block(struct hl_device *hdev, struct hl_ctx *ctx,
+		u64 start_addr, u64 size)
+{
+	enum hl_va_range_type type;
+	int rc;
+
+	rc = hl_get_va_range_type(ctx, start_addr, size, &type);
+	if (rc) {
+		dev_err(hdev->dev,
+			"cannot find va_range for va %#llx size %llu",
+			start_addr, size);
+		return rc;
+	}
+
+	rc = add_va_block(hdev, ctx->va_range[type], start_addr,
+						start_addr + size - 1);
+	if (rc)
+		dev_warn(hdev->dev,
+			"add va block failed for vaddr: 0x%llx\n", start_addr);
+
+	return rc;
+}
+
 /*
  * get_sg_info - get number of pages and the DMA address from SG list
  *
diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index 086d8363f3ae..1135b2cc5860 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -7768,7 +7768,11 @@ static int gaudi_internal_cb_pool_init(struct hl_device *hdev,
 		goto destroy_internal_cb_pool;
 	}
 
-	hdev->internal_cb_va_base = VA_HOST_SPACE_INTERNAL_CB_START;
+	hdev->internal_cb_va_base = hl_reserve_va_block(hdev, ctx,
+			HL_VA_RANGE_TYPE_HOST, HOST_SPACE_INTERNAL_CB_SZ);
+
+	if (!hdev->internal_cb_va_base)
+		goto destroy_internal_cb_pool;
 
 	mutex_lock(&ctx->mmu_lock);
 
@@ -7776,7 +7780,7 @@ static int gaudi_internal_cb_pool_init(struct hl_device *hdev,
 	 * is aligned to HOST_SPACE_INTERNAL_CB_SZ
 	 */
 	for (off = 0 ; off < HOST_SPACE_INTERNAL_CB_SZ ; off += PAGE_SIZE_4KB) {
-		va = VA_HOST_SPACE_INTERNAL_CB_START + off;
+		va = hdev->internal_cb_va_base + off;
 		pa = hdev->internal_cb_pool_dma_addr + off;
 		flush_pte = (off + PAGE_SIZE_4KB) >= HOST_SPACE_INTERNAL_CB_SZ;
 		rc = hl_mmu_map(ctx, va, pa, PAGE_SIZE_4KB, flush_pte);
@@ -7796,13 +7800,16 @@ static int gaudi_internal_cb_pool_init(struct hl_device *hdev,
 
 unmap:
 	for (; off >= 0 ; off -= PAGE_SIZE_4KB) {
-		va = VA_HOST_SPACE_INTERNAL_CB_START + off;
+		va = hdev->internal_cb_va_base + off;
 		flush_pte = (off - (s32) PAGE_SIZE_4KB) < 0;
 		if (hl_mmu_unmap(ctx, va, PAGE_SIZE_4KB, flush_pte))
 			dev_warn_ratelimited(hdev->dev,
 					"failed to unmap va 0x%llx\n", va);
 	}
 
+	hl_unreserve_va_block(hdev, ctx, hdev->internal_cb_va_base,
+			HOST_SPACE_INTERNAL_CB_SZ);
+
 	hdev->asic_funcs->mmu_invalidate_cache(hdev, true, VM_TYPE_USERPTR);
 
 	mutex_unlock(&ctx->mmu_lock);
@@ -7832,7 +7839,7 @@ static void gaudi_internal_cb_pool_fini(struct hl_device *hdev,
 	mutex_lock(&ctx->mmu_lock);
 
 	for (off = 0 ; off < HOST_SPACE_INTERNAL_CB_SZ ; off += PAGE_SIZE_4KB) {
-		va = VA_HOST_SPACE_INTERNAL_CB_START + off;
+		va = hdev->internal_cb_va_base + off;
 
 		if (off + PAGE_SIZE_4KB >= HOST_SPACE_INTERNAL_CB_SZ)
 			flush_pte = true;
@@ -7842,6 +7849,9 @@ static void gaudi_internal_cb_pool_fini(struct hl_device *hdev,
 					"failed to unmap va 0x%llx\n", va);
 	}
 
+	hl_unreserve_va_block(hdev, ctx, hdev->internal_cb_va_base,
+			HOST_SPACE_INTERNAL_CB_SZ);
+
 	hdev->asic_funcs->mmu_invalidate_cache(hdev, true, VM_TYPE_USERPTR);
 
 	mutex_unlock(&ctx->mmu_lock);
diff --git a/drivers/misc/habanalabs/gaudi/gaudiP.h b/drivers/misc/habanalabs/gaudi/gaudiP.h
index e882cf7f8cf7..1a5e681c720d 100644
--- a/drivers/misc/habanalabs/gaudi/gaudiP.h
+++ b/drivers/misc/habanalabs/gaudi/gaudiP.h
@@ -153,12 +153,9 @@
 
 /* Virtual address space */
 #define VA_HOST_SPACE_START	0x1000000000000ull	/* 256TB */
-#define VA_HOST_SPACE_END	0x3FF7FFFE00000ull	/* 1PB - 1TB */
+#define VA_HOST_SPACE_END	0x3FF8000000000ull	/* 1PB - 512GB */
 #define VA_HOST_SPACE_SIZE	(VA_HOST_SPACE_END - \
 					VA_HOST_SPACE_START) /* 767TB */
-
-#define VA_HOST_SPACE_INTERNAL_CB_START	0x3FF7FFFE00000ull /* 1PB - 1TB - 2MB */
-#define VA_HOST_SPACE_INTERNAL_CB_END	0x3FF8000000000ull /* 1PB - 1TB */
 #define HOST_SPACE_INTERNAL_CB_SZ	SZ_2M
 
 #define HW_CAP_PLL		BIT(0)
-- 
2.17.1

