Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DA80269492
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 20:13:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726122AbgINSNg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 14:13:36 -0400
Received: from linux.microsoft.com ([13.77.154.182]:42804 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725984AbgINSNN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 14:13:13 -0400
Received: from vennila-Virtual-Machine.redmond.corp.microsoft.com (unknown [131.107.159.190])
        by linux.microsoft.com (Postfix) with ESMTPSA id 39C22209F32A;
        Mon, 14 Sep 2020 11:13:13 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 39C22209F32A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1600107193;
        bh=O7GLupHZ3pFPFMY1HucftGastWnLX6zwmGrMq8vy3/Q=;
        h=From:To:Cc:Subject:Date:From;
        b=FvzLRbDDDQ0e3o8Xv8DroMUwzD8FyDiLQjkhEkuxRsYaSBRXGwAfzHH5QdmnCSie4
         ZzB52f1Zlpq3WImYIGvfufg8G674cmHPUwl8gavyQUVYyBvacLyU2yrO21Ry+w2zmV
         2fjoh1StkSTJX0WStYOVObcYo75weOlRNY9Fhkog=
From:   Vennila Megavannan <vemegava@linux.microsoft.com>
To:     will@kernel.org, robin.murphy@arm.com, joro@8bytes.org
Cc:     srinath.mannam@broadcom.com, jean-philippe@linaro.org,
        eric.auger@redhat.com, shameerali.kolothum.thodi@huawei.com,
        tyhicks@linux.microsoft.com, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com
Subject: [PATCH v2] iommu/arm: Add module parameter to set msi iova address
Date:   Mon, 14 Sep 2020 11:13:07 -0700
Message-Id: <20200914181307.117792-1-vemegava@linux.microsoft.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Srinath Mannam <srinath.mannam@broadcom.com>

Add provision to change default value of MSI IOVA base to platform's
suitable IOVA using module parameter. The present hardcoded MSI IOVA base
may not be the accessible IOVA ranges of platform.

If any platform has the limitaion to access default MSI IOVA, then it can
be changed using "arm-smmu.msi_iova_base=0xa0000000" command line argument.

Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
Co-developed-by: Vennila Megavannan <vemegava@linux.microsoft.com>
Signed-off-by: Vennila Megavannan <vemegava@linux.microsoft.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 5 ++++-
 drivers/iommu/arm/arm-smmu/arm-smmu.c       | 5 ++++-
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index c192544e874b..dfef0df66c19 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -417,6 +417,9 @@ static bool disable_bypass = 1;
 module_param_named(disable_bypass, disable_bypass, bool, S_IRUGO);
 MODULE_PARM_DESC(disable_bypass,
 	"Disable bypass streams such that incoming transactions from devices that are not attached to an iommu domain will report an abort back to the device and will not be allowed to pass through the SMMU.");
+static unsigned long msi_iova_base = MSI_IOVA_BASE;
+module_param(msi_iova_base, ulong, S_IRUGO);
+MODULE_PARM_DESC(msi_iova_base, "set MSI IOVA base address if default (0x8000000) does not work for your platform.");
 
 enum pri_resp {
 	PRI_RESP_DENY = 0,
@@ -3102,7 +3105,7 @@ static void arm_smmu_get_resv_regions(struct device *dev,
 	struct iommu_resv_region *region;
 	int prot = IOMMU_WRITE | IOMMU_NOEXEC | IOMMU_MMIO;
 
-	region = iommu_alloc_resv_region(MSI_IOVA_BASE, MSI_IOVA_LENGTH,
+	region = iommu_alloc_resv_region(msi_iova_base, MSI_IOVA_LENGTH,
 					 prot, IOMMU_RESV_SW_MSI);
 	if (!region)
 		return;
diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
index 09c42af9f31e..9d46a2628dd5 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
@@ -64,6 +64,9 @@ static bool disable_bypass =
 module_param(disable_bypass, bool, S_IRUGO);
 MODULE_PARM_DESC(disable_bypass,
 	"Disable bypass streams such that incoming transactions from devices that are not attached to an iommu domain will report an abort back to the device and will not be allowed to pass through the SMMU.");
+static unsigned long msi_iova_base = MSI_IOVA_BASE;
+module_param(msi_iova_base, ulong, S_IRUGO);
+MODULE_PARM_DESC(msi_iova_base, "set MSI IOVA base address if default (0x8000000) does not work for your platform.");
 
 struct arm_smmu_s2cr {
 	struct iommu_group		*group;
@@ -1603,7 +1606,7 @@ static void arm_smmu_get_resv_regions(struct device *dev,
 	struct iommu_resv_region *region;
 	int prot = IOMMU_WRITE | IOMMU_NOEXEC | IOMMU_MMIO;
 
-	region = iommu_alloc_resv_region(MSI_IOVA_BASE, MSI_IOVA_LENGTH,
+	region = iommu_alloc_resv_region(msi_iova_base, MSI_IOVA_LENGTH,
 					 prot, IOMMU_RESV_SW_MSI);
 	if (!region)
 		return;
-- 
2.17.1

