Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E5A42B7EAA
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 14:54:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726658AbgKRNvG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 08:51:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:38318 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726110AbgKRNvB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 08:51:01 -0500
Received: from ogabbay-VM.habana-labs.com (unknown [213.57.90.10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4ABA4206E0;
        Wed, 18 Nov 2020 13:50:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605707458;
        bh=gKPDAW/o1gFCqkn9Nzc2K8p17MqjHWkx/zP5/PCp4dM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TORB6amHUFXUy2aj7KBGOMRTmgqTEVg9Sv2BqTU7lUeHNWMZ61KeK5S4ahcMMKb1+
         1+GKWLSUMqlg2LyIhcUQ31bVSZHx+qvLPg0kKpk/Fka5Cx5MT9EjomQXNXw8IY3f/E
         LJXfVDZ//crtvxPuyVZFdu+KyTxe/eQHyzVjM9xM=
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     SW_Drivers@habana.ai, Ofir Bitton <obitton@habana.ai>
Subject: [PATCH] habanalabs: mmu map wrapper for sizes larger than a page
Date:   Wed, 18 Nov 2020 15:50:49 +0200
Message-Id: <20201118135050.19621-2-ogabbay@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201118135050.19621-1-ogabbay@kernel.org>
References: <20201118135050.19621-1-ogabbay@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ofir Bitton <obitton@habana.ai>

We introduce a new wrapper which allows us to mmu map any size
to any host va_range available. In addition we remove duplicated
code from various places in driver and using this new wrapper
instead.
This wrapper supports mapping only contiguous physical
memory blocks and will be used for mappings that are done to the
driver ASID.

Signed-off-by: Ofir Bitton <obitton@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 .../misc/habanalabs/common/command_buffer.c   |  10 +-
 drivers/misc/habanalabs/common/habanalabs.h   |   7 +-
 drivers/misc/habanalabs/common/memory.c       |   6 +-
 drivers/misc/habanalabs/common/mmu.c          | 112 +++++++++++++++++-
 drivers/misc/habanalabs/gaudi/gaudi.c         |  60 ++--------
 drivers/misc/habanalabs/goya/goya.c           |  26 ++--
 6 files changed, 144 insertions(+), 77 deletions(-)

diff --git a/drivers/misc/habanalabs/common/command_buffer.c b/drivers/misc/habanalabs/common/command_buffer.c
index 0c482358f350..2856bb3423ee 100644
--- a/drivers/misc/habanalabs/common/command_buffer.c
+++ b/drivers/misc/habanalabs/common/command_buffer.c
@@ -67,9 +67,9 @@ static int cb_map_mem(struct hl_ctx *ctx, struct hl_cb *cb)
 	bus_addr = cb->bus_address;
 	offset = 0;
 	list_for_each_entry(va_block, &cb->va_block_list, node) {
-		rc = hl_mmu_map(ctx, va_block->start, bus_addr, va_block->size,
-				list_is_last(&va_block->node,
-						&cb->va_block_list));
+		rc = hl_mmu_map_page(ctx, va_block->start, bus_addr,
+				va_block->size, list_is_last(&va_block->node,
+							&cb->va_block_list));
 		if (rc) {
 			dev_err(hdev->dev, "Failed to map VA %#llx to CB\n",
 				va_block->start);
@@ -92,7 +92,7 @@ static int cb_map_mem(struct hl_ctx *ctx, struct hl_cb *cb)
 	list_for_each_entry(va_block, &cb->va_block_list, node) {
 		if (offset <= 0)
 			break;
-		hl_mmu_unmap(ctx, va_block->start, va_block->size,
+		hl_mmu_unmap_page(ctx, va_block->start, va_block->size,
 				offset <= va_block->size);
 		offset -= va_block->size;
 	}
@@ -119,7 +119,7 @@ static void cb_unmap_mem(struct hl_ctx *ctx, struct hl_cb *cb)
 	mutex_lock(&ctx->mmu_lock);
 
 	list_for_each_entry(va_block, &cb->va_block_list, node)
-		if (hl_mmu_unmap(ctx, va_block->start, va_block->size,
+		if (hl_mmu_unmap_page(ctx, va_block->start, va_block->size,
 				list_is_last(&va_block->node,
 						&cb->va_block_list)))
 			dev_warn_ratelimited(hdev->dev,
diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index 43aa8cbd8969..e1db8301ecbd 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -2162,10 +2162,13 @@ int hl_mmu_init(struct hl_device *hdev);
 void hl_mmu_fini(struct hl_device *hdev);
 int hl_mmu_ctx_init(struct hl_ctx *ctx);
 void hl_mmu_ctx_fini(struct hl_ctx *ctx);
-int hl_mmu_map(struct hl_ctx *ctx, u64 virt_addr, u64 phys_addr,
+int hl_mmu_map_page(struct hl_ctx *ctx, u64 virt_addr, u64 phys_addr,
 		u32 page_size, bool flush_pte);
-int hl_mmu_unmap(struct hl_ctx *ctx, u64 virt_addr, u32 page_size,
+int hl_mmu_unmap_page(struct hl_ctx *ctx, u64 virt_addr, u32 page_size,
 		bool flush_pte);
+int hl_mmu_map_contiguous(struct hl_ctx *ctx, u64 virt_addr,
+					u64 phys_addr, u32 size);
+int hl_mmu_unmap_contiguous(struct hl_ctx *ctx, u64 virt_addr, u32 size);
 void hl_mmu_swap_out(struct hl_ctx *ctx);
 void hl_mmu_swap_in(struct hl_ctx *ctx);
 int hl_mmu_if_set_funcs(struct hl_device *hdev);
diff --git a/drivers/misc/habanalabs/common/memory.c b/drivers/misc/habanalabs/common/memory.c
index 351c9927151f..744275dd6410 100644
--- a/drivers/misc/habanalabs/common/memory.c
+++ b/drivers/misc/habanalabs/common/memory.c
@@ -843,7 +843,7 @@ static int map_phys_pg_pack(struct hl_ctx *ctx, u64 vaddr,
 	for (i = 0 ; i < phys_pg_pack->npages ; i++) {
 		paddr = phys_pg_pack->pages[i];
 
-		rc = hl_mmu_map(ctx, next_vaddr, paddr, page_size,
+		rc = hl_mmu_map_page(ctx, next_vaddr, paddr, page_size,
 				(i + 1) == phys_pg_pack->npages);
 		if (rc) {
 			dev_err(hdev->dev,
@@ -862,7 +862,7 @@ static int map_phys_pg_pack(struct hl_ctx *ctx, u64 vaddr,
 err:
 	next_vaddr = vaddr;
 	for (i = 0 ; i < mapped_pg_cnt ; i++) {
-		if (hl_mmu_unmap(ctx, next_vaddr, page_size,
+		if (hl_mmu_unmap_page(ctx, next_vaddr, page_size,
 					(i + 1) == mapped_pg_cnt))
 			dev_warn_ratelimited(hdev->dev,
 				"failed to unmap handle %u, va: 0x%llx, pa: 0x%llx, page size: %u\n",
@@ -892,7 +892,7 @@ static void unmap_phys_pg_pack(struct hl_ctx *ctx, u64 vaddr,
 	next_vaddr = vaddr;
 
 	for (i = 0 ; i < phys_pg_pack->npages ; i++, next_vaddr += page_size) {
-		if (hl_mmu_unmap(ctx, next_vaddr, page_size,
+		if (hl_mmu_unmap_page(ctx, next_vaddr, page_size,
 				       (i + 1) == phys_pg_pack->npages))
 			dev_warn_ratelimited(hdev->dev,
 			"unmap failed for vaddr: 0x%llx\n", next_vaddr);
diff --git a/drivers/misc/habanalabs/common/mmu.c b/drivers/misc/habanalabs/common/mmu.c
index 7279c83cc081..33ae953d3a36 100644
--- a/drivers/misc/habanalabs/common/mmu.c
+++ b/drivers/misc/habanalabs/common/mmu.c
@@ -122,7 +122,7 @@ void hl_mmu_ctx_fini(struct hl_ctx *ctx)
 }
 
 /*
- * hl_mmu_unmap - unmaps a virtual addr
+ * hl_mmu_unmap_page - unmaps a virtual addr
  *
  * @ctx: pointer to the context structure
  * @virt_addr: virt addr to map from
@@ -142,7 +142,7 @@ void hl_mmu_ctx_fini(struct hl_ctx *ctx)
  * For optimization reasons PCI flush may be requested once after unmapping of
  * large area.
  */
-int hl_mmu_unmap(struct hl_ctx *ctx, u64 virt_addr, u32 page_size,
+int hl_mmu_unmap_page(struct hl_ctx *ctx, u64 virt_addr, u32 page_size,
 		bool flush_pte)
 {
 	struct hl_device *hdev = ctx->hdev;
@@ -200,7 +200,7 @@ int hl_mmu_unmap(struct hl_ctx *ctx, u64 virt_addr, u32 page_size,
 }
 
 /*
- * hl_mmu_map - maps a virtual addr to physical addr
+ * hl_mmu_map_page - maps a virtual addr to physical addr
  *
  * @ctx: pointer to the context structure
  * @virt_addr: virt addr to map from
@@ -221,8 +221,8 @@ int hl_mmu_unmap(struct hl_ctx *ctx, u64 virt_addr, u32 page_size,
  * For optimization reasons PCI flush may be requested once after mapping of
  * large area.
  */
-int hl_mmu_map(struct hl_ctx *ctx, u64 virt_addr, u64 phys_addr, u32 page_size,
-		bool flush_pte)
+int hl_mmu_map_page(struct hl_ctx *ctx, u64 virt_addr, u64 phys_addr,
+		u32 page_size, bool flush_pte)
 {
 	struct hl_device *hdev = ctx->hdev;
 	struct asic_fixed_properties *prop = &hdev->asic_prop;
@@ -302,6 +302,108 @@ int hl_mmu_map(struct hl_ctx *ctx, u64 virt_addr, u64 phys_addr, u32 page_size,
 	return rc;
 }
 
+/*
+ * hl_mmu_map_contiguous - implements a wrapper for hl_mmu_map_page
+ *                         for mapping contiguous physical memory
+ *
+ * @ctx: pointer to the context structure
+ * @virt_addr: virt addr to map from
+ * @phys_addr: phys addr to map to
+ * @size: size to map
+ *
+ */
+int hl_mmu_map_contiguous(struct hl_ctx *ctx, u64 virt_addr,
+					u64 phys_addr, u32 size)
+{
+	struct hl_device *hdev = ctx->hdev;
+	struct asic_fixed_properties *prop = &hdev->asic_prop;
+	u64 curr_va, curr_pa;
+	u32 page_size;
+	bool flush_pte;
+	int rc = 0, off;
+
+	if (hl_mem_area_inside_range(virt_addr, size,
+			prop->dmmu.start_addr, prop->dmmu.end_addr))
+		page_size = prop->dmmu.page_size;
+	else if (hl_mem_area_inside_range(virt_addr, size,
+			prop->pmmu.start_addr, prop->pmmu.end_addr))
+		page_size = prop->pmmu.page_size;
+	else if (hl_mem_area_inside_range(virt_addr, size,
+			prop->pmmu_huge.start_addr, prop->pmmu_huge.end_addr))
+		page_size = prop->pmmu_huge.page_size;
+	else
+		return -EINVAL;
+
+	for (off = 0 ; off < size ; off += page_size) {
+		curr_va = virt_addr + off;
+		curr_pa = phys_addr + off;
+		flush_pte = (off + page_size) >= size;
+		rc = hl_mmu_map_page(ctx, curr_va, curr_pa, page_size,
+								flush_pte);
+		if (rc) {
+			dev_err(hdev->dev,
+				"Map failed for va 0x%llx to pa 0x%llx\n",
+				curr_va, curr_pa);
+			goto unmap;
+		}
+	}
+
+	return rc;
+
+unmap:
+	for (; off >= 0 ; off -= page_size) {
+		curr_va = virt_addr + off;
+		flush_pte = (off - (s32) page_size) < 0;
+		if (hl_mmu_unmap_page(ctx, curr_va, page_size, flush_pte))
+			dev_warn_ratelimited(hdev->dev,
+				"failed to unmap va 0x%llx\n", curr_va);
+	}
+
+	return rc;
+}
+
+/*
+ * hl_mmu_unmap_contiguous - implements a wrapper for hl_mmu_unmap_page
+ *                           for unmapping contiguous physical memory
+ *
+ * @ctx: pointer to the context structure
+ * @virt_addr: virt addr to unmap
+ * @size: size to unmap
+ *
+ */
+int hl_mmu_unmap_contiguous(struct hl_ctx *ctx, u64 virt_addr, u32 size)
+{
+	struct hl_device *hdev = ctx->hdev;
+	struct asic_fixed_properties *prop = &hdev->asic_prop;
+	u64 curr_va;
+	u32 page_size;
+	bool flush_pte;
+	int rc = 0, off;
+
+	if (hl_mem_area_inside_range(virt_addr, size,
+			prop->dmmu.start_addr, prop->dmmu.end_addr))
+		page_size = prop->dmmu.page_size;
+	else if (hl_mem_area_inside_range(virt_addr, size,
+			prop->pmmu.start_addr, prop->pmmu.end_addr))
+		page_size = prop->pmmu.page_size;
+	else if (hl_mem_area_inside_range(virt_addr, size,
+			prop->pmmu_huge.start_addr, prop->pmmu_huge.end_addr))
+		page_size = prop->pmmu_huge.page_size;
+	else
+		return -EINVAL;
+
+	for (off = 0 ; off < size ; off += page_size) {
+		curr_va = virt_addr + off;
+		flush_pte = (off + page_size) >= size;
+		rc = hl_mmu_unmap_page(ctx, curr_va, page_size, flush_pte);
+		if (rc)
+			dev_warn_ratelimited(hdev->dev,
+				"Unmap failed for va 0x%llx\n", curr_va);
+	}
+
+	return rc;
+}
+
 /*
  * hl_mmu_swap_out - marks all mapping of the given ctx as swapped out
  *
diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index 9f54baeef754..c44a883d9787 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -7766,9 +7766,6 @@ static int gaudi_internal_cb_pool_init(struct hl_device *hdev,
 		struct hl_ctx *ctx)
 {
 	struct gaudi_device *gaudi = hdev->asic_specific;
-	bool flush_pte;
-	u64 va, pa;
-	s64 off;
 	int min_alloc_order, rc, collective_cb_size;
 
 	if (!(gaudi->hw_cap_initialized & HW_CAP_MMU))
@@ -7813,48 +7810,23 @@ static int gaudi_internal_cb_pool_init(struct hl_device *hdev,
 		goto destroy_internal_cb_pool;
 
 	mutex_lock(&ctx->mmu_lock);
-
-	/* The mapping is done page by page since we can't assure allocated ptr
-	 * is aligned to HOST_SPACE_INTERNAL_CB_SZ
-	 */
-	for (off = 0 ; off < HOST_SPACE_INTERNAL_CB_SZ ; off += PAGE_SIZE_4KB) {
-		va = hdev->internal_cb_va_base + off;
-		pa = hdev->internal_cb_pool_dma_addr + off;
-		flush_pte = (off + PAGE_SIZE_4KB) >= HOST_SPACE_INTERNAL_CB_SZ;
-		rc = hl_mmu_map(ctx, va, pa, PAGE_SIZE_4KB, flush_pte);
-		if (rc) {
-			dev_err(hdev->dev,
-				"Map failed for va 0x%llx to pa 0x%llx\n",
-				va, pa);
-			goto unmap;
-		}
-	}
+	rc = hl_mmu_map_contiguous(ctx, hdev->internal_cb_va_base,
+			hdev->internal_cb_pool_dma_addr,
+			HOST_SPACE_INTERNAL_CB_SZ);
 
 	hdev->asic_funcs->mmu_invalidate_cache(hdev, false, VM_TYPE_USERPTR);
-
 	mutex_unlock(&ctx->mmu_lock);
 
-	return 0;
+	if (rc)
+		goto unreserve_internal_cb_pool;
 
-unmap:
-	for (; off >= 0 ; off -= PAGE_SIZE_4KB) {
-		va = hdev->internal_cb_va_base + off;
-		flush_pte = (off - (s32) PAGE_SIZE_4KB) < 0;
-		if (hl_mmu_unmap(ctx, va, PAGE_SIZE_4KB, flush_pte))
-			dev_warn_ratelimited(hdev->dev,
-					"failed to unmap va 0x%llx\n", va);
-	}
+	return 0;
 
+unreserve_internal_cb_pool:
 	hl_unreserve_va_block(hdev, ctx, hdev->internal_cb_va_base,
 			HOST_SPACE_INTERNAL_CB_SZ);
-
-	hdev->asic_funcs->mmu_invalidate_cache(hdev, true, VM_TYPE_USERPTR);
-
-	mutex_unlock(&ctx->mmu_lock);
-
 destroy_internal_cb_pool:
 	gen_pool_destroy(hdev->internal_cb_pool);
-
 free_internal_cb_pool:
 	hdev->asic_funcs->asic_dma_free_coherent(hdev,
 			HOST_SPACE_INTERNAL_CB_SZ,
@@ -7868,30 +7840,16 @@ static void gaudi_internal_cb_pool_fini(struct hl_device *hdev,
 		struct hl_ctx *ctx)
 {
 	struct gaudi_device *gaudi = hdev->asic_specific;
-	bool flush_pte = false;
-	u64 va, off;
 
 	if (!(gaudi->hw_cap_initialized & HW_CAP_MMU))
 		return;
 
 	mutex_lock(&ctx->mmu_lock);
-
-	for (off = 0 ; off < HOST_SPACE_INTERNAL_CB_SZ ; off += PAGE_SIZE_4KB) {
-		va = hdev->internal_cb_va_base + off;
-
-		if (off + PAGE_SIZE_4KB >= HOST_SPACE_INTERNAL_CB_SZ)
-			flush_pte = true;
-
-		if (hl_mmu_unmap(ctx, va, PAGE_SIZE_4KB, flush_pte))
-			dev_warn_ratelimited(hdev->dev,
-					"failed to unmap va 0x%llx\n", va);
-	}
-
+	hl_mmu_unmap_contiguous(ctx, hdev->internal_cb_va_base,
+			HOST_SPACE_INTERNAL_CB_SZ);
 	hl_unreserve_va_block(hdev, ctx, hdev->internal_cb_va_base,
 			HOST_SPACE_INTERNAL_CB_SZ);
-
 	hdev->asic_funcs->mmu_invalidate_cache(hdev, true, VM_TYPE_USERPTR);
-
 	mutex_unlock(&ctx->mmu_lock);
 
 	gen_pool_destroy(hdev->internal_cb_pool);
diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index 55d174d3cac8..342227b93778 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -4906,9 +4906,10 @@ static int goya_mmu_add_mappings_for_device_cpu(struct hl_device *hdev)
 		return 0;
 
 	for (off = 0 ; off < CPU_FW_IMAGE_SIZE ; off += PAGE_SIZE_2MB) {
-		rc = hl_mmu_map(hdev->kernel_ctx, prop->dram_base_address + off,
-				prop->dram_base_address + off, PAGE_SIZE_2MB,
-				(off + PAGE_SIZE_2MB) == CPU_FW_IMAGE_SIZE);
+		rc = hl_mmu_map_page(hdev->kernel_ctx,
+			prop->dram_base_address + off,
+			prop->dram_base_address + off, PAGE_SIZE_2MB,
+			(off + PAGE_SIZE_2MB) == CPU_FW_IMAGE_SIZE);
 		if (rc) {
 			dev_err(hdev->dev, "Map failed for address 0x%llx\n",
 				prop->dram_base_address + off);
@@ -4917,8 +4918,10 @@ static int goya_mmu_add_mappings_for_device_cpu(struct hl_device *hdev)
 	}
 
 	if (!(hdev->cpu_accessible_dma_address & (PAGE_SIZE_2MB - 1))) {
-		rc = hl_mmu_map(hdev->kernel_ctx, VA_CPU_ACCESSIBLE_MEM_ADDR,
-			hdev->cpu_accessible_dma_address, PAGE_SIZE_2MB, true);
+		rc = hl_mmu_map_page(hdev->kernel_ctx,
+			VA_CPU_ACCESSIBLE_MEM_ADDR,
+			hdev->cpu_accessible_dma_address,
+			PAGE_SIZE_2MB, true);
 
 		if (rc) {
 			dev_err(hdev->dev,
@@ -4928,7 +4931,7 @@ static int goya_mmu_add_mappings_for_device_cpu(struct hl_device *hdev)
 		}
 	} else {
 		for (cpu_off = 0 ; cpu_off < SZ_2M ; cpu_off += PAGE_SIZE_4KB) {
-			rc = hl_mmu_map(hdev->kernel_ctx,
+			rc = hl_mmu_map_page(hdev->kernel_ctx,
 				VA_CPU_ACCESSIBLE_MEM_ADDR + cpu_off,
 				hdev->cpu_accessible_dma_address + cpu_off,
 				PAGE_SIZE_4KB, true);
@@ -4955,7 +4958,7 @@ static int goya_mmu_add_mappings_for_device_cpu(struct hl_device *hdev)
 
 unmap_cpu:
 	for (; cpu_off >= 0 ; cpu_off -= PAGE_SIZE_4KB)
-		if (hl_mmu_unmap(hdev->kernel_ctx,
+		if (hl_mmu_unmap_page(hdev->kernel_ctx,
 				VA_CPU_ACCESSIBLE_MEM_ADDR + cpu_off,
 				PAGE_SIZE_4KB, true))
 			dev_warn_ratelimited(hdev->dev,
@@ -4963,7 +4966,7 @@ static int goya_mmu_add_mappings_for_device_cpu(struct hl_device *hdev)
 				VA_CPU_ACCESSIBLE_MEM_ADDR + cpu_off);
 unmap:
 	for (; off >= 0 ; off -= PAGE_SIZE_2MB)
-		if (hl_mmu_unmap(hdev->kernel_ctx,
+		if (hl_mmu_unmap_page(hdev->kernel_ctx,
 				prop->dram_base_address + off, PAGE_SIZE_2MB,
 				true))
 			dev_warn_ratelimited(hdev->dev,
@@ -4989,13 +4992,14 @@ void goya_mmu_remove_device_cpu_mappings(struct hl_device *hdev)
 	WREG32(mmCPU_IF_AWUSER_OVR_EN, 0);
 
 	if (!(hdev->cpu_accessible_dma_address & (PAGE_SIZE_2MB - 1))) {
-		if (hl_mmu_unmap(hdev->kernel_ctx, VA_CPU_ACCESSIBLE_MEM_ADDR,
+		if (hl_mmu_unmap_page(hdev->kernel_ctx,
+				VA_CPU_ACCESSIBLE_MEM_ADDR,
 				PAGE_SIZE_2MB, true))
 			dev_warn(hdev->dev,
 				"Failed to unmap CPU accessible memory\n");
 	} else {
 		for (cpu_off = 0 ; cpu_off < SZ_2M ; cpu_off += PAGE_SIZE_4KB)
-			if (hl_mmu_unmap(hdev->kernel_ctx,
+			if (hl_mmu_unmap_page(hdev->kernel_ctx,
 					VA_CPU_ACCESSIBLE_MEM_ADDR + cpu_off,
 					PAGE_SIZE_4KB,
 					(cpu_off + PAGE_SIZE_4KB) >= SZ_2M))
@@ -5005,7 +5009,7 @@ void goya_mmu_remove_device_cpu_mappings(struct hl_device *hdev)
 	}
 
 	for (off = 0 ; off < CPU_FW_IMAGE_SIZE ; off += PAGE_SIZE_2MB)
-		if (hl_mmu_unmap(hdev->kernel_ctx,
+		if (hl_mmu_unmap_page(hdev->kernel_ctx,
 				prop->dram_base_address + off, PAGE_SIZE_2MB,
 				(off + PAGE_SIZE_2MB) >= CPU_FW_IMAGE_SIZE))
 			dev_warn_ratelimited(hdev->dev,
-- 
2.17.1

