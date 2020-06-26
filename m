Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 328C720B63B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jun 2020 18:49:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728030AbgFZQt3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Jun 2020 12:49:29 -0400
Received: from out28-100.mail.aliyun.com ([115.124.28.100]:49589 "EHLO
        out28-100.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727938AbgFZQtZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 12:49:25 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07436522|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.361374-0.00520398-0.633422;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03301;MF=zhouyanjie@wanyeetech.com;NM=1;PH=DS;RN=11;RT=11;SR=0;TI=SMTPD_---.HsyHo9F_1593190149;
Received: from localhost.localdomain(mailfrom:zhouyanjie@wanyeetech.com fp:SMTPD_---.HsyHo9F_1593190149)
          by smtp.aliyun-inc.com(10.147.41.137);
          Sat, 27 Jun 2020 00:49:17 +0800
From:   =?UTF-8?q?=E5=91=A8=E7=90=B0=E6=9D=B0=20=28Zhou=20Yanjie=29?= 
        <zhouyanjie@wanyeetech.com>
To:     linux-clk@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, sboyd@kernel.org,
        paul@crapouillou.net, mturquette@baylibre.com,
        dongsheng.qiu@ingenic.com, aric.pzqi@ingenic.com,
        rick.tyliu@ingenic.com, yanfei.li@ingenic.com,
        sernia.zhou@foxmail.com, zhenwenjin@gmail.com
Subject: [PATCH 1/2] clk: JZ4780: Add functions for enable and disable USB PHY.
Date:   Sat, 27 Jun 2020 00:48:43 +0800
Message-Id: <20200626164844.25436-2-zhouyanjie@wanyeetech.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200626164844.25436-1-zhouyanjie@wanyeetech.com>
References: <20200626164844.25436-1-zhouyanjie@wanyeetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add new functions to "jz4780_otg_phy_ops" to enable or disable the
USB PHY in the Ingenic JZ4780 SoC.

Tested-by: 周正 (Zhou Zheng) <sernia.zhou@foxmail.com>
Signed-off-by: 周琰杰 (Zhou Yanjie) <zhouyanjie@wanyeetech.com>
---
 drivers/clk/ingenic/jz4780-cgu.c | 124 +++++++++++++++++++++++++--------------
 1 file changed, 80 insertions(+), 44 deletions(-)

diff --git a/drivers/clk/ingenic/jz4780-cgu.c b/drivers/clk/ingenic/jz4780-cgu.c
index 6c5b8029cc8a..0ec50b9ab9c1 100644
--- a/drivers/clk/ingenic/jz4780-cgu.c
+++ b/drivers/clk/ingenic/jz4780-cgu.c
@@ -4,6 +4,7 @@
  *
  * Copyright (c) 2013-2015 Imagination Technologies
  * Author: Paul Burton <paul.burton@mips.com>
+ * Copyright (c) 2020 周琰杰 (Zhou Yanjie) <zhouyanjie@wanyeetech.com>
  */
 
 #include <linux/clk-provider.h>
@@ -19,55 +20,57 @@
 
 /* CGU register offsets */
 #define CGU_REG_CLOCKCONTROL	0x00
-#define CGU_REG_LCR			0x04
-#define CGU_REG_APLL		0x10
-#define CGU_REG_MPLL		0x14
-#define CGU_REG_EPLL		0x18
-#define CGU_REG_VPLL		0x1c
-#define CGU_REG_CLKGR0		0x20
-#define CGU_REG_OPCR		0x24
-#define CGU_REG_CLKGR1		0x28
-#define CGU_REG_DDRCDR		0x2c
-#define CGU_REG_VPUCDR		0x30
-#define CGU_REG_USBPCR		0x3c
-#define CGU_REG_USBRDT		0x40
-#define CGU_REG_USBVBFIL	0x44
-#define CGU_REG_USBPCR1		0x48
-#define CGU_REG_LP0CDR		0x54
-#define CGU_REG_I2SCDR		0x60
-#define CGU_REG_LP1CDR		0x64
-#define CGU_REG_MSC0CDR		0x68
-#define CGU_REG_UHCCDR		0x6c
-#define CGU_REG_SSICDR		0x74
-#define CGU_REG_CIMCDR		0x7c
-#define CGU_REG_PCMCDR		0x84
-#define CGU_REG_GPUCDR		0x88
-#define CGU_REG_HDMICDR		0x8c
-#define CGU_REG_MSC1CDR		0xa4
-#define CGU_REG_MSC2CDR		0xa8
-#define CGU_REG_BCHCDR		0xac
-#define CGU_REG_CLOCKSTATUS	0xd4
+#define CGU_REG_LCR				0x04
+#define CGU_REG_APLL			0x10
+#define CGU_REG_MPLL			0x14
+#define CGU_REG_EPLL			0x18
+#define CGU_REG_VPLL			0x1c
+#define CGU_REG_CLKGR0			0x20
+#define CGU_REG_OPCR			0x24
+#define CGU_REG_CLKGR1			0x28
+#define CGU_REG_DDRCDR			0x2c
+#define CGU_REG_VPUCDR			0x30
+#define CGU_REG_USBPCR			0x3c
+#define CGU_REG_USBRDT			0x40
+#define CGU_REG_USBVBFIL		0x44
+#define CGU_REG_USBPCR1			0x48
+#define CGU_REG_LP0CDR			0x54
+#define CGU_REG_I2SCDR			0x60
+#define CGU_REG_LP1CDR			0x64
+#define CGU_REG_MSC0CDR			0x68
+#define CGU_REG_UHCCDR			0x6c
+#define CGU_REG_SSICDR			0x74
+#define CGU_REG_CIMCDR			0x7c
+#define CGU_REG_PCMCDR			0x84
+#define CGU_REG_GPUCDR			0x88
+#define CGU_REG_HDMICDR			0x8c
+#define CGU_REG_MSC1CDR			0xa4
+#define CGU_REG_MSC2CDR			0xa8
+#define CGU_REG_BCHCDR			0xac
+#define CGU_REG_CLOCKSTATUS		0xd4
 
 /* bits within the OPCR register */
-#define OPCR_SPENDN0		BIT(7)
-#define OPCR_SPENDN1		BIT(6)
+#define OPCR_SPENDN0			BIT(7)
+#define OPCR_SPENDN1			BIT(6)
 
 /* bits within the USBPCR register */
-#define USBPCR_USB_MODE		BIT(31)
+#define USBPCR_USB_MODE			BIT(31)
 #define USBPCR_IDPULLUP_MASK	(0x3 << 28)
-#define USBPCR_COMMONONN	BIT(25)
-#define USBPCR_VBUSVLDEXT	BIT(24)
+#define USBPCR_COMMONONN		BIT(25)
+#define USBPCR_VBUSVLDEXT		BIT(24)
 #define USBPCR_VBUSVLDEXTSEL	BIT(23)
-#define USBPCR_POR		BIT(22)
-#define USBPCR_OTG_DISABLE	BIT(20)
+#define USBPCR_POR				BIT(22)
+#define USBPCR_SIDDQ			BIT(21)
+#define USBPCR_OTG_DISABLE		BIT(20)
 #define USBPCR_COMPDISTUNE_MASK	(0x7 << 17)
-#define USBPCR_OTGTUNE_MASK	(0x7 << 14)
+#define USBPCR_OTGTUNE_MASK		(0x7 << 14)
 #define USBPCR_SQRXTUNE_MASK	(0x7 << 11)
 #define USBPCR_TXFSLSTUNE_MASK	(0xf << 7)
 #define USBPCR_TXPREEMPHTUNE	BIT(6)
 #define USBPCR_TXHSXVTUNE_MASK	(0x3 << 4)
 #define USBPCR_TXVREFTUNE_MASK	0xf
 
+
 /* bits within the USBPCR1 register */
 #define USBPCR1_REFCLKSEL_SHIFT	26
 #define USBPCR1_REFCLKSEL_MASK	(0x3 << USBPCR1_REFCLKSEL_SHIFT)
@@ -78,13 +81,13 @@
 #define USBPCR1_REFCLKDIV_48	(0x2 << USBPCR1_REFCLKDIV_SHIFT)
 #define USBPCR1_REFCLKDIV_24	(0x1 << USBPCR1_REFCLKDIV_SHIFT)
 #define USBPCR1_REFCLKDIV_12	(0x0 << USBPCR1_REFCLKDIV_SHIFT)
-#define USBPCR1_USB_SEL		BIT(28)
-#define USBPCR1_WORD_IF0	BIT(19)
-#define USBPCR1_WORD_IF1	BIT(18)
+#define USBPCR1_USB_SEL			BIT(28)
+#define USBPCR1_WORD_IF0		BIT(19)
+#define USBPCR1_WORD_IF1		BIT(18)
 
 /* bits within the USBRDT register */
-#define USBRDT_VBFIL_LD_EN	BIT(25)
-#define USBRDT_USBRDT_MASK	0x7fffff
+#define USBRDT_VBFIL_LD_EN		BIT(25)
+#define USBRDT_USBRDT_MASK		0x7fffff
 
 /* bits within the USBVBFIL register */
 #define USBVBFIL_IDDIGFIL_SHIFT	16
@@ -92,11 +95,11 @@
 #define USBVBFIL_USBVBFIL_MASK	(0xffff)
 
 /* bits within the LCR register */
-#define LCR_PD_SCPU			BIT(31)
-#define LCR_SCPUS			BIT(27)
+#define LCR_PD_SCPU				BIT(31)
+#define LCR_SCPUS				BIT(27)
 
 /* bits within the CLKGR1 register */
-#define CLKGR1_CORE1		BIT(15)
+#define CLKGR1_CORE1			BIT(15)
 
 static struct ingenic_cgu *cgu;
 
@@ -206,6 +209,35 @@ static int jz4780_otg_phy_set_rate(struct clk_hw *hw, unsigned long req_rate,
 	return 0;
 }
 
+static int jz4780_otg_phy_enable(struct clk_hw *hw)
+{
+	void __iomem *reg_opcr		= cgu->base + CGU_REG_OPCR;
+	void __iomem *reg_usbpcr	= cgu->base + CGU_REG_USBPCR;
+
+	writel(readl(reg_opcr) | OPCR_SPENDN0, reg_opcr);
+	writel(readl(reg_usbpcr) & ~USBPCR_OTG_DISABLE & ~USBPCR_SIDDQ, reg_usbpcr);
+	return 0;
+}
+
+static void jz4780_otg_phy_disable(struct clk_hw *hw)
+{
+	void __iomem *reg_opcr		= cgu->base + CGU_REG_OPCR;
+	void __iomem *reg_usbpcr	= cgu->base + CGU_REG_USBPCR;
+
+	writel(readl(reg_opcr) & ~OPCR_SPENDN0, reg_opcr);
+	writel(readl(reg_usbpcr) | USBPCR_OTG_DISABLE | USBPCR_SIDDQ, reg_usbpcr);
+}
+
+static int jz4780_otg_phy_is_enabled(struct clk_hw *hw)
+{
+	void __iomem *reg_opcr		= cgu->base + CGU_REG_OPCR;
+	void __iomem *reg_usbpcr	= cgu->base + CGU_REG_USBPCR;
+
+	return (readl(reg_opcr) & OPCR_SPENDN0) &&
+		!(readl(reg_usbpcr) & USBPCR_SIDDQ) &&
+		!(readl(reg_usbpcr) & USBPCR_OTG_DISABLE);
+}
+
 static const struct clk_ops jz4780_otg_phy_ops = {
 	.get_parent = jz4780_otg_phy_get_parent,
 	.set_parent = jz4780_otg_phy_set_parent,
@@ -213,6 +245,10 @@ static const struct clk_ops jz4780_otg_phy_ops = {
 	.recalc_rate = jz4780_otg_phy_recalc_rate,
 	.round_rate = jz4780_otg_phy_round_rate,
 	.set_rate = jz4780_otg_phy_set_rate,
+
+	.enable		= jz4780_otg_phy_enable,
+	.disable	= jz4780_otg_phy_disable,
+	.is_enabled	= jz4780_otg_phy_is_enabled,
 };
 
 static int jz4780_core1_enable(struct clk_hw *hw)
-- 
2.11.0

