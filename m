Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC4F229D81F
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Oct 2020 23:29:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387632AbgJ1W3t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 18:29:49 -0400
Received: from inva020.nxp.com ([92.121.34.13]:41736 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387589AbgJ1W3d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 18:29:33 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 041491A15AA;
        Wed, 28 Oct 2020 13:59:38 +0100 (CET)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id EAB941A1595;
        Wed, 28 Oct 2020 13:59:37 +0100 (CET)
Received: from fsr-ub1664-175.ea.freescale.net (fsr-ub1664-175.ea.freescale.net [10.171.82.40])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 4D9C12030E;
        Wed, 28 Oct 2020 13:59:37 +0100 (CET)
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Lucas Stach <l.stach@pengutronix.de>,
        Rob Herring <robh@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>, Peng Fan <peng.fan@nxp.com>,
        Dong Aisheng <aisheng.dong@nxp.com>
Cc:     NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        Abel Vesa <abel.vesa@nxp.com>
Subject: [PATCH v2 4/5] clk: imx: gate2: Add cgr_mask for more flexible number of control bits
Date:   Wed, 28 Oct 2020 14:59:01 +0200
Message-Id: <1603889942-27026-5-git-send-email-abel.vesa@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1603889942-27026-1-git-send-email-abel.vesa@nxp.com>
References: <1603889942-27026-1-git-send-email-abel.vesa@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On some i.MX8 platforms, there are HW gates that share the same bit.
So in order to make this clock type more usable, use a mask to specify
how many bits belong to those HW gates.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
---
 drivers/clk/imx/clk-gate2.c | 16 ++++++++++------
 drivers/clk/imx/clk.h       | 24 ++++++++++++------------
 2 files changed, 22 insertions(+), 18 deletions(-)

diff --git a/drivers/clk/imx/clk-gate2.c b/drivers/clk/imx/clk-gate2.c
index 40bcc2d..7e4b5e8 100644
--- a/drivers/clk/imx/clk-gate2.c
+++ b/drivers/clk/imx/clk-gate2.c
@@ -30,6 +30,7 @@ struct clk_gate2 {
 	void __iomem	*reg;
 	u8		bit_idx;
 	u8		cgr_val;
+	u8		cgr_mask;
 	u8		flags;
 	spinlock_t	*lock;
 	unsigned int	*share_count;
@@ -43,9 +44,9 @@ static void clk_gate2_do_shared_clks(struct clk_hw *hw, bool enable)
 	u32 reg;
 
 	reg = readl(gate->reg);
-	reg &= ~(3 << gate->bit_idx);
+	reg &= ~(gate->cgr_mask << gate->bit_idx);
 	if (enable)
-		reg |= gate->cgr_val << gate->bit_idx;
+		reg |= (gate->cgr_val & gate->cgr_mask) << gate->bit_idx;
 	writel(reg, gate->reg);
 }
 
@@ -86,11 +87,12 @@ static void clk_gate2_disable(struct clk_hw *hw)
 	spin_unlock_irqrestore(gate->lock, flags);
 }
 
-static int clk_gate2_reg_is_enabled(void __iomem *reg, u8 bit_idx, u8 cgr_val)
+static int clk_gate2_reg_is_enabled(void __iomem *reg, u8 bit_idx,
+					u8 cgr_val, u8 cgr_mask)
 {
 	u32 val = readl(reg);
 
-	if (((val >> bit_idx) & 3) == cgr_val)
+	if (((val >> bit_idx) & cgr_mask) == cgr_val)
 		return 1;
 
 	return 0;
@@ -100,7 +102,8 @@ static int clk_gate2_is_enabled(struct clk_hw *hw)
 {
 	struct clk_gate2 *gate = to_clk_gate2(hw);
 
-	return clk_gate2_reg_is_enabled(gate->reg, gate->bit_idx, gate->cgr_val);
+	return clk_gate2_reg_is_enabled(gate->reg, gate->bit_idx,
+					gate->cgr_val, gate->cgr_mask);
 }
 
 static void clk_gate2_disable_unused(struct clk_hw *hw)
@@ -125,7 +128,7 @@ static const struct clk_ops clk_gate2_ops = {
 
 struct clk_hw *clk_hw_register_gate2(struct device *dev, const char *name,
 		const char *parent_name, unsigned long flags,
-		void __iomem *reg, u8 bit_idx, u8 cgr_val,
+		void __iomem *reg, u8 bit_idx, u8 cgr_val, u8 cgr_mask,
 		u8 clk_gate2_flags, spinlock_t *lock,
 		unsigned int *share_count)
 {
@@ -142,6 +145,7 @@ struct clk_hw *clk_hw_register_gate2(struct device *dev, const char *name,
 	gate->reg = reg;
 	gate->bit_idx = bit_idx;
 	gate->cgr_val = cgr_val;
+	gate->cgr_mask = cgr_mask;
 	gate->flags = clk_gate2_flags;
 	gate->lock = lock;
 	gate->share_count = share_count;
diff --git a/drivers/clk/imx/clk.h b/drivers/clk/imx/clk.h
index 87b2744f..3d8e40b 100644
--- a/drivers/clk/imx/clk.h
+++ b/drivers/clk/imx/clk.h
@@ -66,9 +66,9 @@ extern struct imx_pll14xx_clk imx_1443x_dram_pll;
 	to_clk(imx_clk_hw_cpu(name, parent_name, div, mux, pll, step))
 
 #define clk_register_gate2(dev, name, parent_name, flags, reg, bit_idx, \
-				cgr_val, clk_gate_flags, lock, share_count) \
+				cgr_val, cgr_mask, clk_gate_flags, lock, share_count) \
 	to_clk(clk_hw_register_gate2(dev, name, parent_name, flags, reg, bit_idx, \
-				cgr_val, clk_gate_flags, lock, share_count))
+				cgr_val, cgr_mask, clk_gate_flags, lock, share_count))
 
 #define imx_clk_pllv3(type, name, parent_name, base, div_mask) \
 	to_clk(imx_clk_hw_pllv3(type, name, parent_name, base, div_mask))
@@ -196,7 +196,7 @@ struct clk_hw *imx_clk_hw_pllv4(const char *name, const char *parent_name,
 
 struct clk_hw *clk_hw_register_gate2(struct device *dev, const char *name,
 		const char *parent_name, unsigned long flags,
-		void __iomem *reg, u8 bit_idx, u8 cgr_val,
+		void __iomem *reg, u8 bit_idx, u8 cgr_val, u8 cgr_mask,
 		u8 clk_gate_flags, spinlock_t *lock,
 		unsigned int *share_count);
 
@@ -349,14 +349,14 @@ static inline struct clk_hw *imx_clk_hw_gate2(const char *name, const char *pare
 		void __iomem *reg, u8 shift)
 {
 	return clk_hw_register_gate2(NULL, name, parent, CLK_SET_RATE_PARENT, reg,
-			shift, 0x3, 0, &imx_ccm_lock, NULL);
+			shift, 0x3, 0x3, 0, &imx_ccm_lock, NULL);
 }
 
 static inline struct clk_hw *imx_clk_hw_gate2_flags(const char *name, const char *parent,
 		void __iomem *reg, u8 shift, unsigned long flags)
 {
 	return clk_hw_register_gate2(NULL, name, parent, flags | CLK_SET_RATE_PARENT, reg,
-			shift, 0x3, 0, &imx_ccm_lock, NULL);
+			shift, 0x3, 0x3, 0, &imx_ccm_lock, NULL);
 }
 
 static inline struct clk_hw *imx_clk_hw_gate2_shared(const char *name,
@@ -364,7 +364,7 @@ static inline struct clk_hw *imx_clk_hw_gate2_shared(const char *name,
 		unsigned int *share_count)
 {
 	return clk_hw_register_gate2(NULL, name, parent, CLK_SET_RATE_PARENT, reg,
-			shift, 0x3, 0, &imx_ccm_lock, share_count);
+			shift, 0x3, 0x3, 0, &imx_ccm_lock, share_count);
 }
 
 static inline struct clk_hw *imx_clk_hw_gate2_shared2(const char *name,
@@ -372,7 +372,7 @@ static inline struct clk_hw *imx_clk_hw_gate2_shared2(const char *name,
 		unsigned int *share_count)
 {
 	return clk_hw_register_gate2(NULL, name, parent, CLK_SET_RATE_PARENT |
-				  CLK_OPS_PARENT_ENABLE, reg, shift, 0x3, 0,
+				  CLK_OPS_PARENT_ENABLE, reg, shift, 0x3, 0x3, 0,
 				  &imx_ccm_lock, share_count);
 }
 
@@ -382,15 +382,15 @@ static inline struct clk_hw *imx_dev_clk_hw_gate_shared(struct device *dev,
 				unsigned int *share_count)
 {
 	return clk_hw_register_gate2(NULL, name, parent, CLK_SET_RATE_PARENT |
-					CLK_OPS_PARENT_ENABLE, reg, shift, 0x1, 0,
-					&imx_ccm_lock, share_count);
+					CLK_OPS_PARENT_ENABLE, reg, shift, 0x1,
+					0x1, 0, &imx_ccm_lock, share_count);
 }
 
 static inline struct clk *imx_clk_gate2_cgr(const char *name,
 		const char *parent, void __iomem *reg, u8 shift, u8 cgr_val)
 {
 	return clk_register_gate2(NULL, name, parent, CLK_SET_RATE_PARENT, reg,
-			shift, cgr_val, 0, &imx_ccm_lock, NULL);
+			shift, cgr_val, 0x3, 0, &imx_ccm_lock, NULL);
 }
 
 static inline struct clk_hw *imx_clk_hw_gate3(const char *name, const char *parent,
@@ -418,7 +418,7 @@ static inline struct clk_hw *imx_clk_hw_gate4(const char *name, const char *pare
 {
 	return clk_hw_register_gate2(NULL, name, parent,
 			CLK_SET_RATE_PARENT | CLK_OPS_PARENT_ENABLE,
-			reg, shift, 0x3, 0, &imx_ccm_lock, NULL);
+			reg, shift, 0x3, 0x3, 0, &imx_ccm_lock, NULL);
 }
 
 static inline struct clk_hw *imx_clk_hw_gate4_flags(const char *name,
@@ -427,7 +427,7 @@ static inline struct clk_hw *imx_clk_hw_gate4_flags(const char *name,
 {
 	return clk_hw_register_gate2(NULL, name, parent,
 			flags | CLK_SET_RATE_PARENT | CLK_OPS_PARENT_ENABLE,
-			reg, shift, 0x3, 0, &imx_ccm_lock, NULL);
+			reg, shift, 0x3, 0x3, 0, &imx_ccm_lock, NULL);
 }
 
 #define imx_clk_gate4_flags(name, parent, reg, shift, flags) \
-- 
2.7.4

