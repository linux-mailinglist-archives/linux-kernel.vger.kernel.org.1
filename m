Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07A222F787C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 13:15:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729597AbhAOMO6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 07:14:58 -0500
Received: from foss.arm.com ([217.140.110.172]:37532 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729409AbhAOMO6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 07:14:58 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9E9881396;
        Fri, 15 Jan 2021 04:14:12 -0800 (PST)
Received: from usa.arm.com (a074945.blr.arm.com [10.162.16.71])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 275AB3F70D;
        Fri, 15 Jan 2021 04:14:07 -0800 (PST)
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
Subject: [PATCH RFC v1 04/15] iommu/arm-smmu-v3: Update CD base address info for user-space
Date:   Fri, 15 Jan 2021 17:43:31 +0530
Message-Id: <20210115121342.15093-5-vivek.gautam@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210115121342.15093-1-vivek.gautam@arm.com>
References: <20210115121342.15093-1-vivek.gautam@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update base address information in vendor pasid table info to pass that
to user-space for stage1 table management.

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
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-cd-lib.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-cd-lib.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-cd-lib.c
index 8a7187534706..ec37476c8d09 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-cd-lib.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-cd-lib.c
@@ -55,6 +55,9 @@ static __le64 *arm_smmu_get_cd_ptr(struct iommu_vendor_psdtable_cfg *pst_cfg,
 		if (arm_smmu_alloc_cd_leaf_table(dev, l1_desc))
 			return NULL;
 
+		if (s1cfg->s1fmt == STRTAB_STE_0_S1FMT_LINEAR)
+			pst_cfg->base = l1_desc->l2ptr_dma;
+
 		l1ptr = cdcfg->cdtab + idx * CTXDESC_L1_DESC_DWORDS;
 		arm_smmu_write_cd_l1_desc(l1ptr, l1_desc);
 		/* An invalid L1CD can be cached */
@@ -211,6 +214,9 @@ static int arm_smmu_alloc_cd_tables(struct iommu_vendor_psdtable_cfg *pst_cfg)
 		goto err_free_l1;
 	}
 
+	if (s1cfg->s1fmt == STRTAB_STE_0_S1FMT_64K_L2)
+		pst_cfg->base = cdcfg->cdtab_dma;
+
 	return 0;
 
 err_free_l1:
-- 
2.17.1

