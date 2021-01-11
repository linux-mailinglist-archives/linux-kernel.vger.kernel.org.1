Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B913C2F1151
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 12:23:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729941AbhAKLXN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 06:23:13 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:60030 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729902AbhAKLXJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 06:23:09 -0500
X-UUID: 343936d70bd141c2bf6093e4313bcfe5-20210111
X-UUID: 343936d70bd141c2bf6093e4313bcfe5-20210111
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1538222942; Mon, 11 Jan 2021 19:22:44 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 11 Jan 2021 19:22:43 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 11 Jan 2021 19:22:42 +0800
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
Subject: [PATCH v6 20/33] iommu/mediatek: Add power-domain operation
Date:   Mon, 11 Jan 2021 19:19:01 +0800
Message-ID: <20210111111914.22211-21-yong.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210111111914.22211-1-yong.wu@mediatek.com>
References: <20210111111914.22211-1-yong.wu@mediatek.com>
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
Therefore, we increase the ref_count for pm when pm status is ACTIVE,
otherwise, skip it. Meanwhile, the tlb_flush_range is called so often,
thus, update pm ref_count while the SoC has power-domain to avoid touch the
dev->power.lock. and the tlb_flush_all only is called when boot, so no
need check if the SoC has power-domain to keep code clean.

There will be one case that pm runctime status is not expected when tlb
flush. After boot, the display may call dma_alloc_attrs before it call
pm_runtime_get(disp-dev), then the m4u's pm status is not active inside
the dma_alloc_attrs. Since it only happens after boot, the tlb is clean
at that time, I also think this is ok.

Signed-off-by: Yong Wu <yong.wu@mediatek.com>
---
 drivers/iommu/mtk_iommu.c | 39 ++++++++++++++++++++++++++++++++++-----
 1 file changed, 34 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index 3682137b789a..b9c63c8de33e 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -182,10 +182,15 @@ static struct mtk_iommu_domain *to_mtk_domain(struct iommu_domain *dom)
 static void mtk_iommu_tlb_flush_all(struct mtk_iommu_data *data)
 {
 	for_each_m4u(data) {
+		if (pm_runtime_get_if_in_use(data->dev) <= 0)
+			continue;
+
 		writel_relaxed(F_INVLD_EN1 | F_INVLD_EN0,
 			       data->base + data->plat_data->inv_sel_reg);
 		writel_relaxed(F_ALL_INVLD, data->base + REG_MMU_INVALIDATE);
 		wmb(); /* Make sure the tlb flush all done */
+
+		pm_runtime_put(data->dev);
 	}
 }
 
@@ -193,11 +198,17 @@ static void mtk_iommu_tlb_flush_range_sync(unsigned long iova, size_t size,
 					   size_t granule,
 					   struct mtk_iommu_data *data)
 {
+	bool has_pm = !!data->dev->pm_domain;
 	unsigned long flags;
 	int ret;
 	u32 tmp;
 
 	for_each_m4u(data) {
+		if (has_pm) {
+			if (pm_runtime_get_if_in_use(data->dev) <= 0)
+				continue;
+		}
+
 		spin_lock_irqsave(&data->tlb_lock, flags);
 		writel_relaxed(F_INVLD_EN1 | F_INVLD_EN0,
 			       data->base + data->plat_data->inv_sel_reg);
@@ -219,6 +230,9 @@ static void mtk_iommu_tlb_flush_range_sync(unsigned long iova, size_t size,
 		/* Clear the CPE status */
 		writel_relaxed(0, data->base + REG_MMU_CPE_DONE);
 		spin_unlock_irqrestore(&data->tlb_lock, flags);
+
+		if (has_pm)
+			pm_runtime_put(data->dev);
 	}
 }
 
@@ -367,18 +381,27 @@ static int mtk_iommu_attach_device(struct iommu_domain *domain,
 {
 	struct mtk_iommu_data *data = dev_iommu_priv_get(dev);
 	struct mtk_iommu_domain *dom = to_mtk_domain(domain);
+	struct device *m4udev = data->dev;
 	int ret;
 
 	if (!data)
 		return -ENODEV;
 
 	if (!data->m4u_dom) { /* Initialize the M4U HW */
+		ret = pm_runtime_resume_and_get(m4udev);
+		if (ret < 0)
+			return ret;
+
 		ret = mtk_iommu_hw_init(data);
-		if (ret)
+		if (ret) {
+			pm_runtime_put(m4udev);
 			return ret;
+		}
 		data->m4u_dom = dom;
 		writel(dom->cfg.arm_v7s_cfg.ttbr & MMU_PT_ADDR_MASK,
 		       data->base + REG_MMU_PT_BASE_ADDR);
+
+		pm_runtime_put(m4udev);
 	}
 
 	mtk_iommu_config(data, dev, true);
@@ -738,11 +761,13 @@ static int mtk_iommu_probe(struct platform_device *pdev)
 	of_node_put(smicomm_node);
 	data->smicomm_dev = &plarbdev->dev;
 
+	pm_runtime_enable(dev);
+
 	link = device_link_add(data->smicomm_dev, dev,
 			DL_FLAG_STATELESS | DL_FLAG_PM_RUNTIME);
 	if (!link) {
 		dev_err(dev, "Unable link %s.\n", dev_name(data->smicomm_dev));
-		return -EINVAL;
+		goto out_runtime_disable;
 	}
 
 	platform_set_drvdata(pdev, data);
@@ -782,6 +807,8 @@ static int mtk_iommu_probe(struct platform_device *pdev)
 	iommu_device_sysfs_remove(&data->iommu);
 out_link_remove:
 	device_link_remove(data->smicomm_dev, dev);
+out_runtime_disable:
+	pm_runtime_disable(dev);
 	return ret;
 }
 
@@ -797,6 +824,7 @@ static int mtk_iommu_remove(struct platform_device *pdev)
 
 	clk_disable_unprepare(data->bclk);
 	device_link_remove(data->smicomm_dev, &pdev->dev);
+	pm_runtime_disable(&pdev->dev);
 	devm_free_irq(&pdev->dev, data->irq, data);
 	component_master_del(&pdev->dev, &mtk_iommu_com_ops);
 	return 0;
@@ -828,6 +856,9 @@ static int __maybe_unused mtk_iommu_runtime_resume(struct device *dev)
 	void __iomem *base = data->base;
 	int ret;
 
+	/* Avoid first resume to affect the default value of registers below. */
+	if (!m4u_dom)
+		return 0;
 	ret = clk_prepare_enable(data->bclk);
 	if (ret) {
 		dev_err(data->dev, "Failed to enable clk(%d) in resume\n", ret);
@@ -841,9 +872,7 @@ static int __maybe_unused mtk_iommu_runtime_resume(struct device *dev)
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

