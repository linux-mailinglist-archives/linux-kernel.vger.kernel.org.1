Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0E772B8B8D
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 07:21:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726458AbgKSGT2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 01:19:28 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:39996 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726224AbgKSGT1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 01:19:27 -0500
X-UUID: 31a8eb1f609f4173ab620051a6d7108a-20201119
X-UUID: 31a8eb1f609f4173ab620051a6d7108a-20201119
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 762270547; Thu, 19 Nov 2020 14:19:22 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 19 Nov 2020 14:19:21 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 19 Nov 2020 14:19:20 +0800
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
        <jun.wen@mediatek.com>
Subject: [PATCH v2 6/6] iommu/mediatek: Convert tlb_flush_walk to gather_add_page
Date:   Thu, 19 Nov 2020 14:18:36 +0800
Message-ID: <20201119061836.15238-7-yong.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20201119061836.15238-1-yong.wu@mediatek.com>
References: <20201119061836.15238-1-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MediaTek TLB flush don't care about granule. when unmap, it could gather
whole the iova range then do tlb flush once.

In current v7s, If unmap the lvl2 pagetable, the steps are:
step1: set this current pdg to 0.
step2: tlb flush for this lvl2 block iova(1M).
step3: free the lvl2 pagetable.

This patch means we delay the step2 after unmap whole the iova.
the iommu consumer HW should have stopped before it call dma_free_xx,
thus, this delay looks ok.

Since tlb_flush_walk doesn't have the "gather" parameter, so we have to
add this "gather" in ourself private data.

Meanswhile, After this patch, the gather_add_pages will always be called,
then "gather->start == ULONG_MAX" is impossible. remove this checking.

Signed-off-by: Yong Wu <yong.wu@mediatek.com>
---
tlb_flush_walk is designed for tlb flush range, I'm not sure whether it's ok
if adding "gather" as a parameter in tlb_flush_walk. in this version, I put
it into our private data.
---
 drivers/iommu/mtk_iommu.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index 94786860bd84..4c8200f4403a 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -128,6 +128,8 @@ struct mtk_iommu_domain {
 	struct io_pgtable_ops		*iop;
 
 	struct iommu_domain		domain;
+
+	struct iommu_iotlb_gather	*gather;
 };
 
 static const struct iommu_ops mtk_iommu_ops;
@@ -227,6 +229,17 @@ static void mtk_iommu_tlb_flush_range_sync(unsigned long iova, size_t size,
 	}
 }
 
+static void mtk_iommu_tlb_flush_walk(unsigned long iova, size_t size,
+				     size_t granule, void *cookie)
+{
+	struct mtk_iommu_data *data = cookie;
+	struct mtk_iommu_domain *m4u_dom = data->m4u_dom;
+	struct iommu_domain *domain = &m4u_dom->domain;
+
+	/* Gather all the iova and tlb flush once after unmap. */
+	iommu_iotlb_gather_add_page(domain, m4u_dom->gather, iova, size);
+}
+
 static void mtk_iommu_tlb_flush_page_nosync(struct iommu_iotlb_gather *gather,
 					    unsigned long iova, size_t granule,
 					    void *cookie)
@@ -239,8 +252,8 @@ static void mtk_iommu_tlb_flush_page_nosync(struct iommu_iotlb_gather *gather,
 
 static const struct iommu_flush_ops mtk_iommu_flush_ops = {
 	.tlb_flush_all = mtk_iommu_tlb_flush_all,
-	.tlb_flush_walk = mtk_iommu_tlb_flush_range_sync,
-	.tlb_flush_leaf = mtk_iommu_tlb_flush_range_sync,
+	.tlb_flush_walk = mtk_iommu_tlb_flush_walk,
+	.tlb_flush_leaf = mtk_iommu_tlb_flush_walk,
 	.tlb_add_page = mtk_iommu_tlb_flush_page_nosync,
 };
 
@@ -432,6 +445,7 @@ static size_t mtk_iommu_unmap(struct iommu_domain *domain,
 {
 	struct mtk_iommu_domain *dom = to_mtk_domain(domain);
 
+	dom->gather = gather;
 	gather->granule_ignore = true;
 	return dom->iop->unmap(dom->iop, iova, size, gather);
 }
@@ -447,9 +461,6 @@ static void mtk_iommu_iotlb_sync(struct iommu_domain *domain,
 	struct mtk_iommu_data *data = mtk_iommu_get_m4u_data();
 	size_t length = gather->end - gather->start;
 
-	if (gather->start == ULONG_MAX)
-		return;
-
 	mtk_iommu_tlb_flush_range_sync(gather->start, length, gather->pgsize,
 				       data);
 }
-- 
2.18.0

