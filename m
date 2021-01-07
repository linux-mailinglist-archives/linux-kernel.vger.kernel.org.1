Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5B9C2ECFB6
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 13:31:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728213AbhAGMaz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 07:30:55 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:41356 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725835AbhAGMay (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 07:30:54 -0500
X-UUID: 86e73c3f0034401a82a686edce92bb07-20210107
X-UUID: 86e73c3f0034401a82a686edce92bb07-20210107
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw01.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1210095996; Thu, 07 Jan 2021 20:30:08 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 7 Jan 2021 20:30:06 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 7 Jan 2021 20:30:00 +0800
From:   Yong Wu <yong.wu@mediatek.com>
To:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>
CC:     Matthias Brugger <matthias.bgg@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Tomasz Figa <tfiga@google.com>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux-foundation.org>, <yong.wu@mediatek.com>,
        <youlin.pei@mediatek.com>, Nicolas Boichat <drinkcat@chromium.org>,
        <anan.sun@mediatek.com>, <chao.hao@mediatek.com>,
        Greg Kroah-Hartman <gregkh@google.com>,
        <kernel-team@android.com>, Christoph Hellwig <hch@infradead.org>,
        David Laight <David.Laight@ACULAB.COM>
Subject: [PATCH v4 4/7] iommu: Switch gather->end to the inclusive end
Date:   Thu, 7 Jan 2021 20:29:06 +0800
Message-ID: <20210107122909.16317-5-yong.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210107122909.16317-1-yong.wu@mediatek.com>
References: <20210107122909.16317-1-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently gather->end is "unsigned long" which may be overflow in
arch32 in the corner case: 0xfff00000 + 0x100000(iova + size).
Although it doesn't affect the size(end - start), it affects the checking
"gather->end < end"

This patch changes this "end" to the real end address
(end = start + size - 1). Correspondingly, update the length to
"end - start + 1".

Fixes: a7d20dc19d9e ("iommu: Introduce struct iommu_iotlb_gather for batching TLB flushes")
Signed-off-by: Yong Wu <yong.wu@mediatek.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 2 +-
 drivers/iommu/mtk_iommu.c                   | 2 +-
 drivers/iommu/tegra-gart.c                  | 2 +-
 include/linux/iommu.h                       | 4 ++--
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 8ca7415d785d..c70d6e79f534 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2280,7 +2280,7 @@ static void arm_smmu_iotlb_sync(struct iommu_domain *domain,
 {
 	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
 
-	arm_smmu_tlb_inv_range(gather->start, gather->end - gather->start,
+	arm_smmu_tlb_inv_range(gather->start, gather->end - gather->start + 1,
 			       gather->pgsize, true, smmu_domain);
 }
 
diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index f579fc21971e..66a00a2cb445 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -443,7 +443,7 @@ static void mtk_iommu_iotlb_sync(struct iommu_domain *domain,
 				 struct iommu_iotlb_gather *gather)
 {
 	struct mtk_iommu_data *data = mtk_iommu_get_m4u_data();
-	size_t length = gather->end - gather->start;
+	size_t length = gather->end - gather->start + 1;
 
 	if (gather->start == ULONG_MAX)
 		return;
diff --git a/drivers/iommu/tegra-gart.c b/drivers/iommu/tegra-gart.c
index 05e8e19b8269..6f130e51f072 100644
--- a/drivers/iommu/tegra-gart.c
+++ b/drivers/iommu/tegra-gart.c
@@ -270,7 +270,7 @@ static void gart_iommu_sync_map(struct iommu_domain *domain, unsigned long iova,
 static void gart_iommu_sync(struct iommu_domain *domain,
 			    struct iommu_iotlb_gather *gather)
 {
-	size_t length = gather->end - gather->start;
+	size_t length = gather->end - gather->start + 1;
 
 	gart_iommu_sync_map(domain, gather->start, length);
 }
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 9ce0aa9e236b..ae8eddd4621b 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -170,7 +170,7 @@ enum iommu_dev_features {
  * struct iommu_iotlb_gather - Range information for a pending IOTLB flush
  *
  * @start: IOVA representing the start of the range to be flushed
- * @end: IOVA representing the end of the range to be flushed (exclusive)
+ * @end: IOVA representing the end of the range to be flushed (inclusive)
  * @pgsize: The interval at which to perform the flush
  *
  * This structure is intended to be updated by multiple calls to the
@@ -539,7 +539,7 @@ static inline void iommu_iotlb_gather_add_page(struct iommu_domain *domain,
 					       struct iommu_iotlb_gather *gather,
 					       unsigned long iova, size_t size)
 {
-	unsigned long start = iova, end = start + size;
+	unsigned long start = iova, end = start + size - 1;
 
 	/*
 	 * If the new page is disjoint from the current range or is mapped at
-- 
2.18.0

