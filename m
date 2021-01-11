Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA3172F1153
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 12:23:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729955AbhAKLXY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 06:23:24 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:60479 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729650AbhAKLXX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 06:23:23 -0500
X-UUID: c266d31348794a5c8ecfce1cd1868076-20210111
X-UUID: c266d31348794a5c8ecfce1cd1868076-20210111
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1104988850; Mon, 11 Jan 2021 19:22:52 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 11 Jan 2021 19:22:51 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 11 Jan 2021 19:22:50 +0800
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
Subject: [PATCH v6 21/33] iommu/mediatek: Support up to 34bit iova in tlb flush
Date:   Mon, 11 Jan 2021 19:19:02 +0800
Message-ID: <20210111111914.22211-22-yong.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210111111914.22211-1-yong.wu@mediatek.com>
References: <20210111111914.22211-1-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the iova is 34bit, the iova[32][33] is the bit0/1 in the tlb flush
register. Add a new macro for this.

In the macro, since (iova + size - 1) may be end with 0xfff, then the
bit0/1 always is 1, thus add a mask.

Signed-off-by: Yong Wu <yong.wu@mediatek.com>
---
 drivers/iommu/mtk_iommu.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index b9c63c8de33e..468be7ca62e4 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -129,6 +129,11 @@ static const struct iommu_ops mtk_iommu_ops;
 
 static int mtk_iommu_hw_init(const struct mtk_iommu_data *data);
 
+#define MTK_IOMMU_TLB_ADDR(iova) ({					\
+	dma_addr_t _addr = iova;					\
+	((lower_32_bits(_addr) & GENMASK(31, 12)) | upper_32_bits(_addr));\
+})
+
 /*
  * In M4U 4GB mode, the physical address is remapped as below:
  *
@@ -213,8 +218,9 @@ static void mtk_iommu_tlb_flush_range_sync(unsigned long iova, size_t size,
 		writel_relaxed(F_INVLD_EN1 | F_INVLD_EN0,
 			       data->base + data->plat_data->inv_sel_reg);
 
-		writel_relaxed(iova, data->base + REG_MMU_INVLD_START_A);
-		writel_relaxed(iova + size - 1,
+		writel_relaxed(MTK_IOMMU_TLB_ADDR(iova),
+			       data->base + REG_MMU_INVLD_START_A);
+		writel_relaxed(MTK_IOMMU_TLB_ADDR(iova + size - 1),
 			       data->base + REG_MMU_INVLD_END_A);
 		writel_relaxed(F_MMU_INV_RANGE,
 			       data->base + REG_MMU_INVALIDATE);
-- 
2.18.0

