Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C92BD2C46BA
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 18:27:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732793AbgKYR1X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 12:27:23 -0500
Received: from out28-172.mail.aliyun.com ([115.124.28.172]:51470 "EHLO
        out28-172.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732774AbgKYR1T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 12:27:19 -0500
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07436282|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.00371057-1.20985e-05-0.996277;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047203;MF=zhouyanjie@wanyeetech.com;NM=1;PH=DS;RN=13;RT=13;SR=0;TI=SMTPD_---.J.BPrxs_1606325224;
Received: from localhost.localdomain(mailfrom:zhouyanjie@wanyeetech.com fp:SMTPD_---.J.BPrxs_1606325224)
          by smtp.aliyun-inc.com(10.147.41.137);
          Thu, 26 Nov 2020 01:27:14 +0800
From:   =?UTF-8?q?=E5=91=A8=E7=90=B0=E6=9D=B0=20=28Zhou=20Yanjie=29?= 
        <zhouyanjie@wanyeetech.com>
To:     sboyd@kernel.org, robh+dt@kernel.org, mturquette@baylibre.com,
        paul@crapouillou.net
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, dongsheng.qiu@ingenic.com,
        aric.pzqi@ingenic.com, rick.tyliu@ingenic.com,
        yanfei.li@ingenic.com, sernia.zhou@foxmail.com,
        zhenwenjin@gmail.com
Subject: [PATCH 3/4] clk: Ingenic: Add missing clocks for Ingenic SoCs.
Date:   Thu, 26 Nov 2020 01:26:17 +0800
Message-Id: <20201125172618.112707-4-zhouyanjie@wanyeetech.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20201125172618.112707-1-zhouyanjie@wanyeetech.com>
References: <20201125172618.112707-1-zhouyanjie@wanyeetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add CIM, AIC, DMIC clocks for the X1000 SoC, and CIM, AIC, DMIC, I2S
clocks for the X1830 SoC from Ingenic.

Signed-off-by: 周琰杰 (Zhou Yanjie) <zhouyanjie@wanyeetech.com>
---
 drivers/clk/ingenic/x1000-cgu.c |  19 ++++
 drivers/clk/ingenic/x1830-cgu.c | 189 +++++++++++++++++++++++++++++++++++++++-
 2 files changed, 207 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/ingenic/x1000-cgu.c b/drivers/clk/ingenic/x1000-cgu.c
index 9aa20b5..d340bcd 100644
--- a/drivers/clk/ingenic/x1000-cgu.c
+++ b/drivers/clk/ingenic/x1000-cgu.c
@@ -360,6 +360,13 @@ static const struct ingenic_cgu_clk_info x1000_cgu_clocks[] = {
 		.mux = { CGU_REG_SSICDR, 30, 1 },
 	},
 
+	[X1000_CLK_CIM] = {
+		"cim", CGU_CLK_MUX | CGU_CLK_DIV,
+		.parents = { X1000_CLK_SCLKA, X1000_CLK_MPLL, -1, -1 },
+		.mux = { CGU_REG_CIMCDR, 31, 1 },
+		.div = { CGU_REG_CIMCDR, 0, 1, 8, 29, 28, 27 },
+	},
+
 	[X1000_CLK_EXCLK_DIV512] = {
 		"exclk_div512", CGU_CLK_FIXDIV,
 		.parents = { X1000_CLK_EXCLK },
@@ -411,6 +418,12 @@ static const struct ingenic_cgu_clk_info x1000_cgu_clocks[] = {
 		.gate = { CGU_REG_CLKGR, 9 },
 	},
 
+	[X1000_CLK_AIC] = {
+		"aic", CGU_CLK_GATE,
+		.parents = { X1000_CLK_EXCLK, -1, -1, -1 },
+		.gate = { CGU_REG_CLKGR, 11 },
+	},
+
 	[X1000_CLK_UART0] = {
 		"uart0", CGU_CLK_GATE,
 		.parents = { X1000_CLK_EXCLK, -1, -1, -1 },
@@ -429,6 +442,12 @@ static const struct ingenic_cgu_clk_info x1000_cgu_clocks[] = {
 		.gate = { CGU_REG_CLKGR, 16 },
 	},
 
+	[X1000_CLK_DMIC] = {
+		"dmic", CGU_CLK_GATE,
+		.parents = { X1000_CLK_PCLK, -1, -1, -1 },
+		.gate = { CGU_REG_CLKGR, 17 },
+	},
+
 	[X1000_CLK_TCU] = {
 		"tcu", CGU_CLK_GATE,
 		.parents = { X1000_CLK_EXCLK, -1, -1, -1 },
diff --git a/drivers/clk/ingenic/x1830-cgu.c b/drivers/clk/ingenic/x1830-cgu.c
index 950aee2..e76e82c 100644
--- a/drivers/clk/ingenic/x1830-cgu.c
+++ b/drivers/clk/ingenic/x1830-cgu.c
@@ -52,6 +52,15 @@
 #define USBPCR_SIDDQ		BIT(21)
 #define USBPCR_OTG_DISABLE	BIT(20)
 
+/* bits within the I2SCDR register */
+#define I2SCDR_I2PCS_SHIFT	30
+#define I2SCDR_I2PCS_MASK	(0x3 << I2SCDR_I2PCS_SHIFT)
+#define I2SCDR_I2SDIV_M_SHIFT	20
+#define I2SCDR_I2SDIV_M_MASK	(0x1ff << I2SCDR_I2SDIV_M_SHIFT)
+#define I2SCDR_I2SDIV_N_SHIFT	0
+#define I2SCDR_I2SDIV_N_MASK	(0xfffff << I2SCDR_I2SDIV_N_SHIFT)
+#define I2SCDR_CE_I2S		BIT(29)
+
 static struct ingenic_cgu *cgu;
 
 static int x1830_usb_phy_enable(struct clk_hw *hw)
@@ -89,6 +98,157 @@ static const struct clk_ops x1830_otg_phy_ops = {
 	.is_enabled	= x1830_usb_phy_is_enabled,
 };
 
+static u8 x1830_i2s_get_parent(struct clk_hw *hw)
+{
+	u32 i2scdr;
+
+	i2scdr = readl(cgu->base + CGU_REG_I2SCDR);
+
+	return (i2scdr & I2SCDR_I2PCS_MASK) >> I2SCDR_I2PCS_SHIFT;
+}
+
+static int x1830_i2s_set_parent(struct clk_hw *hw, u8 idx)
+{
+	writel(idx << I2SCDR_I2PCS_SHIFT, cgu->base + CGU_REG_I2SCDR);
+
+	return 0;
+}
+
+static unsigned long x1830_i2s_recalc_rate(struct clk_hw *hw,
+						unsigned long parent_rate)
+{
+	unsigned m, n;
+	u32 i2scdr;
+
+	i2scdr = readl(cgu->base + CGU_REG_I2SCDR);
+
+	m = (i2scdr & I2SCDR_I2SDIV_M_MASK) >> I2SCDR_I2SDIV_M_SHIFT;
+	n = (i2scdr & I2SCDR_I2SDIV_N_MASK) >> I2SCDR_I2SDIV_N_SHIFT;
+
+	return div_u64((u64)parent_rate * m, n);
+}
+
+static unsigned long x1830_i2s_calc(unsigned long rate, unsigned long parent_rate,
+						unsigned *pm, unsigned *pn)
+{
+	u64 curr_delta, curr_m, curr_n, delta, m, n;
+
+	if ((parent_rate % rate == 0) && ((parent_rate / rate) > 1)) {
+		m = 1;
+		n = parent_rate / rate;
+		goto out;
+	}
+
+	delta = rate;
+
+	/*
+	 * The length of M is 9 bits, its value must be between 1 and 511.
+	 * The length of N is 20 bits, its value must be between 2 and 1048575,
+	 * and must not be less than 2 times of the value of M.
+	 */
+	for (curr_m = 511; curr_m >= 1; curr_m--) {
+		curr_n = parent_rate * curr_m;
+		curr_delta = do_div(curr_n, rate);
+
+		if (curr_n < 2 * curr_m || curr_n > 1048575)
+			continue;
+
+		if (curr_delta == 0)
+			break;
+
+		if (curr_delta < delta) {
+			m = curr_m;
+			n = curr_n;
+			delta = curr_delta;
+		}
+	}
+
+out:
+	if (pm)
+		*pm = m;
+	if (pn)
+		*pn = n;
+
+	return div_u64((u64)parent_rate * m, n);
+}
+
+static long x1830_i2s_round_rate(struct clk_hw *hw, unsigned long req_rate,
+						unsigned long *prate)
+{
+	return x1830_i2s_calc(req_rate, *prate, NULL, NULL);
+}
+
+static int x1830_i2s_set_rate(struct clk_hw *hw, unsigned long req_rate,
+						unsigned long parent_rate)
+{
+	unsigned long rate;
+	unsigned m, n;
+	u32 ctl;
+
+	/*
+	 * The parent clock rate of I2S must not be lower than 2 times
+	 * of the target clock rate.
+	 */
+	if (parent_rate < 2 * req_rate)
+		return -EINVAL;
+
+	rate = x1830_i2s_calc(req_rate, parent_rate, &m, &n);
+	if (rate != req_rate)
+		pr_info("%s: request I2S rate %luHz, actual %luHz\n", __func__,
+			req_rate, rate);
+
+	ctl = readl(cgu->base + CGU_REG_I2SCDR);
+	ctl &= ~I2SCDR_I2SDIV_M_MASK;
+	ctl |= m << I2SCDR_I2SDIV_M_SHIFT;
+	ctl &= ~I2SCDR_I2SDIV_N_MASK;
+	ctl |= n << I2SCDR_I2SDIV_N_SHIFT;
+	writel(ctl, cgu->base + CGU_REG_I2SCDR);
+
+	return 0;
+}
+
+static int x1830_i2s_enable(struct clk_hw *hw)
+{
+	u32 ctl;
+
+	ctl = readl(cgu->base + CGU_REG_I2SCDR);
+	ctl |= I2SCDR_CE_I2S;
+	writel(ctl, cgu->base + CGU_REG_I2SCDR);
+
+	return 0;
+}
+
+static void x1830_i2s_disable(struct clk_hw *hw)
+{
+	u32 ctl;
+
+	ctl = readl(cgu->base + CGU_REG_I2SCDR);
+	ctl &= ~I2SCDR_CE_I2S;
+	writel(ctl, cgu->base + CGU_REG_I2SCDR);
+}
+
+static int x1830_i2s_is_enabled(struct clk_hw *hw)
+{
+	u32 ctl;
+
+	ctl = readl(cgu->base + CGU_REG_I2SCDR);
+
+	return !!(ctl & I2SCDR_CE_I2S);
+}
+
+static const struct clk_ops x1830_i2s_ops = {
+	.get_parent = x1830_i2s_get_parent,
+	.set_parent = x1830_i2s_set_parent,
+
+	.recalc_rate = x1830_i2s_recalc_rate,
+	.round_rate = x1830_i2s_round_rate,
+	.set_rate = x1830_i2s_set_rate,
+
+	.enable = x1830_i2s_enable,
+	.disable = x1830_i2s_disable,
+	.is_enabled = x1830_i2s_is_enabled,
+};
+
 static const s8 pll_od_encoding[64] = {
 	0x0, 0x1,  -1, 0x2,  -1,  -1,  -1, 0x3,
 	 -1,  -1,  -1,  -1,  -1,  -1,  -1, 0x4,
@@ -201,7 +361,7 @@ static const struct ingenic_cgu_clk_info x1830_cgu_clocks[] = {
 		},
 	},
 
-	/* Custom (SoC-specific) OTG PHY */
+	/* Custom (SoC-specific) */
 
 	[X1830_CLK_OTGPHY] = {
 		"otg_phy", CGU_CLK_CUSTOM,
@@ -209,6 +369,13 @@ static const struct ingenic_cgu_clk_info x1830_cgu_clocks[] = {
 		.custom = { &x1830_otg_phy_ops },
 	},
 
+	[X1830_CLK_I2S] = {
+		"i2s", CGU_CLK_CUSTOM,
+		.parents = { X1830_CLK_SCLKA, X1830_CLK_MPLL,
+					 X1830_CLK_VPLL, X1830_CLK_EPLL },
+		.custom = { &x1830_i2s_ops },
+	},
+
 	/* Muxes & dividers */
 
 	[X1830_CLK_SCLKA] = {
@@ -329,6 +496,14 @@ static const struct ingenic_cgu_clk_info x1830_cgu_clocks[] = {
 		.mux = { CGU_REG_SSICDR, 29, 1 },
 	},
 
+	[X1830_CLK_CIM] = {
+		"cim", CGU_CLK_MUX | CGU_CLK_DIV,
+		.parents = { X1830_CLK_SCLKA, X1830_CLK_MPLL,
+					 X1830_CLK_VPLL, X1830_CLK_EPLL },
+		.mux = { CGU_REG_CIMCDR, 30, 2 },
+		.div = { CGU_REG_CIMCDR, 0, 1, 8, 29, 28, 27 },
+	},
+
 	[X1830_CLK_EXCLK_DIV512] = {
 		"exclk_div512", CGU_CLK_FIXDIV,
 		.parents = { X1830_CLK_EXCLK },
@@ -386,6 +561,18 @@ static const struct ingenic_cgu_clk_info x1830_cgu_clocks[] = {
 		.gate = { CGU_REG_CLKGR0, 9 },
 	},
 
+	[X1830_CLK_AIC] = {
+		"aic", CGU_CLK_GATE,
+		.parents = { X1830_CLK_EXCLK, -1, -1, -1 },
+		.gate = { CGU_REG_CLKGR0, 11 },
+	},
+
+	[X1830_CLK_DMIC] = {
+		"dmic", CGU_CLK_GATE,
+		.parents = { X1830_CLK_PCLK, -1, -1, -1 },
+		.gate = { CGU_REG_CLKGR0, 12 },
+	},
+
 	[X1830_CLK_UART0] = {
 		"uart0", CGU_CLK_GATE,
 		.parents = { X1830_CLK_EXCLK, -1, -1, -1 },
-- 
2.7.4

