Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 092242DBEC9
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 11:39:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726243AbgLPKhf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Dec 2020 05:37:35 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:33909 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726270AbgLPKhe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Dec 2020 05:37:34 -0500
X-UUID: 4ac3b89680fe42a6b1ead9b62835b6ce-20201216
X-UUID: 4ac3b89680fe42a6b1ead9b62835b6ce-20201216
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1161542630; Wed, 16 Dec 2020 18:37:11 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 16 Dec 2020 18:37:08 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 16 Dec 2020 18:37:07 +0800
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
        <kernel-team@android.com>
Subject: [PATCH v3 7/7] iommu/mediatek: Remove the tlb-ops for v7s
Date:   Wed, 16 Dec 2020 18:36:07 +0800
Message-ID: <20201216103607.23050-8-yong.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20201216103607.23050-1-yong.wu@mediatek.com>
References: <20201216103607.23050-1-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Until now, we have already used the tlb operations from iommu framework,
then the tlb operations for v7s can be removed.

Correspondingly, Switch the paramenter "cookie" to internal structure.

Signed-off-by: Yong Wu <yong.wu@mediatek.com>
---
 drivers/iommu/mtk_iommu.c | 27 ++++-----------------------
 1 file changed, 4 insertions(+), 23 deletions(-)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index 89cec51405cd..5656819cd4a1 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -206,10 +206,8 @@ static struct mtk_iommu_domain *to_mtk_domain(struct iommu_domain *dom)
 	return container_of(dom, struct mtk_iommu_domain, domain);
 }
 
-static void mtk_iommu_tlb_flush_all(void *cookie)
+static void mtk_iommu_tlb_flush_all(struct mtk_iommu_data *data)
 {
-	struct mtk_iommu_data *data = cookie;
-
 	for_each_m4u(data) {
 		if (!pm_runtime_active(data->dev))
 			continue;
@@ -221,9 +219,9 @@ static void mtk_iommu_tlb_flush_all(void *cookie)
 }
 
 static void mtk_iommu_tlb_flush_range_sync(unsigned long iova, size_t size,
-					   size_t granule, void *cookie)
+					   size_t granule,
+					   struct mtk_iommu_data *data)
 {
-	struct mtk_iommu_data *data = cookie;
 	unsigned long flags;
 	int ret;
 	u32 tmp;
@@ -250,7 +248,7 @@ static void mtk_iommu_tlb_flush_range_sync(unsigned long iova, size_t size,
 		if (ret) {
 			dev_warn(data->dev,
 				 "Partial TLB flush timed out, falling back to full flush\n");
-			mtk_iommu_tlb_flush_all(cookie);
+			mtk_iommu_tlb_flush_all(data);
 		}
 		/* Clear the CPE status */
 		writel_relaxed(0, data->base + REG_MMU_CPE_DONE);
@@ -258,22 +256,6 @@ static void mtk_iommu_tlb_flush_range_sync(unsigned long iova, size_t size,
 	}
 }
 
-static void mtk_iommu_tlb_flush_page_nosync(struct iommu_iotlb_gather *gather,
-					    unsigned long iova, size_t granule,
-					    void *cookie)
-{
-	struct mtk_iommu_data *data = cookie;
-	struct iommu_domain *domain = &data->m4u_dom->domain;
-
-	iommu_iotlb_gather_add_page(domain, gather, iova, granule);
-}
-
-static const struct iommu_flush_ops mtk_iommu_flush_ops = {
-	.tlb_flush_all = mtk_iommu_tlb_flush_all,
-	.tlb_flush_walk = mtk_iommu_tlb_flush_range_sync,
-	.tlb_add_page = mtk_iommu_tlb_flush_page_nosync,
-};
-
 static irqreturn_t mtk_iommu_isr(int irq, void *dev_id)
 {
 	struct mtk_iommu_data *data = dev_id;
@@ -380,7 +362,6 @@ static int mtk_iommu_domain_finalise(struct mtk_iommu_domain *dom)
 		.pgsize_bitmap = mtk_iommu_ops.pgsize_bitmap,
 		.ias = MTK_IOMMU_HAS_FLAG(data->plat_data, IOVA_34_EN) ? 34 : 32,
 		.oas = 35,
-		.tlb = &mtk_iommu_flush_ops,
 		.iommu_dev = data->dev,
 	};
 
-- 
2.18.0

