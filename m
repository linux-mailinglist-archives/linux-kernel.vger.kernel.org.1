Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3ACD52ACFC7
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 07:35:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730310AbgKJGfX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 01:35:23 -0500
Received: from smtp2207-205.mail.aliyun.com ([121.197.207.205]:47723 "EHLO
        smtp2207-205.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728085AbgKJGfW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 01:35:22 -0500
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07436288|-1;CH=blue;DM=|OVERLOAD|false|;DS=CONTINUE|ham_system_inform|0.019185-0.0136594-0.967156;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047201;MF=frank@allwinnertech.com;NM=1;PH=DS;RN=13;RT=13;SR=0;TI=SMTPD_---.IunzSG8_1604990111;
Received: from allwinnertech.com(mailfrom:frank@allwinnertech.com fp:SMTPD_---.IunzSG8_1604990111)
          by smtp.aliyun-inc.com(10.147.41.143);
          Tue, 10 Nov 2020 14:35:15 +0800
From:   Frank Lee <frank@allwinnertech.com>
To:     tiny.windzz@gmail.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Yangtao Li <frank@allwinnertech.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Colin Ian King <colin.king@canonical.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Ondrej Jirman <megous@megous.com>,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>
Subject: [RESEND PATCH 09/19] phy: allwinner: Convert to devm_platform_ioremap_* API
Date:   Tue, 10 Nov 2020 14:35:01 +0800
Message-Id: <e16729e3e19f4b1f401d6b62621d00ab3ee4ec3a.1604988979.git.frank@allwinnertech.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1604988979.git.frank@allwinnertech.com>
References: <cover.1604988979.git.frank@allwinnertech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yangtao Li <frank@allwinnertech.com>

Use the devm_platform_ioremap_resource_byname() and
devm_platform_ioremap_resource helper to simplify the code.

Signed-off-by: Yangtao Li <frank@allwinnertech.com>
---
 drivers/phy/allwinner/phy-sun4i-usb.c       | 9 +++------
 drivers/phy/allwinner/phy-sun50i-usb3.c     | 4 +---
 drivers/phy/allwinner/phy-sun6i-mipi-dphy.c | 4 +---
 drivers/phy/allwinner/phy-sun9i-usb.c       | 4 +---
 4 files changed, 6 insertions(+), 15 deletions(-)

diff --git a/drivers/phy/allwinner/phy-sun4i-usb.c b/drivers/phy/allwinner/phy-sun4i-usb.c
index 0f1888b55dbd..a6900495baa5 100644
--- a/drivers/phy/allwinner/phy-sun4i-usb.c
+++ b/drivers/phy/allwinner/phy-sun4i-usb.c
@@ -686,7 +686,6 @@ static int sun4i_usb_phy_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct device_node *np = dev->of_node;
 	struct phy_provider *phy_provider;
-	struct resource *res;
 	int i, ret;
 
 	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
@@ -700,8 +699,7 @@ static int sun4i_usb_phy_probe(struct platform_device *pdev)
 	if (!data->cfg)
 		return -EINVAL;
 
-	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "phy_ctrl");
-	data->base = devm_ioremap_resource(dev, res);
+	data->base = devm_platform_ioremap_resource_byname(pdev, "phy_ctrl");
 	if (IS_ERR(data->base))
 		return PTR_ERR(data->base);
 
@@ -796,9 +794,8 @@ static int sun4i_usb_phy_probe(struct platform_device *pdev)
 
 		if (i || data->cfg->phy0_dual_route) { /* No pmu for musb */
 			snprintf(name, sizeof(name), "pmu%d", i);
-			res = platform_get_resource_byname(pdev,
-							IORESOURCE_MEM, name);
-			phy->pmu = devm_ioremap_resource(dev, res);
+			phy->pmu = devm_platform_ioremap_resource_byname(pdev,
+									 name);
 			if (IS_ERR(phy->pmu))
 				return PTR_ERR(phy->pmu);
 		}
diff --git a/drivers/phy/allwinner/phy-sun50i-usb3.c b/drivers/phy/allwinner/phy-sun50i-usb3.c
index b1c04f71a31d..84055b720016 100644
--- a/drivers/phy/allwinner/phy-sun50i-usb3.c
+++ b/drivers/phy/allwinner/phy-sun50i-usb3.c
@@ -134,7 +134,6 @@ static int sun50i_usb3_phy_probe(struct platform_device *pdev)
 	struct sun50i_usb3_phy *phy;
 	struct device *dev = &pdev->dev;
 	struct phy_provider *phy_provider;
-	struct resource *res;
 
 	phy = devm_kzalloc(dev, sizeof(*phy), GFP_KERNEL);
 	if (!phy)
@@ -153,8 +152,7 @@ static int sun50i_usb3_phy_probe(struct platform_device *pdev)
 		return PTR_ERR(phy->reset);
 	}
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	phy->regs = devm_ioremap_resource(dev, res);
+	phy->regs = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(phy->regs))
 		return PTR_ERR(phy->regs);
 
diff --git a/drivers/phy/allwinner/phy-sun6i-mipi-dphy.c b/drivers/phy/allwinner/phy-sun6i-mipi-dphy.c
index 1fa761ba6cbb..f0bc87d654d4 100644
--- a/drivers/phy/allwinner/phy-sun6i-mipi-dphy.c
+++ b/drivers/phy/allwinner/phy-sun6i-mipi-dphy.c
@@ -253,15 +253,13 @@ static int sun6i_dphy_probe(struct platform_device *pdev)
 {
 	struct phy_provider *phy_provider;
 	struct sun6i_dphy *dphy;
-	struct resource *res;
 	void __iomem *regs;
 
 	dphy = devm_kzalloc(&pdev->dev, sizeof(*dphy), GFP_KERNEL);
 	if (!dphy)
 		return -ENOMEM;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	regs = devm_ioremap_resource(&pdev->dev, res);
+	regs = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(regs)) {
 		dev_err(&pdev->dev, "Couldn't map the DPHY encoder registers\n");
 		return PTR_ERR(regs);
diff --git a/drivers/phy/allwinner/phy-sun9i-usb.c b/drivers/phy/allwinner/phy-sun9i-usb.c
index fc6784dd7fa0..2f9e60c188b8 100644
--- a/drivers/phy/allwinner/phy-sun9i-usb.c
+++ b/drivers/phy/allwinner/phy-sun9i-usb.c
@@ -117,7 +117,6 @@ static int sun9i_usb_phy_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct device_node *np = dev->of_node;
 	struct phy_provider *phy_provider;
-	struct resource *res;
 
 	phy = devm_kzalloc(dev, sizeof(*phy), GFP_KERNEL);
 	if (!phy)
@@ -156,8 +155,7 @@ static int sun9i_usb_phy_probe(struct platform_device *pdev)
 		}
 	}
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	phy->pmu = devm_ioremap_resource(dev, res);
+	phy->pmu = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(phy->pmu))
 		return PTR_ERR(phy->pmu);
 
-- 
2.28.0

