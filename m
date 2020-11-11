Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E07D2AF10E
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 13:42:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727061AbgKKMmh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 07:42:37 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:58644 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726985AbgKKMly (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 07:41:54 -0500
X-UUID: e0e83c3fcd1847118c204756a062f229-20201111
X-UUID: e0e83c3fcd1847118c204756a062f229-20201111
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1912702079; Wed, 11 Nov 2020 20:41:50 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 11 Nov 2020 20:41:47 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 11 Nov 2020 20:41:46 +0800
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
        <anan.sun@mediatek.com>, <chao.hao@mediatek.com>,
        Greg Kroah-Hartman <gregkh@google.com>,
        <kernel-team@android.com>
Subject: [PATCH v4 21/24] iommu/mediatek: Add support for multi domain
Date:   Wed, 11 Nov 2020 20:38:35 +0800
Message-ID: <20201111123838.15682-22-yong.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20201111123838.15682-1-yong.wu@mediatek.com>
References: <20201111123838.15682-1-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some HW IP(ex: CCU) require the special iova range. That means the
iova got from dma_alloc_attrs for that devices must locate in his
special range. In this patch, we allocate a special iova_range for
each a special requirement and create each a iommu domain for each
a iova_range.

meanwhile we still use one pagetable which support 16GB iova.

After this patch, If the iova range of a master is over 4G, the master
should:
a) Declare its special dma_ranges in its dtsi node. For example, If we
   preassign the iova 4G-8G for vcodec, then the vcodec dtsi node should
   add this:
   /*
    * iova start at 0x1_0000_0000, pa still start at 0x4000_0000
    * size is 0x1_0000_0000.
    */
   dma-ranges = <0x1 0x0 0x0 0x40000000 0x1 0x0>;  /* 4G ~ 8G */
 Note: we don't have a actual bus concept here. the master doesn't have its
 special parent node, thus this dma-ranges can only be put in the master's
 node.

b) Update the dma_mask:
  dma_set_mask_and_coherent(dev, DMA_BIT_MASK(33));

Signed-off-by: Yong Wu <yong.wu@mediatek.com>
---
 drivers/iommu/mtk_iommu.c | 47 +++++++++++++++++++++++++++++++--------
 drivers/iommu/mtk_iommu.h |  3 ++-
 2 files changed, 40 insertions(+), 10 deletions(-)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index fdf08e2d9ed5..d9a66b2d55e9 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -354,6 +354,14 @@ static int mtk_iommu_domain_finalise(struct mtk_iommu_domain *dom)
 {
 	struct mtk_iommu_data *data = mtk_iommu_get_m4u_data();
 
+	/* Use the exist domain as there is only one m4u pgtable here. */
+	if (data->m4u_dom) {
+		dom->iop = data->m4u_dom->iop;
+		dom->cfg = data->m4u_dom->cfg;
+		dom->domain.pgsize_bitmap = data->m4u_dom->cfg.pgsize_bitmap;
+		return 0;
+	}
+
 	dom->cfg = (struct io_pgtable_cfg) {
 		.quirks = IO_PGTABLE_QUIRK_ARM_NS |
 			IO_PGTABLE_QUIRK_NO_PERMS |
@@ -379,6 +387,8 @@ static int mtk_iommu_domain_finalise(struct mtk_iommu_domain *dom)
 
 static struct iommu_domain *mtk_iommu_domain_alloc(unsigned type)
 {
+	struct mtk_iommu_data *data = mtk_iommu_get_m4u_data();
+	const struct mtk_iommu_iova_region *region;
 	struct mtk_iommu_domain *dom;
 
 	if (type != IOMMU_DOMAIN_DMA)
@@ -394,8 +404,9 @@ static struct iommu_domain *mtk_iommu_domain_alloc(unsigned type)
 	if (mtk_iommu_domain_finalise(dom))
 		goto  put_dma_cookie;
 
-	dom->domain.geometry.aperture_start = 0;
-	dom->domain.geometry.aperture_end = DMA_BIT_MASK(32);
+	region = data->plat_data->iova_region + data->cur_domid;
+	dom->domain.geometry.aperture_start = region->iova_base;
+	dom->domain.geometry.aperture_end = region->iova_base + region->size - 1;
 	dom->domain.geometry.force_aperture = true;
 
 	return &dom->domain;
@@ -539,19 +550,31 @@ static void mtk_iommu_release_device(struct device *dev)
 static struct iommu_group *mtk_iommu_device_group(struct device *dev)
 {
 	struct mtk_iommu_data *data = mtk_iommu_get_m4u_data();
+	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
+	struct iommu_group *group;
+	int domid;
 
 	if (!data)
 		return ERR_PTR(-ENODEV);
 
-	/* All the client devices are in the same m4u iommu-group */
-	if (!data->m4u_group) {
-		data->m4u_group = iommu_group_alloc();
-		if (IS_ERR(data->m4u_group))
+	domid = MTK_M4U_TO_DOM(fwspec->ids[0]);
+	if (domid >= data->plat_data->iova_region_nr) {
+		dev_err(dev, "iommu domain id(%d/%d) is error.\n", domid,
+			data->plat_data->iova_region_nr);
+		return ERR_PTR(-EINVAL);
+	}
+
+	group = data->m4u_group[domid];
+	if (!group) {
+		group = iommu_group_alloc();
+		if (IS_ERR(group))
 			dev_err(dev, "Failed to allocate M4U IOMMU group\n");
+		data->m4u_group[domid] = group;
 	} else {
-		iommu_group_ref_get(data->m4u_group);
+		iommu_group_ref_get(group);
 	}
-	return data->m4u_group;
+	data->cur_domid = domid;
+	return group;
 }
 
 static int mtk_iommu_of_xlate(struct device *dev, struct of_phandle_args *args)
@@ -580,14 +603,20 @@ static void mtk_iommu_get_resv_regions(struct device *dev,
 				       struct list_head *head)
 {
 	struct mtk_iommu_data *data = dev_iommu_priv_get(dev);
-	const struct mtk_iommu_iova_region *resv;
+	const struct mtk_iommu_iova_region *resv, *curdom;
 	struct iommu_resv_region *region;
 	int prot = IOMMU_WRITE | IOMMU_READ;
 	unsigned int i;
 
+	curdom = data->plat_data->iova_region + data->cur_domid;
 	for (i = 0; i < data->plat_data->iova_region_nr; i++) {
 		resv = data->plat_data->iova_region + i;
 
+		/* Only reserve when the region is in the current domain */
+		if (resv->iova_base <= curdom->iova_base ||
+		    resv->iova_base + resv->size >= curdom->iova_base + curdom->size)
+			continue;
+
 		region = iommu_alloc_resv_region(resv->iova_base, resv->size,
 						 prot, IOMMU_RESV_RESERVED);
 		if (!region)
diff --git a/drivers/iommu/mtk_iommu.h b/drivers/iommu/mtk_iommu.h
index e867cd3aeeac..b54862307128 100644
--- a/drivers/iommu/mtk_iommu.h
+++ b/drivers/iommu/mtk_iommu.h
@@ -67,7 +67,7 @@ struct mtk_iommu_data {
 	phys_addr_t			protect_base; /* protect memory base */
 	struct mtk_iommu_suspend_reg	reg;
 	struct mtk_iommu_domain		*m4u_dom;
-	struct iommu_group		*m4u_group;
+	struct iommu_group		*m4u_group[MTK_M4U_DOM_NR_MAX];
 	bool                            enable_4GB;
 	spinlock_t			tlb_lock; /* lock for tlb range flush */
 
@@ -77,6 +77,7 @@ struct mtk_iommu_data {
 
 	struct dma_iommu_mapping	*mapping; /* For mtk_iommu_v1.c */
 
+	unsigned int			cur_domid;
 	struct list_head		list;
 	struct mtk_smi_larb_iommu	larb_imu[MTK_LARB_NR_MAX];
 };
-- 
2.18.0

