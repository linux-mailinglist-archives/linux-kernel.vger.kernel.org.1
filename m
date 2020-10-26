Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD01C2995C3
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 19:51:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1790460AbgJZSvK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 14:51:10 -0400
Received: from inva020.nxp.com ([92.121.34.13]:35430 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1790447AbgJZSvI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 14:51:08 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 26B591A125F;
        Mon, 26 Oct 2020 19:51:06 +0100 (CET)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 194FC1A006E;
        Mon, 26 Oct 2020 19:51:06 +0100 (CET)
Received: from fsr-ub1664-175.ea.freescale.net (fsr-ub1664-175.ea.freescale.net [10.171.82.40])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 7DB3A20308;
        Mon, 26 Oct 2020 19:51:05 +0100 (CET)
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>, Peng Fan <peng.fan@nxp.com>,
        Dong Aisheng <aisheng.dong@nxp.com>
Cc:     NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-clk@vger.kernel.org, Abel Vesa <abel.vesa@nxp.com>
Subject: [PATCH] clk: imx: gate2: Fix the is_enabled op
Date:   Mon, 26 Oct 2020 20:50:48 +0200
Message-Id: <1603738248-8193-1-git-send-email-abel.vesa@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The clock is considered to be enabled only if the controlling bits
match the cgr_val mask. Also make sure the is_enabled returns the
correct vaule by locking the access to the register.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
Fixes: 1e54afe9fcfe ("clk: imx: gate2: Allow single bit gating clock")
---
 drivers/clk/imx/clk-gate2.c | 60 ++++++++++++++++++++-------------------------
 drivers/clk/imx/clk.h       |  8 ++----
 2 files changed, 29 insertions(+), 39 deletions(-)

diff --git a/drivers/clk/imx/clk-gate2.c b/drivers/clk/imx/clk-gate2.c
index 7eed708..f320bd2b 100644
--- a/drivers/clk/imx/clk-gate2.c
+++ b/drivers/clk/imx/clk-gate2.c
@@ -37,10 +37,22 @@ struct clk_gate2 {
 
 #define to_clk_gate2(_hw) container_of(_hw, struct clk_gate2, hw)
 
+static void clk_gate2_do_shared_clks(struct clk_hw *hw, bool enable)
+{
+	struct clk_gate2 *gate = to_clk_gate2(hw);
+	u32 reg;
+
+	reg = readl(gate->reg);
+	if (enable)
+		reg |= gate->cgr_val << gate->bit_idx;
+	else
+		reg &= ~(gate->cgr_val << gate->bit_idx);
+	writel(reg, gate->reg);
+}
+
 static int clk_gate2_enable(struct clk_hw *hw)
 {
 	struct clk_gate2 *gate = to_clk_gate2(hw);
-	u32 reg;
 	unsigned long flags;
 	int ret = 0;
 
@@ -49,15 +61,7 @@ static int clk_gate2_enable(struct clk_hw *hw)
 	if (gate->share_count && (*gate->share_count)++ > 0)
 		goto out;
 
-	if (gate->flags & IMX_CLK_GATE2_SINGLE_BIT) {
-		ret = clk_gate_ops.enable(hw);
-	} else {
-		reg = readl(gate->reg);
-		reg &= ~(3 << gate->bit_idx);
-		reg |= gate->cgr_val << gate->bit_idx;
-		writel(reg, gate->reg);
-	}
-
+	clk_gate2_do_shared_clks(hw, true);
 out:
 	spin_unlock_irqrestore(gate->lock, flags);
 
@@ -67,7 +71,6 @@ static int clk_gate2_enable(struct clk_hw *hw)
 static void clk_gate2_disable(struct clk_hw *hw)
 {
 	struct clk_gate2 *gate = to_clk_gate2(hw);
-	u32 reg;
 	unsigned long flags;
 
 	spin_lock_irqsave(gate->lock, flags);
@@ -79,23 +82,16 @@ static void clk_gate2_disable(struct clk_hw *hw)
 			goto out;
 	}
 
-	if (gate->flags & IMX_CLK_GATE2_SINGLE_BIT) {
-		clk_gate_ops.disable(hw);
-	} else {
-		reg = readl(gate->reg);
-		reg &= ~(3 << gate->bit_idx);
-		writel(reg, gate->reg);
-	}
-
+	clk_gate2_do_shared_clks(hw, false);
 out:
 	spin_unlock_irqrestore(gate->lock, flags);
 }
 
-static int clk_gate2_reg_is_enabled(void __iomem *reg, u8 bit_idx)
+static int clk_gate2_reg_is_enabled(void __iomem *reg, u8 bit_idx, u8 cgr_val)
 {
 	u32 val = readl(reg);
 
-	if (((val >> bit_idx) & 1) == 1)
+	if (((val >> bit_idx) & cgr_val) == cgr_val)
 		return 1;
 
 	return 0;
@@ -104,29 +100,27 @@ static int clk_gate2_reg_is_enabled(void __iomem *reg, u8 bit_idx)
 static int clk_gate2_is_enabled(struct clk_hw *hw)
 {
 	struct clk_gate2 *gate = to_clk_gate2(hw);
+	unsigned long flags;
+	int ret;
 
-	if (gate->flags & IMX_CLK_GATE2_SINGLE_BIT)
-		return clk_gate_ops.is_enabled(hw);
+	spin_lock_irqsave(gate->lock, flags);
 
-	return clk_gate2_reg_is_enabled(gate->reg, gate->bit_idx);
+	ret = clk_gate2_reg_is_enabled(gate->reg, gate->bit_idx, gate->cgr_val);
+
+	spin_unlock_irqrestore(gate->lock, flags);
+
+	return ret;
 }
 
 static void clk_gate2_disable_unused(struct clk_hw *hw)
 {
 	struct clk_gate2 *gate = to_clk_gate2(hw);
 	unsigned long flags;
-	u32 reg;
-
-	if (gate->flags & IMX_CLK_GATE2_SINGLE_BIT)
-		return;
 
 	spin_lock_irqsave(gate->lock, flags);
 
-	if (!gate->share_count || *gate->share_count == 0) {
-		reg = readl(gate->reg);
-		reg &= ~(3 << gate->bit_idx);
-		writel(reg, gate->reg);
-	}
+	if (!gate->share_count || *gate->share_count == 0)
+		clk_gate2_do_shared_clks(hw, false);
 
 	spin_unlock_irqrestore(gate->lock, flags);
 }
diff --git a/drivers/clk/imx/clk.h b/drivers/clk/imx/clk.h
index 3b796b3..069b07d 100644
--- a/drivers/clk/imx/clk.h
+++ b/drivers/clk/imx/clk.h
@@ -6,8 +6,6 @@
 #include <linux/spinlock.h>
 #include <linux/clk-provider.h>
 
-#define IMX_CLK_GATE2_SINGLE_BIT	1
-
 extern spinlock_t imx_ccm_lock;
 
 void imx_check_clocks(struct clk *clks[], unsigned int count);
@@ -383,10 +381,8 @@ static inline struct clk_hw *imx_dev_clk_hw_gate_shared(struct device *dev,
 				void __iomem *reg, u8 shift,
 				unsigned int *share_count)
 {
-	return clk_hw_register_gate2(NULL, name, parent, CLK_SET_RATE_PARENT |
-					CLK_OPS_PARENT_ENABLE, reg, shift, 0x3,
-					IMX_CLK_GATE2_SINGLE_BIT,
-					&imx_ccm_lock, share_count);
+	return clk_hw_register_gate2(dev, name, parent, CLK_SET_RATE_PARENT | CLK_OPS_PARENT_ENABLE, reg,
+					shift, 0x1, 0, &imx_ccm_lock, share_count);
 }
 
 static inline struct clk *imx_clk_gate2_cgr(const char *name,
-- 
2.7.4

