Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC1582F1161
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 12:27:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729616AbhAKLYB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 06:24:01 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:46248 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729544AbhAKLX7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 06:23:59 -0500
X-UUID: a63ee9ac1e574feba14e294c2bb66451-20210111
X-UUID: a63ee9ac1e574feba14e294c2bb66451-20210111
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1850579567; Mon, 11 Jan 2021 19:23:30 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 11 Jan 2021 19:23:30 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 11 Jan 2021 19:23:29 +0800
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
Subject: [PATCH v6 26/33] iommu/mediatek: Add iova_region structure
Date:   Mon, 11 Jan 2021 19:19:07 +0800
Message-ID: <20210111111914.22211-27-yong.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210111111914.22211-1-yong.wu@mediatek.com>
References: <20210111111914.22211-1-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new structure for the iova_region. Each a region will be a
independent iommu domain.

For the previous SoC, there is single iova region(0~4G). For the SoC
that need support multi-domains, there will be several regions.

Signed-off-by: Yong Wu <yong.wu@mediatek.com>
---
 drivers/iommu/mtk_iommu.c | 19 +++++++++++++++++++
 drivers/iommu/mtk_iommu.h |  5 +++++
 2 files changed, 24 insertions(+)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index 309b06d5e1f9..6875ca1225f0 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -167,6 +167,15 @@ static LIST_HEAD(m4ulist);	/* List all the M4U HWs */
 
 #define for_each_m4u(data)	list_for_each_entry(data, &m4ulist, list)
 
+struct mtk_iommu_iova_region {
+	dma_addr_t		iova_base;
+	unsigned long long	size;
+};
+
+static const struct mtk_iommu_iova_region single_domain[] = {
+	{.iova_base = 0,		.size = SZ_4G},
+};
+
 /*
  * There may be 1 or 2 M4U HWs, But we always expect they are in the same domain
  * for the performance.
@@ -901,6 +910,8 @@ static const struct mtk_iommu_plat_data mt2712_data = {
 	.m4u_plat     = M4U_MT2712,
 	.flags        = HAS_4GB_MODE | HAS_BCLK | HAS_VLD_PA_RNG,
 	.inv_sel_reg  = REG_MMU_INV_SEL_GEN1,
+	.iova_region  = single_domain,
+	.iova_region_nr = ARRAY_SIZE(single_domain),
 	.larbid_remap = {{0}, {1}, {2}, {3}, {4}, {5}, {6}, {7}},
 };
 
@@ -908,6 +919,8 @@ static const struct mtk_iommu_plat_data mt6779_data = {
 	.m4u_plat      = M4U_MT6779,
 	.flags         = HAS_SUB_COMM | OUT_ORDER_WR_EN | WR_THROT_EN,
 	.inv_sel_reg   = REG_MMU_INV_SEL_GEN2,
+	.iova_region   = single_domain,
+	.iova_region_nr = ARRAY_SIZE(single_domain),
 	.larbid_remap  = {{0}, {1}, {2}, {3}, {5}, {7, 8}, {10}, {9}},
 };
 
@@ -915,6 +928,8 @@ static const struct mtk_iommu_plat_data mt8167_data = {
 	.m4u_plat     = M4U_MT8167,
 	.flags        = RESET_AXI | HAS_LEGACY_IVRP_PADDR,
 	.inv_sel_reg  = REG_MMU_INV_SEL_GEN1,
+	.iova_region  = single_domain,
+	.iova_region_nr = ARRAY_SIZE(single_domain),
 	.larbid_remap = {{0}, {1}, {2}}, /* Linear mapping. */
 };
 
@@ -923,6 +938,8 @@ static const struct mtk_iommu_plat_data mt8173_data = {
 	.flags	      = HAS_4GB_MODE | HAS_BCLK | RESET_AXI |
 			HAS_LEGACY_IVRP_PADDR,
 	.inv_sel_reg  = REG_MMU_INV_SEL_GEN1,
+	.iova_region  = single_domain,
+	.iova_region_nr = ARRAY_SIZE(single_domain),
 	.larbid_remap = {{0}, {1}, {2}, {3}, {4}, {5}}, /* Linear mapping. */
 };
 
@@ -930,6 +947,8 @@ static const struct mtk_iommu_plat_data mt8183_data = {
 	.m4u_plat     = M4U_MT8183,
 	.flags        = RESET_AXI,
 	.inv_sel_reg  = REG_MMU_INV_SEL_GEN1,
+	.iova_region  = single_domain,
+	.iova_region_nr = ARRAY_SIZE(single_domain),
 	.larbid_remap = {{0}, {4}, {5}, {6}, {7}, {2}, {3}, {1}},
 };
 
diff --git a/drivers/iommu/mtk_iommu.h b/drivers/iommu/mtk_iommu.h
index a9b79e118f02..118170af1974 100644
--- a/drivers/iommu/mtk_iommu.h
+++ b/drivers/iommu/mtk_iommu.h
@@ -45,10 +45,15 @@ enum mtk_iommu_plat {
 	M4U_MT8183,
 };
 
+struct mtk_iommu_iova_region;
+
 struct mtk_iommu_plat_data {
 	enum mtk_iommu_plat m4u_plat;
 	u32                 flags;
 	u32                 inv_sel_reg;
+
+	unsigned int				iova_region_nr;
+	const struct mtk_iommu_iova_region	*iova_region;
 	unsigned char       larbid_remap[MTK_LARB_COM_MAX][MTK_LARB_SUBCOM_MAX];
 };
 
-- 
2.18.0

