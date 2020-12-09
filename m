Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 246892D3CEA
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 09:07:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727007AbgLIIGJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 03:06:09 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:47508 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728843AbgLIIFt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 03:05:49 -0500
X-UUID: 3a67baf3d30d431cb8864dbbde3868c5-20201209
X-UUID: 3a67baf3d30d431cb8864dbbde3868c5-20201209
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 2053061292; Wed, 09 Dec 2020 16:05:11 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 9 Dec 2020 16:05:07 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 9 Dec 2020 16:05:10 +0800
From:   Yong Wu <yong.wu@mediatek.com>
To:     Joerg Roedel <joro@8bytes.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>
CC:     Krzysztof Kozlowski <krzk@kernel.org>,
        Evan Green <evgreen@chromium.org>,
        Tomasz Figa <tfiga@google.com>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux-foundation.org>, <yong.wu@mediatek.com>,
        <youlin.pei@mediatek.com>, Nicolas Boichat <drinkcat@chromium.org>,
        <anan.sun@mediatek.com>, <chao.hao@mediatek.com>
Subject: [PATCH v5 25/27] iommu/mediatek: Adjust the structure
Date:   Wed, 9 Dec 2020 16:01:00 +0800
Message-ID: <20201209080102.26626-26-yong.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20201209080102.26626-1-yong.wu@mediatek.com>
References: <20201209080102.26626-1-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add "struct mtk_iommu_data *" in the "struct mtk_iommu_domain",
reduce the call mtk_iommu_get_m4u_data().
No functional change.

Signed-off-by: Yong Wu <yong.wu@mediatek.com>
---
 drivers/iommu/mtk_iommu.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index 160690d56bd2..92c1e2f0af89 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -126,6 +126,7 @@ struct mtk_iommu_domain {
 	struct io_pgtable_cfg		cfg;
 	struct io_pgtable_ops		*iop;
 
+	struct mtk_iommu_data		*data;
 	struct iommu_domain		domain;
 };
 
@@ -353,7 +354,7 @@ static void mtk_iommu_config(struct mtk_iommu_data *data,
 
 static int mtk_iommu_domain_finalise(struct mtk_iommu_domain *dom)
 {
-	struct mtk_iommu_data *data = mtk_iommu_get_m4u_data();
+	struct mtk_iommu_data *data = dom->data;
 
 	/* Use the exist domain as there is only one m4u pgtable here. */
 	if (data->m4u_dom) {
@@ -402,6 +403,7 @@ static struct iommu_domain *mtk_iommu_domain_alloc(unsigned type)
 	if (iommu_get_dma_cookie(&dom->domain))
 		goto  free_dom;
 
+	dom->data = data;
 	if (mtk_iommu_domain_finalise(dom))
 		goto  put_dma_cookie;
 
@@ -482,10 +484,9 @@ static int mtk_iommu_map(struct iommu_domain *domain, unsigned long iova,
 			 phys_addr_t paddr, size_t size, int prot, gfp_t gfp)
 {
 	struct mtk_iommu_domain *dom = to_mtk_domain(domain);
-	struct mtk_iommu_data *data = mtk_iommu_get_m4u_data();
 
 	/* The "4GB mode" M4U physically can not use the lower remap of Dram. */
-	if (data->enable_4GB)
+	if (dom->data->enable_4GB)
 		paddr |= BIT_ULL(32);
 
 	/* Synchronize with the tlb_lock */
@@ -503,31 +504,32 @@ static size_t mtk_iommu_unmap(struct iommu_domain *domain,
 
 static void mtk_iommu_flush_iotlb_all(struct iommu_domain *domain)
 {
-	mtk_iommu_tlb_flush_all(mtk_iommu_get_m4u_data());
+	struct mtk_iommu_domain *dom = to_mtk_domain(domain);
+
+	mtk_iommu_tlb_flush_all(dom->data);
 }
 
 static void mtk_iommu_iotlb_sync(struct iommu_domain *domain,
 				 struct iommu_iotlb_gather *gather)
 {
-	struct mtk_iommu_data *data = mtk_iommu_get_m4u_data();
+	struct mtk_iommu_domain *dom = to_mtk_domain(domain);
 	size_t length = gather->end - gather->start;
 
 	if (gather->start == ULONG_MAX)
 		return;
 
 	mtk_iommu_tlb_flush_range_sync(gather->start, length, gather->pgsize,
-				       data);
+				       dom->data);
 }
 
 static phys_addr_t mtk_iommu_iova_to_phys(struct iommu_domain *domain,
 					  dma_addr_t iova)
 {
 	struct mtk_iommu_domain *dom = to_mtk_domain(domain);
-	struct mtk_iommu_data *data = mtk_iommu_get_m4u_data();
 	phys_addr_t pa;
 
 	pa = dom->iop->iova_to_phys(dom->iop, iova);
-	if (data->enable_4GB && pa >= MTK_IOMMU_4GB_MODE_REMAP_BASE)
+	if (dom->data->enable_4GB && pa >= MTK_IOMMU_4GB_MODE_REMAP_BASE)
 		pa &= ~BIT_ULL(32);
 
 	return pa;
-- 
2.18.0

