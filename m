Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E47C2DBEC1
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 11:37:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726202AbgLPKhL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Dec 2020 05:37:11 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:36877 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726143AbgLPKhK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Dec 2020 05:37:10 -0500
X-UUID: b25e4e00b67d487d9ca4d45ce3372851-20201216
X-UUID: b25e4e00b67d487d9ca4d45ce3372851-20201216
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 120131141; Wed, 16 Dec 2020 18:36:26 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 16 Dec 2020 18:36:23 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 16 Dec 2020 18:36:22 +0800
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
Subject: [PATCH v3 1/7] iommu: Move iotlb_sync_map out from __iommu_map
Date:   Wed, 16 Dec 2020 18:36:01 +0800
Message-ID: <20201216103607.23050-2-yong.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20201216103607.23050-1-yong.wu@mediatek.com>
References: <20201216103607.23050-1-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the end of __iommu_map, It alway call iotlb_sync_map.
This patch moves iotlb_sync_map out from __iommu_map since it is
unnecessary to call this for each sg segment especially iotlb_sync_map
is flush tlb all currently.

Signed-off-by: Yong Wu <yong.wu@mediatek.com>
Reviewed-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/iommu.c | 24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 8c470f451a32..decef851fa3a 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -2407,9 +2407,6 @@ static int __iommu_map(struct iommu_domain *domain, unsigned long iova,
 		size -= pgsize;
 	}
 
-	if (ops->iotlb_sync_map)
-		ops->iotlb_sync_map(domain);
-
 	/* unroll mapping in case something went wrong */
 	if (ret)
 		iommu_unmap(domain, orig_iova, orig_size - size);
@@ -2422,15 +2419,29 @@ static int __iommu_map(struct iommu_domain *domain, unsigned long iova,
 int iommu_map(struct iommu_domain *domain, unsigned long iova,
 	      phys_addr_t paddr, size_t size, int prot)
 {
+	const struct iommu_ops *ops = domain->ops;
+	int ret;
+
 	might_sleep();
-	return __iommu_map(domain, iova, paddr, size, prot, GFP_KERNEL);
+	ret = __iommu_map(domain, iova, paddr, size, prot, GFP_KERNEL);
+	if (ret == 0 && ops->iotlb_sync_map)
+		ops->iotlb_sync_map(domain);
+
+	return ret;
 }
 EXPORT_SYMBOL_GPL(iommu_map);
 
 int iommu_map_atomic(struct iommu_domain *domain, unsigned long iova,
 	      phys_addr_t paddr, size_t size, int prot)
 {
-	return __iommu_map(domain, iova, paddr, size, prot, GFP_ATOMIC);
+	const struct iommu_ops *ops = domain->ops;
+	int ret;
+
+	ret = __iommu_map(domain, iova, paddr, size, prot, GFP_ATOMIC);
+	if (ret == 0 && ops->iotlb_sync_map)
+		ops->iotlb_sync_map(domain);
+
+	return ret;
 }
 EXPORT_SYMBOL_GPL(iommu_map_atomic);
 
@@ -2514,6 +2525,7 @@ static size_t __iommu_map_sg(struct iommu_domain *domain, unsigned long iova,
 			     struct scatterlist *sg, unsigned int nents, int prot,
 			     gfp_t gfp)
 {
+	const struct iommu_ops *ops = domain->ops;
 	size_t len = 0, mapped = 0;
 	phys_addr_t start;
 	unsigned int i = 0;
@@ -2544,6 +2556,8 @@ static size_t __iommu_map_sg(struct iommu_domain *domain, unsigned long iova,
 			sg = sg_next(sg);
 	}
 
+	if (ops->iotlb_sync_map)
+		ops->iotlb_sync_map(domain);
 	return mapped;
 
 out_err:
-- 
2.18.0

