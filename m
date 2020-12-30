Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4588F2E7B09
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Dec 2020 17:25:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726491AbgL3QYm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Dec 2020 11:24:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:57866 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726168AbgL3QYm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Dec 2020 11:24:42 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 79F022079A;
        Wed, 30 Dec 2020 16:23:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609345440;
        bh=7l8+FgQ1UG4sCZXh74xMyB3HZRMJeylTYrAdsHUiFgI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Goxp30UGbzFM4/OvMHw94JLSoafJO/0FyYwkhREKf7ctUAb3GnpzTYGRaxfyPUYiq
         u9Zpokf+8xccMSOBxhN28x9SAosLD08wEdG36I7WzYEdFoLoF1PA9gq8QtLqTORNP7
         4EjBCUlWzuwCm7acXJ3aaJOJT8PounIe8mWnph421qIggdfj5I2V3reTyTVqQeAtdJ
         y242rcWYj8wGi7aIERCSw48Oe4VqdQkjnSOQSJv4DNbDFUsyZPNgIRfYB7LhjgZT70
         d1xIfxOXx3L6wIainXhKvUTW/+/6FnJg5FfzfwjM7R0e71d4WbA+e8ErOSka2WexwH
         YYfLAdZycHu5g==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Moti Haimovski <mhaimovski@habana.ai>
Subject: [PATCH 2/2] habanalabs: support non power-of-2 DRAM phys page sizes
Date:   Wed, 30 Dec 2020 18:23:53 +0200
Message-Id: <20201230162353.4672-2-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201230162353.4672-1-ogabbay@kernel.org>
References: <20201230162353.4672-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Moti Haimovski <mhaimovski@habana.ai>

DRAM physical page sizes depend of the amount of HBMs available in
the device. this number is device-dependent and may also be subject
to binning when one or more of the DRAM controllers are found to
to be faulty. Such a configuration may lead to partitioning the DRAM
to non-power-of-2 pages.

To support this feature we also need to add infrastructure of address
scarmbling.

Signed-off-by: Moti Haimovski <mhaimovski@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/debugfs.c    |   6 +-
 drivers/misc/habanalabs/common/habanalabs.h |   8 +
 drivers/misc/habanalabs/common/memory.c     | 176 ++++++++++++++++----
 drivers/misc/habanalabs/common/mmu.c        |  61 ++++++-
 drivers/misc/habanalabs/gaudi/gaudi.c       |   3 +-
 drivers/misc/habanalabs/goya/goya.c         |   3 +-
 6 files changed, 213 insertions(+), 44 deletions(-)

diff --git a/drivers/misc/habanalabs/common/debugfs.c b/drivers/misc/habanalabs/common/debugfs.c
index cef716643979..50ca8eea6648 100644
--- a/drivers/misc/habanalabs/common/debugfs.c
+++ b/drivers/misc/habanalabs/common/debugfs.c
@@ -333,8 +333,10 @@ static int mmu_show(struct seq_file *s, void *data)
 		return 0;
 	}
 
-	seq_printf(s, "asid: %u, virt_addr: 0x%llx\n",
-			dev_entry->mmu_asid, dev_entry->mmu_addr);
+	seq_printf(s,
+		"asid: %u, virt_addr: 0x%llx, scrambled virt_addr: 0x%llx\n",
+		dev_entry->mmu_asid, dev_entry->mmu_addr,
+		hops_info.scrambled_vaddr);
 
 	for (i = 0 ; i < hops_info.used_hops ; i++) {
 		seq_printf(s, "hop%d_addr: 0x%llx\n",
diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index 0cd18c0fec95..554633cc9474 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -848,6 +848,8 @@ enum div_select_defs {
  * @collective_wait_init_cs: Generate collective master/slave packets
  *                           and place them in the relevant cs jobs
  * @collective_wait_create_jobs: allocate collective wait cs jobs
+ * @scramble_vaddr: Routine to scramble the virtual address prior of mapping it
+ *                  in the MMU.
  */
 struct hl_asic_funcs {
 	int (*early_init)(struct hl_device *hdev);
@@ -957,6 +959,7 @@ struct hl_asic_funcs {
 	int (*collective_wait_create_jobs)(struct hl_device *hdev,
 			struct hl_ctx *ctx, struct hl_cs *cs, u32 wait_queue_id,
 			u32 collective_engine_id);
+	u64 (*scramble_vaddr)(struct hl_device *hdev, u64 virt_addr);
 };
 
 
@@ -1690,10 +1693,14 @@ struct hl_mmu_per_hop_info {
  * struct hl_mmu_hop_info - A structure describing the TLB hops and their
  * hop-entries that were created in order to translate a virtual address to a
  * physical one.
+ * @scrambled_vaddr: The value of the virtual address after scrambling. This
+ *                   address replaces the original virtual-address when mapped
+ *                   in the MMU tables.
  * @hop_info: Array holding the per-hop information used for the translation.
  * @used_hops: The number of hops used for the translation.
  */
 struct hl_mmu_hop_info {
+	u64 scrambled_vaddr;
 	struct hl_mmu_per_hop_info hop_info[MMU_ARCH_5_HOPS];
 	u32 used_hops;
 };
@@ -2184,6 +2191,7 @@ void hl_mmu_v1_set_funcs(struct hl_device *hdev, struct hl_mmu_funcs *mmu);
 int hl_mmu_va_to_pa(struct hl_ctx *ctx, u64 virt_addr, u64 *phys_addr);
 int hl_mmu_get_tlb_info(struct hl_ctx *ctx, u64 virt_addr,
 			struct hl_mmu_hop_info *hops);
+u64 hl_mmu_scramble_vaddr(struct hl_device *hdev, u64 virt_addr);
 
 int hl_fw_load_fw_to_device(struct hl_device *hdev, const char *fw_name,
 				void __iomem *dst, u32 src_offset, u32 size);
diff --git a/drivers/misc/habanalabs/common/memory.c b/drivers/misc/habanalabs/common/memory.c
index 5d8228522bfc..639e4d9e73a5 100644
--- a/drivers/misc/habanalabs/common/memory.c
+++ b/drivers/misc/habanalabs/common/memory.c
@@ -14,6 +14,9 @@
 
 #define HL_MMU_DEBUG	0
 
+/* use small pages for supporting non-pow2 (32M/40M/48M) DRAM phys page sizes */
+#define DRAM_POOL_PAGE_SIZE SZ_8M
+
 /*
  * The va ranges in context object contain a list with the available chunks of
  * device virtual memory.
@@ -54,15 +57,14 @@ static int alloc_device_memory(struct hl_ctx *ctx, struct hl_mem_in *args,
 	struct hl_vm *vm = &hdev->vm;
 	struct hl_vm_phys_pg_pack *phys_pg_pack;
 	u64 paddr = 0, total_size, num_pgs, i;
-	u32 num_curr_pgs, page_size, page_shift;
+	u32 num_curr_pgs, page_size;
 	int handle, rc;
 	bool contiguous;
 
 	num_curr_pgs = 0;
 	page_size = hdev->asic_prop.dram_page_size;
-	page_shift = __ffs(page_size);
-	num_pgs = (args->alloc.mem_size + (page_size - 1)) >> page_shift;
-	total_size = num_pgs << page_shift;
+	num_pgs = DIV_ROUND_UP_ULL(args->alloc.mem_size, page_size);
+	total_size = num_pgs * page_size;
 
 	if (!total_size) {
 		dev_err(hdev->dev, "Cannot allocate 0 bytes\n");
@@ -518,7 +520,8 @@ static inline int add_va_block(struct hl_device *hdev,
 }
 
 /**
- * get_va_block() - get a virtual block for the given size and alignment.
+ * get_va_block_pow2() - get a virtual block for the given size and alignment
+ *                       where alignment is a power of 2.
  * @hdev: pointer to the habanalabs device structure.
  * @va_range: pointer to the virtual addresses range.
  * @size: requested block size.
@@ -531,12 +534,13 @@ static inline int add_va_block(struct hl_device *hdev,
  * - Reserve the requested block and update the list.
  * - Return the start address of the virtual block.
  */
-static u64 get_va_block(struct hl_device *hdev, struct hl_va_range *va_range,
-			u64 size, u64 hint_addr, u32 va_block_align)
+static u64 get_va_block_pow2(struct hl_device *hdev,
+				struct hl_va_range *va_range,
+				u64 size, u64 hint_addr, u32 va_block_align)
 {
 	struct hl_vm_va_block *va_block, *new_va_block = NULL;
 	u64 valid_start, valid_size, prev_start, prev_end, align_mask,
-		res_valid_start = 0, res_valid_size = 0;
+	reserved_valid_start = 0, reserved_valid_size = 0;
 	bool add_prev = false;
 
 	align_mask = ~((u64)va_block_align - 1);
@@ -562,34 +566,34 @@ static u64 get_va_block(struct hl_device *hdev, struct hl_va_range *va_range,
 
 		valid_size = va_block->end - valid_start;
 
-		if (valid_size >= size &&
-			(!new_va_block || valid_size < res_valid_size)) {
+		if (valid_size >= size && (!new_va_block ||
+					valid_size < reserved_valid_size)) {
 			new_va_block = va_block;
-			res_valid_start = valid_start;
-			res_valid_size = valid_size;
+			reserved_valid_start = valid_start;
+			reserved_valid_size = valid_size;
 		}
 
 		if (hint_addr && hint_addr >= valid_start &&
-				((hint_addr + size) <= va_block->end)) {
+					(hint_addr + size) <= va_block->end) {
 			new_va_block = va_block;
-			res_valid_start = hint_addr;
-			res_valid_size = valid_size;
+			reserved_valid_start = hint_addr;
+			reserved_valid_size = valid_size;
 			break;
 		}
 	}
 
 	if (!new_va_block) {
 		dev_err(hdev->dev, "no available va block for size %llu\n",
-				size);
+		size);
 		goto out;
 	}
 
-	if (res_valid_start > new_va_block->start) {
+	if (reserved_valid_start > new_va_block->start) {
 		prev_start = new_va_block->start;
-		prev_end = res_valid_start - 1;
+		prev_end = reserved_valid_start - 1;
 
-		new_va_block->start = res_valid_start;
-		new_va_block->size = res_valid_size;
+		new_va_block->start = reserved_valid_start;
+		new_va_block->size = reserved_valid_size;
 
 		add_prev = true;
 	}
@@ -610,10 +614,99 @@ static u64 get_va_block(struct hl_device *hdev, struct hl_va_range *va_range,
 out:
 	mutex_unlock(&va_range->lock);
 
-	return res_valid_start;
+	return reserved_valid_start;
 }
 
 /**
+ * get_va_block_non_pow2() - get a virtual block for the given size and
+ *                           alignment where alignment is not a power of 2.
+ * @hdev: pointer to the habanalabs device structure.
+ * @va_range: pointer to the virtual addresses range.
+ * @size: requested block size.
+ * @hint_addr: hint for requested address by the user.
+ * @va_block_align: required alignment of the virtual block start address.
+ *
+ * This function does the following:
+ * - Iterate on the virtual block list to find a suitable virtual block for the
+ *   given size and alignment.
+ * - Reserve the requested block and update the list.
+ * - Return the start address of the virtual block.
+ */
+static u64 get_va_block_non_pow2(struct hl_device *hdev,
+				struct hl_va_range *va_range,
+				u64 size, u64 hint_addr, u32 va_block_align)
+{
+	struct hl_vm_va_block *va_block, *new_va_block = NULL;
+	u64 reserved_valid_start = 0;
+
+	hint_addr = 0; /* hint_address is not considered */
+
+	/*
+	 * with non-power-of-2 range we work only with page granularity and the
+	 * start address is page aligned, so no need for alignment checking.
+	 */
+	size = roundup(size, va_range->page_size);
+
+	mutex_lock(&va_range->lock);
+
+	print_va_list_locked(hdev, &va_range->list);
+
+	list_for_each_entry(va_block, &va_range->list, node) {
+		if ((va_block->start + size) > va_block->end)
+			continue;
+
+		new_va_block = va_block;
+		reserved_valid_start = va_block->start;
+		break;
+	}
+
+	if (!new_va_block) {
+		dev_err(hdev->dev, "no available va block for size %llu\n",
+				size);
+		goto out;
+	}
+
+	if (new_va_block->size > size) {
+		new_va_block->start += size;
+		new_va_block->size = new_va_block->end - new_va_block->start;
+	} else {
+		list_del(&new_va_block->node);
+		kfree(new_va_block);
+	}
+
+	print_va_list_locked(hdev, &va_range->list);
+out:
+	mutex_unlock(&va_range->lock);
+
+	return reserved_valid_start;
+}
+
+/*
+ * get_va_block() - get a virtual block for the given size and alignment.
+ * @hdev: pointer to the habanalabs device structure.
+ * @va_range: pointer to the virtual addresses range.
+ * @size: requested block size.
+ * @hint_addr: hint for requested address by the user.
+ * @va_block_align: required alignment of the virtual block start address.
+ *
+ * This function does the following:
+ * - Iterate on the virtual block list to find a suitable virtual block for the
+ *   given size and alignment.
+ * - Reserve the requested block and update the list.
+ * - Return the start address of the virtual block.
+ */
+static u64 get_va_block(struct hl_device *hdev, struct hl_va_range *va_range,
+			u64 size, u64 hint_addr, u32 va_block_align)
+{
+	if (is_power_of_2(va_range->page_size))
+		return get_va_block_pow2(hdev, va_range,
+					size, hint_addr, va_block_align);
+	else
+		return get_va_block_non_pow2(hdev, va_range,
+					size, hint_addr, va_block_align);
+}
+
+/*
  * hl_reserve_va_block() - reserve a virtual block of a given size.
  * @hdev: pointer to the habanalabs device structure.
  * @ctx: current context
@@ -1018,7 +1111,7 @@ static int map_device_va(struct hl_ctx *ctx, struct hl_mem_in *args,
 
 		hint_addr = args->map_device.hint_addr;
 
-		/* DRAM VA alignment is the same as the DRAM page size */
+		/* DRAM VA alignment is the same as the MMU page size */
 		va_range = ctx->va_range[HL_VA_RANGE_TYPE_DRAM];
 		va_block_align = hdev->asic_prop.dmmu.page_size;
 	}
@@ -1123,6 +1216,7 @@ static int unmap_device_va(struct hl_ctx *ctx, struct hl_mem_in *args,
 				bool ctx_free)
 {
 	struct hl_device *hdev = ctx->hdev;
+	struct asic_fixed_properties *prop = &hdev->asic_prop;
 	struct hl_vm_phys_pg_pack *phys_pg_pack = NULL;
 	struct hl_vm_hash_node *hnode = NULL;
 	struct hl_userptr *userptr = NULL;
@@ -1186,7 +1280,12 @@ static int unmap_device_va(struct hl_ctx *ctx, struct hl_mem_in *args,
 		goto mapping_cnt_err;
 	}
 
-	vaddr &= ~(((u64) phys_pg_pack->page_size) - 1);
+	if (!is_userptr && !is_power_of_2(phys_pg_pack->page_size))
+		vaddr = prop->dram_base_address +
+			rounddown(vaddr - prop->dram_base_address,
+				phys_pg_pack->page_size);
+	else
+		vaddr &= ~(((u64) phys_pg_pack->page_size) - 1);
 
 	mutex_lock(&ctx->mmu_lock);
 
@@ -1631,16 +1730,22 @@ static int va_range_init(struct hl_device *hdev, struct hl_va_range *va_range,
 
 	INIT_LIST_HEAD(&va_range->list);
 
-	/* PAGE_SIZE alignment */
+	/*
+	 * PAGE_SIZE alignment
+	 * it is the callers responsibility to align the addresses if the
+	 * page size is not a power of 2
+	 */
+
+	if (is_power_of_2(page_size)) {
+		if (start & (PAGE_SIZE - 1)) {
+			start &= PAGE_MASK;
+			start += PAGE_SIZE;
+		}
 
-	if (start & (PAGE_SIZE - 1)) {
-		start &= PAGE_MASK;
-		start += PAGE_SIZE;
+		if (end & (PAGE_SIZE - 1))
+			end &= PAGE_MASK;
 	}
 
-	if (end & (PAGE_SIZE - 1))
-		end &= PAGE_MASK;
-
 	if (start >= end) {
 		dev_err(hdev->dev, "too small vm range for va list\n");
 		return -EFAULT;
@@ -1814,7 +1919,8 @@ int hl_vm_ctx_init(struct hl_ctx *ctx)
 
 	dram_range_start = prop->dmmu.start_addr;
 	dram_range_end = prop->dmmu.end_addr;
-	dram_page_size = prop->dmmu.page_size;
+	dram_page_size = prop->dram_page_size ?
+				prop->dram_page_size : prop->dmmu.page_size;
 	host_range_start = prop->pmmu.start_addr;
 	host_range_end = prop->pmmu.end_addr;
 	host_page_size = prop->pmmu.page_size;
@@ -1932,7 +2038,13 @@ int hl_vm_init(struct hl_device *hdev)
 	struct hl_vm *vm = &hdev->vm;
 	int rc;
 
-	vm->dram_pg_pool = gen_pool_create(__ffs(prop->dram_page_size), -1);
+	if (is_power_of_2(prop->dram_page_size))
+		vm->dram_pg_pool =
+			gen_pool_create(__ffs(prop->dram_page_size), -1);
+	else
+		vm->dram_pg_pool =
+			gen_pool_create(__ffs(DRAM_POOL_PAGE_SIZE), -1);
+
 	if (!vm->dram_pg_pool) {
 		dev_err(hdev->dev, "Failed to create dram page pool\n");
 		return -ENOMEM;
diff --git a/drivers/misc/habanalabs/common/mmu.c b/drivers/misc/habanalabs/common/mmu.c
index 8ca265420545..ec11111aee8a 100644
--- a/drivers/misc/habanalabs/common/mmu.c
+++ b/drivers/misc/habanalabs/common/mmu.c
@@ -166,7 +166,6 @@ int hl_mmu_unmap_page(struct hl_ctx *ctx, u64 virt_addr, u32 page_size,
 		mmu_prop = &prop->pmmu;
 
 	pgt_residency = mmu_prop->host_resident ? MMU_HR_PGT : MMU_DR_PGT;
-
 	/*
 	 * The H/W handles mapping of specific page sizes. Hence if the page
 	 * size is bigger, we break it to sub-pages and unmap them separately.
@@ -174,11 +173,21 @@ int hl_mmu_unmap_page(struct hl_ctx *ctx, u64 virt_addr, u32 page_size,
 	if ((page_size % mmu_prop->page_size) == 0) {
 		real_page_size = mmu_prop->page_size;
 	} else {
-		dev_err(hdev->dev,
-			"page size of %u is not %uKB aligned, can't unmap\n",
-			page_size, mmu_prop->page_size >> 10);
+		/*
+		 * MMU page size may differ from DRAM page size.
+		 * In such case work with the DRAM page size and let the MMU
+		 * scrambling routine to handle this mismatch when
+		 * calculating the address to remove from the MMU page table
+		 */
+		if (is_dram_addr && ((page_size % prop->dram_page_size) == 0)) {
+			real_page_size = prop->dram_page_size;
+		} else {
+			dev_err(hdev->dev,
+				"page size of %u is not %uKB aligned, can't unmap\n",
+				page_size, mmu_prop->page_size >> 10);
 
-		return -EFAULT;
+			return -EFAULT;
+		}
 	}
 
 	npages = page_size / real_page_size;
@@ -253,6 +262,17 @@ int hl_mmu_map_page(struct hl_ctx *ctx, u64 virt_addr, u64 phys_addr,
 	 */
 	if ((page_size % mmu_prop->page_size) == 0) {
 		real_page_size = mmu_prop->page_size;
+	} else if (is_dram_addr && ((page_size % prop->dram_page_size) == 0) &&
+			(prop->dram_page_size < mmu_prop->page_size)) {
+		/*
+		 * MMU page size may differ from DRAM page size.
+		 * In such case work with the DRAM page size and let the MMU
+		 * scrambling routine handle this mismatch when calculating
+		 * the address to place in the MMU page table. (in that case
+		 * also make sure that the dram_page_size smaller than the
+		 * mmu page size)
+		 */
+		real_page_size = prop->dram_page_size;
 	} else {
 		dev_err(hdev->dev,
 			"page size of %u is not %uKB aligned, can't map\n",
@@ -261,10 +281,21 @@ int hl_mmu_map_page(struct hl_ctx *ctx, u64 virt_addr, u64 phys_addr,
 		return -EFAULT;
 	}
 
-	if (phys_addr & (real_page_size - 1))
+	/*
+	 * Verify that the phys and virt addresses are aligned with the
+	 * MMU page size (in dram this means checking the address and MMU
+	 * after scrambling)
+	 */
+	if ((is_dram_addr &&
+			((hdev->asic_funcs->scramble_vaddr(hdev, phys_addr) &
+				(mmu_prop->page_size - 1)) ||
+			(hdev->asic_funcs->scramble_vaddr(hdev, virt_addr) &
+				(mmu_prop->page_size - 1)))) ||
+		(!is_dram_addr && ((phys_addr & (real_page_size - 1)) ||
+				(virt_addr & (real_page_size - 1)))))
 		dev_crit(hdev->dev,
-			"Mapping 0x%llx with page size of 0x%x is erroneous! Address must be divisible by page size",
-			phys_addr, real_page_size);
+			"Mapping address 0x%llx with virtual address 0x%llx and page size of 0x%x is erroneous! Addresses must be divisible by page size",
+			phys_addr, virt_addr, real_page_size);
 
 	npages = page_size / real_page_size;
 	real_virt_addr = virt_addr;
@@ -474,6 +505,8 @@ int hl_mmu_get_tlb_info(struct hl_ctx *ctx, u64 virt_addr,
 	if (!hdev->mmu_enable)
 		return -EOPNOTSUPP;
 
+	hops->scrambled_vaddr = virt_addr;      /* assume no scrambling */
+
 	is_dram_addr = hl_mem_area_inside_range(virt_addr, prop->dmmu.page_size,
 						prop->dmmu.start_addr,
 						prop->dmmu.end_addr);
@@ -513,3 +546,15 @@ int hl_mmu_if_set_funcs(struct hl_device *hdev)
 
 	return 0;
 }
+
+/**
+ * hl_mmu_scramble_vaddr() - The generic mmu virtual address scrambling routine.
+ * @hdev: pointer to device data.
+ * @virt_addr: The virtual address to scramble.
+ *
+ * Return: The scrambled virtual address.
+ */
+u64 hl_mmu_scramble_vaddr(struct hl_device *hdev, u64 virt_addr)
+{
+	return virt_addr;
+}
diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index ac5ad01186c1..44f470e11f78 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -8307,7 +8307,8 @@ static const struct hl_asic_funcs gaudi_funcs = {
 	.set_dma_mask_from_fw = gaudi_set_dma_mask_from_fw,
 	.get_device_time = gaudi_get_device_time,
 	.collective_wait_init_cs = gaudi_collective_wait_init_cs,
-	.collective_wait_create_jobs = gaudi_collective_wait_create_jobs
+	.collective_wait_create_jobs = gaudi_collective_wait_create_jobs,
+	.scramble_vaddr = hl_mmu_scramble_vaddr
 };
 
 /**
diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index 71d5a2620421..748b57036080 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -5455,7 +5455,8 @@ static const struct hl_asic_funcs goya_funcs = {
 	.set_dma_mask_from_fw = goya_set_dma_mask_from_fw,
 	.get_device_time = goya_get_device_time,
 	.collective_wait_init_cs = goya_collective_wait_init_cs,
-	.collective_wait_create_jobs = goya_collective_wait_create_jobs
+	.collective_wait_create_jobs = goya_collective_wait_create_jobs,
+	.scramble_vaddr = hl_mmu_scramble_vaddr
 };
 
 /*
-- 
2.25.1

