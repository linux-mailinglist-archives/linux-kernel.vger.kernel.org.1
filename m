Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 850162AF0F0
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 13:41:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726906AbgKKMlR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 07:41:17 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:58137 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726897AbgKKMlP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 07:41:15 -0500
X-UUID: dfd23aa02cbb494db0a286a2be4eaf22-20201111
X-UUID: dfd23aa02cbb494db0a286a2be4eaf22-20201111
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw02.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 907776938; Wed, 11 Nov 2020 20:41:10 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 11 Nov 2020 20:41:08 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 11 Nov 2020 20:41:08 +0800
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
Subject: [PATCH v4 15/24] iommu/mediatek: Add power-domain operation
Date:   Wed, 11 Nov 2020 20:38:29 +0800
Message-ID: <20201111123838.15682-16-yong.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20201111123838.15682-1-yong.wu@mediatek.com>
References: <20201111123838.15682-1-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the previous SoC, the M4U HW is in the EMI power domain which is
always on. the latest M4U is in the display power domain which may be
turned on/off, thus we have to add pm_runtime interface for it.

When the engine work, the engine always enable the power and clocks for
smi-larb/smi-common, then the M4U's power will always be powered on
automatically via the device link with smi-common.

Note: we don't enable the M4U power in iommu_map/unmap for tlb flush.
If its power already is on, of course it is ok. if the power is off,
the main tlb will be reset while M4U power on, thus the tlb flush while
m4u power off is unnecessary, just skip it.

There will be one case that pm runctime status is not expected when tlb
flush. After boot, the display may call dma_alloc_attrs before it call
pm_runtime_get(disp-dev), then the m4u's pm status is not active inside
the dma_alloc_attrs. Since it only happens after boot, the tlb is clean
at that time, I also think this is ok.

Signed-off-by: Yong Wu <yong.wu@mediatek.com>
---
 drivers/iommu/mtk_iommu.c | 33 +++++++++++++++++++++++++++------
 1 file changed, 27 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index fe16053eda48..90aae34f4da0 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -183,6 +183,8 @@ static void mtk_iommu_tlb_flush_all(void *cookie)
 	struct mtk_iommu_data *data = cookie;
 
 	for_each_m4u(data) {
+		if (!pm_runtime_active(data->dev))
+			continue;
 		writel_relaxed(F_INVLD_EN1 | F_INVLD_EN0,
 			       data->base + data->plat_data->inv_sel_reg);
 		writel_relaxed(F_ALL_INVLD, data->base + REG_MMU_INVALIDATE);
@@ -199,6 +201,10 @@ static void mtk_iommu_tlb_flush_range_sync(unsigned long iova, size_t size,
 	u32 tmp;
 
 	for_each_m4u(data) {
+		/* skip tlb flush when pm is not active. */
+		if (!pm_runtime_active(data->dev))
+			continue;
+
 		spin_lock_irqsave(&data->tlb_lock, flags);
 		writel_relaxed(F_INVLD_EN1 | F_INVLD_EN0,
 			       data->base + data->plat_data->inv_sel_reg);
@@ -383,6 +389,7 @@ static int mtk_iommu_attach_device(struct iommu_domain *domain,
 {
 	struct mtk_iommu_data *data = dev_iommu_priv_get(dev);
 	struct mtk_iommu_domain *dom = to_mtk_domain(domain);
+	struct device *m4udev = data->dev;
 	int ret;
 
 	if (!data)
@@ -390,12 +397,18 @@ static int mtk_iommu_attach_device(struct iommu_domain *domain,
 
 	/* Update the pgtable base address register of the M4U HW */
 	if (!data->m4u_dom) {
+		ret = pm_runtime_get_sync(m4udev);
+		if (ret < 0)
+			return ret;
 		ret = mtk_iommu_hw_init(data);
-		if (ret)
+		if (ret) {
+			pm_runtime_put(m4udev);
 			return ret;
+		}
 		data->m4u_dom = dom;
 		writel(dom->cfg.arm_v7s_cfg.ttbr & MMU_PT_ADDR_MASK,
 		       data->base + REG_MMU_PT_BASE_ADDR);
+		pm_runtime_put(m4udev);
 	}
 
 	mtk_iommu_config(data, dev, true);
@@ -746,10 +759,13 @@ static int mtk_iommu_probe(struct platform_device *pdev)
 	if (dev->pm_domain) {
 		struct device_link *link;
 
+		pm_runtime_enable(dev);
+
 		link = device_link_add(data->smicomm_dev, dev,
 				       DL_FLAG_STATELESS | DL_FLAG_PM_RUNTIME);
 		if (!link) {
 			dev_err(dev, "Unable link %s.\n", dev_name(data->smicomm_dev));
+			pm_runtime_disable(dev);
 			return -EINVAL;
 		}
 	}
@@ -779,8 +795,10 @@ static int mtk_iommu_probe(struct platform_device *pdev)
 out_sysfs_remove:
 	iommu_device_sysfs_remove(&data->iommu);
 out_link_remove:
-	if (dev->pm_domain)
+	if (dev->pm_domain) {
 		device_link_remove(data->smicomm_dev, dev);
+		pm_runtime_disable(dev);
+	}
 	return ret;
 }
 
@@ -795,8 +813,10 @@ static int mtk_iommu_remove(struct platform_device *pdev)
 		bus_set_iommu(&platform_bus_type, NULL);
 
 	clk_disable_unprepare(data->bclk);
-	if (pdev->dev.pm_domain)
+	if (pdev->dev.pm_domain) {
 		device_link_remove(data->smicomm_dev, &pdev->dev);
+		pm_runtime_disable(&pdev->dev);
+	}
 	devm_free_irq(&pdev->dev, data->irq, data);
 	component_master_del(&pdev->dev, &mtk_iommu_com_ops);
 	return 0;
@@ -828,6 +848,9 @@ static int __maybe_unused mtk_iommu_runtime_resume(struct device *dev)
 	void __iomem *base = data->base;
 	int ret;
 
+	/* Avoid first resume to affect the default value of registers below. */
+	if (!m4u_dom)
+		return 0;
 	ret = clk_prepare_enable(data->bclk);
 	if (ret) {
 		dev_err(data->dev, "Failed to enable clk(%d) in resume\n", ret);
@@ -841,9 +864,7 @@ static int __maybe_unused mtk_iommu_runtime_resume(struct device *dev)
 	writel_relaxed(reg->int_main_control, base + REG_MMU_INT_MAIN_CONTROL);
 	writel_relaxed(reg->ivrp_paddr, base + REG_MMU_IVRP_PADDR);
 	writel_relaxed(reg->vld_pa_rng, base + REG_MMU_VLD_PA_RNG);
-	if (m4u_dom)
-		writel(m4u_dom->cfg.arm_v7s_cfg.ttbr & MMU_PT_ADDR_MASK,
-		       base + REG_MMU_PT_BASE_ADDR);
+	writel(m4u_dom->cfg.arm_v7s_cfg.ttbr & MMU_PT_ADDR_MASK, base + REG_MMU_PT_BASE_ADDR);
 	return 0;
 }
 
-- 
2.18.0

