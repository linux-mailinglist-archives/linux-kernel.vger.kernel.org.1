Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C80B52D3CE7
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 09:07:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728838AbgLIIFq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 03:05:46 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:47508 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727728AbgLIIFb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 03:05:31 -0500
X-UUID: 93a17a495d734472a414fa9effc32f86-20201209
X-UUID: 93a17a495d734472a414fa9effc32f86-20201209
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 2118711044; Wed, 09 Dec 2020 16:04:46 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 9 Dec 2020 16:04:45 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 9 Dec 2020 16:04:44 +0800
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
Subject: [PATCH v5 22/27] iommu/mediatek: Support up to 34bit iova in tlb flush
Date:   Wed, 9 Dec 2020 16:00:57 +0800
Message-ID: <20201209080102.26626-23-yong.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20201209080102.26626-1-yong.wu@mediatek.com>
References: <20201209080102.26626-1-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the iova is 34bit, the iova[32][33] is the bit0/1 in the tlb flush
register. Add a new macro for this.

there is a minor change unrelated with this patch. it also use the new
macro.

Signed-off-by: Yong Wu <yong.wu@mediatek.com>
---
 drivers/iommu/mtk_iommu.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index f206275230b3..164479e1f5c5 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -129,6 +129,9 @@ static const struct iommu_ops mtk_iommu_ops;
 
 static int mtk_iommu_hw_init(const struct mtk_iommu_data *data);
 
+#define MTK_IOMMU_ADDR(addr) ({unsigned long _addr = addr; \
+			      (lower_32_bits(_addr) | upper_32_bits(_addr)); })
+
 /*
  * In M4U 4GB mode, the physical address is remapped as below:
  *
@@ -219,8 +222,9 @@ static void mtk_iommu_tlb_flush_range_sync(unsigned long iova, size_t size,
 		writel_relaxed(F_INVLD_EN1 | F_INVLD_EN0,
 			       data->base + data->plat_data->inv_sel_reg);
 
-		writel_relaxed(iova, data->base + REG_MMU_INVLD_START_A);
-		writel_relaxed(iova + size - 1,
+		writel_relaxed(MTK_IOMMU_ADDR(iova),
+			       data->base + REG_MMU_INVLD_START_A);
+		writel_relaxed(MTK_IOMMU_ADDR(iova + size - 1),
 			       data->base + REG_MMU_INVLD_END_A);
 		writel_relaxed(F_MMU_INV_RANGE,
 			       data->base + REG_MMU_INVALIDATE);
@@ -648,8 +652,7 @@ static int mtk_iommu_hw_init(const struct mtk_iommu_data *data)
 	if (MTK_IOMMU_HAS_FLAG(data->plat_data, HAS_LEGACY_IVRP_PADDR))
 		regval = (data->protect_base >> 1) | (data->enable_4GB << 31);
 	else
-		regval = lower_32_bits(data->protect_base) |
-			 upper_32_bits(data->protect_base);
+		regval = MTK_IOMMU_ADDR(data->protect_base);
 	writel_relaxed(regval, data->base + REG_MMU_IVRP_PADDR);
 
 	if (data->enable_4GB &&
-- 
2.18.0

