Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E110265410
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Sep 2020 23:49:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725294AbgIJVtG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Sep 2020 17:49:06 -0400
Received: from cmccmta3.chinamobile.com ([221.176.66.81]:18257 "EHLO
        cmccmta3.chinamobile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730567AbgIJL5g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 07:57:36 -0400
Received: from spf.mail.chinamobile.com (unknown[172.16.121.13]) by rmmx-syy-dmz-app10-12010 (RichMail) with SMTP id 2eea5f5a1432a09-8b324; Thu, 10 Sep 2020 19:55:30 +0800 (CST)
X-RM-TRANSID: 2eea5f5a1432a09-8b324
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost.localdomain (unknown[223.112.105.130])
        by rmsmtp-syy-appsvr07-12007 (RichMail) with SMTP id 2ee75f5a142f81d-8c931;
        Thu, 10 Sep 2020 19:55:30 +0800 (CST)
X-RM-TRANSID: 2ee75f5a142f81d-8c931
From:   Tang Bin <tangbin@cmss.chinamobile.com>
To:     balbi@kernel.org, gregkh@linuxfoundation.org,
        thierry.reding@gmail.com, jonathanh@nvidia.com
Cc:     linux-usb@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Tang Bin <tangbin@cmss.chinamobile.com>,
        Zhang Shengju <zhangshengju@cmss.chinamobile.com>
Subject: [PATCH] usb: phy: tegra: Use IS_ERR() to check and simplify code
Date:   Thu, 10 Sep 2020 19:56:07 +0800
Message-Id: <20200910115607.11392-1-tangbin@cmss.chinamobile.com>
X-Mailer: git-send-email 2.20.1.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use IS_ERR() and PTR_ERR() instead of PTR_ERR_OR_ZERO() to
simplify code, avoid redundant judgements.

Signed-off-by: Zhang Shengju <zhangshengju@cmss.chinamobile.com>
Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
---
 drivers/usb/phy/phy-tegra-usb.c | 25 ++++++++++---------------
 1 file changed, 10 insertions(+), 15 deletions(-)

diff --git a/drivers/usb/phy/phy-tegra-usb.c b/drivers/usb/phy/phy-tegra-usb.c
index 6153cc35a..3b901429d 100644
--- a/drivers/usb/phy/phy-tegra-usb.c
+++ b/drivers/usb/phy/phy-tegra-usb.c
@@ -1121,10 +1121,9 @@ static int tegra_usb_phy_probe(struct platform_device *pdev)
 		return PTR_ERR(tegra_phy->vbus);
 
 	tegra_phy->pll_u = devm_clk_get(&pdev->dev, "pll_u");
-	err = PTR_ERR_OR_ZERO(tegra_phy->pll_u);
-	if (err) {
+	if (IS_ERR(tegra_phy->pll_u)) {
 		dev_err(&pdev->dev, "Failed to get pll_u clock: %d\n", err);
-		return err;
+		return PTR_ERR(tegra_phy->pll_u);
 	}
 
 	phy_type = of_usb_get_phy_mode(np);
@@ -1135,20 +1134,18 @@ static int tegra_usb_phy_probe(struct platform_device *pdev)
 			return err;
 
 		tegra_phy->pad_clk = devm_clk_get(&pdev->dev, "utmi-pads");
-		err = PTR_ERR_OR_ZERO(tegra_phy->pad_clk);
-		if (err) {
+		if (IS_ERR(tegra_phy->pad_clk)) {
 			dev_err(&pdev->dev,
 				"Failed to get UTMIP pad clock: %d\n", err);
-			return err;
+			return PTR_ERR(tegra_phy->pad_clk);
 		}
 
 		reset = devm_reset_control_get_optional_shared(&pdev->dev,
 							       "utmi-pads");
-		err = PTR_ERR_OR_ZERO(reset);
-		if (err) {
+		if (IS_ERR(reset)) {
 			dev_err(&pdev->dev,
 				"Failed to get UTMI-pads reset: %d\n", err);
-			return err;
+			return PTR_ERR(reset);
 		}
 		tegra_phy->pad_rst = reset;
 		break;
@@ -1157,22 +1154,20 @@ static int tegra_usb_phy_probe(struct platform_device *pdev)
 		tegra_phy->is_ulpi_phy = true;
 
 		tegra_phy->clk = devm_clk_get(&pdev->dev, "ulpi-link");
-		err = PTR_ERR_OR_ZERO(tegra_phy->clk);
-		if (err) {
+		if (IS_ERR(tegra_phy->clk)) {
 			dev_err(&pdev->dev,
 				"Failed to get ULPI clock: %d\n", err);
-			return err;
+			return PTR_ERR(tegra_phy->clk);
 		}
 
 		gpiod = devm_gpiod_get_from_of_node(&pdev->dev, np,
 						    "nvidia,phy-reset-gpio",
 						    0, GPIOD_OUT_HIGH,
 						    "ulpi_phy_reset_b");
-		err = PTR_ERR_OR_ZERO(gpiod);
-		if (err) {
+		if (IS_ERR(gpiod)) {
 			dev_err(&pdev->dev,
 				"Request failed for reset GPIO: %d\n", err);
-			return err;
+			return PTR_ERR(gpiod);
 		}
 		tegra_phy->reset_gpio = gpiod;
 
-- 
2.20.1.windows.1



