Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 101D82EA3AD
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 04:09:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728246AbhAEDHc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 22:07:32 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:60715 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728033AbhAEDHb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 22:07:31 -0500
X-UUID: 7689bb0df0004707ba1447134445034a-20210105
X-UUID: 7689bb0df0004707ba1447134445034a-20210105
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <yongqiang.niu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 100661042; Tue, 05 Jan 2021 11:06:44 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs05n2.mediatek.inc (172.21.101.140) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 5 Jan 2021 11:06:43 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 5 Jan 2021 11:06:42 +0800
From:   Yongqiang Niu <yongqiang.niu@mediatek.com>
To:     CK Hu <ck.hu@mediatek.com>, Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Yongqiang Niu <yongqiang.niu@mediatek.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
Subject: [PATCH v4, 02/10] soc: mediatek: mmsys: Create struct mtk_mmsys to store context data
Date:   Tue, 5 Jan 2021 11:06:25 +0800
Message-ID: <1609815993-22744-3-git-send-email-yongqiang.niu@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1609815993-22744-1-git-send-email-yongqiang.niu@mediatek.com>
References: <1609815993-22744-1-git-send-email-yongqiang.niu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Apart from the driver data, in order to extend the driver to support more
and more SoCs, we will need to store other configuration data. So, create
a mtk_mmsys struct to encapsulate all that information.

Signed-off-by: CK Hu <ck.hu@mediatek.com>
Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
Reviewed-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>
---
 drivers/soc/mediatek/mmsys/mtk-mmsys.c | 47 +++++++++++++++++++---------------
 1 file changed, 27 insertions(+), 20 deletions(-)

diff --git a/drivers/soc/mediatek/mmsys/mtk-mmsys.c b/drivers/soc/mediatek/mmsys/mtk-mmsys.c
index 18f9397..6c03282 100644
--- a/drivers/soc/mediatek/mmsys/mtk-mmsys.c
+++ b/drivers/soc/mediatek/mmsys/mtk-mmsys.c
@@ -77,6 +77,11 @@ struct mtk_mmsys_driver_data {
 	const char *clk_driver;
 };
 
+struct mtk_mmsys {
+	void __iomem *regs;
+	const struct mtk_mmsys_driver_data *data;
+};
+
 static const struct mtk_mmsys_driver_data mt2701_mmsys_driver_data = {
 	.clk_driver = "clk-mt2701-mm",
 };
@@ -259,21 +264,21 @@ void mtk_mmsys_ddp_connect(struct device *dev,
 			   enum mtk_ddp_comp_id cur,
 			   enum mtk_ddp_comp_id next)
 {
-	void __iomem *config_regs = dev_get_drvdata(dev);
+	struct mtk_mmsys *mmsys = dev_get_drvdata(dev);
 	unsigned int addr, value, reg;
 
 	value = mtk_mmsys_ddp_mout_en(cur, next, &addr);
 	if (value) {
-		reg = readl_relaxed(config_regs + addr) | value;
-		writel_relaxed(reg, config_regs + addr);
+		reg = readl_relaxed(mmsys->regs + addr) | value;
+		writel_relaxed(reg, mmsys->regs + addr);
 	}
 
-	mtk_mmsys_ddp_sout_sel(config_regs, cur, next);
+	mtk_mmsys_ddp_sout_sel(mmsys->regs, cur, next);
 
 	value = mtk_mmsys_ddp_sel_in(cur, next, &addr);
 	if (value) {
-		reg = readl_relaxed(config_regs + addr) | value;
-		writel_relaxed(reg, config_regs + addr);
+		reg = readl_relaxed(mmsys->regs + addr) | value;
+		writel_relaxed(reg, mmsys->regs + addr);
 	}
 }
 EXPORT_SYMBOL_GPL(mtk_mmsys_ddp_connect);
@@ -282,44 +287,46 @@ void mtk_mmsys_ddp_disconnect(struct device *dev,
 			      enum mtk_ddp_comp_id cur,
 			      enum mtk_ddp_comp_id next)
 {
-	void __iomem *config_regs = dev_get_drvdata(dev);
+	struct mtk_mmsys *mmsys = dev_get_drvdata(dev);
 	unsigned int addr, value, reg;
 
 	value = mtk_mmsys_ddp_mout_en(cur, next, &addr);
 	if (value) {
-		reg = readl_relaxed(config_regs + addr) & ~value;
-		writel_relaxed(reg, config_regs + addr);
+		reg = readl_relaxed(mmsys->regs + addr) & ~value;
+		writel_relaxed(reg, mmsys->regs + addr);
 	}
 
 	value = mtk_mmsys_ddp_sel_in(cur, next, &addr);
 	if (value) {
-		reg = readl_relaxed(config_regs + addr) & ~value;
-		writel_relaxed(reg, config_regs + addr);
+		reg = readl_relaxed(mmsys->regs + addr) & ~value;
+		writel_relaxed(reg, mmsys->regs + addr);
 	}
 }
 EXPORT_SYMBOL_GPL(mtk_mmsys_ddp_disconnect);
 
 static int mtk_mmsys_probe(struct platform_device *pdev)
 {
-	const struct mtk_mmsys_driver_data *data;
 	struct device *dev = &pdev->dev;
 	struct platform_device *clks;
 	struct platform_device *drm;
-	void __iomem *config_regs;
+	struct mtk_mmsys *mmsys;
 	int ret;
 
-	config_regs = devm_platform_ioremap_resource(pdev, 0);
-	if (IS_ERR(config_regs)) {
-		ret = PTR_ERR(config_regs);
+	mmsys = devm_kzalloc(dev, sizeof(*mmsys), GFP_KERNEL);
+	if (!mmsys)
+		return -ENOMEM;
+
+	mmsys->regs = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(mmsys->regs)) {
+		ret = PTR_ERR(mmsys->regs);
 		dev_err(dev, "Failed to ioremap mmsys registers: %d\n", ret);
 		return ret;
 	}
 
-	platform_set_drvdata(pdev, config_regs);
-
-	data = of_device_get_match_data(&pdev->dev);
+	mmsys->data = of_device_get_match_data(&pdev->dev);
+	platform_set_drvdata(pdev, mmsys);
 
-	clks = platform_device_register_data(&pdev->dev, data->clk_driver,
+	clks = platform_device_register_data(&pdev->dev, mmsys->data->clk_driver,
 					     PLATFORM_DEVID_AUTO, NULL, 0);
 	if (IS_ERR(clks))
 		return PTR_ERR(clks);
-- 
1.8.1.1.dirty

