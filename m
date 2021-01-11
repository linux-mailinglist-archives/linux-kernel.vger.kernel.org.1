Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 841D12F1157
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 12:23:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729984AbhAKLXm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 06:23:42 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:60479 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725868AbhAKLXk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 06:23:40 -0500
X-UUID: e9612186a5cf45c1bcba385b81320a14-20210111
X-UUID: e9612186a5cf45c1bcba385b81320a14-20210111
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1679903328; Mon, 11 Jan 2021 19:23:11 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 11 Jan 2021 19:23:09 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 11 Jan 2021 19:23:09 +0800
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
Subject: [PATCH v6 24/33] iommu/mediatek: Move domain_finalise into attach_device
Date:   Mon, 11 Jan 2021 19:19:05 +0800
Message-ID: <20210111111914.22211-25-yong.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210111111914.22211-1-yong.wu@mediatek.com>
References: <20210111111914.22211-1-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently domain_alloc only has a parameter(type), We have no chance to
input some special data. This patch moves the domain_finalise into
attach_device which has the device information, then could update
the domain's geometry.aperture ranges for each a device.

Strictly, I should use the data from mtk_iommu_get_m4u_data as the
parameter of mtk_iommu_domain_finalise in this patch. but dom->data
only is used in tlb ops in which the data is get from the m4u_list, thus
it is ok here.

Signed-off-by: Yong Wu <yong.wu@mediatek.com>
---
 drivers/iommu/mtk_iommu.c | 31 ++++++++++++-------------------
 1 file changed, 12 insertions(+), 19 deletions(-)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index f1941608ccb7..d321d09ac4c2 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -328,10 +328,9 @@ static void mtk_iommu_config(struct mtk_iommu_data *data,
 	}
 }
 
-static int mtk_iommu_domain_finalise(struct mtk_iommu_domain *dom)
+static int mtk_iommu_domain_finalise(struct mtk_iommu_domain *dom,
+				     struct mtk_iommu_data *data)
 {
-	struct mtk_iommu_data *data = mtk_iommu_get_m4u_data();
-
 	dom->cfg = (struct io_pgtable_cfg) {
 		.quirks = IO_PGTABLE_QUIRK_ARM_NS |
 			IO_PGTABLE_QUIRK_NO_PERMS |
@@ -352,7 +351,6 @@ static int mtk_iommu_domain_finalise(struct mtk_iommu_domain *dom)
 		return -EINVAL;
 	}
 
-	dom->data = data;
 	/* Update our support page sizes bitmap */
 	dom->domain.pgsize_bitmap = dom->cfg.pgsize_bitmap;
 	return 0;
@@ -369,30 +367,19 @@ static struct iommu_domain *mtk_iommu_domain_alloc(unsigned type)
 	if (!dom)
 		return NULL;
 
-	if (iommu_get_dma_cookie(&dom->domain))
-		goto  free_dom;
-
-	if (mtk_iommu_domain_finalise(dom))
-		goto  put_dma_cookie;
+	if (iommu_get_dma_cookie(&dom->domain)) {
+		kfree(dom);
+		return NULL;
+	}
 
 	dom->domain.geometry.aperture_start = 0;
 	dom->domain.geometry.aperture_end = DMA_BIT_MASK(32);
 	dom->domain.geometry.force_aperture = true;
-
 	return &dom->domain;
-
-put_dma_cookie:
-	iommu_put_dma_cookie(&dom->domain);
-free_dom:
-	kfree(dom);
-	return NULL;
 }
 
 static void mtk_iommu_domain_free(struct iommu_domain *domain)
 {
-	struct mtk_iommu_domain *dom = to_mtk_domain(domain);
-
-	free_io_pgtable_ops(dom->iop);
 	iommu_put_dma_cookie(domain);
 	kfree(to_mtk_domain(domain));
 }
@@ -408,6 +395,12 @@ static int mtk_iommu_attach_device(struct iommu_domain *domain,
 	if (!data)
 		return -ENODEV;
 
+	if (!dom->data) {
+		if (mtk_iommu_domain_finalise(dom, data))
+			return -ENODEV;
+		dom->data = data;
+	}
+
 	if (!data->m4u_dom) { /* Initialize the M4U HW */
 		ret = pm_runtime_resume_and_get(m4udev);
 		if (ret < 0)
-- 
2.18.0

