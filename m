Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 015A7303F3E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 14:49:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404722AbhAZNnk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 08:43:40 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:11887 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404814AbhAZNmi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 08:42:38 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4DQ7Cs173Hz7bGZ;
        Tue, 26 Jan 2021 21:40:41 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.176.220) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.498.0; Tue, 26 Jan 2021 21:41:43 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        "Mark Rutland" <mark.rutland@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        iommu <iommu@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Subject: [PATCH v2 3/3] iommu/arm-smmu-v3: Reserving the entire SMMU register space
Date:   Tue, 26 Jan 2021 21:41:28 +0800
Message-ID: <20210126134128.1368-4-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
In-Reply-To: <20210126134128.1368-1-thunder.leizhen@huawei.com>
References: <20210126134128.1368-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.176.220]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit 52f3fab0067d ("iommu/arm-smmu-v3: Don't reserve implementation
defined register space") only reserves the basic SMMU register space. So
the ECMDQ register space is not covered, it should be mapped again. Due
to the size of this ECMDQ resource is not fixed, depending on
SMMU_IDR6.CMDQ_CONTROL_PAGE_LOG2NUMQ. Processing its resource reservation
to avoid resource conflict with PMCG is a bit more complicated.

Therefore, the resources of the PMCG are not reserved, and the entire SMMU
resources are reserved.

Suggested-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 28 ++++------------------------
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  2 --
 2 files changed, 4 insertions(+), 26 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index bca458c00e48a8b..fde24403b06a9e3 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -3476,18 +3476,6 @@ static int arm_smmu_set_bus_ops(struct iommu_ops *ops)
 	return err;
 }
 
-static void __iomem *arm_smmu_ioremap(struct device *dev, resource_size_t start,
-				      resource_size_t size)
-{
-	struct resource res = {
-		.flags = IORESOURCE_MEM,
-		.start = start,
-		.end = start + size - 1,
-	};
-
-	return devm_ioremap_resource(dev, &res);
-}
-
 static int arm_smmu_device_probe(struct platform_device *pdev)
 {
 	int irq, ret;
@@ -3523,22 +3511,14 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
 	}
 	ioaddr = res->start;
 
-	/*
-	 * Don't map the IMPLEMENTATION DEFINED regions, since they may contain
-	 * the PMCG registers which are reserved by the PMU driver.
-	 */
-	smmu->base = arm_smmu_ioremap(dev, ioaddr, ARM_SMMU_REG_SZ);
+	smmu->base = devm_ioremap_resource(dev, res);
 	if (IS_ERR(smmu->base))
 		return PTR_ERR(smmu->base);
 
-	if (arm_smmu_resource_size(smmu) > SZ_64K) {
-		smmu->page1 = arm_smmu_ioremap(dev, ioaddr + SZ_64K,
-					       ARM_SMMU_REG_SZ);
-		if (IS_ERR(smmu->page1))
-			return PTR_ERR(smmu->page1);
-	} else {
+	if (arm_smmu_resource_size(smmu) > SZ_64K)
+		smmu->page1 = smmu->base + SZ_64K;
+	else
 		smmu->page1 = smmu->base;
-	}
 
 	/* Interrupt lines */
 
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index da525f46dab4fc1..63f2b476987d6ae 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -152,8 +152,6 @@
 #define ARM_SMMU_PRIQ_IRQ_CFG1		0xd8
 #define ARM_SMMU_PRIQ_IRQ_CFG2		0xdc
 
-#define ARM_SMMU_REG_SZ			0xe00
-
 /* Common MSI config fields */
 #define MSI_CFG0_ADDR_MASK		GENMASK_ULL(51, 2)
 #define MSI_CFG2_SH			GENMASK(5, 4)
-- 
1.8.3


