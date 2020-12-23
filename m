Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EBE82E1C5D
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Dec 2020 13:50:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728672AbgLWMp5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Dec 2020 07:45:57 -0500
Received: from aposti.net ([89.234.176.197]:53728 "EHLO aposti.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728659AbgLWMp4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Dec 2020 07:45:56 -0500
From:   Paul Cercueil <paul@crapouillou.net>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>
Cc:     =?UTF-8?q?=E6=BC=86=E9=B9=8F=E6=8C=AF?= <aric.pzqi@ingenic.com>,
        =?UTF-8?q?=E5=91=A8=E7=90=B0=E6=9D=B0?= <zhouyanjie@wanyeetech.com>,
        linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH] phy: ingenic: Remove useless field .version
Date:   Wed, 23 Dec 2020 12:45:05 +0000
Message-Id: <20201223124505.40792-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the useless field .version from the private structure, which is
set but never read.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/phy/ingenic/phy-ingenic-usb.c | 23 -----------------------
 1 file changed, 23 deletions(-)

diff --git a/drivers/phy/ingenic/phy-ingenic-usb.c b/drivers/phy/ingenic/phy-ingenic-usb.c
index 4d1587d82286..ea127b177f46 100644
--- a/drivers/phy/ingenic/phy-ingenic-usb.c
+++ b/drivers/phy/ingenic/phy-ingenic-usb.c
@@ -82,18 +82,7 @@
 #define USBPCR1_PORT_RST			BIT(21)
 #define USBPCR1_WORD_IF_16BIT		BIT(19)
 
-enum ingenic_usb_phy_version {
-	ID_JZ4770,
-	ID_JZ4775,
-	ID_JZ4780,
-	ID_X1000,
-	ID_X1830,
-	ID_X2000,
-};
-
 struct ingenic_soc_info {
-	enum ingenic_usb_phy_version version;
-
 	void (*usb_phy_init)(struct phy *phy);
 };
 
@@ -300,38 +289,26 @@ static void x2000_usb_phy_init(struct phy *phy)
 }
 
 static const struct ingenic_soc_info jz4770_soc_info = {
-	.version = ID_JZ4770,
-
 	.usb_phy_init = jz4770_usb_phy_init,
 };
 
 static const struct ingenic_soc_info jz4775_soc_info = {
-	.version = ID_JZ4775,
-
 	.usb_phy_init = jz4775_usb_phy_init,
 };
 
 static const struct ingenic_soc_info jz4780_soc_info = {
-	.version = ID_JZ4780,
-
 	.usb_phy_init = jz4780_usb_phy_init,
 };
 
 static const struct ingenic_soc_info x1000_soc_info = {
-	.version = ID_X1000,
-
 	.usb_phy_init = x1000_usb_phy_init,
 };
 
 static const struct ingenic_soc_info x1830_soc_info = {
-	.version = ID_X1830,
-
 	.usb_phy_init = x1830_usb_phy_init,
 };
 
 static const struct ingenic_soc_info x2000_soc_info = {
-	.version = ID_X2000,
-
 	.usb_phy_init = x2000_usb_phy_init,
 };
 
-- 
2.29.2

