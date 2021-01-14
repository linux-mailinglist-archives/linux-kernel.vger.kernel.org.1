Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1C3C2F67E5
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 18:41:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728855AbhANRgs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 12:36:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:33858 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727297AbhANRg3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 12:36:29 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0BD3C23B44;
        Thu, 14 Jan 2021 17:35:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610645748;
        bh=j5TNAkUnCDVkwUohdOLjCc2ujRXRd6fxt6gLz8EHDEE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PlKBIabHU+4pvfT1TXgBcMiV5fJ0uBASsuVNW/DFmxt1qIj82FsjoHkIkzY91gICw
         49p1s3AIiuD5NakjLwn6lHz1Z6hbVR3rSt8zDd9M08RN1spO9Cjvrgecg5/vEEt3JG
         uh9vRPUwQ78Lj/0c9eNy8RtSblSkeBcFX5VchHMqNvdj2OWrnogi53t2K4+gJtQfXg
         2+0Bj8UjYsOuiM6yIRulg79ji6V5dc6ZdiVb0R/9x8UWDJ6l0I1Pxap3+3hoeSAXTY
         G8P7Ggki84soKo4d1B8INhk4l8KzI+8k+m495ql12FewG1lhJn5UVkgVSm6kUaIdu5
         mRwfaxOivLmig==
Received: by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1l06XB-00FQtt-GJ; Thu, 14 Jan 2021 18:35:45 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Alex Dewar <alex.dewar90@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Yu Chen <chenyu56@huawei.com>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/4] staging: hikey9xx: phy-hi3670-usb3.c: use bitfield macros
Date:   Thu, 14 Jan 2021 18:35:41 +0100
Message-Id: <01eae5ee20eb4a114cccdb637fd2a037b3417479.1610645385.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1610645385.git.mchehab+huawei@kernel.org>
References: <cover.1610645385.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cleanup the bitfield macros by using FIELD_PREP() and GENMASK().

While here, place all hexadecimal values in lowercase.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/staging/hikey9xx/phy-hi3670-usb3.c | 61 ++++++++++------------
 1 file changed, 28 insertions(+), 33 deletions(-)

diff --git a/drivers/staging/hikey9xx/phy-hi3670-usb3.c b/drivers/staging/hikey9xx/phy-hi3670-usb3.c
index 4fc013911a78..722cabaa9bd9 100644
--- a/drivers/staging/hikey9xx/phy-hi3670-usb3.c
+++ b/drivers/staging/hikey9xx/phy-hi3670-usb3.c
@@ -8,6 +8,7 @@
  * Authors: Yu Chen <chenyu56@huawei.com>
  */
 
+#include <linux/bitfield.h>
 #include <linux/clk.h>
 #include <linux/kernel.h>
 #include <linux/mfd/syscon.h>
@@ -41,15 +42,15 @@
 #define SC_CLK_USB3PHY_3MUX1_SEL	BIT(25)
 
 #define USB3OTG_CTRL0			(0x00)
-#define USB3OTG_CTRL3			(0x0C)
+#define USB3OTG_CTRL3			(0x0c)
 #define USB3OTG_CTRL4			(0x10)
 #define USB3OTG_CTRL5			(0x14)
-#define USB3OTG_CTRL7			(0x1C)
+#define USB3OTG_CTRL7			(0x1c)
 #define USB_MISC_CFG50			(0x50)
 #define USB_MISC_CFG54			(0x54)
 #define USB_MISC_CFG58			(0x58)
-#define USB_MISC_CFG5C			(0x5C)
-#define USB_MISC_CFGA0			(0xA0)
+#define USB_MISC_CFG5C			(0x5c)
+#define USB_MISC_CFGA0			(0xa0)
 #define TCA_CLK_RST			(0x200)
 #define TCA_INTR_EN			(0x204)
 #define TCA_INTR_STS			(0x208)
@@ -66,14 +67,14 @@
 
 #define CTRL5_USB2_SIDDQ		BIT(0)
 
-#define CTRL7_USB2_REFCLKSEL_MASK	(3 << 3)
-#define CTRL7_USB2_REFCLKSEL_ABB	(3 << 3)
-#define CTRL7_USB2_REFCLKSEL_PAD	(2 << 3)
+#define CTRL7_USB2_REFCLKSEL_MASK	GENMASK(4, 3)
+#define CTRL7_USB2_REFCLKSEL_ABB	(BIT(4) | BIT(3))
+#define CTRL7_USB2_REFCLKSEL_PAD	BIT(4)
 
 #define CFG50_USB3_PHY_TEST_POWERDOWN	BIT(23)
 
-#define CFG54_USB31PHY_CR_ADDR_MASK	(0xFFFF)
-#define CFG54_USB31PHY_CR_ADDR_SHIFT	(16)
+#define CFG54_USB31PHY_CR_ADDR_MASK	GENMASK(31, 16)
+
 #define CFG54_USB3PHY_REF_USE_PAD	BIT(12)
 #define CFG54_PHY0_PMA_PWR_STABLE	BIT(11)
 #define CFG54_PHY0_PCS_PWR_STABLE	BIT(9)
@@ -84,8 +85,7 @@
 #define CFG54_USB31PHY_CR_CLK		BIT(2)
 #define CFG54_USB3_PHY0_ANA_PWR_EN	BIT(1)
 
-#define CFG58_USB31PHY_CR_DATA_MASK     (0xFFFF)
-#define CFG58_USB31PHY_CR_DATA_RD_START (16)
+#define CFG58_USB31PHY_CR_DATA_MASK     GENMASK(31, 16)
 
 #define CFG5C_USB3_PHY0_SS_MPLLA_SSC_EN	BIT(1)
 
@@ -102,20 +102,20 @@
 #define CLK_RST_SUSPEND_CLK_EN		BIT(0)
 
 #define GCFG_ROLE_HSTDEV		BIT(4)
-#define GCFG_OP_MODE			(3 << 0)
+#define GCFG_OP_MODE			GENMASK(1, 0)
 #define GCFG_OP_MODE_CTRL_SYNC_MODE	BIT(0)
 
 #define TCPC_VALID			BIT(4)
 #define TCPC_LOW_POWER_EN		BIT(3)
-#define TCPC_MUX_CONTROL_MASK		(3 << 0)
+#define TCPC_MUX_CONTROL_MASK		GENMASK(1, 0)
 #define TCPC_MUX_CONTROL_USB31		BIT(0)
 
 #define SYSMODE_CFG_TYPEC_DISABLE	BIT(3)
 
-#define VBUS_CTRL_POWERPRESENT_OVERRD	(3 << 2)
-#define VBUS_CTRL_VBUSVALID_OVERRD	(3 << 0)
+#define VBUS_CTRL_POWERPRESENT_OVERRD	GENMASK(3, 2)
+#define VBUS_CTRL_VBUSVALID_OVERRD	GENMASK(1, 0)
 
-#define KIRIN970_USB_DEFAULT_PHY_PARAM	(0xFDFEE4)
+#define KIRIN970_USB_DEFAULT_PHY_PARAM	(0xfdfee4)
 #define KIRIN970_USB_DEFAULT_PHY_VBOOST	(0x5)
 
 #define TX_VBOOST_LVL_REG		(0xf)
@@ -162,16 +162,14 @@ static int hi3670_phy_cr_set_sel(struct regmap *usb31misc)
 
 static int hi3670_phy_cr_start(struct regmap *usb31misc, int direction)
 {
-	int ret;
+	int ret, reg;
 
 	if (direction)
-		ret = regmap_update_bits(usb31misc, USB_MISC_CFG54,
-					 CFG54_USB31PHY_CR_WR_EN,
-					 CFG54_USB31PHY_CR_WR_EN);
+		reg = CFG54_USB31PHY_CR_WR_EN;
 	else
-		ret = regmap_update_bits(usb31misc, USB_MISC_CFG54,
-					 CFG54_USB31PHY_CR_RD_EN,
-					 CFG54_USB31PHY_CR_RD_EN);
+		reg = CFG54_USB31PHY_CR_RD_EN;
+
+	ret = regmap_update_bits(usb31misc, USB_MISC_CFG54, reg, reg);
 
 	if (ret)
 		return ret;
@@ -180,10 +178,8 @@ static int hi3670_phy_cr_start(struct regmap *usb31misc, int direction)
 	if (ret)
 		return ret;
 
-	ret = regmap_update_bits(usb31misc, USB_MISC_CFG54,
-				 CFG54_USB31PHY_CR_RD_EN | CFG54_USB31PHY_CR_WR_EN, 0);
-
-	return ret;
+	return regmap_update_bits(usb31misc, USB_MISC_CFG54,
+				  CFG54_USB31PHY_CR_RD_EN | CFG54_USB31PHY_CR_WR_EN, 0);
 }
 
 static int hi3670_phy_cr_wait_ack(struct regmap *usb31misc)
@@ -216,9 +212,9 @@ static int hi3670_phy_cr_set_addr(struct regmap *usb31misc, u32 addr)
 	if (ret)
 		return ret;
 
-	reg &= ~(CFG54_USB31PHY_CR_ADDR_MASK << CFG54_USB31PHY_CR_ADDR_SHIFT);
-	reg |= ((addr & CFG54_USB31PHY_CR_ADDR_MASK) << CFG54_USB31PHY_CR_ADDR_SHIFT);
-	ret = regmap_write(usb31misc, USB_MISC_CFG54, reg);
+	reg = FIELD_PREP(CFG54_USB31PHY_CR_ADDR_MASK, addr);
+	ret = regmap_update_bits(usb31misc, USB_MISC_CFG54,
+				 CFG54_USB31PHY_CR_ADDR_MASK, reg);
 
 	return ret;
 }
@@ -255,8 +251,7 @@ static int hi3670_phy_cr_read(struct regmap *usb31misc, u32 addr, u32 *val)
 	if (ret)
 		return ret;
 
-	*val = (reg >> CFG58_USB31PHY_CR_DATA_RD_START) &
-		CFG58_USB31PHY_CR_DATA_MASK;
+	*val = FIELD_GET(CFG58_USB31PHY_CR_DATA_MASK, reg);
 
 	return 0;
 }
@@ -281,7 +276,7 @@ static int hi3670_phy_cr_write(struct regmap *usb31misc, u32 addr, u32 val)
 		return ret;
 
 	ret = regmap_write(usb31misc, USB_MISC_CFG58,
-			   val & CFG58_USB31PHY_CR_DATA_MASK);
+			   FIELD_PREP(CFG58_USB31PHY_CR_DATA_MASK, val));
 	if (ret)
 		return ret;
 
-- 
2.29.2

