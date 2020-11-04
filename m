Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9489D2A6154
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 11:14:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729292AbgKDKOq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 05:14:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:50256 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729059AbgKDKOj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 05:14:39 -0500
Received: from ogabbay-VM.habana-labs.com (unknown [213.57.90.10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 17495223AB;
        Wed,  4 Nov 2020 10:14:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604484878;
        bh=bdR7Unn2X0qPJ7Hx3kL79kl7gPJZJ3F4d2NDBB7j+lw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yzxfb16lybY0xGI/j7sqgVz62xTIiHy2KHL3hGZKO+YbRwb/QcT8gZ537q5qf90R9
         KZcPikl6s+TtXJHPy633Qcjm95XfZNC7MSsk2FRqVNBsA6NtPEV/B9XPXgBPU8OqpU
         9KhtW5m8dxqRYiloESPyCWi/ws8JufrEYfaliRLE=
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     SW_Drivers@habana.ai, Moti Haimovski <mhaimovski@habana.ai>
Subject: [PATCH] habanalabs: refactor MMU to support dual residency MMU
Date:   Wed,  4 Nov 2020 12:14:28 +0200
Message-Id: <20201104101429.15594-3-ogabbay@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201104101429.15594-1-ogabbay@kernel.org>
References: <20201104101429.15594-1-ogabbay@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Moti Haimovski <mhaimovski@habana.ai>

This commit refactors the MMU code to support PCI MMU page tables
residing on host and DCORE MMU residing on the device DRAM at the
same time.

This is needed for future devices as on GAUDI and GOYA we have
a single MMU where its page tables always reside on DRAM.

Signed-off-by: Moti Haimovski <mhaimovski@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/habanalabs.h |  57 ++++++++++-
 drivers/misc/habanalabs/common/mmu.c        | 105 ++++++++++++++------
 drivers/misc/habanalabs/common/mmu_v1.c     |  28 +++---
 3 files changed, 143 insertions(+), 47 deletions(-)

diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index 54600443ebc7..fee68fc121d7 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -61,6 +61,18 @@
 /* MMU */
 #define MMU_HASH_TABLE_BITS		7 /* 1 << 7 buckets */
 
+/**
+ * enum hl_mmu_page_table_locaion - mmu page table location
+ * @MMU_DR_PGT: page-table is located on device DRAM.
+ * @MMU_HR_PGT: page-table is located on host memory.
+ * @MMU_NUM_PGT_LOCATIONS: number of page-table locations currently supported.
+ */
+enum hl_mmu_page_table_location {
+	MMU_DR_PGT = 0,		/* device-dram-resident MMU PGT */
+	MMU_HR_PGT,		/* host resident MMU PGT */
+	MMU_NUM_PGT_LOCATIONS	/* num of PGT locations */
+};
+
 /*
  * HL_RSVD_SOBS 'sync stream' reserved sync objects per QMAN stream
  * HL_RSVD_MONS 'sync stream' reserved monitors per QMAN stream
@@ -303,6 +315,8 @@ enum hl_device_hw_state {
  * @hop5_mask: mask to get the PTE address in hop 5.
  * @page_size: default page size used to allocate memory.
  * @num_hops: The amount of hops supported by the translation table.
+ * @host_resident: Should the MMU page table reside in host memory or in the
+ *                 device DRAM.
  */
 struct hl_mmu_properties {
 	u64	start_addr;
@@ -321,6 +335,7 @@ struct hl_mmu_properties {
 	u64	hop5_mask;
 	u32	page_size;
 	u32	num_hops;
+	u8	host_resident;
 };
 
 /**
@@ -1572,17 +1587,51 @@ struct hl_device_idle_busy_ts {
 	ktime_t				busy_to_idle_ts;
 };
 
+/**
+ * struct hr_mmu_hop_addrs - used for holding per-device host-resident mmu hop
+ * information.
+ * @virt_addr: the virtual address of the hop.
+ * @phys-addr: the physical address of the hop (used by the device-mmu).
+ * @shadow_addr: The shadow of the hop used by the driver for walking the hops.
+ */
+struct hr_mmu_hop_addrs {
+	u64 virt_addr;
+	u64 phys_addr;
+	u64 shadow_addr;
+};
 
 /**
- * struct hl_mmu_priv - used for holding per-device mmu internal information.
+ * struct hl_mmu_hr_pgt_priv - used for holding per-device mmu host-resident
+ * page-table internal information.
  * @mmu_pgt_pool: pool of page tables used by MMU for allocating hops.
  * @mmu_shadow_hop0: shadow array of hop0 tables.
  */
-struct hl_mmu_priv {
+struct hl_mmu_hr_priv {
+	struct gen_pool *mmu_pgt_pool;
+	struct hr_mmu_hop_addrs *mmu_shadow_hop0;
+};
+
+/**
+ * struct hl_mmu_dr_pgt_priv - used for holding per-device mmu device-resident
+ * page-table internal information.
+ * @mmu_pgt_pool: pool of page tables used by MMU for allocating hops.
+ * @mmu_shadow_hop0: shadow array of hop0 tables.
+ */
+struct hl_mmu_dr_priv {
 	struct gen_pool *mmu_pgt_pool;
 	void *mmu_shadow_hop0;
 };
 
+/**
+ * struct hl_mmu_priv - used for holding per-device mmu internal information.
+ * @dr: information on the device-resident MMU, when exists.
+ * @hr: information on the host-resident MMU, when exists.
+ */
+struct hl_mmu_priv {
+	struct hl_mmu_dr_priv dr;
+	struct hl_mmu_hr_priv hr;
+};
+
 /**
  * struct hl_mmu_funcs - Device related MMU functions.
  * @init: initialize the MMU module.
@@ -1779,7 +1828,7 @@ struct hl_device {
 	struct hl_cs_counters_atomic	aggregated_cs_counters;
 
 	struct hl_mmu_priv		mmu_priv;
-	struct hl_mmu_funcs		mmu_func;
+	struct hl_mmu_funcs		mmu_func[MMU_NUM_PGT_LOCATIONS];
 
 	atomic64_t			dram_used_mem;
 	u64				timeout_jiffies;
@@ -2042,7 +2091,7 @@ int hl_mmu_unmap(struct hl_ctx *ctx, u64 virt_addr, u32 page_size,
 void hl_mmu_swap_out(struct hl_ctx *ctx);
 void hl_mmu_swap_in(struct hl_ctx *ctx);
 int hl_mmu_if_set_funcs(struct hl_device *hdev);
-void hl_mmu_v1_set_funcs(struct hl_device *hdev);
+void hl_mmu_v1_set_funcs(struct hl_device *hdev, struct hl_mmu_funcs *mmu);
 
 int hl_fw_load_fw_to_device(struct hl_device *hdev, const char *fw_name,
 				void __iomem *dst, u32 src_offset, u32 size);
diff --git a/drivers/misc/habanalabs/common/mmu.c b/drivers/misc/habanalabs/common/mmu.c
index 451148959431..6f535c81478d 100644
--- a/drivers/misc/habanalabs/common/mmu.c
+++ b/drivers/misc/habanalabs/common/mmu.c
@@ -22,18 +22,25 @@ static bool is_dram_va(struct hl_device *hdev, u64 virt_addr)
  * hl_mmu_init() - initialize the MMU module.
  * @hdev: habanalabs device structure.
  *
- * This function does the following:
- * - Create a pool of pages for pgt_infos.
- * - Create a shadow table for pgt
- *
  * Return: 0 for success, non-zero for failure.
  */
 int hl_mmu_init(struct hl_device *hdev)
 {
-	if (hdev->mmu_enable)
-		return hdev->mmu_func.init(hdev);
+	int rc = -EOPNOTSUPP;
 
-	return 0;
+	if (!hdev->mmu_enable)
+		return 0;
+
+	if (hdev->mmu_func[MMU_DR_PGT].init != NULL) {
+		rc = hdev->mmu_func[MMU_DR_PGT].init(hdev);
+		if (rc)
+			return rc;
+	}
+
+	if (hdev->mmu_func[MMU_HR_PGT].init != NULL)
+		rc = hdev->mmu_func[MMU_HR_PGT].init(hdev);
+
+	return rc;
 }
 
 /**
@@ -48,8 +55,14 @@ int hl_mmu_init(struct hl_device *hdev)
  */
 void hl_mmu_fini(struct hl_device *hdev)
 {
-	if (hdev->mmu_enable)
-		hdev->mmu_func.fini(hdev);
+	if (!hdev->mmu_enable)
+		return;
+
+	if (hdev->mmu_func[MMU_DR_PGT].fini != NULL)
+		hdev->mmu_func[MMU_DR_PGT].fini(hdev);
+
+	if (hdev->mmu_func[MMU_HR_PGT].fini != NULL)
+		hdev->mmu_func[MMU_HR_PGT].fini(hdev);
 }
 
 /**
@@ -63,11 +76,21 @@ void hl_mmu_fini(struct hl_device *hdev)
 int hl_mmu_ctx_init(struct hl_ctx *ctx)
 {
 	struct hl_device *hdev = ctx->hdev;
+	int rc = -EOPNOTSUPP;
 
-	if (hdev->mmu_enable)
-		return hdev->mmu_func.ctx_init(ctx);
+	if (!hdev->mmu_enable)
+		return 0;
 
-	return 0;
+	if (hdev->mmu_func[MMU_DR_PGT].ctx_init != NULL) {
+		rc = hdev->mmu_func[MMU_DR_PGT].ctx_init(ctx);
+		if (rc)
+			return rc;
+	}
+
+	if (hdev->mmu_func[MMU_HR_PGT].ctx_init != NULL)
+		rc = hdev->mmu_func[MMU_HR_PGT].ctx_init(ctx);
+
+	return rc;
 }
 
 /*
@@ -84,8 +107,14 @@ void hl_mmu_ctx_fini(struct hl_ctx *ctx)
 {
 	struct hl_device *hdev = ctx->hdev;
 
-	if (hdev->mmu_enable)
-		hdev->mmu_func.ctx_fini(ctx);
+	if (!hdev->mmu_enable)
+		return;
+
+	if (hdev->mmu_func[MMU_DR_PGT].ctx_fini != NULL)
+		hdev->mmu_func[MMU_DR_PGT].ctx_fini(ctx);
+
+	if (hdev->mmu_func[MMU_HR_PGT].ctx_fini != NULL)
+		hdev->mmu_func[MMU_HR_PGT].ctx_fini(ctx);
 }
 
 /*
@@ -117,7 +146,7 @@ int hl_mmu_unmap(struct hl_ctx *ctx, u64 virt_addr, u32 page_size,
 	struct hl_mmu_properties *mmu_prop;
 	u64 real_virt_addr;
 	u32 real_page_size, npages;
-	int i, rc = 0;
+	int i, rc = 0, pgt_residency;
 	bool is_dram_addr;
 
 	if (!hdev->mmu_enable)
@@ -132,6 +161,8 @@ int hl_mmu_unmap(struct hl_ctx *ctx, u64 virt_addr, u32 page_size,
 	else
 		mmu_prop = &prop->pmmu;
 
+	pgt_residency = mmu_prop->host_resident ? MMU_HR_PGT : MMU_DR_PGT;
+
 	/*
 	 * The H/W handles mapping of specific page sizes. Hence if the page
 	 * size is bigger, we break it to sub-pages and unmap them separately.
@@ -150,7 +181,8 @@ int hl_mmu_unmap(struct hl_ctx *ctx, u64 virt_addr, u32 page_size,
 	real_virt_addr = virt_addr;
 
 	for (i = 0 ; i < npages ; i++) {
-		rc = hdev->mmu_func.unmap(ctx, real_virt_addr, is_dram_addr);
+		rc = hdev->mmu_func[pgt_residency].unmap(ctx,
+						real_virt_addr, is_dram_addr);
 		if (rc)
 			break;
 
@@ -158,7 +190,7 @@ int hl_mmu_unmap(struct hl_ctx *ctx, u64 virt_addr, u32 page_size,
 	}
 
 	if (flush_pte)
-		hdev->mmu_func.flush(ctx);
+		hdev->mmu_func[pgt_residency].flush(ctx);
 
 	return rc;
 }
@@ -193,9 +225,10 @@ int hl_mmu_map(struct hl_ctx *ctx, u64 virt_addr, u64 phys_addr, u32 page_size,
 	struct hl_mmu_properties *mmu_prop;
 	u64 real_virt_addr, real_phys_addr;
 	u32 real_page_size, npages;
-	int i, rc, mapped_cnt = 0;
+	int i, rc, pgt_residency, mapped_cnt = 0;
 	bool is_dram_addr;
 
+
 	if (!hdev->mmu_enable)
 		return 0;
 
@@ -208,6 +241,8 @@ int hl_mmu_map(struct hl_ctx *ctx, u64 virt_addr, u64 phys_addr, u32 page_size,
 	else
 		mmu_prop = &prop->pmmu;
 
+	pgt_residency = mmu_prop->host_resident ? MMU_HR_PGT : MMU_DR_PGT;
+
 	/*
 	 * The H/W handles mapping of specific page sizes. Hence if the page
 	 * size is bigger, we break it to sub-pages and map them separately.
@@ -231,8 +266,9 @@ int hl_mmu_map(struct hl_ctx *ctx, u64 virt_addr, u64 phys_addr, u32 page_size,
 	real_phys_addr = phys_addr;
 
 	for (i = 0 ; i < npages ; i++) {
-		rc = hdev->mmu_func.map(ctx, real_virt_addr, real_phys_addr,
-				real_page_size, is_dram_addr);
+		rc = hdev->mmu_func[pgt_residency].map(ctx,
+						real_virt_addr, real_phys_addr,
+						real_page_size, is_dram_addr);
 		if (rc)
 			goto err;
 
@@ -242,21 +278,22 @@ int hl_mmu_map(struct hl_ctx *ctx, u64 virt_addr, u64 phys_addr, u32 page_size,
 	}
 
 	if (flush_pte)
-		hdev->mmu_func.flush(ctx);
+		hdev->mmu_func[pgt_residency].flush(ctx);
 
 	return 0;
 
 err:
 	real_virt_addr = virt_addr;
 	for (i = 0 ; i < mapped_cnt ; i++) {
-		if (hdev->mmu_func.unmap(ctx, real_virt_addr, is_dram_addr))
+		if (hdev->mmu_func[pgt_residency].unmap(ctx,
+						real_virt_addr, is_dram_addr))
 			dev_warn_ratelimited(hdev->dev,
 				"failed to unmap va: 0x%llx\n", real_virt_addr);
 
 		real_virt_addr += real_page_size;
 	}
 
-	hdev->mmu_func.flush(ctx);
+	hdev->mmu_func[pgt_residency].flush(ctx);
 
 	return rc;
 }
@@ -271,8 +308,14 @@ void hl_mmu_swap_out(struct hl_ctx *ctx)
 {
 	struct hl_device *hdev = ctx->hdev;
 
-	if (hdev->mmu_enable)
-		hdev->mmu_func.swap_out(ctx);
+	if (!hdev->mmu_enable)
+		return;
+
+	if (hdev->mmu_func[MMU_DR_PGT].swap_out != NULL)
+		hdev->mmu_func[MMU_DR_PGT].swap_out(ctx);
+
+	if (hdev->mmu_func[MMU_HR_PGT].swap_out != NULL)
+		hdev->mmu_func[MMU_HR_PGT].swap_out(ctx);
 }
 
 /*
@@ -285,8 +328,14 @@ void hl_mmu_swap_in(struct hl_ctx *ctx)
 {
 	struct hl_device *hdev = ctx->hdev;
 
-	if (hdev->mmu_enable)
-		hdev->mmu_func.swap_in(ctx);
+	if (!hdev->mmu_enable)
+		return;
+
+	if (hdev->mmu_func[MMU_DR_PGT].swap_in != NULL)
+		hdev->mmu_func[MMU_DR_PGT].swap_in(ctx);
+
+	if (hdev->mmu_func[MMU_HR_PGT].swap_in != NULL)
+		hdev->mmu_func[MMU_HR_PGT].swap_in(ctx);
 }
 
 int hl_mmu_if_set_funcs(struct hl_device *hdev)
@@ -297,7 +346,7 @@ int hl_mmu_if_set_funcs(struct hl_device *hdev)
 	switch (hdev->asic_type) {
 	case ASIC_GOYA:
 	case ASIC_GAUDI:
-		hl_mmu_v1_set_funcs(hdev);
+		hl_mmu_v1_set_funcs(hdev, &hdev->mmu_func[MMU_DR_PGT]);
 		break;
 	default:
 		dev_err(hdev->dev, "Unrecognized ASIC type %d\n",
diff --git a/drivers/misc/habanalabs/common/mmu_v1.c b/drivers/misc/habanalabs/common/mmu_v1.c
index 8d1eb5265419..ec7e8a3c37b8 100644
--- a/drivers/misc/habanalabs/common/mmu_v1.c
+++ b/drivers/misc/habanalabs/common/mmu_v1.c
@@ -29,7 +29,7 @@ static void _free_hop(struct hl_ctx *ctx, struct pgt_info *pgt_info)
 {
 	struct hl_device *hdev = ctx->hdev;
 
-	gen_pool_free(hdev->mmu_priv.mmu_pgt_pool, pgt_info->phys_addr,
+	gen_pool_free(hdev->mmu_priv.dr.mmu_pgt_pool, pgt_info->phys_addr,
 			hdev->asic_prop.mmu_hop_table_size);
 	hash_del(&pgt_info->node);
 	kfree((u64 *) (uintptr_t) pgt_info->shadow_addr);
@@ -54,7 +54,7 @@ static u64 alloc_hop(struct hl_ctx *ctx)
 	if (!pgt_info)
 		return ULLONG_MAX;
 
-	phys_addr = (u64) gen_pool_alloc(hdev->mmu_priv.mmu_pgt_pool,
+	phys_addr = (u64) gen_pool_alloc(hdev->mmu_priv.dr.mmu_pgt_pool,
 					prop->mmu_hop_table_size);
 	if (!phys_addr) {
 		dev_err(hdev->dev, "failed to allocate page\n");
@@ -75,7 +75,7 @@ static u64 alloc_hop(struct hl_ctx *ctx)
 	return shadow_addr;
 
 shadow_err:
-	gen_pool_free(hdev->mmu_priv.mmu_pgt_pool, phys_addr,
+	gen_pool_free(hdev->mmu_priv.dr.mmu_pgt_pool, phys_addr,
 			prop->mmu_hop_table_size);
 pool_add_err:
 	kfree(pgt_info);
@@ -91,7 +91,7 @@ static inline u64 get_phys_hop0_addr(struct hl_ctx *ctx)
 
 static inline u64 get_hop0_addr(struct hl_ctx *ctx)
 {
-	return (u64) (uintptr_t) ctx->hdev->mmu_priv.mmu_shadow_hop0 +
+	return (u64) (uintptr_t) ctx->hdev->mmu_priv.dr.mmu_shadow_hop0 +
 			(ctx->asid * ctx->hdev->asic_prop.mmu_hop_table_size);
 }
 
@@ -419,15 +419,15 @@ static int hl_mmu_v1_init(struct hl_device *hdev)
 	struct asic_fixed_properties *prop = &hdev->asic_prop;
 	int rc;
 
-	hdev->mmu_priv.mmu_pgt_pool =
+	hdev->mmu_priv.dr.mmu_pgt_pool =
 			gen_pool_create(__ffs(prop->mmu_hop_table_size), -1);
 
-	if (!hdev->mmu_priv.mmu_pgt_pool) {
+	if (!hdev->mmu_priv.dr.mmu_pgt_pool) {
 		dev_err(hdev->dev, "Failed to create page gen pool\n");
 		return -ENOMEM;
 	}
 
-	rc = gen_pool_add(hdev->mmu_priv.mmu_pgt_pool, prop->mmu_pgt_addr +
+	rc = gen_pool_add(hdev->mmu_priv.dr.mmu_pgt_pool, prop->mmu_pgt_addr +
 			prop->mmu_hop0_tables_total_size,
 			prop->mmu_pgt_size - prop->mmu_hop0_tables_total_size,
 			-1);
@@ -436,10 +436,10 @@ static int hl_mmu_v1_init(struct hl_device *hdev)
 		goto err_pool_add;
 	}
 
-	hdev->mmu_priv.mmu_shadow_hop0 = kvmalloc_array(prop->max_asid,
+	hdev->mmu_priv.dr.mmu_shadow_hop0 = kvmalloc_array(prop->max_asid,
 						prop->mmu_hop_table_size,
 						GFP_KERNEL | __GFP_ZERO);
-	if (ZERO_OR_NULL_PTR(hdev->mmu_priv.mmu_shadow_hop0)) {
+	if (ZERO_OR_NULL_PTR(hdev->mmu_priv.dr.mmu_shadow_hop0)) {
 		rc = -ENOMEM;
 		goto err_pool_add;
 	}
@@ -449,7 +449,7 @@ static int hl_mmu_v1_init(struct hl_device *hdev)
 	return 0;
 
 err_pool_add:
-	gen_pool_destroy(hdev->mmu_priv.mmu_pgt_pool);
+	gen_pool_destroy(hdev->mmu_priv.dr.mmu_pgt_pool);
 
 	return rc;
 }
@@ -468,8 +468,8 @@ static void hl_mmu_v1_fini(struct hl_device *hdev)
 {
 	/* MMU H/W fini was already done in device hw_fini() */
 
-	kvfree(hdev->mmu_priv.mmu_shadow_hop0);
-	gen_pool_destroy(hdev->mmu_priv.mmu_pgt_pool);
+	kvfree(hdev->mmu_priv.dr.mmu_shadow_hop0);
+	gen_pool_destroy(hdev->mmu_priv.dr.mmu_pgt_pool);
 }
 
 /**
@@ -847,10 +847,8 @@ static void hl_mmu_v1_swap_in(struct hl_ctx *ctx)
  *
  * @hdev: pointer to the device structure
  */
-void hl_mmu_v1_set_funcs(struct hl_device *hdev)
+void hl_mmu_v1_set_funcs(struct hl_device *hdev, struct hl_mmu_funcs *mmu)
 {
-	struct hl_mmu_funcs *mmu = &hdev->mmu_func;
-
 	mmu->init = hl_mmu_v1_init;
 	mmu->fini = hl_mmu_v1_fini;
 	mmu->ctx_init = hl_mmu_v1_ctx_init;
-- 
2.17.1

