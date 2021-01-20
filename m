Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 666F52FD121
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 14:19:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389647AbhATNGE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 08:06:04 -0500
Received: from aposti.net ([89.234.176.197]:39592 "EHLO aposti.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388494AbhATMRk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 07:17:40 -0500
From:   Paul Cercueil <paul@crapouillou.net>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>
Cc:     od@zcrc.me, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 2/2] phy: ingenic: Add support for the JZ4760
Date:   Wed, 20 Jan 2021 11:59:45 +0000
Message-Id: <20210120115945.29046-2-paul@crapouillou.net>
In-Reply-To: <20210120115945.29046-1-paul@crapouillou.net>
References: <20210120115945.29046-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the JZ4760 SoC, which behave exactly as the (newer)
JZ4770 SoC.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/phy/ingenic/phy-ingenic-usb.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/phy/ingenic/phy-ingenic-usb.c b/drivers/phy/ingenic/phy-ingenic-usb.c
index ea127b177f46..42902a0278cc 100644
--- a/drivers/phy/ingenic/phy-ingenic-usb.c
+++ b/drivers/phy/ingenic/phy-ingenic-usb.c
@@ -201,7 +201,7 @@ static const struct phy_ops ingenic_usb_phy_ops = {
 	.owner		= THIS_MODULE,
 };
 
-static void jz4770_usb_phy_init(struct phy *phy)
+static void jz4760_usb_phy_init(struct phy *phy)
 {
 	struct ingenic_usb_phy *priv = phy_get_drvdata(phy);
 	u32 reg;
@@ -288,8 +288,8 @@ static void x2000_usb_phy_init(struct phy *phy)
 	writel(reg, priv->base + REG_USBPCR_OFFSET);
 }
 
-static const struct ingenic_soc_info jz4770_soc_info = {
-	.usb_phy_init = jz4770_usb_phy_init,
+static const struct ingenic_soc_info jz4760_soc_info = {
+	.usb_phy_init = jz4760_usb_phy_init,
 };
 
 static const struct ingenic_soc_info jz4775_soc_info = {
@@ -363,7 +363,8 @@ static int ingenic_usb_phy_probe(struct platform_device *pdev)
 }
 
 static const struct of_device_id ingenic_usb_phy_of_matches[] = {
-	{ .compatible = "ingenic,jz4770-phy", .data = &jz4770_soc_info },
+	{ .compatible = "ingenic,jz4760-phy", .data = &jz4760_soc_info },
+	{ .compatible = "ingenic,jz4770-phy", .data = &jz4760_soc_info },
 	{ .compatible = "ingenic,jz4775-phy", .data = &jz4775_soc_info },
 	{ .compatible = "ingenic,jz4780-phy", .data = &jz4780_soc_info },
 	{ .compatible = "ingenic,x1000-phy", .data = &x1000_soc_info },
-- 
2.29.2

