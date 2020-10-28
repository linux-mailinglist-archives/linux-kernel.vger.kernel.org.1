Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 516B729D817
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Oct 2020 23:29:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387618AbgJ1W3h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 18:29:37 -0400
Received: from inva020.nxp.com ([92.121.34.13]:41686 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387545AbgJ1W3c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 18:29:32 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id D0D581A15AC;
        Wed, 28 Oct 2020 13:59:35 +0100 (CET)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id C34681A1595;
        Wed, 28 Oct 2020 13:59:35 +0100 (CET)
Received: from fsr-ub1664-175.ea.freescale.net (fsr-ub1664-175.ea.freescale.net [10.171.82.40])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 260272030E;
        Wed, 28 Oct 2020 13:59:35 +0100 (CET)
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
Subject: [PATCH v2 1/5] clk: imx: gate2: Remove the IMX_CLK_GATE2_SINGLE_BIT special case
Date:   Wed, 28 Oct 2020 14:58:58 +0200
Message-Id: <1603889942-27026-2-git-send-email-abel.vesa@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1603889942-27026-1-git-send-email-abel.vesa@nxp.com>
References: <1603889942-27026-1-git-send-email-abel.vesa@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This was a hack which would allow multiple HW gates to be controlled
by a single bit. The only user of this is the imx_dev_clk_hw_gate_shared
which is not used anywhere as of now. Basically, complicates the logic
of the driver for no reason.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
---
 drivers/clk/imx/clk-gate2.c | 28 +++++++---------------------
 drivers/clk/imx/clk.h       |  5 +----
 2 files changed, 8 insertions(+), 25 deletions(-)

diff --git a/drivers/clk/imx/clk-gate2.c b/drivers/clk/imx/clk-gate2.c
index 7eed708..49952ee 100644
--- a/drivers/clk/imx/clk-gate2.c
+++ b/drivers/clk/imx/clk-gate2.c
@@ -49,14 +49,10 @@ static int clk_gate2_enable(struct clk_hw *hw)
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
+	reg = readl(gate->reg);
+	reg &= ~(3 << gate->bit_idx);
+	reg |= gate->cgr_val << gate->bit_idx;
+	writel(reg, gate->reg);
 
 out:
 	spin_unlock_irqrestore(gate->lock, flags);
@@ -79,13 +75,9 @@ static void clk_gate2_disable(struct clk_hw *hw)
 			goto out;
 	}
 
-	if (gate->flags & IMX_CLK_GATE2_SINGLE_BIT) {
-		clk_gate_ops.disable(hw);
-	} else {
-		reg = readl(gate->reg);
-		reg &= ~(3 << gate->bit_idx);
-		writel(reg, gate->reg);
-	}
+	reg = readl(gate->reg);
+	reg &= ~(3 << gate->bit_idx);
+	writel(reg, gate->reg);
 
 out:
 	spin_unlock_irqrestore(gate->lock, flags);
@@ -105,9 +97,6 @@ static int clk_gate2_is_enabled(struct clk_hw *hw)
 {
 	struct clk_gate2 *gate = to_clk_gate2(hw);
 
-	if (gate->flags & IMX_CLK_GATE2_SINGLE_BIT)
-		return clk_gate_ops.is_enabled(hw);
-
 	return clk_gate2_reg_is_enabled(gate->reg, gate->bit_idx);
 }
 
@@ -117,9 +106,6 @@ static void clk_gate2_disable_unused(struct clk_hw *hw)
 	unsigned long flags;
 	u32 reg;
 
-	if (gate->flags & IMX_CLK_GATE2_SINGLE_BIT)
-		return;
-
 	spin_lock_irqsave(gate->lock, flags);
 
 	if (!gate->share_count || *gate->share_count == 0) {
diff --git a/drivers/clk/imx/clk.h b/drivers/clk/imx/clk.h
index 3b796b3..87b2744f 100644
--- a/drivers/clk/imx/clk.h
+++ b/drivers/clk/imx/clk.h
@@ -6,8 +6,6 @@
 #include <linux/spinlock.h>
 #include <linux/clk-provider.h>
 
-#define IMX_CLK_GATE2_SINGLE_BIT	1
-
 extern spinlock_t imx_ccm_lock;
 
 void imx_check_clocks(struct clk *clks[], unsigned int count);
@@ -384,8 +382,7 @@ static inline struct clk_hw *imx_dev_clk_hw_gate_shared(struct device *dev,
 				unsigned int *share_count)
 {
 	return clk_hw_register_gate2(NULL, name, parent, CLK_SET_RATE_PARENT |
-					CLK_OPS_PARENT_ENABLE, reg, shift, 0x3,
-					IMX_CLK_GATE2_SINGLE_BIT,
+					CLK_OPS_PARENT_ENABLE, reg, shift, 0x1, 0,
 					&imx_ccm_lock, share_count);
 }
 
-- 
2.7.4

