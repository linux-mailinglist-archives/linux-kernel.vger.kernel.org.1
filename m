Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E8DA2AF0FC
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 13:41:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726979AbgKKMlk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 07:41:40 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:35010 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726923AbgKKMlf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 07:41:35 -0500
X-UUID: e905f26aa5dd4cb68b8f165cf756066c-20201111
X-UUID: e905f26aa5dd4cb68b8f165cf756066c-20201111
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1827595870; Wed, 11 Nov 2020 20:41:31 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 11 Nov 2020 20:41:28 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 11 Nov 2020 20:41:28 +0800
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
Subject: [PATCH v4 18/24] iommu/mediatek: Support master use iova over 32bit
Date:   Wed, 11 Nov 2020 20:38:32 +0800
Message-ID: <20201111123838.15682-19-yong.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20201111123838.15682-1-yong.wu@mediatek.com>
References: <20201111123838.15682-1-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After extending v7s, our pagetable already support iova reach
16GB(34bit). the master got the iova via dma_alloc_attrs may reach
34bits, but its HW register still is 32bit. then how to set the
bit32/bit33 iova? this depend on a SMI larb setting(bank_sel).

we separate whole 16GB iova to four banks:
bank: 0: 0~4G; 1: 4~8G; 2: 8-12G; 3: 12-16G;
The bank number is (iova >> 32).

We will preassign which bank the larbs belong to. currently we don't
have a interface for master to adjust its bank number.

Each a bank is a iova_region which is a independent iommu-domain.
the iova range for each iommu-domain can't cross 4G.

Signed-off-by: Yong Wu <yong.wu@mediatek.com>
Acked-by: Krzysztof Kozlowski <krzk@kernel.org> # memory part
---
 drivers/iommu/mtk_iommu.c  | 12 +++++++++---
 drivers/memory/mtk-smi.c   |  7 +++++++
 include/soc/mediatek/smi.h |  1 +
 3 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index a7727a3899d1..46c9143703a9 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -308,17 +308,23 @@ static void mtk_iommu_config(struct mtk_iommu_data *data,
 			     struct device *dev, bool enable)
 {
 	struct mtk_smi_larb_iommu    *larb_mmu;
-	unsigned int                 larbid, portid;
+	unsigned int                 larbid, portid, domid;
 	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
+	const struct mtk_iommu_iova_region *region;
 	int i;
 
 	for (i = 0; i < fwspec->num_ids; ++i) {
 		larbid = MTK_M4U_TO_LARB(fwspec->ids[i]);
 		portid = MTK_M4U_TO_PORT(fwspec->ids[i]);
+		domid = MTK_M4U_TO_DOM(fwspec->ids[i]);
+
 		larb_mmu = &data->larb_imu[larbid];
+		region = data->plat_data->iova_region + domid;
+		larb_mmu->bank[portid] = upper_32_bits(region->iova_base);
 
-		dev_dbg(dev, "%s iommu port: %d\n",
-			enable ? "enable" : "disable", portid);
+		dev_dbg(dev, "%s iommu for larb(%s) port %d dom %d bank %d.\n",
+			enable ? "enable" : "disable", dev_name(larb_mmu->dev),
+			portid, domid, larb_mmu->bank[portid]);
 
 		if (enable)
 			larb_mmu->mmu |= MTK_SMI_MMU_EN(portid);
diff --git a/drivers/memory/mtk-smi.c b/drivers/memory/mtk-smi.c
index a02ce091005d..935b72d60e9c 100644
--- a/drivers/memory/mtk-smi.c
+++ b/drivers/memory/mtk-smi.c
@@ -44,6 +44,10 @@
 /* mt2712 */
 #define SMI_LARB_NONSEC_CON(id)	(0x380 + ((id) * 4))
 #define F_MMU_EN		BIT(0)
+#define BANK_SEL(id)		({			\
+	u32 _id = (id) & 0x3;				\
+	(_id << 8 | _id << 10 | _id << 12 | _id << 14);	\
+})
 
 /* SMI COMMON */
 #define SMI_BUS_SEL			0x220
@@ -88,6 +92,7 @@ struct mtk_smi_larb { /* larb: local arbiter */
 	const struct mtk_smi_larb_gen	*larb_gen;
 	int				larbid;
 	u32				*mmu;
+	unsigned char			*bank;
 };
 
 static int mtk_smi_clk_enable(const struct mtk_smi *smi)
@@ -154,6 +159,7 @@ mtk_smi_larb_bind(struct device *dev, struct device *master, void *data)
 		if (dev == larb_mmu[i].dev) {
 			larb->larbid = i;
 			larb->mmu = &larb_mmu[i].mmu;
+			larb->bank = larb_mmu[i].bank;
 			return 0;
 		}
 	}
@@ -172,6 +178,7 @@ static void mtk_smi_larb_config_port_gen2_general(struct device *dev)
 	for_each_set_bit(i, (unsigned long *)larb->mmu, 32) {
 		reg = readl_relaxed(larb->base + SMI_LARB_NONSEC_CON(i));
 		reg |= F_MMU_EN;
+		reg |= BANK_SEL(larb->bank[i]);
 		writel(reg, larb->base + SMI_LARB_NONSEC_CON(i));
 	}
 }
diff --git a/include/soc/mediatek/smi.h b/include/soc/mediatek/smi.h
index 9371bf572ab8..4cf445dbbdaa 100644
--- a/include/soc/mediatek/smi.h
+++ b/include/soc/mediatek/smi.h
@@ -16,6 +16,7 @@
 struct mtk_smi_larb_iommu {
 	struct device *dev;
 	unsigned int   mmu;
+	unsigned char  bank[32];
 };
 
 /*
-- 
2.18.0

