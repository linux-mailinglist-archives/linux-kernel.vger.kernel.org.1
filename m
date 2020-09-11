Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FB852667A1
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Sep 2020 19:46:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725984AbgIKRqA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Sep 2020 13:46:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:59284 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725856AbgIKMRL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 08:17:11 -0400
Received: from mail.kernel.org (ip5f5ad5a5.dynamic.kabel-deutschland.de [95.90.213.165])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 127F522206;
        Fri, 11 Sep 2020 12:16:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599826608;
        bh=hNJam27LJP0WGoR+RLaJeT9CAHLg8Z9yTve7R/1lvjo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=l6eJ6MntwlLCoPg2tJH3CvQhto3uTgCxgaHYcrLY9cRUrf8pEU+rhcatbsFTWX2/b
         Dgg9Ruzg6o4wtskvQP5Ia+8Kf4MKukVYOMnZb5VGnXJXfWlmTAC3V0K1r2+LfoxL6k
         vL4GMjMBhXuDmXcP1Vm7NQT77JW6vETR+U+iaYqU=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kGhyv-0006WF-V2; Fri, 11 Sep 2020 14:16:45 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "John Stultz" <john.stultz@linaro.org>,
        "Manivannan Sadhasivam" <mani@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>, Yu Chen <chenyu56@huawei.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 RESEND 3/8] phy: hisilicon: phy-hi3670-usb3: use a consistent namespace
Date:   Fri, 11 Sep 2020 14:16:39 +0200
Message-Id: <450926c5378a1ce4b16243004621f89a8d960a21.1599826421.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1599826421.git.mchehab+huawei@kernel.org>
References: <cover.1599826421.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename hikey970 to hi3670, in order to use a namespace
similar to hi3660 driver.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/phy/hisilicon/phy-hi3670-usb3.c | 98 ++++++++++++-------------
 1 file changed, 49 insertions(+), 49 deletions(-)

diff --git a/drivers/phy/hisilicon/phy-hi3670-usb3.c b/drivers/phy/hisilicon/phy-hi3670-usb3.c
index 1d4caf7a2aaf..fd679b39185a 100644
--- a/drivers/phy/hisilicon/phy-hi3670-usb3.c
+++ b/drivers/phy/hisilicon/phy-hi3670-usb3.c
@@ -130,7 +130,7 @@
 #define TX_VBOOST_LVL_START		(6)
 #define TX_VBOOST_LVL_ENABLE		BIT(9)
 
-struct kirin970_priv {
+struct hi3670_priv {
 	struct device *dev;
 	struct regmap *peri_crg;
 	struct regmap *pctrl;
@@ -145,7 +145,7 @@ struct kirin970_priv {
 	u32 usb31misc_offset;
 };
 
-static int kirin970_phy_cr_clk(struct regmap *usb31misc)
+static int hi3670_phy_cr_clk(struct regmap *usb31misc)
 {
 	int ret;
 
@@ -162,13 +162,13 @@ static int kirin970_phy_cr_clk(struct regmap *usb31misc)
 	return ret;
 }
 
-static int kirin970_phy_cr_set_sel(struct regmap *usb31misc)
+static int hi3670_phy_cr_set_sel(struct regmap *usb31misc)
 {
 	return regmap_update_bits(usb31misc, USB_MISC_CFG54,
 			CFG54_USB31PHY_CR_SEL, CFG54_USB31PHY_CR_SEL);
 }
 
-static int kirin970_phy_cr_start(struct regmap *usb31misc, int direction)
+static int hi3670_phy_cr_start(struct regmap *usb31misc, int direction)
 {
 	int ret;
 
@@ -182,7 +182,7 @@ static int kirin970_phy_cr_start(struct regmap *usb31misc, int direction)
 	if (ret)
 		return ret;
 
-	ret = kirin970_phy_cr_clk(usb31misc);
+	ret = hi3670_phy_cr_clk(usb31misc);
 	if (ret)
 		return ret;
 
@@ -192,7 +192,7 @@ static int kirin970_phy_cr_start(struct regmap *usb31misc, int direction)
 	return ret;
 }
 
-static int kirin970_phy_cr_wait_ack(struct regmap *usb31misc)
+static int hi3670_phy_cr_wait_ack(struct regmap *usb31misc)
 {
 	u32 reg;
 	int retry = 100000;
@@ -205,7 +205,7 @@ static int kirin970_phy_cr_wait_ack(struct regmap *usb31misc)
 		if ((reg & CFG54_USB31PHY_CR_ACK) == CFG54_USB31PHY_CR_ACK)
 			return 0;
 
-		ret = kirin970_phy_cr_clk(usb31misc);
+		ret = hi3670_phy_cr_clk(usb31misc);
 		if (ret)
 			return ret;
 	}
@@ -213,7 +213,7 @@ static int kirin970_phy_cr_wait_ack(struct regmap *usb31misc)
 	return -ETIMEDOUT;
 }
 
-static int kirin970_phy_cr_set_addr(struct regmap *usb31misc, u32 addr)
+static int hi3670_phy_cr_set_addr(struct regmap *usb31misc, u32 addr)
 {
 	u32 reg;
 	int ret;
@@ -230,31 +230,31 @@ static int kirin970_phy_cr_set_addr(struct regmap *usb31misc, u32 addr)
 	return ret;
 }
 
-static int kirin970_phy_cr_read(struct regmap *usb31misc, u32 addr, u32 *val)
+static int hi3670_phy_cr_read(struct regmap *usb31misc, u32 addr, u32 *val)
 {
 	int reg;
 	int i;
 	int ret;
 
 	for (i = 0; i < 100; i++) {
-		ret = kirin970_phy_cr_clk(usb31misc);
+		ret = hi3670_phy_cr_clk(usb31misc);
 		if (ret)
 			return ret;
 	}
 
-	ret = kirin970_phy_cr_set_sel(usb31misc);
+	ret = hi3670_phy_cr_set_sel(usb31misc);
 	if (ret)
 		return ret;
 
-	ret = kirin970_phy_cr_set_addr(usb31misc, addr);
+	ret = hi3670_phy_cr_set_addr(usb31misc, addr);
 	if (ret)
 		return ret;
 
-	ret = kirin970_phy_cr_start(usb31misc, 0);
+	ret = hi3670_phy_cr_start(usb31misc, 0);
 	if (ret)
 		return ret;
 
-	ret = kirin970_phy_cr_wait_ack(usb31misc);
+	ret = hi3670_phy_cr_wait_ack(usb31misc);
 	if (ret)
 		return ret;
 
@@ -268,22 +268,22 @@ static int kirin970_phy_cr_read(struct regmap *usb31misc, u32 addr, u32 *val)
 	return 0;
 }
 
-static int kirin970_phy_cr_write(struct regmap *usb31misc, u32 addr, u32 val)
+static int hi3670_phy_cr_write(struct regmap *usb31misc, u32 addr, u32 val)
 {
 	int i;
 	int ret;
 
 	for (i = 0; i < 100; i++) {
-		ret = kirin970_phy_cr_clk(usb31misc);
+		ret = hi3670_phy_cr_clk(usb31misc);
 		if (ret)
 			return ret;
 	}
 
-	ret = kirin970_phy_cr_set_sel(usb31misc);
+	ret = hi3670_phy_cr_set_sel(usb31misc);
 	if (ret)
 		return ret;
 
-	ret = kirin970_phy_cr_set_addr(usb31misc, addr);
+	ret = hi3670_phy_cr_set_addr(usb31misc, addr);
 	if (ret)
 		return ret;
 
@@ -292,16 +292,16 @@ static int kirin970_phy_cr_write(struct regmap *usb31misc, u32 addr, u32 val)
 	if (ret)
 		return ret;
 
-	ret = kirin970_phy_cr_start(usb31misc, 1);
+	ret = hi3670_phy_cr_start(usb31misc, 1);
 	if (ret)
 		return ret;
 
-	ret = kirin970_phy_cr_wait_ack(usb31misc);
+	ret = hi3670_phy_cr_wait_ack(usb31misc);
 
 	return ret;
 }
 
-static int kirin970_phy_set_params(struct kirin970_priv *priv)
+static int hi3670_phy_set_params(struct hi3670_priv *priv)
 {
 	u32 reg;
 	int ret;
@@ -315,7 +315,7 @@ static int kirin970_phy_set_params(struct kirin970_priv *priv)
 	}
 
 	while (retry-- > 0) {
-		ret = kirin970_phy_cr_read(priv->usb31misc,
+		ret = hi3670_phy_cr_read(priv->usb31misc,
 				TX_VBOOST_LVL_REG, &reg);
 		if (!ret)
 			break;
@@ -329,14 +329,14 @@ static int kirin970_phy_set_params(struct kirin970_priv *priv)
 
 	reg |= (TX_VBOOST_LVL_ENABLE |
 			(priv->tx_vboost_lvl << TX_VBOOST_LVL_START));
-	ret = kirin970_phy_cr_write(priv->usb31misc, TX_VBOOST_LVL_REG, reg);
+	ret = hi3670_phy_cr_write(priv->usb31misc, TX_VBOOST_LVL_REG, reg);
 	if (ret)
 		dev_err(priv->dev, "write TX_VBOOST_LVL_REG failed\n");
 
 	return ret;
 }
 
-static int kirin970_is_abbclk_seleted(struct kirin970_priv *priv)
+static int hi3670_is_abbclk_seleted(struct hi3670_priv *priv)
 {
 	u32 reg;
 
@@ -356,12 +356,12 @@ static int kirin970_is_abbclk_seleted(struct kirin970_priv *priv)
 	return 0;
 }
 
-static int kirin970_config_phy_clock(struct kirin970_priv *priv)
+static int hi3670_config_phy_clock(struct hi3670_priv *priv)
 {
 	u32 val, mask;
 	int ret;
 
-	if (kirin970_is_abbclk_seleted(priv)) {
+	if (hi3670_is_abbclk_seleted(priv)) {
 		/* usb refclk iso disable */
 		ret = regmap_write(priv->peri_crg, PERI_CRG_ISODIS,
 				USB_REFCLK_ISO_EN);
@@ -427,7 +427,7 @@ static int kirin970_config_phy_clock(struct kirin970_priv *priv)
 	return ret;
 }
 
-static int kirin970_config_tca(struct kirin970_priv *priv)
+static int hi3670_config_tca(struct hi3670_priv *priv)
 {
 	u32 val, mask;
 	int ret;
@@ -477,9 +477,9 @@ static int kirin970_config_tca(struct kirin970_priv *priv)
 	return ret;
 }
 
-static int kirin970_phy_init(struct phy *phy)
+static int hi3670_phy_init(struct phy *phy)
 {
-	struct kirin970_priv *priv = phy_get_drvdata(phy);
+	struct hi3670_priv *priv = phy_get_drvdata(phy);
 	u32 val;
 	int ret;
 
@@ -490,7 +490,7 @@ static int kirin970_phy_init(struct phy *phy)
 	if (ret)
 		goto out;
 
-	ret = kirin970_config_phy_clock(priv);
+	ret = hi3670_config_phy_clock(priv);
 	if (ret)
 		goto out;
 
@@ -522,7 +522,7 @@ static int kirin970_phy_init(struct phy *phy)
 	if (ret)
 		goto out;
 
-	ret = kirin970_config_tca(priv);
+	ret = hi3670_config_tca(priv);
 	if (ret)
 		goto out;
 
@@ -554,7 +554,7 @@ static int kirin970_phy_init(struct phy *phy)
 
 	udelay(100);
 
-	ret = kirin970_phy_set_params(priv);
+	ret = hi3670_phy_set_params(priv);
 	if (ret)
 		goto out;
 
@@ -564,9 +564,9 @@ static int kirin970_phy_init(struct phy *phy)
 	return ret;
 }
 
-static int kirin970_phy_exit(struct phy *phy)
+static int hi3670_phy_exit(struct phy *phy)
 {
-	struct kirin970_priv *priv = phy_get_drvdata(phy);
+	struct hi3670_priv *priv = phy_get_drvdata(phy);
 	u32 mask;
 	int ret;
 
@@ -576,7 +576,7 @@ static int kirin970_phy_exit(struct phy *phy)
 	if (ret)
 		goto out;
 
-	if (kirin970_is_abbclk_seleted(priv)) {
+	if (hi3670_is_abbclk_seleted(priv)) {
 		/* disable usb_tcxo_en */
 		ret = regmap_write(priv->pctrl, PCTRL_PERI_CTRL3,
 				USB_TCXO_EN << PCTRL_PERI_CTRL3_MSK_START);
@@ -593,18 +593,18 @@ static int kirin970_phy_exit(struct phy *phy)
 	return ret;
 }
 
-static struct phy_ops kirin970_phy_ops = {
-	.init		= kirin970_phy_init,
-	.exit		= kirin970_phy_exit,
+static struct phy_ops hi3670_phy_ops = {
+	.init		= hi3670_phy_init,
+	.exit		= hi3670_phy_exit,
 	.owner		= THIS_MODULE,
 };
 
-static int kirin970_phy_probe(struct platform_device *pdev)
+static int hi3670_phy_probe(struct platform_device *pdev)
 {
 	struct phy_provider *phy_provider;
 	struct device *dev = &pdev->dev;
 	struct phy *phy;
-	struct kirin970_priv *priv;
+	struct hi3670_priv *priv;
 
 	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
@@ -647,7 +647,7 @@ static int kirin970_phy_probe(struct platform_device *pdev)
 				&(priv->tx_vboost_lvl)))
 		priv->eye_diagram_param = KIRIN970_USB_DEFAULT_PHY_VBOOST;
 
-	phy = devm_phy_create(dev, NULL, &kirin970_phy_ops);
+	phy = devm_phy_create(dev, NULL, &hi3670_phy_ops);
 	if (IS_ERR(phy))
 		return PTR_ERR(phy);
 
@@ -656,20 +656,20 @@ static int kirin970_phy_probe(struct platform_device *pdev)
 	return PTR_ERR_OR_ZERO(phy_provider);
 }
 
-static const struct of_device_id kirin970_phy_of_match[] = {
-	{.compatible = "hisilicon,kirin970-usb-phy",},
+static const struct of_device_id hi3670_phy_of_match[] = {
+	{.compatible = "hisilicon,hi3670-usb-phy",},
 	{ },
 };
-MODULE_DEVICE_TABLE(of, kirin970_phy_of_match);
+MODULE_DEVICE_TABLE(of, hi3670_phy_of_match);
 
-static struct platform_driver kirin970_phy_driver = {
-	.probe	= kirin970_phy_probe,
+static struct platform_driver hi3670_phy_driver = {
+	.probe	= hi3670_phy_probe,
 	.driver = {
-		.name	= "kirin970-usb-phy",
-		.of_match_table	= kirin970_phy_of_match,
+		.name	= "hi3670-usb-phy",
+		.of_match_table	= hi3670_phy_of_match,
 	}
 };
-module_platform_driver(kirin970_phy_driver);
+module_platform_driver(hi3670_phy_driver);
 
 MODULE_AUTHOR("Yu Chen <chenyu56@huawei.com>");
 MODULE_LICENSE("GPL v2");
-- 
2.26.2

