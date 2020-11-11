Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32B662AF0F9
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 13:41:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726944AbgKKMlb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 07:41:31 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:34893 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726923AbgKKMl2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 07:41:28 -0500
X-UUID: bc8fa4358de34e7cb2a9b8c141056f49-20201111
X-UUID: bc8fa4358de34e7cb2a9b8c141056f49-20201111
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 31783035; Wed, 11 Nov 2020 20:41:25 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 11 Nov 2020 20:41:22 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 11 Nov 2020 20:41:21 +0800
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
Subject: [PATCH v4 17/24] iommu/mediatek: Add single domain
Date:   Wed, 11 Nov 2020 20:38:31 +0800
Message-ID: <20201111123838.15682-18-yong.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20201111123838.15682-1-yong.wu@mediatek.com>
References: <20201111123838.15682-1-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Defaultly the iova range is 0-4G. here we add a single-domain(0-4G)
for the previous SoC. this also is a preparing patch for supporting
multi-domains.

Signed-off-by: Yong Wu <yong.wu@mediatek.com>
---
 drivers/iommu/mtk_iommu.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index bf3f4e0f4748..a7727a3899d1 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -161,6 +161,10 @@ struct mtk_iommu_iova_region {
 	unsigned long long	size;
 };
 
+static const struct mtk_iommu_iova_region single_domain[] = {
+	{.iova_base = 0,		.size = SZ_4G},
+};
+
 /*
  * There may be 1 or 2 M4U HWs, But we always expect they are in the same domain
  * for the performance.
@@ -922,6 +926,8 @@ static const struct mtk_iommu_plat_data mt2712_data = {
 	.m4u_plat     = M4U_MT2712,
 	.flags        = HAS_4GB_MODE | HAS_BCLK | HAS_VLD_PA_RNG,
 	.inv_sel_reg  = REG_MMU_INV_SEL_GEN1,
+	.iova_region  = single_domain,
+	.iova_region_nr = ARRAY_SIZE(single_domain),
 	.larbid_remap = {{0}, {1}, {2}, {3}, {4}, {5}, {6}, {7}},
 };
 
@@ -929,6 +935,8 @@ static const struct mtk_iommu_plat_data mt6779_data = {
 	.m4u_plat      = M4U_MT6779,
 	.flags         = HAS_SUB_COMM | OUT_ORDER_WR_EN | WR_THROT_EN,
 	.inv_sel_reg   = REG_MMU_INV_SEL_GEN2,
+	.iova_region   = single_domain,
+	.iova_region_nr = ARRAY_SIZE(single_domain),
 	.larbid_remap  = {{0}, {1}, {2}, {3}, {5}, {7, 8}, {10}, {9}},
 };
 
@@ -944,6 +952,8 @@ static const struct mtk_iommu_plat_data mt8173_data = {
 	.flags	      = HAS_4GB_MODE | HAS_BCLK | RESET_AXI |
 			HAS_LEGACY_IVRP_PADDR,
 	.inv_sel_reg  = REG_MMU_INV_SEL_GEN1,
+	.iova_region  = single_domain,
+	.iova_region_nr = ARRAY_SIZE(single_domain),
 	.larbid_remap = {{0}, {1}, {2}, {3}, {4}, {5}}, /* Linear mapping. */
 };
 
@@ -951,6 +961,8 @@ static const struct mtk_iommu_plat_data mt8183_data = {
 	.m4u_plat     = M4U_MT8183,
 	.flags        = RESET_AXI,
 	.inv_sel_reg  = REG_MMU_INV_SEL_GEN1,
+	.iova_region  = single_domain,
+	.iova_region_nr = ARRAY_SIZE(single_domain),
 	.larbid_remap = {{0}, {4}, {5}, {6}, {7}, {2}, {3}, {1}},
 };
 
-- 
2.18.0

