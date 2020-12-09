Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F14042D3CF0
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 09:07:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728904AbgLIIGV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 03:06:21 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:47650 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728860AbgLIIGC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 03:06:02 -0500
X-UUID: 98d6b5e88fc4486ea459ffa97c9c8ccf-20201209
X-UUID: 98d6b5e88fc4486ea459ffa97c9c8ccf-20201209
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 2117350880; Wed, 09 Dec 2020 16:05:20 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 9 Dec 2020 16:05:18 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 9 Dec 2020 16:05:18 +0800
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
Subject: [PATCH v5 26/27] iommu/mediatek: Add mt8192 support
Date:   Wed, 9 Dec 2020 16:01:01 +0800
Message-ID: <20201209080102.26626-27-yong.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20201209080102.26626-1-yong.wu@mediatek.com>
References: <20201209080102.26626-1-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add mt8192 iommu support.

For multi domain, Add 1M gap for the vdec domain size. That is because
vdec HW has a end address register which require (start_addr +
len) rather than (start_addr + len - 1). Take a example, if the start_addr
is 0xfff00000, size is 0x100000, then the end_address is 0xfff00000 +
0x100000 = 0x1 0000 0000. but the register only is 32bit. thus HW will get
the end address is 0. To avoid this issue, I add 1M gap for this.

Signed-off-by: Yong Wu <yong.wu@mediatek.com>
---
 drivers/iommu/mtk_iommu.c | 22 ++++++++++++++++++++++
 drivers/iommu/mtk_iommu.h |  1 +
 2 files changed, 23 insertions(+)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index 92c1e2f0af89..799adf7b39d3 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -174,6 +174,16 @@ static const struct mtk_iommu_iova_region single_domain[] = {
 	{.iova_base = 0,		.size = SZ_4G},
 };
 
+static const struct mtk_iommu_iova_region mt8192_multi_dom[] = {
+	{ .iova_base = 0x0,		.size = SZ_4G},		/* disp: 0 ~ 4G */
+	#if IS_ENABLED(CONFIG_ARCH_DMA_ADDR_T_64BIT)
+	{ .iova_base = SZ_4G,		.size = SZ_4G - SZ_1M},	/* vdec: 4G ~ 8G gap: 1M */
+	{ .iova_base = SZ_4G * 2,	.size = SZ_4G - SZ_1M},	/* CAM/MDP: 8G ~ 12G */
+	{ .iova_base = 0x240000000ULL,	.size = 0x4000000},	/* CCU0 */
+	{ .iova_base = 0x244000000ULL,	.size = 0x4000000},	/* CCU1 */
+	#endif
+};
+
 /*
  * There may be 1 or 2 M4U HWs, But we always expect they are in the same domain
  * for the performance.
@@ -1035,12 +1045,24 @@ static const struct mtk_iommu_plat_data mt8183_data = {
 	.larbid_remap = {{0}, {4}, {5}, {6}, {7}, {2}, {3}, {1}},
 };
 
+static const struct mtk_iommu_plat_data mt8192_data = {
+	.m4u_plat       = M4U_MT8192,
+	.flags          = HAS_BCLK | HAS_SUB_COMM | OUT_ORDER_WR_EN |
+			  WR_THROT_EN | IOVA_34_EN,
+	.inv_sel_reg    = REG_MMU_INV_SEL_GEN2,
+	.iova_region    = mt8192_multi_dom,
+	.iova_region_nr = ARRAY_SIZE(mt8192_multi_dom),
+	.larbid_remap   = {{0}, {1}, {4, 5}, {7}, {2}, {9, 11, 19, 20},
+			   {0, 14, 16}, {0, 13, 18, 17}},
+};
+
 static const struct of_device_id mtk_iommu_of_ids[] = {
 	{ .compatible = "mediatek,mt2712-m4u", .data = &mt2712_data},
 	{ .compatible = "mediatek,mt6779-m4u", .data = &mt6779_data},
 	{ .compatible = "mediatek,mt8167-m4u", .data = &mt8167_data},
 	{ .compatible = "mediatek,mt8173-m4u", .data = &mt8173_data},
 	{ .compatible = "mediatek,mt8183-m4u", .data = &mt8183_data},
+	{ .compatible = "mediatek,mt8192-m4u", .data = &mt8192_data},
 	{}
 };
 
diff --git a/drivers/iommu/mtk_iommu.h b/drivers/iommu/mtk_iommu.h
index b54862307128..e96b1b8639f4 100644
--- a/drivers/iommu/mtk_iommu.h
+++ b/drivers/iommu/mtk_iommu.h
@@ -43,6 +43,7 @@ enum mtk_iommu_plat {
 	M4U_MT8167,
 	M4U_MT8173,
 	M4U_MT8183,
+	M4U_MT8192,
 };
 
 struct mtk_iommu_iova_region;
-- 
2.18.0

