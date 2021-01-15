Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74D762F787D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 13:15:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729776AbhAOMPE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 07:15:04 -0500
Received: from foss.arm.com ([217.140.110.172]:37556 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727550AbhAOMPD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 07:15:03 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 97496139F;
        Fri, 15 Jan 2021 04:14:17 -0800 (PST)
Received: from usa.arm.com (a074945.blr.arm.com [10.162.16.71])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 1C3083F70D;
        Fri, 15 Jan 2021 04:14:12 -0800 (PST)
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
Subject: [PATCH RFC v1 05/15] iommu/arm-smmu-v3: Set sync op from consumer driver of cd-lib
Date:   Fri, 15 Jan 2021 17:43:32 +0530
Message-Id: <20210115121342.15093-6-vivek.gautam@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210115121342.15093-1-vivek.gautam@arm.com>
References: <20210115121342.15093-1-vivek.gautam@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Te change allows different consumers of arm-smmu-v3-cd-lib to set
their respective sync op for pasid entries.

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
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-cd-lib.c | 1 -
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c        | 7 +++++++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-cd-lib.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-cd-lib.c
index ec37476c8d09..acaa09acecdd 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-cd-lib.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-cd-lib.c
@@ -265,7 +265,6 @@ struct iommu_vendor_psdtable_ops arm_cd_table_ops = {
 	.free	 = arm_smmu_free_cd_tables,
 	.prepare = arm_smmu_prepare_cd,
 	.write	 = arm_smmu_write_ctx_desc,
-	.sync	 = arm_smmu_sync_cd,
 };
 
 struct iommu_pasid_table *arm_smmu_register_cd_table(struct device *dev,
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 2f86c6ac42b6..0c644be22b4b 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -1869,6 +1869,13 @@ static int arm_smmu_domain_finalise_s1(struct arm_smmu_domain *smmu_domain,
 	if (ret)
 		goto out_free_cd_tables;
 
+	/*
+	 * Strange to setup an op here?
+	 * cd-lib is the actual user of sync op, and therefore the platform
+	 * drivers should assign this sync/maintenance ops as per need.
+	 */
+	tbl->ops->sync = arm_smmu_sync_cd;
+
 	/*
 	 * Note that this will end up calling arm_smmu_sync_cd() before
 	 * the master has been added to the devices list for this domain.
-- 
2.17.1

