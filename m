Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1878C2ECFBB
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 13:31:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728275AbhAGMbO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 07:31:14 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:57840 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728233AbhAGMbN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 07:31:13 -0500
X-UUID: 060ac8cd00b24e38bc17ff443bc4edf6-20210107
X-UUID: 060ac8cd00b24e38bc17ff443bc4edf6-20210107
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 915304804; Thu, 07 Jan 2021 20:30:26 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 7 Jan 2021 20:30:24 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 7 Jan 2021 20:30:24 +0800
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
Subject: [PATCH v4 6/7] iommu/mediatek: Gather iova in iommu_unmap to achieve tlb sync once
Date:   Thu, 7 Jan 2021 20:29:08 +0800
Message-ID: <20210107122909.16317-7-yong.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210107122909.16317-1-yong.wu@mediatek.com>
References: <20210107122909.16317-1-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In current iommu_unmap, this code is:

	iommu_iotlb_gather_init(&iotlb_gather);
	ret = __iommu_unmap(domain, iova, size, &iotlb_gather);
	iommu_iotlb_sync(domain, &iotlb_gather);

We could gather the whole iova range in __iommu_unmap, and then do tlb
synchronization in the iommu_iotlb_sync.

This patch implement this, Gather the range in mtk_iommu_unmap.
then iommu_iotlb_sync call tlb synchronization for the gathered iova range.
we don't call iommu_iotlb_gather_add_page since our tlb synchronization
could be regardless of granule size.

In this way, gather->start is impossible ULONG_MAX, remove the checking.

This patch aims to do tlb synchronization *once* in the iommu_unmap.

Signed-off-by: Yong Wu <yong.wu@mediatek.com>
---
 drivers/iommu/mtk_iommu.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index 66a00a2cb445..d3b8a1649093 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -430,7 +430,12 @@ static size_t mtk_iommu_unmap(struct iommu_domain *domain,
 			      struct iommu_iotlb_gather *gather)
 {
 	struct mtk_iommu_domain *dom = to_mtk_domain(domain);
+	unsigned long end = iova + size - 1;
 
+	if (gather->start > iova)
+		gather->start = iova;
+	if (gather->end < end)
+		gather->end = end;
 	return dom->iop->unmap(dom->iop, iova, size, gather);
 }
 
@@ -445,9 +450,6 @@ static void mtk_iommu_iotlb_sync(struct iommu_domain *domain,
 	struct mtk_iommu_data *data = mtk_iommu_get_m4u_data();
 	size_t length = gather->end - gather->start + 1;
 
-	if (gather->start == ULONG_MAX)
-		return;
-
 	mtk_iommu_tlb_flush_range_sync(gather->start, length, gather->pgsize,
 				       data);
 }
-- 
2.18.0

