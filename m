Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D9B22F1146
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 12:23:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729847AbhAKLWg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 06:22:36 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:60030 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728305AbhAKLWf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 06:22:35 -0500
X-UUID: b710d73c20bb4a2e8f89df9aad4e615d-20210111
X-UUID: b710d73c20bb4a2e8f89df9aad4e615d-20210111
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 604849001; Mon, 11 Jan 2021 19:21:55 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 11 Jan 2021 19:21:53 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 11 Jan 2021 19:21:53 +0800
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
Subject: [PATCH v6 15/33] iommu/mediatek: Update oas for v7s
Date:   Mon, 11 Jan 2021 19:18:56 +0800
Message-ID: <20210111111914.22211-16-yong.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210111111914.22211-1-yong.wu@mediatek.com>
References: <20210111111914.22211-1-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch only updates oas in different SoCs.

If the SoC supports 4GB-mode and current dram size is 4GB, the oas is 33.
otherwise, it's still 32. In the lastest SoC, the oas is 35bits.

Signed-off-by: Yong Wu <yong.wu@mediatek.com>
---
 drivers/iommu/mtk_iommu.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index bf1277d58121..1c4af574f5f7 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -301,10 +301,14 @@ static int mtk_iommu_domain_finalise(struct mtk_iommu_domain *dom)
 			IO_PGTABLE_QUIRK_ARM_MTK_EXT,
 		.pgsize_bitmap = mtk_iommu_ops.pgsize_bitmap,
 		.ias = MTK_IOMMU_HAS_FLAG(data->plat_data, IOVA_34_EN) ? 34 : 32,
-		.oas = 35,
 		.iommu_dev = data->dev,
 	};
 
+	if (MTK_IOMMU_HAS_FLAG(data->plat_data, HAS_4GB_MODE))
+		dom->cfg.oas = data->enable_4GB ? 33 : 32;
+	else
+		dom->cfg.oas = 35;
+
 	dom->iop = alloc_io_pgtable_ops(ARM_V7S, &dom->cfg, data);
 	if (!dom->iop) {
 		dev_err(data->dev, "Failed to alloc io pgtable\n");
-- 
2.18.0

