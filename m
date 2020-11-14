Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43A572B2C67
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Nov 2020 10:26:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726690AbgKNJYZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Nov 2020 04:24:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:60948 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726478AbgKNJYY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Nov 2020 04:24:24 -0500
Received: from ogabbay-VM.habana-labs.com (unknown [213.57.90.10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 846D822249;
        Sat, 14 Nov 2020 09:24:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605345861;
        bh=i7iRCaP5Z0dyS4BWejCnpJ8j/ESuSikv4AV3lmZCd7s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=c56F8khA4MA4QwsUX0Kaob9Baff91espvk/4Fx+pzl3R2qMRflcJ0eLFRGSnmYmdQ
         ee5TLsoIEYJajA4h6BmJ5BniOUG2vUY4n4RfeILh5eEKL2xgsTlq/eQLVNk8t6QQk+
         GBx+D4k3Jp5wOFwkBFAotb1k5axJPjLPydImK458=
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     SW_Drivers@habana.ai, Moti Haimovski <mhaimovski@habana.ai>
Subject: [PATCH] habanalabs: fix MMU debugfs operations
Date:   Sat, 14 Nov 2020 11:24:12 +0200
Message-Id: <20201114092414.12244-2-ogabbay@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201114092414.12244-1-ogabbay@kernel.org>
References: <20201114092414.12244-1-ogabbay@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Moti Haimovski <mhaimovski@habana.ai>

After the MMU-code refactoring, the existing MMU debugfs operations
are no longer working so we need to fix them.
In addition, remove the duplicate code that was in the debugfs code
and use the already existing MMU-code.

Signed-off-by: Moti Haimovski <mhaimovski@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/debugfs.c    | 282 ++------------------
 drivers/misc/habanalabs/common/habanalabs.h |  35 +++
 drivers/misc/habanalabs/common/mmu.c        |  50 ++++
 drivers/misc/habanalabs/common/mmu_v1.c     | 102 +++++++
 4 files changed, 206 insertions(+), 263 deletions(-)

diff --git a/drivers/misc/habanalabs/common/debugfs.c b/drivers/misc/habanalabs/common/debugfs.c
index 3d9bd86312e2..1db804de45ba 100644
--- a/drivers/misc/habanalabs/common/debugfs.c
+++ b/drivers/misc/habanalabs/common/debugfs.c
@@ -301,93 +301,15 @@ static int vm_show(struct seq_file *s, void *data)
 	return 0;
 }
 
-/* these inline functions are copied from mmu.c */
-static inline u64 get_hop0_addr(struct hl_ctx *ctx)
-{
-	return ctx->hdev->asic_prop.mmu_pgt_addr +
-			(ctx->asid * ctx->hdev->asic_prop.mmu_hop_table_size);
-}
-
-static inline u64 get_hopN_pte_addr(struct hl_ctx *ctx, u64 hop_addr,
-					u64 virt_addr, u64 mask, u64 shift)
-{
-	return hop_addr + ctx->hdev->asic_prop.mmu_pte_size *
-			((virt_addr & mask) >> shift);
-}
-
-static inline u64 get_hop0_pte_addr(struct hl_ctx *ctx,
-					struct hl_mmu_properties *mmu_specs,
-					u64 hop_addr, u64 vaddr)
-{
-	return get_hopN_pte_addr(ctx, hop_addr, vaddr, mmu_specs->hop0_mask,
-					mmu_specs->hop0_shift);
-}
-
-static inline u64 get_hop1_pte_addr(struct hl_ctx *ctx,
-					struct hl_mmu_properties *mmu_specs,
-					u64 hop_addr, u64 vaddr)
-{
-	return get_hopN_pte_addr(ctx, hop_addr, vaddr, mmu_specs->hop1_mask,
-					mmu_specs->hop1_shift);
-}
-
-static inline u64 get_hop2_pte_addr(struct hl_ctx *ctx,
-					struct hl_mmu_properties *mmu_specs,
-					u64 hop_addr, u64 vaddr)
-{
-	return get_hopN_pte_addr(ctx, hop_addr, vaddr, mmu_specs->hop2_mask,
-					mmu_specs->hop2_shift);
-}
-
-static inline u64 get_hop3_pte_addr(struct hl_ctx *ctx,
-					struct hl_mmu_properties *mmu_specs,
-					u64 hop_addr, u64 vaddr)
-{
-	return get_hopN_pte_addr(ctx, hop_addr, vaddr, mmu_specs->hop3_mask,
-					mmu_specs->hop3_shift);
-}
-
-static inline u64 get_hop4_pte_addr(struct hl_ctx *ctx,
-					struct hl_mmu_properties *mmu_specs,
-					u64 hop_addr, u64 vaddr)
-{
-	return get_hopN_pte_addr(ctx, hop_addr, vaddr, mmu_specs->hop4_mask,
-					mmu_specs->hop4_shift);
-}
-
-static inline u64 get_hop5_pte_addr(struct hl_ctx *ctx,
-					struct hl_mmu_properties *mmu_specs,
-					u64 hop_addr, u64 vaddr)
-{
-	return get_hopN_pte_addr(ctx, hop_addr, vaddr, mmu_specs->hop5_mask,
-					mmu_specs->hop5_shift);
-}
-
-static inline u64 get_next_hop_addr(u64 curr_pte)
-{
-	if (curr_pte & PAGE_PRESENT_MASK)
-		return curr_pte & HOP_PHYS_ADDR_MASK;
-	else
-		return ULLONG_MAX;
-}
-
 static int mmu_show(struct seq_file *s, void *data)
 {
 	struct hl_debugfs_entry *entry = s->private;
 	struct hl_dbg_device_entry *dev_entry = entry->dev_entry;
 	struct hl_device *hdev = dev_entry->hdev;
-	struct asic_fixed_properties *prop = &hdev->asic_prop;
-	struct hl_mmu_properties *mmu_prop;
 	struct hl_ctx *ctx;
-	bool is_dram_addr;
-
-	u64 hop0_addr = 0, hop0_pte_addr = 0, hop0_pte = 0,
-		hop1_addr = 0, hop1_pte_addr = 0, hop1_pte = 0,
-		hop2_addr = 0, hop2_pte_addr = 0, hop2_pte = 0,
-		hop3_addr = 0, hop3_pte_addr = 0, hop3_pte = 0,
-		hop4_addr = 0, hop4_pte_addr = 0, hop4_pte = 0,
-		hop5_addr = 0, hop5_pte_addr = 0, hop5_pte = 0,
-		virt_addr = dev_entry->mmu_addr;
+	struct hl_mmu_hop_info hops_info;
+	u64 virt_addr = dev_entry->mmu_addr;
+	int i;
 
 	if (!hdev->mmu_enable)
 		return 0;
@@ -402,132 +324,24 @@ static int mmu_show(struct seq_file *s, void *data)
 		return 0;
 	}
 
-	is_dram_addr = hl_mem_area_inside_range(virt_addr, prop->dmmu.page_size,
-						prop->dmmu.start_addr,
-						prop->dmmu.end_addr);
-
-	/* shifts and masks are the same in PMMU and HPMMU, use one of them */
-	mmu_prop = is_dram_addr ? &prop->dmmu : &prop->pmmu;
-
-	mutex_lock(&ctx->mmu_lock);
-
-	/* the following lookup is copied from unmap() in mmu.c */
-
-	hop0_addr = get_hop0_addr(ctx);
-	hop0_pte_addr = get_hop0_pte_addr(ctx, mmu_prop, hop0_addr, virt_addr);
-	hop0_pte = hdev->asic_funcs->read_pte(hdev, hop0_pte_addr);
-	hop1_addr = get_next_hop_addr(hop0_pte);
-
-	if (hop1_addr == ULLONG_MAX)
-		goto not_mapped;
-
-	hop1_pte_addr = get_hop1_pte_addr(ctx, mmu_prop, hop1_addr, virt_addr);
-	hop1_pte = hdev->asic_funcs->read_pte(hdev, hop1_pte_addr);
-	hop2_addr = get_next_hop_addr(hop1_pte);
-
-	if (hop2_addr == ULLONG_MAX)
-		goto not_mapped;
-
-	hop2_pte_addr = get_hop2_pte_addr(ctx, mmu_prop, hop2_addr, virt_addr);
-	hop2_pte = hdev->asic_funcs->read_pte(hdev, hop2_pte_addr);
-	hop3_addr = get_next_hop_addr(hop2_pte);
-
-	if (hop3_addr == ULLONG_MAX)
-		goto not_mapped;
-
-	hop3_pte_addr = get_hop3_pte_addr(ctx, mmu_prop, hop3_addr, virt_addr);
-	hop3_pte = hdev->asic_funcs->read_pte(hdev, hop3_pte_addr);
-
-	if (mmu_prop->num_hops == MMU_ARCH_5_HOPS) {
-		if (!(hop3_pte & LAST_MASK)) {
-			hop4_addr = get_next_hop_addr(hop3_pte);
-
-			if (hop4_addr == ULLONG_MAX)
-				goto not_mapped;
-
-			hop4_pte_addr = get_hop4_pte_addr(ctx, mmu_prop,
-							hop4_addr, virt_addr);
-			hop4_pte = hdev->asic_funcs->read_pte(hdev,
-								hop4_pte_addr);
-			if (!(hop4_pte & PAGE_PRESENT_MASK))
-				goto not_mapped;
-		} else {
-			if (!(hop3_pte & PAGE_PRESENT_MASK))
-				goto not_mapped;
-		}
-	} else {
-		hop4_addr = get_next_hop_addr(hop3_pte);
-
-		if (hop4_addr == ULLONG_MAX)
-			goto not_mapped;
-
-		hop4_pte_addr = get_hop4_pte_addr(ctx, mmu_prop,
-						hop4_addr, virt_addr);
-		hop4_pte = hdev->asic_funcs->read_pte(hdev,
-							hop4_pte_addr);
-		if (!(hop4_pte & LAST_MASK)) {
-			hop5_addr = get_next_hop_addr(hop4_pte);
-
-			if (hop5_addr == ULLONG_MAX)
-				goto not_mapped;
-
-			hop5_pte_addr = get_hop5_pte_addr(ctx, mmu_prop,
-							hop5_addr, virt_addr);
-			hop5_pte = hdev->asic_funcs->read_pte(hdev,
-								hop5_pte_addr);
-			if (!(hop5_pte & PAGE_PRESENT_MASK))
-				goto not_mapped;
-		} else {
-			if (!(hop4_pte & PAGE_PRESENT_MASK))
-				goto not_mapped;
-		}
+	if (hl_mmu_get_tlb_info(ctx, virt_addr, &hops_info)) {
+		dev_err(hdev->dev, "virt addr 0x%llx is not mapped to phys addr\n",
+				virt_addr);
+		return 0;
 	}
 
 	seq_printf(s, "asid: %u, virt_addr: 0x%llx\n",
 			dev_entry->mmu_asid, dev_entry->mmu_addr);
 
-	seq_printf(s, "hop0_addr: 0x%llx\n", hop0_addr);
-	seq_printf(s, "hop0_pte_addr: 0x%llx\n", hop0_pte_addr);
-	seq_printf(s, "hop0_pte: 0x%llx\n", hop0_pte);
-
-	seq_printf(s, "hop1_addr: 0x%llx\n", hop1_addr);
-	seq_printf(s, "hop1_pte_addr: 0x%llx\n", hop1_pte_addr);
-	seq_printf(s, "hop1_pte: 0x%llx\n", hop1_pte);
-
-	seq_printf(s, "hop2_addr: 0x%llx\n", hop2_addr);
-	seq_printf(s, "hop2_pte_addr: 0x%llx\n", hop2_pte_addr);
-	seq_printf(s, "hop2_pte: 0x%llx\n", hop2_pte);
-
-	seq_printf(s, "hop3_addr: 0x%llx\n", hop3_addr);
-	seq_printf(s, "hop3_pte_addr: 0x%llx\n", hop3_pte_addr);
-	seq_printf(s, "hop3_pte: 0x%llx\n", hop3_pte);
-
-	if (mmu_prop->num_hops == MMU_ARCH_5_HOPS) {
-		if (!(hop3_pte & LAST_MASK)) {
-			seq_printf(s, "hop4_addr: 0x%llx\n", hop4_addr);
-			seq_printf(s, "hop4_pte_addr: 0x%llx\n", hop4_pte_addr);
-			seq_printf(s, "hop4_pte: 0x%llx\n", hop4_pte);
-		}
-	} else {
-		seq_printf(s, "hop4_addr: 0x%llx\n", hop4_addr);
-		seq_printf(s, "hop4_pte_addr: 0x%llx\n", hop4_pte_addr);
-		seq_printf(s, "hop4_pte: 0x%llx\n", hop4_pte);
-
-		if (!(hop4_pte & LAST_MASK)) {
-			seq_printf(s, "hop5_addr: 0x%llx\n", hop5_addr);
-			seq_printf(s, "hop5_pte_addr: 0x%llx\n", hop5_pte_addr);
-			seq_printf(s, "hop5_pte: 0x%llx\n", hop5_pte);
-		}
+	for (i = 0 ; i < hops_info.used_hops ; i++) {
+		seq_printf(s, "hop%d_addr: 0x%llx\n",
+				i, hops_info.hop_info[i].hop_addr);
+		seq_printf(s, "hop%d_pte_addr: 0x%llx\n",
+				i, hops_info.hop_info[i].hop_pte_addr);
+		seq_printf(s, "hop%d_pte: 0x%llx\n",
+				i, hops_info.hop_info[i].hop_pte_val);
 	}
 
-	goto out;
-
-not_mapped:
-	dev_err(hdev->dev, "virt addr 0x%llx is not mapped to phys addr\n",
-			virt_addr);
-out:
-	mutex_unlock(&ctx->mmu_lock);
-
 	return 0;
 }
 
@@ -617,78 +431,20 @@ static int device_va_to_pa(struct hl_device *hdev, u64 virt_addr,
 				u64 *phys_addr)
 {
 	struct hl_ctx *ctx = hdev->compute_ctx;
-	struct asic_fixed_properties *prop = &hdev->asic_prop;
-	struct hl_mmu_properties *mmu_prop;
-	u64 hop_addr, hop_pte_addr, hop_pte;
-	u64 offset_mask = HOP4_MASK | FLAGS_MASK;
 	int rc = 0;
-	bool is_dram_addr;
 
 	if (!ctx) {
 		dev_err(hdev->dev, "no ctx available\n");
 		return -EINVAL;
 	}
 
-	is_dram_addr = hl_mem_area_inside_range(virt_addr, prop->dmmu.page_size,
-						prop->dmmu.start_addr,
-						prop->dmmu.end_addr);
-
-	/* shifts and masks are the same in PMMU and HPMMU, use one of them */
-	mmu_prop = is_dram_addr ? &prop->dmmu : &prop->pmmu;
-
-	mutex_lock(&ctx->mmu_lock);
-
-	/* hop 0 */
-	hop_addr = get_hop0_addr(ctx);
-	hop_pte_addr = get_hop0_pte_addr(ctx, mmu_prop, hop_addr, virt_addr);
-	hop_pte = hdev->asic_funcs->read_pte(hdev, hop_pte_addr);
-
-	/* hop 1 */
-	hop_addr = get_next_hop_addr(hop_pte);
-	if (hop_addr == ULLONG_MAX)
-		goto not_mapped;
-	hop_pte_addr = get_hop1_pte_addr(ctx, mmu_prop, hop_addr, virt_addr);
-	hop_pte = hdev->asic_funcs->read_pte(hdev, hop_pte_addr);
-
-	/* hop 2 */
-	hop_addr = get_next_hop_addr(hop_pte);
-	if (hop_addr == ULLONG_MAX)
-		goto not_mapped;
-	hop_pte_addr = get_hop2_pte_addr(ctx, mmu_prop, hop_addr, virt_addr);
-	hop_pte = hdev->asic_funcs->read_pte(hdev, hop_pte_addr);
-
-	/* hop 3 */
-	hop_addr = get_next_hop_addr(hop_pte);
-	if (hop_addr == ULLONG_MAX)
-		goto not_mapped;
-	hop_pte_addr = get_hop3_pte_addr(ctx, mmu_prop, hop_addr, virt_addr);
-	hop_pte = hdev->asic_funcs->read_pte(hdev, hop_pte_addr);
-
-	if (!(hop_pte & LAST_MASK)) {
-		/* hop 4 */
-		hop_addr = get_next_hop_addr(hop_pte);
-		if (hop_addr == ULLONG_MAX)
-			goto not_mapped;
-		hop_pte_addr = get_hop4_pte_addr(ctx, mmu_prop, hop_addr,
-							virt_addr);
-		hop_pte = hdev->asic_funcs->read_pte(hdev, hop_pte_addr);
-
-		offset_mask = FLAGS_MASK;
+	rc = hl_mmu_va_to_pa(ctx, virt_addr, phys_addr);
+	if (rc) {
+		dev_err(hdev->dev, "virt addr 0x%llx is not mapped to phys addr\n",
+				virt_addr);
+		rc = -EINVAL;
 	}
 
-	if (!(hop_pte & PAGE_PRESENT_MASK))
-		goto not_mapped;
-
-	*phys_addr = (hop_pte & ~offset_mask) | (virt_addr & offset_mask);
-
-	goto out;
-
-not_mapped:
-	dev_err(hdev->dev, "virt addr 0x%llx is not mapped to phys addr\n",
-			virt_addr);
-	rc = -EINVAL;
-out:
-	mutex_unlock(&ctx->mmu_lock);
 	return rc;
 }
 
diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index 76ab9741895d..b8ad5bfa6359 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -10,6 +10,7 @@
 
 #include "../include/common/cpucp_if.h"
 #include "../include/common/qman_if.h"
+#include "../include/hw_ip/mmu/mmu_general.h"
 #include <uapi/misc/habanalabs.h>
 
 #include <linux/cdev.h>
@@ -1661,6 +1662,32 @@ struct hl_mmu_priv {
 	struct hl_mmu_hr_priv hr;
 };
 
+/**
+ * struct hl_mmu_per_hop_info - A structure describing one TLB HOP and its entry
+ *                that was created in order to translate a virtual address to a
+ *                physical one.
+ * @hop_addr: The address of the hop.
+ * @hop_pte_addr: The address of the hop entry.
+ * @hop_pte_val: The value in the hop entry.
+ */
+struct hl_mmu_per_hop_info {
+	u64 hop_addr;
+	u64 hop_pte_addr;
+	u64 hop_pte_val;
+};
+
+/**
+ * struct hl_mmu_hop_info - A structure describing the TLB hops and their
+ * hop-entries that were created in order to translate a virtual address to a
+ * physical one.
+ * @hop_info: Array holding the per-hop information used for the translation.
+ * @used_hops: The number of hops used for the translation.
+ */
+struct hl_mmu_hop_info {
+	struct hl_mmu_per_hop_info hop_info[MMU_ARCH_5_HOPS];
+	u32 used_hops;
+};
+
 /**
  * struct hl_mmu_funcs - Device related MMU functions.
  * @init: initialize the MMU module.
@@ -1672,6 +1699,9 @@ struct hl_mmu_priv {
  * @flush: flush all writes from all cores to reach device MMU.
  * @swap_out: marks all mapping of the given context as swapped out.
  * @swap_in: marks all mapping of the given context as swapped in.
+ * @get_tlb_info: returns the list of hops and hop-entries used that were
+ *                created in order to translate the giver virtual address to a
+ *                physical one.
  */
 struct hl_mmu_funcs {
 	int (*init)(struct hl_device *hdev);
@@ -1686,6 +1716,8 @@ struct hl_mmu_funcs {
 	void (*flush)(struct hl_ctx *ctx);
 	void (*swap_out)(struct hl_ctx *ctx);
 	void (*swap_in)(struct hl_ctx *ctx);
+	int (*get_tlb_info)(struct hl_ctx *ctx,
+			u64 virt_addr, struct hl_mmu_hop_info *hops);
 };
 
 /**
@@ -2138,6 +2170,9 @@ void hl_mmu_swap_out(struct hl_ctx *ctx);
 void hl_mmu_swap_in(struct hl_ctx *ctx);
 int hl_mmu_if_set_funcs(struct hl_device *hdev);
 void hl_mmu_v1_set_funcs(struct hl_device *hdev, struct hl_mmu_funcs *mmu);
+int hl_mmu_va_to_pa(struct hl_ctx *ctx, u64 virt_addr, u64 *phys_addr);
+int hl_mmu_get_tlb_info(struct hl_ctx *ctx, u64 virt_addr,
+			struct hl_mmu_hop_info *hops);
 
 int hl_fw_load_fw_to_device(struct hl_device *hdev, const char *fw_name,
 				void __iomem *dst, u32 src_offset, u32 size);
diff --git a/drivers/misc/habanalabs/common/mmu.c b/drivers/misc/habanalabs/common/mmu.c
index f4b3d02fe0d8..7279c83cc081 100644
--- a/drivers/misc/habanalabs/common/mmu.c
+++ b/drivers/misc/habanalabs/common/mmu.c
@@ -342,6 +342,56 @@ void hl_mmu_swap_in(struct hl_ctx *ctx)
 		hdev->mmu_func[MMU_HR_PGT].swap_in(ctx);
 }
 
+int hl_mmu_va_to_pa(struct hl_ctx *ctx, u64 virt_addr, u64 *phys_addr)
+{
+	struct hl_mmu_hop_info hops;
+	u64 tmp_addr;
+	int rc;
+
+	rc = hl_mmu_get_tlb_info(ctx, virt_addr, &hops);
+	if (rc)
+		return rc;
+
+	/* last hop holds the phys address and flags */
+	tmp_addr = hops.hop_info[hops.used_hops - 1].hop_pte_val;
+	*phys_addr = (tmp_addr & HOP_PHYS_ADDR_MASK) | (virt_addr & FLAGS_MASK);
+
+	return 0;
+}
+
+int hl_mmu_get_tlb_info(struct hl_ctx *ctx, u64 virt_addr,
+			struct hl_mmu_hop_info *hops)
+{
+	struct hl_device *hdev = ctx->hdev;
+	struct asic_fixed_properties *prop = &hdev->asic_prop;
+	struct hl_mmu_properties *mmu_prop;
+	int rc;
+	bool is_dram_addr;
+
+	if (!hdev->mmu_enable)
+		return -EOPNOTSUPP;
+
+	is_dram_addr = hl_mem_area_inside_range(virt_addr, prop->dmmu.page_size,
+						prop->dmmu.start_addr,
+						prop->dmmu.end_addr);
+
+	/* host-residency is the same in PMMU and HPMMU, use one of them */
+	mmu_prop = is_dram_addr ? &prop->dmmu : &prop->pmmu;
+
+	mutex_lock(&ctx->mmu_lock);
+
+	if (mmu_prop->host_resident)
+		rc = hdev->mmu_func[MMU_HR_PGT].get_tlb_info(ctx,
+							virt_addr, hops);
+	else
+		rc = hdev->mmu_func[MMU_DR_PGT].get_tlb_info(ctx,
+							virt_addr, hops);
+
+	mutex_unlock(&ctx->mmu_lock);
+
+	return rc;
+}
+
 int hl_mmu_if_set_funcs(struct hl_device *hdev)
 {
 	if (!hdev->mmu_enable)
diff --git a/drivers/misc/habanalabs/common/mmu_v1.c b/drivers/misc/habanalabs/common/mmu_v1.c
index 92b22298bb5c..2ce6ea89d4fa 100644
--- a/drivers/misc/habanalabs/common/mmu_v1.c
+++ b/drivers/misc/habanalabs/common/mmu_v1.c
@@ -837,6 +837,107 @@ static void hl_mmu_v1_swap_in(struct hl_ctx *ctx)
 
 }
 
+static inline u64 get_hop_pte_addr(struct hl_ctx *ctx,
+				struct hl_mmu_properties *mmu_prop,
+				int hop_num, u64 hop_addr, u64 virt_addr)
+{
+	switch (hop_num) {
+	case 0:
+		return get_hop0_pte_addr(ctx, mmu_prop, hop_addr, virt_addr);
+	case 1:
+		return get_hop1_pte_addr(ctx, mmu_prop, hop_addr, virt_addr);
+	case 2:
+		return get_hop2_pte_addr(ctx, mmu_prop, hop_addr, virt_addr);
+	case 3:
+		return get_hop3_pte_addr(ctx, mmu_prop, hop_addr, virt_addr);
+	case 4:
+		return get_hop4_pte_addr(ctx, mmu_prop, hop_addr, virt_addr);
+	default:
+		break;
+	}
+	return U64_MAX;
+}
+
+static int hl_mmu_v1_get_tlb_info(struct hl_ctx *ctx, u64 virt_addr,
+				struct hl_mmu_hop_info *hops)
+{
+	struct hl_device *hdev = ctx->hdev;
+	struct asic_fixed_properties *prop = &hdev->asic_prop;
+	struct hl_mmu_properties *mmu_prop;
+	bool is_dram_addr, is_pmmu_addr, is_pmmu_h_addr, is_huge;
+	int i, used_hops;
+
+	is_dram_addr = hl_mem_area_inside_range(virt_addr, prop->dmmu.page_size,
+						prop->dmmu.start_addr,
+						prop->dmmu.end_addr);
+	is_pmmu_addr = hl_mem_area_inside_range(virt_addr, prop->pmmu.page_size,
+						prop->pmmu.start_addr,
+						prop->pmmu.end_addr);
+	is_pmmu_h_addr = hl_mem_area_inside_range(virt_addr,
+						prop->pmmu_huge.page_size,
+						prop->pmmu_huge.start_addr,
+						prop->pmmu_huge.end_addr);
+	if (is_dram_addr) {
+		mmu_prop = &prop->dmmu;
+		is_huge = true;
+	} else if (is_pmmu_addr) {
+		mmu_prop = &prop->pmmu;
+		is_huge = false;
+	} else if (is_pmmu_h_addr) {
+		mmu_prop = &prop->pmmu_huge;
+		is_huge = true;
+	} else {
+		return -EINVAL;
+	}
+
+	used_hops = mmu_prop->num_hops;
+
+	/* huge pages use lesser hops */
+	if (is_huge)
+		used_hops--;
+
+	hops->hop_info[0].hop_addr = get_phys_hop0_addr(ctx);
+	hops->hop_info[0].hop_pte_addr =
+			get_hop_pte_addr(ctx, mmu_prop, 0,
+					hops->hop_info[0].hop_addr, virt_addr);
+	hops->hop_info[0].hop_pte_val =
+			hdev->asic_funcs->read_pte(hdev,
+						hops->hop_info[0].hop_pte_addr);
+
+	for (i = 1 ; i < used_hops ; i++) {
+		hops->hop_info[i].hop_addr =
+			get_next_hop_addr(ctx,
+					hops->hop_info[i - 1].hop_pte_val);
+		if (hops->hop_info[i].hop_addr == ULLONG_MAX)
+			return -EFAULT;
+
+		hops->hop_info[i].hop_pte_addr =
+				get_hop_pte_addr(ctx, mmu_prop, i,
+						hops->hop_info[i].hop_addr,
+						virt_addr);
+		hops->hop_info[i].hop_pte_val =
+				hdev->asic_funcs->read_pte(hdev,
+						hops->hop_info[i].hop_pte_addr);
+
+		if (!(hops->hop_info[i].hop_pte_val & PAGE_PRESENT_MASK))
+			return -EFAULT;
+
+		if (hops->hop_info[i].hop_pte_val & LAST_MASK)
+			break;
+	}
+
+	/* if passed over all hops then no last hop was found */
+	if (i == mmu_prop->num_hops)
+		return -EFAULT;
+
+	if (!(hops->hop_info[i].hop_pte_val & PAGE_PRESENT_MASK))
+		return -EFAULT;
+
+	hops->used_hops = i + 1;
+
+	return 0;
+}
+
 /*
  * hl_mmu_v1_prepare - prepare mmu  for working with mmu v1
  *
@@ -853,4 +954,5 @@ void hl_mmu_v1_set_funcs(struct hl_device *hdev, struct hl_mmu_funcs *mmu)
 	mmu->flush = flush;
 	mmu->swap_out = hl_mmu_v1_swap_out;
 	mmu->swap_in = hl_mmu_v1_swap_in;
+	mmu->get_tlb_info = hl_mmu_v1_get_tlb_info;
 }
-- 
2.17.1

