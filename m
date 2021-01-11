Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A09C22F1165
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 12:27:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730028AbhAKLYX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 06:24:23 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:33662 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729637AbhAKLYU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 06:24:20 -0500
X-UUID: 47bfbcef09be4534bfd2b8fb72d7e07a-20210111
X-UUID: 47bfbcef09be4534bfd2b8fb72d7e07a-20210111
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 261536895; Mon, 11 Jan 2021 19:23:37 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 11 Jan 2021 19:23:36 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 11 Jan 2021 19:23:35 +0800
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
Subject: [PATCH v6 27/33] iommu/mediatek: Add get_domain_id from dev->dma_range_map
Date:   Mon, 11 Jan 2021 19:19:08 +0800
Message-ID: <20210111111914.22211-28-yong.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210111111914.22211-1-yong.wu@mediatek.com>
References: <20210111111914.22211-1-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new interface _get_domain_id from dev->dma_range_map,
The iommu consumer device will use dma-ranges in dtsi node to indicate
its dma address region requirement. In this iommu driver, we will get
the requirement and decide which iova domain it should locate.

In the lastest SoC, there will be several iova-regions(domains), we will
compare and calculate which domain is right. If the start/end of device
requirement equal some region. it is best fit of course. If it is inside
some region, it is also ok. the iova requirement of a device should not
be inside two or more regions.

Signed-off-by: Yong Wu <yong.wu@mediatek.com>
---
 drivers/iommu/mtk_iommu.c | 42 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 41 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index 6875ca1225f0..8fc17158bc28 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -8,6 +8,7 @@
 #include <linux/clk.h>
 #include <linux/component.h>
 #include <linux/device.h>
+#include <linux/dma-direct.h>
 #include <linux/dma-iommu.h>
 #include <linux/err.h>
 #include <linux/interrupt.h>
@@ -314,6 +315,36 @@ static irqreturn_t mtk_iommu_isr(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
+static int mtk_iommu_get_domain_id(struct device *dev,
+				   const struct mtk_iommu_plat_data *plat_data)
+{
+	const struct mtk_iommu_iova_region *rgn = plat_data->iova_region;
+	const struct bus_dma_region *dma_rgn = dev->dma_range_map;
+	int i, candidate = -1;
+	dma_addr_t dma_end;
+
+	if (!dma_rgn || plat_data->iova_region_nr == 1)
+		return 0;
+
+	dma_end = dma_rgn->dma_start + dma_rgn->size - 1;
+	for (i = 0; i < plat_data->iova_region_nr; i++, rgn++) {
+		/* Best fit. */
+		if (dma_rgn->dma_start == rgn->iova_base &&
+		    dma_end == rgn->iova_base + rgn->size - 1)
+			return i;
+		/* ok if it is inside this region. */
+		if (dma_rgn->dma_start >= rgn->iova_base &&
+		    dma_end < rgn->iova_base + rgn->size)
+			candidate = i;
+	}
+
+	if (candidate >= 0)
+		return candidate;
+	dev_err(dev, "Can NOT find the iommu domain id(%pad 0x%llx).\n",
+		&dma_rgn->dma_start, dma_rgn->size);
+	return -EINVAL;
+}
+
 static void mtk_iommu_config(struct mtk_iommu_data *data,
 			     struct device *dev, bool enable)
 {
@@ -400,11 +431,15 @@ static int mtk_iommu_attach_device(struct iommu_domain *domain,
 	struct mtk_iommu_data *data = dev_iommu_priv_get(dev);
 	struct mtk_iommu_domain *dom = to_mtk_domain(domain);
 	struct device *m4udev = data->dev;
-	int ret;
+	int ret, domid;
 
 	if (!data)
 		return -ENODEV;
 
+	domid = mtk_iommu_get_domain_id(dev, data->plat_data);
+	if (domid < 0)
+		return domid;
+
 	if (!dom->data) {
 		if (mtk_iommu_domain_finalise(dom, data))
 			return -ENODEV;
@@ -534,10 +569,15 @@ static void mtk_iommu_release_device(struct device *dev)
 static struct iommu_group *mtk_iommu_device_group(struct device *dev)
 {
 	struct mtk_iommu_data *data = mtk_iommu_get_m4u_data();
+	int domid;
 
 	if (!data)
 		return ERR_PTR(-ENODEV);
 
+	domid = mtk_iommu_get_domain_id(dev, data->plat_data);
+	if (domid < 0)
+		return ERR_PTR(domid);
+
 	/* All the client devices are in the same m4u iommu-group */
 	if (!data->m4u_group) {
 		data->m4u_group = iommu_group_alloc();
-- 
2.18.0

