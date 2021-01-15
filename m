Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A630B2F7879
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 13:15:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728609AbhAOMOp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 07:14:45 -0500
Received: from foss.arm.com ([217.140.110.172]:37450 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725910AbhAOMOo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 07:14:44 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 829EDED1;
        Fri, 15 Jan 2021 04:13:57 -0800 (PST)
Received: from usa.arm.com (a074945.blr.arm.com [10.162.16.71])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id BD83A3F70D;
        Fri, 15 Jan 2021 04:13:52 -0800 (PST)
From:   Vivek Gautam <vivek.gautam@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org,
        virtualization@lists.linux-foundation.org
Cc:     joro@8bytes.org, will.deacon@arm.com, mst@redhat.com,
        robin.murphy@arm.com, jean-philippe@linaro.org,
        eric.auger@redhat.com, alex.williamson@redhat.com,
        kevin.tian@intel.com, jacob.jun.pan@linux.intel.com,
        yi.l.liu@intel.com, lorenzo.pieralisi@arm.com,
        shameerali.kolothum.thodi@huawei.com, vivek.gautam@arm.com
Subject: [PATCH RFC v1 01/15] iommu/arm-smmu-v3: Create a Context Descriptor library
Date:   Fri, 15 Jan 2021 17:43:28 +0530
Message-Id: <20210115121342.15093-2-vivek.gautam@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210115121342.15093-1-vivek.gautam@arm.com>
References: <20210115121342.15093-1-vivek.gautam@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Para-virtualized iommu drivers in guest may require to create and manage
context descriptor (CD) tables as part of PASID table allocations.
The PASID tables are passed to host to configure stage-1 tables in
hardware.
Make way for a library driver for CD management to allow para-
virtualized iommu driver call such code.

Signed-off-by: Vivek Gautam <vivek.gautam@arm.com>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc: Eric Auger <eric.auger@redhat.com>
Cc: Alex Williamson <alex.williamson@redhat.com>
Cc: Kevin Tian <kevin.tian@intel.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Liu Yi L <yi.l.liu@intel.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
---
 drivers/iommu/arm/arm-smmu-v3/Makefile        |   2 +-
 .../arm/arm-smmu-v3/arm-smmu-v3-cd-lib.c      | 223 ++++++++++++++++++
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 216 +----------------
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |   3 +
 4 files changed, 228 insertions(+), 216 deletions(-)
 create mode 100644 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-cd-lib.c

diff --git a/drivers/iommu/arm/arm-smmu-v3/Makefile b/drivers/iommu/arm/arm-smmu-v3/Makefile
index 54feb1ecccad..ca1a05b8b8ad 100644
--- a/drivers/iommu/arm/arm-smmu-v3/Makefile
+++ b/drivers/iommu/arm/arm-smmu-v3/Makefile
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_ARM_SMMU_V3) += arm_smmu_v3.o
-arm_smmu_v3-objs-y += arm-smmu-v3.o
+arm_smmu_v3-objs-y += arm-smmu-v3.o arm-smmu-v3-cd-lib.o
 arm_smmu_v3-objs-$(CONFIG_ARM_SMMU_V3_SVA) += arm-smmu-v3-sva.o
 arm_smmu_v3-objs := $(arm_smmu_v3-objs-y)
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-cd-lib.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-cd-lib.c
new file mode 100644
index 000000000000..97d1786a8a70
--- /dev/null
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-cd-lib.c
@@ -0,0 +1,223 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * arm-smmu-v3 context descriptor handling library driver
+ *
+ * Copyright (C) 2021 Arm Ltd.
+ */
+
+#include <linux/dma-iommu.h>
+
+#include "arm-smmu-v3.h"
+
+static int arm_smmu_alloc_cd_leaf_table(struct arm_smmu_device *smmu,
+					struct arm_smmu_l1_ctx_desc *l1_desc)
+{
+	size_t size = CTXDESC_L2_ENTRIES * (CTXDESC_CD_DWORDS << 3);
+
+	l1_desc->l2ptr = dmam_alloc_coherent(smmu->dev, size,
+					     &l1_desc->l2ptr_dma, GFP_KERNEL);
+	if (!l1_desc->l2ptr) {
+		dev_warn(smmu->dev,
+			 "failed to allocate context descriptor table\n");
+		return -ENOMEM;
+	}
+	return 0;
+}
+
+static void arm_smmu_write_cd_l1_desc(__le64 *dst,
+				      struct arm_smmu_l1_ctx_desc *l1_desc)
+{
+	u64 val = (l1_desc->l2ptr_dma & CTXDESC_L1_DESC_L2PTR_MASK) |
+		  CTXDESC_L1_DESC_V;
+
+	/* See comment in arm_smmu_write_ctx_desc() */
+	WRITE_ONCE(*dst, cpu_to_le64(val));
+}
+
+static __le64 *arm_smmu_get_cd_ptr(struct arm_smmu_domain *smmu_domain,
+				   u32 ssid)
+{
+	__le64 *l1ptr;
+	unsigned int idx;
+	struct arm_smmu_l1_ctx_desc *l1_desc;
+	struct arm_smmu_device *smmu = smmu_domain->smmu;
+	struct arm_smmu_ctx_desc_cfg *cdcfg = &smmu_domain->s1_cfg.cdcfg;
+
+	if (smmu_domain->s1_cfg.s1fmt == STRTAB_STE_0_S1FMT_LINEAR)
+		return cdcfg->cdtab + ssid * CTXDESC_CD_DWORDS;
+
+	idx = ssid >> CTXDESC_SPLIT;
+	l1_desc = &cdcfg->l1_desc[idx];
+	if (!l1_desc->l2ptr) {
+		if (arm_smmu_alloc_cd_leaf_table(smmu, l1_desc))
+			return NULL;
+
+		l1ptr = cdcfg->cdtab + idx * CTXDESC_L1_DESC_DWORDS;
+		arm_smmu_write_cd_l1_desc(l1ptr, l1_desc);
+		/* An invalid L1CD can be cached */
+		arm_smmu_sync_cd(smmu_domain, ssid, false);
+	}
+	idx = ssid & (CTXDESC_L2_ENTRIES - 1);
+	return l1_desc->l2ptr + idx * CTXDESC_CD_DWORDS;
+}
+
+int arm_smmu_write_ctx_desc(struct arm_smmu_domain *smmu_domain, int ssid,
+			    struct arm_smmu_ctx_desc *cd)
+{
+	/*
+	 * This function handles the following cases:
+	 *
+	 * (1) Install primary CD, for normal DMA traffic (SSID = 0).
+	 * (2) Install a secondary CD, for SID+SSID traffic.
+	 * (3) Update ASID of a CD. Atomically write the first 64 bits of the
+	 *     CD, then invalidate the old entry and mappings.
+	 * (4) Quiesce the context without clearing the valid bit. Disable
+	 *     translation, and ignore any translation fault.
+	 * (5) Remove a secondary CD.
+	 */
+	u64 val;
+	bool cd_live;
+	__le64 *cdptr;
+	struct arm_smmu_device *smmu = smmu_domain->smmu;
+
+	if (WARN_ON(ssid >= (1 << smmu_domain->s1_cfg.s1cdmax)))
+		return -E2BIG;
+
+	cdptr = arm_smmu_get_cd_ptr(smmu_domain, ssid);
+	if (!cdptr)
+		return -ENOMEM;
+
+	val = le64_to_cpu(cdptr[0]);
+	cd_live = !!(val & CTXDESC_CD_0_V);
+
+	if (!cd) { /* (5) */
+		val = 0;
+	} else if (cd == &quiet_cd) { /* (4) */
+		val |= CTXDESC_CD_0_TCR_EPD0;
+	} else if (cd_live) { /* (3) */
+		val &= ~CTXDESC_CD_0_ASID;
+		val |= FIELD_PREP(CTXDESC_CD_0_ASID, cd->asid);
+		/*
+		 * Until CD+TLB invalidation, both ASIDs may be used for tagging
+		 * this substream's traffic
+		 */
+	} else { /* (1) and (2) */
+		cdptr[1] = cpu_to_le64(cd->ttbr & CTXDESC_CD_1_TTB0_MASK);
+		cdptr[2] = 0;
+		cdptr[3] = cpu_to_le64(cd->mair);
+
+		/*
+		 * STE is live, and the SMMU might read dwords of this CD in any
+		 * order. Ensure that it observes valid values before reading
+		 * V=1.
+		 */
+		arm_smmu_sync_cd(smmu_domain, ssid, true);
+
+		val = cd->tcr |
+#ifdef __BIG_ENDIAN
+			CTXDESC_CD_0_ENDI |
+#endif
+			CTXDESC_CD_0_R | CTXDESC_CD_0_A |
+			(cd->mm ? 0 : CTXDESC_CD_0_ASET) |
+			CTXDESC_CD_0_AA64 |
+			FIELD_PREP(CTXDESC_CD_0_ASID, cd->asid) |
+			CTXDESC_CD_0_V;
+
+		/* STALL_MODEL==0b10 && CD.S==0 is ILLEGAL */
+		if (smmu->features & ARM_SMMU_FEAT_STALL_FORCE)
+			val |= CTXDESC_CD_0_S;
+	}
+
+	/*
+	 * The SMMU accesses 64-bit values atomically. See IHI0070Ca 3.21.3
+	 * "Configuration structures and configuration invalidation completion"
+	 *
+	 *   The size of single-copy atomic reads made by the SMMU is
+	 *   IMPLEMENTATION DEFINED but must be at least 64 bits. Any single
+	 *   field within an aligned 64-bit span of a structure can be altered
+	 *   without first making the structure invalid.
+	 */
+	WRITE_ONCE(cdptr[0], cpu_to_le64(val));
+	arm_smmu_sync_cd(smmu_domain, ssid, true);
+	return 0;
+}
+
+int arm_smmu_alloc_cd_tables(struct arm_smmu_domain *smmu_domain)
+{
+	int ret;
+	size_t l1size;
+	size_t max_contexts;
+	struct arm_smmu_device *smmu = smmu_domain->smmu;
+	struct arm_smmu_s1_cfg *cfg = &smmu_domain->s1_cfg;
+	struct arm_smmu_ctx_desc_cfg *cdcfg = &cfg->cdcfg;
+
+	max_contexts = 1 << cfg->s1cdmax;
+
+	if (!(smmu->features & ARM_SMMU_FEAT_2_LVL_CDTAB) ||
+	    max_contexts <= CTXDESC_L2_ENTRIES) {
+		cfg->s1fmt = STRTAB_STE_0_S1FMT_LINEAR;
+		cdcfg->num_l1_ents = max_contexts;
+
+		l1size = max_contexts * (CTXDESC_CD_DWORDS << 3);
+	} else {
+		cfg->s1fmt = STRTAB_STE_0_S1FMT_64K_L2;
+		cdcfg->num_l1_ents = DIV_ROUND_UP(max_contexts,
+						  CTXDESC_L2_ENTRIES);
+
+		cdcfg->l1_desc = devm_kcalloc(smmu->dev, cdcfg->num_l1_ents,
+					      sizeof(*cdcfg->l1_desc),
+					      GFP_KERNEL);
+		if (!cdcfg->l1_desc)
+			return -ENOMEM;
+
+		l1size = cdcfg->num_l1_ents * (CTXDESC_L1_DESC_DWORDS << 3);
+	}
+
+	cdcfg->cdtab = dmam_alloc_coherent(smmu->dev, l1size, &cdcfg->cdtab_dma,
+					   GFP_KERNEL);
+	if (!cdcfg->cdtab) {
+		dev_warn(smmu->dev, "failed to allocate context descriptor\n");
+		ret = -ENOMEM;
+		goto err_free_l1;
+	}
+
+	return 0;
+
+err_free_l1:
+	if (cdcfg->l1_desc) {
+		devm_kfree(smmu->dev, cdcfg->l1_desc);
+		cdcfg->l1_desc = NULL;
+	}
+	return ret;
+}
+
+void arm_smmu_free_cd_tables(struct arm_smmu_domain *smmu_domain)
+{
+	int i;
+	size_t size, l1size;
+	struct arm_smmu_device *smmu = smmu_domain->smmu;
+	struct arm_smmu_ctx_desc_cfg *cdcfg = &smmu_domain->s1_cfg.cdcfg;
+
+	if (cdcfg->l1_desc) {
+		size = CTXDESC_L2_ENTRIES * (CTXDESC_CD_DWORDS << 3);
+
+		for (i = 0; i < cdcfg->num_l1_ents; i++) {
+			if (!cdcfg->l1_desc[i].l2ptr)
+				continue;
+
+			dmam_free_coherent(smmu->dev, size,
+					   cdcfg->l1_desc[i].l2ptr,
+					   cdcfg->l1_desc[i].l2ptr_dma);
+		}
+		devm_kfree(smmu->dev, cdcfg->l1_desc);
+		cdcfg->l1_desc = NULL;
+
+		l1size = cdcfg->num_l1_ents * (CTXDESC_L1_DESC_DWORDS << 3);
+	} else {
+		l1size = cdcfg->num_l1_ents * (CTXDESC_CD_DWORDS << 3);
+	}
+
+	dmam_free_coherent(smmu->dev, l1size, cdcfg->cdtab, cdcfg->cdtab_dma);
+	cdcfg->cdtab_dma = 0;
+	cdcfg->cdtab = NULL;
+}
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 51da068df4e9..13513f2f651a 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -894,8 +894,7 @@ void arm_smmu_tlb_inv_asid(struct arm_smmu_device *smmu, u16 asid)
 	arm_smmu_cmdq_issue_sync(smmu);
 }
 
-static void arm_smmu_sync_cd(struct arm_smmu_domain *smmu_domain,
-			     int ssid, bool leaf)
+void arm_smmu_sync_cd(struct arm_smmu_domain *smmu_domain, int ssid, bool leaf)
 {
 	size_t i;
 	unsigned long flags;
@@ -922,219 +921,6 @@ static void arm_smmu_sync_cd(struct arm_smmu_domain *smmu_domain,
 	arm_smmu_cmdq_batch_submit(smmu, &cmds);
 }
 
-static int arm_smmu_alloc_cd_leaf_table(struct arm_smmu_device *smmu,
-					struct arm_smmu_l1_ctx_desc *l1_desc)
-{
-	size_t size = CTXDESC_L2_ENTRIES * (CTXDESC_CD_DWORDS << 3);
-
-	l1_desc->l2ptr = dmam_alloc_coherent(smmu->dev, size,
-					     &l1_desc->l2ptr_dma, GFP_KERNEL);
-	if (!l1_desc->l2ptr) {
-		dev_warn(smmu->dev,
-			 "failed to allocate context descriptor table\n");
-		return -ENOMEM;
-	}
-	return 0;
-}
-
-static void arm_smmu_write_cd_l1_desc(__le64 *dst,
-				      struct arm_smmu_l1_ctx_desc *l1_desc)
-{
-	u64 val = (l1_desc->l2ptr_dma & CTXDESC_L1_DESC_L2PTR_MASK) |
-		  CTXDESC_L1_DESC_V;
-
-	/* See comment in arm_smmu_write_ctx_desc() */
-	WRITE_ONCE(*dst, cpu_to_le64(val));
-}
-
-static __le64 *arm_smmu_get_cd_ptr(struct arm_smmu_domain *smmu_domain,
-				   u32 ssid)
-{
-	__le64 *l1ptr;
-	unsigned int idx;
-	struct arm_smmu_l1_ctx_desc *l1_desc;
-	struct arm_smmu_device *smmu = smmu_domain->smmu;
-	struct arm_smmu_ctx_desc_cfg *cdcfg = &smmu_domain->s1_cfg.cdcfg;
-
-	if (smmu_domain->s1_cfg.s1fmt == STRTAB_STE_0_S1FMT_LINEAR)
-		return cdcfg->cdtab + ssid * CTXDESC_CD_DWORDS;
-
-	idx = ssid >> CTXDESC_SPLIT;
-	l1_desc = &cdcfg->l1_desc[idx];
-	if (!l1_desc->l2ptr) {
-		if (arm_smmu_alloc_cd_leaf_table(smmu, l1_desc))
-			return NULL;
-
-		l1ptr = cdcfg->cdtab + idx * CTXDESC_L1_DESC_DWORDS;
-		arm_smmu_write_cd_l1_desc(l1ptr, l1_desc);
-		/* An invalid L1CD can be cached */
-		arm_smmu_sync_cd(smmu_domain, ssid, false);
-	}
-	idx = ssid & (CTXDESC_L2_ENTRIES - 1);
-	return l1_desc->l2ptr + idx * CTXDESC_CD_DWORDS;
-}
-
-int arm_smmu_write_ctx_desc(struct arm_smmu_domain *smmu_domain, int ssid,
-			    struct arm_smmu_ctx_desc *cd)
-{
-	/*
-	 * This function handles the following cases:
-	 *
-	 * (1) Install primary CD, for normal DMA traffic (SSID = 0).
-	 * (2) Install a secondary CD, for SID+SSID traffic.
-	 * (3) Update ASID of a CD. Atomically write the first 64 bits of the
-	 *     CD, then invalidate the old entry and mappings.
-	 * (4) Quiesce the context without clearing the valid bit. Disable
-	 *     translation, and ignore any translation fault.
-	 * (5) Remove a secondary CD.
-	 */
-	u64 val;
-	bool cd_live;
-	__le64 *cdptr;
-	struct arm_smmu_device *smmu = smmu_domain->smmu;
-
-	if (WARN_ON(ssid >= (1 << smmu_domain->s1_cfg.s1cdmax)))
-		return -E2BIG;
-
-	cdptr = arm_smmu_get_cd_ptr(smmu_domain, ssid);
-	if (!cdptr)
-		return -ENOMEM;
-
-	val = le64_to_cpu(cdptr[0]);
-	cd_live = !!(val & CTXDESC_CD_0_V);
-
-	if (!cd) { /* (5) */
-		val = 0;
-	} else if (cd == &quiet_cd) { /* (4) */
-		val |= CTXDESC_CD_0_TCR_EPD0;
-	} else if (cd_live) { /* (3) */
-		val &= ~CTXDESC_CD_0_ASID;
-		val |= FIELD_PREP(CTXDESC_CD_0_ASID, cd->asid);
-		/*
-		 * Until CD+TLB invalidation, both ASIDs may be used for tagging
-		 * this substream's traffic
-		 */
-	} else { /* (1) and (2) */
-		cdptr[1] = cpu_to_le64(cd->ttbr & CTXDESC_CD_1_TTB0_MASK);
-		cdptr[2] = 0;
-		cdptr[3] = cpu_to_le64(cd->mair);
-
-		/*
-		 * STE is live, and the SMMU might read dwords of this CD in any
-		 * order. Ensure that it observes valid values before reading
-		 * V=1.
-		 */
-		arm_smmu_sync_cd(smmu_domain, ssid, true);
-
-		val = cd->tcr |
-#ifdef __BIG_ENDIAN
-			CTXDESC_CD_0_ENDI |
-#endif
-			CTXDESC_CD_0_R | CTXDESC_CD_0_A |
-			(cd->mm ? 0 : CTXDESC_CD_0_ASET) |
-			CTXDESC_CD_0_AA64 |
-			FIELD_PREP(CTXDESC_CD_0_ASID, cd->asid) |
-			CTXDESC_CD_0_V;
-
-		/* STALL_MODEL==0b10 && CD.S==0 is ILLEGAL */
-		if (smmu->features & ARM_SMMU_FEAT_STALL_FORCE)
-			val |= CTXDESC_CD_0_S;
-	}
-
-	/*
-	 * The SMMU accesses 64-bit values atomically. See IHI0070Ca 3.21.3
-	 * "Configuration structures and configuration invalidation completion"
-	 *
-	 *   The size of single-copy atomic reads made by the SMMU is
-	 *   IMPLEMENTATION DEFINED but must be at least 64 bits. Any single
-	 *   field within an aligned 64-bit span of a structure can be altered
-	 *   without first making the structure invalid.
-	 */
-	WRITE_ONCE(cdptr[0], cpu_to_le64(val));
-	arm_smmu_sync_cd(smmu_domain, ssid, true);
-	return 0;
-}
-
-static int arm_smmu_alloc_cd_tables(struct arm_smmu_domain *smmu_domain)
-{
-	int ret;
-	size_t l1size;
-	size_t max_contexts;
-	struct arm_smmu_device *smmu = smmu_domain->smmu;
-	struct arm_smmu_s1_cfg *cfg = &smmu_domain->s1_cfg;
-	struct arm_smmu_ctx_desc_cfg *cdcfg = &cfg->cdcfg;
-
-	max_contexts = 1 << cfg->s1cdmax;
-
-	if (!(smmu->features & ARM_SMMU_FEAT_2_LVL_CDTAB) ||
-	    max_contexts <= CTXDESC_L2_ENTRIES) {
-		cfg->s1fmt = STRTAB_STE_0_S1FMT_LINEAR;
-		cdcfg->num_l1_ents = max_contexts;
-
-		l1size = max_contexts * (CTXDESC_CD_DWORDS << 3);
-	} else {
-		cfg->s1fmt = STRTAB_STE_0_S1FMT_64K_L2;
-		cdcfg->num_l1_ents = DIV_ROUND_UP(max_contexts,
-						  CTXDESC_L2_ENTRIES);
-
-		cdcfg->l1_desc = devm_kcalloc(smmu->dev, cdcfg->num_l1_ents,
-					      sizeof(*cdcfg->l1_desc),
-					      GFP_KERNEL);
-		if (!cdcfg->l1_desc)
-			return -ENOMEM;
-
-		l1size = cdcfg->num_l1_ents * (CTXDESC_L1_DESC_DWORDS << 3);
-	}
-
-	cdcfg->cdtab = dmam_alloc_coherent(smmu->dev, l1size, &cdcfg->cdtab_dma,
-					   GFP_KERNEL);
-	if (!cdcfg->cdtab) {
-		dev_warn(smmu->dev, "failed to allocate context descriptor\n");
-		ret = -ENOMEM;
-		goto err_free_l1;
-	}
-
-	return 0;
-
-err_free_l1:
-	if (cdcfg->l1_desc) {
-		devm_kfree(smmu->dev, cdcfg->l1_desc);
-		cdcfg->l1_desc = NULL;
-	}
-	return ret;
-}
-
-static void arm_smmu_free_cd_tables(struct arm_smmu_domain *smmu_domain)
-{
-	int i;
-	size_t size, l1size;
-	struct arm_smmu_device *smmu = smmu_domain->smmu;
-	struct arm_smmu_ctx_desc_cfg *cdcfg = &smmu_domain->s1_cfg.cdcfg;
-
-	if (cdcfg->l1_desc) {
-		size = CTXDESC_L2_ENTRIES * (CTXDESC_CD_DWORDS << 3);
-
-		for (i = 0; i < cdcfg->num_l1_ents; i++) {
-			if (!cdcfg->l1_desc[i].l2ptr)
-				continue;
-
-			dmam_free_coherent(smmu->dev, size,
-					   cdcfg->l1_desc[i].l2ptr,
-					   cdcfg->l1_desc[i].l2ptr_dma);
-		}
-		devm_kfree(smmu->dev, cdcfg->l1_desc);
-		cdcfg->l1_desc = NULL;
-
-		l1size = cdcfg->num_l1_ents * (CTXDESC_L1_DESC_DWORDS << 3);
-	} else {
-		l1size = cdcfg->num_l1_ents * (CTXDESC_CD_DWORDS << 3);
-	}
-
-	dmam_free_coherent(smmu->dev, l1size, cdcfg->cdtab, cdcfg->cdtab_dma);
-	cdcfg->cdtab_dma = 0;
-	cdcfg->cdtab = NULL;
-}
-
 bool arm_smmu_free_asid(struct arm_smmu_ctx_desc *cd)
 {
 	bool free;
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 9cdccf5d79b3..a50a3e4874f9 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -784,6 +784,9 @@ extern struct arm_smmu_ctx_desc quiet_cd;
 
 int arm_smmu_write_ctx_desc(struct arm_smmu_domain *smmu_domain, int ssid,
 			    struct arm_smmu_ctx_desc *cd);
+int arm_smmu_alloc_cd_tables(struct arm_smmu_domain *smmu_domain);
+void arm_smmu_free_cd_tables(struct arm_smmu_domain *smmu_domain);
+void arm_smmu_sync_cd(struct arm_smmu_domain *smmu_domain, int ssid, bool leaf);
 void arm_smmu_tlb_inv_asid(struct arm_smmu_device *smmu, u16 asid);
 bool arm_smmu_free_asid(struct arm_smmu_ctx_desc *cd);
 int arm_smmu_atc_inv_domain(struct arm_smmu_domain *smmu_domain, int ssid,
-- 
2.17.1

