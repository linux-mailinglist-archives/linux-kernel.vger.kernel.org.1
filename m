Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2A0F20F9A1
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jun 2020 18:39:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732468AbgF3Qjh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Jun 2020 12:39:37 -0400
Received: from out28-76.mail.aliyun.com ([115.124.28.76]:54899 "EHLO
        out28-76.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732379AbgF3Qjf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 12:39:35 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.04436562|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.108682-0.0117639-0.879554;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03307;MF=zhouyanjie@wanyeetech.com;NM=1;PH=DS;RN=11;RT=11;SR=0;TI=SMTPD_---.HvJGFHX_1593535155;
Received: from localhost.localdomain(mailfrom:zhouyanjie@wanyeetech.com fp:SMTPD_---.HvJGFHX_1593535155)
          by smtp.aliyun-inc.com(10.147.43.230);
          Wed, 01 Jul 2020 00:39:30 +0800
From:   =?UTF-8?q?=E5=91=A8=E7=90=B0=E6=9D=B0=20=28Zhou=20Yanjie=29?= 
        <zhouyanjie@wanyeetech.com>
To:     linux-clk@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, sboyd@kernel.org,
        paul@crapouillou.net, mturquette@baylibre.com,
        dongsheng.qiu@ingenic.com, aric.pzqi@ingenic.com,
        rick.tyliu@ingenic.com, yanfei.li@ingenic.com,
        sernia.zhou@foxmail.com, zhenwenjin@gmail.com
Subject: [PATCH v3 3/3] clk: X1000: Add support for calculat REFCLK of USB PHY.
Date:   Wed,  1 Jul 2020 00:38:52 +0800
Message-Id: <20200630163852.47267-4-zhouyanjie@wanyeetech.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200630163852.47267-1-zhouyanjie@wanyeetech.com>
References: <20200630163852.47267-1-zhouyanjie@wanyeetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add functions for calculat the rate of REFCLK, which is needed by
USB PHY in Ingenic X1000 SoC.

Tested-by: 周正 (Zhou Zheng) <sernia.zhou@foxmail.com>
Signed-off-by: 周琰杰 (Zhou Yanjie) <zhouyanjie@wanyeetech.com>
---

Notes:
    v1->v2:
    1.Use "WARN()" instead "BUG()".
    2.Remove unnecessary get_parent/set_parent functions.
    
    v2->v3:
    1.Remove the wrong "WARN()";
    2.Fix wrong parameters in recalc_rate/set_rate functions.

 drivers/clk/ingenic/x1000-cgu.c | 84 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 83 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/ingenic/x1000-cgu.c b/drivers/clk/ingenic/x1000-cgu.c
index 453f3323cb99..38143bcd4cbd 100644
--- a/drivers/clk/ingenic/x1000-cgu.c
+++ b/drivers/clk/ingenic/x1000-cgu.c
@@ -48,8 +48,87 @@
 #define USBPCR_SIDDQ		BIT(21)
 #define USBPCR_OTG_DISABLE	BIT(20)
 
+/* bits within the USBPCR1 register */
+#define USBPCR1_REFCLKSEL_SHIFT	26
+#define USBPCR1_REFCLKSEL_MASK	(0x3 << USBPCR1_REFCLKSEL_SHIFT)
+#define USBPCR1_REFCLKSEL_CORE	(0x2 << USBPCR1_REFCLKSEL_SHIFT)
+#define USBPCR1_REFCLKDIV_SHIFT	24
+#define USBPCR1_REFCLKDIV_MASK	(0x3 << USBPCR1_REFCLKDIV_SHIFT)
+#define USBPCR1_REFCLKDIV_48	(0x2 << USBPCR1_REFCLKDIV_SHIFT)
+#define USBPCR1_REFCLKDIV_24	(0x1 << USBPCR1_REFCLKDIV_SHIFT)
+#define USBPCR1_REFCLKDIV_12	(0x0 << USBPCR1_REFCLKDIV_SHIFT)
+
 static struct ingenic_cgu *cgu;
 
+static unsigned long x1000_otg_phy_recalc_rate(struct clk_hw *hw,
+						unsigned long parent_rate)
+{
+	u32 usbpcr1;
+	unsigned refclk_div;
+
+	usbpcr1 = readl(cgu->base + CGU_REG_USBPCR1);
+	refclk_div = usbpcr1 & USBPCR1_REFCLKDIV_MASK;
+
+	switch (refclk_div) {
+	case USBPCR1_REFCLKDIV_12:
+		return 12000000;
+
+	case USBPCR1_REFCLKDIV_24:
+		return 24000000;
+
+	case USBPCR1_REFCLKDIV_48:
+		return 48000000;
+	}
+
+	return parent_rate;
+}
+
+static long x1000_otg_phy_round_rate(struct clk_hw *hw, unsigned long req_rate,
+				      unsigned long *parent_rate)
+{
+	if (req_rate < 18000000)
+		return 12000000;
+
+	if (req_rate < 36000000)
+		return 24000000;
+
+	return 48000000;
+}
+
+static int x1000_otg_phy_set_rate(struct clk_hw *hw, unsigned long req_rate,
+				   unsigned long parent_rate)
+{
+	unsigned long flags;
+	u32 usbpcr1, div_bits;
+
+	switch (req_rate) {
+	case 12000000:
+		div_bits = USBPCR1_REFCLKDIV_12;
+		break;
+
+	case 24000000:
+		div_bits = USBPCR1_REFCLKDIV_24;
+		break;
+
+	case 48000000:
+		div_bits = USBPCR1_REFCLKDIV_48;
+		break;
+
+	default:
+		return -EINVAL;
+	}
+
+	spin_lock_irqsave(&cgu->lock, flags);
+
+	usbpcr1 = readl(cgu->base + CGU_REG_USBPCR1);
+	usbpcr1 &= ~USBPCR1_REFCLKDIV_MASK;
+	usbpcr1 |= div_bits;
+	writel(usbpcr1, cgu->base + CGU_REG_USBPCR1);
+
+	spin_unlock_irqrestore(&cgu->lock, flags);
+	return 0;
+}
+
 static int x1000_usb_phy_enable(struct clk_hw *hw)
 {
 	void __iomem *reg_opcr		= cgu->base + CGU_REG_OPCR;
@@ -80,6 +159,10 @@ static int x1000_usb_phy_is_enabled(struct clk_hw *hw)
 }
 
 static const struct clk_ops x1000_otg_phy_ops = {
+	.recalc_rate = x1000_otg_phy_recalc_rate,
+	.round_rate = x1000_otg_phy_round_rate,
+	.set_rate = x1000_otg_phy_set_rate,
+
 	.enable		= x1000_usb_phy_enable,
 	.disable	= x1000_usb_phy_disable,
 	.is_enabled	= x1000_usb_phy_is_enabled,
@@ -144,7 +227,6 @@ static const struct ingenic_cgu_clk_info x1000_cgu_clocks[] = {
 		},
 	},
 
-
 	/* Custom (SoC-specific) OTG PHY */
 
 	[X1000_CLK_OTGPHY] = {
-- 
2.11.0

