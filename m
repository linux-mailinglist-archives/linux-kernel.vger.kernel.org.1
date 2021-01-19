Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35B0B2FAE92
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 03:02:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405016AbhASCB3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 21:01:29 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:11110 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404905AbhASCBI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 21:01:08 -0500
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4DKWzr0kCgz15v1w;
        Tue, 19 Jan 2021 09:59:20 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.176.220) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.498.0; Tue, 19 Jan 2021 10:00:16 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        "Mark Rutland" <mark.rutland@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        iommu <iommu@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Neil Leeder <nleeder@codeaurora.org>,
        "Shameer Kolothum" <shameerali.kolothum.thodi@huawei.com>
Subject: [PATCH 1/2] perf/smmuv3: Don't reserve the register space that overlaps with the SMMUv3
Date:   Tue, 19 Jan 2021 09:59:50 +0800
Message-ID: <20210119015951.1042-2-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
In-Reply-To: <20210119015951.1042-1-thunder.leizhen@huawei.com>
References: <20210119015951.1042-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.176.220]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some SMMUv3 implementation embed the Perf Monitor Group Registers (PMCG)
inside the first 64kB region of the SMMU. Since SMMU and PMCG are managed
by two separate drivers, and this driver depends on ARM_SMMU_V3, so the
SMMU driver reserves the corresponding resource first, this driver should
not reserve the corresponding resource again. Otherwise, a resource
reservation conflict is reported during boot.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 drivers/perf/arm_smmuv3_pmu.c | 42 ++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 40 insertions(+), 2 deletions(-)

diff --git a/drivers/perf/arm_smmuv3_pmu.c b/drivers/perf/arm_smmuv3_pmu.c
index 74474bb322c3f26..dcce085431c6ce8 100644
--- a/drivers/perf/arm_smmuv3_pmu.c
+++ b/drivers/perf/arm_smmuv3_pmu.c
@@ -761,6 +761,44 @@ static void smmu_pmu_get_acpi_options(struct smmu_pmu *smmu_pmu)
 	dev_notice(smmu_pmu->dev, "option mask 0x%x\n", smmu_pmu->options);
 }
 
+static void __iomem *
+smmu_pmu_get_and_ioremap_resource(struct platform_device *pdev,
+				  unsigned int index,
+				  struct resource **out_res)
+{
+	int ret;
+	void __iomem *base;
+	struct resource *res;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, index);
+	if (!res) {
+		dev_err(&pdev->dev, "invalid resource\n");
+		return IOMEM_ERR_PTR(-EINVAL);
+	}
+	if (out_res)
+		*out_res = res;
+
+	ret = region_intersects(res->start, resource_size(res),
+				IORESOURCE_MEM, IORES_DESC_NONE);
+	if (ret == REGION_INTERSECTS) {
+		/*
+		 * The resource has already been reserved by the SMMUv3 driver.
+		 * Don't reserve it again, just do devm_ioremap().
+		 */
+		base = devm_ioremap(&pdev->dev, res->start, resource_size(res));
+	} else {
+		/*
+		 * The resource may have not been reserved by any driver, or
+		 * has been reserved but not type IORESOURCE_MEM. In the latter
+		 * case, devm_ioremap_resource() reports a conflict and returns
+		 * IOMEM_ERR_PTR(-EBUSY).
+		 */
+		base = devm_ioremap_resource(&pdev->dev, res);
+	}
+
+	return base;
+}
+
 static int smmu_pmu_probe(struct platform_device *pdev)
 {
 	struct smmu_pmu *smmu_pmu;
@@ -793,7 +831,7 @@ static int smmu_pmu_probe(struct platform_device *pdev)
 		.capabilities	= PERF_PMU_CAP_NO_EXCLUDE,
 	};
 
-	smmu_pmu->reg_base = devm_platform_get_and_ioremap_resource(pdev, 0, &res_0);
+	smmu_pmu->reg_base = smmu_pmu_get_and_ioremap_resource(pdev, 0, &res_0);
 	if (IS_ERR(smmu_pmu->reg_base))
 		return PTR_ERR(smmu_pmu->reg_base);
 
@@ -801,7 +839,7 @@ static int smmu_pmu_probe(struct platform_device *pdev)
 
 	/* Determine if page 1 is present */
 	if (cfgr & SMMU_PMCG_CFGR_RELOC_CTRS) {
-		smmu_pmu->reloc_base = devm_platform_ioremap_resource(pdev, 1);
+		smmu_pmu->reloc_base = smmu_pmu_get_and_ioremap_resource(pdev, 1, NULL);
 		if (IS_ERR(smmu_pmu->reloc_base))
 			return PTR_ERR(smmu_pmu->reloc_base);
 	} else {
-- 
1.8.3


