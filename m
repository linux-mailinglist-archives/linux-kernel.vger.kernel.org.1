Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26FB23015C4
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jan 2021 15:21:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725779AbhAWOUG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jan 2021 09:20:06 -0500
Received: from aposti.net ([89.234.176.197]:32860 "EHLO aposti.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725290AbhAWOUD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jan 2021 09:20:03 -0500
From:   Paul Cercueil <paul@crapouillou.net>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>
Cc:     =?UTF-8?q?=E5=91=A8=E7=90=B0=E6=9D=B0?= <zhouyanjie@wanyeetech.com>,
        od@zcrc.me, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v2 2/2] phy: ingenic: Add support for the JZ4760(B)
Date:   Sat, 23 Jan 2021 14:18:25 +0000
Message-Id: <20210123141825.15481-2-paul@crapouillou.net>
In-Reply-To: <20210123141825.15481-1-paul@crapouillou.net>
References: <20210123141825.15481-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the JZ4760 and JZ4760B SoCs, which behave exactly as the
(newer) JZ4770 SoC.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---

Notes:
    v2: No change

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

