Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 934EA2F1167
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 12:27:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730041AbhAKLYb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 06:24:31 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:33774 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729637AbhAKLYa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 06:24:30 -0500
X-UUID: 72edc036a5ef4e88a2c5b4f2841ff22f-20210111
X-UUID: 72edc036a5ef4e88a2c5b4f2841ff22f-20210111
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1024492409; Mon, 11 Jan 2021 19:23:46 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 11 Jan 2021 19:23:45 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 11 Jan 2021 19:23:44 +0800
From:   Yong Wu <yong.wu@mediatek.com>
To:     Joerg Roedel <joro@8bytes.org>, Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
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
Subject: [PATCH v6 28/33] iommu/mediatek: Support for multi domains
Date:   Mon, 11 Jan 2021 19:19:09 +0800
Message-ID: <20210111111914.22211-29-yong.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210111111914.22211-1-yong.wu@mediatek.com>
References: <20210111111914.22211-1-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some HW IP(ex: CCU) require the special iova range. That means the iova
got from dma_alloc_attrs for that devices must locate in his special range.
In this patch, we prepare a iommu group(domain) for each a iova range
requirement.

Meanwhile we still use one pagetable which support 16GB iova.

After this patch, If the iova range of a master is over 4G, the master
should:
a) Declare its special dma-ranges in its dtsi node. For example, If we
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
 drivers/iommu/mtk_iommu.c | 37 ++++++++++++++++++++++++++-----------
 drivers/iommu/mtk_iommu.h |  4 +++-
 2 files changed, 29 insertions(+), 12 deletions(-)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index 8fc17158bc28..b42fd2535b77 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -369,8 +369,19 @@ static void mtk_iommu_config(struct mtk_iommu_data *data,
 }
 
 static int mtk_iommu_domain_finalise(struct mtk_iommu_domain *dom,
-				     struct mtk_iommu_data *data)
+				     struct mtk_iommu_data *data,
+				     unsigned int domid)
 {
+	const struct mtk_iommu_iova_region *region;
+
+	/* Use the exist domain as there is only one pgtable here. */
+	if (data->m4u_dom) {
+		dom->iop = data->m4u_dom->iop;
+		dom->cfg = data->m4u_dom->cfg;
+		dom->domain.pgsize_bitmap = data->m4u_dom->cfg.pgsize_bitmap;
+		goto update_iova_region;
+	}
+
 	dom->cfg = (struct io_pgtable_cfg) {
 		.quirks = IO_PGTABLE_QUIRK_ARM_NS |
 			IO_PGTABLE_QUIRK_NO_PERMS |
@@ -394,8 +405,11 @@ static int mtk_iommu_domain_finalise(struct mtk_iommu_domain *dom,
 	/* Update our support page sizes bitmap */
 	dom->domain.pgsize_bitmap = dom->cfg.pgsize_bitmap;
 
-	dom->domain.geometry.aperture_start = 0;
-	dom->domain.geometry.aperture_end = DMA_BIT_MASK(32);
+update_iova_region:
+	/* Update the iova region for this domain */
+	region = data->plat_data->iova_region + domid;
+	dom->domain.geometry.aperture_start = region->iova_base;
+	dom->domain.geometry.aperture_end = region->iova_base + region->size - 1;
 	dom->domain.geometry.force_aperture = true;
 	return 0;
 }
@@ -441,7 +455,7 @@ static int mtk_iommu_attach_device(struct iommu_domain *domain,
 		return domid;
 
 	if (!dom->data) {
-		if (mtk_iommu_domain_finalise(dom, data))
+		if (mtk_iommu_domain_finalise(dom, data, domid))
 			return -ENODEV;
 		dom->data = data;
 	}
@@ -569,6 +583,7 @@ static void mtk_iommu_release_device(struct device *dev)
 static struct iommu_group *mtk_iommu_device_group(struct device *dev)
 {
 	struct mtk_iommu_data *data = mtk_iommu_get_m4u_data();
+	struct iommu_group *group;
 	int domid;
 
 	if (!data)
@@ -578,15 +593,15 @@ static struct iommu_group *mtk_iommu_device_group(struct device *dev)
 	if (domid < 0)
 		return ERR_PTR(domid);
 
-	/* All the client devices are in the same m4u iommu-group */
-	if (!data->m4u_group) {
-		data->m4u_group = iommu_group_alloc();
-		if (IS_ERR(data->m4u_group))
-			dev_err(dev, "Failed to allocate M4U IOMMU group\n");
+	group = data->m4u_group[domid];
+	if (!group) {
+		group = iommu_group_alloc();
+		if (!IS_ERR(group))
+			data->m4u_group[domid] = group;
 	} else {
-		iommu_group_ref_get(data->m4u_group);
+		iommu_group_ref_get(group);
 	}
-	return data->m4u_group;
+	return group;
 }
 
 static int mtk_iommu_of_xlate(struct device *dev, struct of_phandle_args *args)
diff --git a/drivers/iommu/mtk_iommu.h b/drivers/iommu/mtk_iommu.h
index 118170af1974..6f2168e3222d 100644
--- a/drivers/iommu/mtk_iommu.h
+++ b/drivers/iommu/mtk_iommu.h
@@ -22,6 +22,8 @@
 #define MTK_LARB_COM_MAX	8
 #define MTK_LARB_SUBCOM_MAX	4
 
+#define MTK_IOMMU_GROUP_MAX	8
+
 struct mtk_iommu_suspend_reg {
 	union {
 		u32			standard_axi_mode;/* v1 */
@@ -67,7 +69,7 @@ struct mtk_iommu_data {
 	phys_addr_t			protect_base; /* protect memory base */
 	struct mtk_iommu_suspend_reg	reg;
 	struct mtk_iommu_domain		*m4u_dom;
-	struct iommu_group		*m4u_group;
+	struct iommu_group		*m4u_group[MTK_IOMMU_GROUP_MAX];
 	bool                            enable_4GB;
 	spinlock_t			tlb_lock; /* lock for tlb range flush */
 
-- 
2.18.0

