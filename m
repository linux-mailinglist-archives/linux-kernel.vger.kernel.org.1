Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A94F2FCE1A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 11:51:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732161AbhATKRi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 05:17:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731465AbhATJeE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 04:34:04 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C8CCC061387
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 01:31:08 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id 7so15118083wrz.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 01:31:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=30zhW0o3snNlsU80MAuQCHF/yyUQuJN98MT9hG2uNLE=;
        b=GDnVmsL1Y/UF6IyBi1RZRwAiaruRNo916+Ywds3s+t3914DBSKdDUoK0fwtHd3ln7m
         CpJSPAQhcBa6O65j3BdZypOX7xMhsifEBZLp9wybgh8+22mhg3iIrmXLNDU50QAcna4P
         dwuf9Gf/NF5Kfw2zbo6yBO14UF1pNbu6rUDxBgAOcWnGBVj3uCtGhcN+1+MNf4SZmFYy
         rZgoPlssFmR1AWjdJAfHeZIz3CfNAlfIO5repl6TCiE+RjwYntlYcMx2hVHvirqR4fKi
         gqLgPHOZGjNaG76L1kumYAgPiBYTlDwVOS2aTfqDYzYMBQOs+R6bm1WOpktDBZxTBv3q
         Fr3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=30zhW0o3snNlsU80MAuQCHF/yyUQuJN98MT9hG2uNLE=;
        b=F6mYIsY72SQ6knHoxJSwepFmG5NRrDUDDg6LISZ6Wijzc02yMx8ov73XS+N1RYLTfx
         R67loahYFxIrlD9QL8jv/8C4On3iY1DWnp2ZIjAWEw/x8qLpJJWsyEOxpdiP73IYmb3S
         CEcUh6txBRnzFy8Q0IDJynteAtQ+SaRtRjdcY6+FFgUkhwLNCEatd3y6RSDdX5m3IstG
         LlECOLTNNvzWSQ0EV32yXihKqd2NIBQCIdVUU4LZpEH83T0OrjMaZALcU/W+bXqYxAAk
         vHRfa3Pe/SkQEvwgfIYsLF22ZhIasnWtZOPzvtXl//JV++tMUwgEGIOyxWo1QIzHbxyQ
         llLw==
X-Gm-Message-State: AOAM533o7vNTQN1Xz9BYx+4YqohXBCsGXpDiEEsiAZJgoCRQS6VEx6Uq
        dJWKL8KBtQz1u8rGSt0JGJd6DQ==
X-Google-Smtp-Source: ABdhPJxEUayvz2eG5bIKF5fnpCWN+R+WuJ/i+WEMiP79FcBTYCv2kmHFklBGQ14t2rl3txn6CfCi7w==
X-Received: by 2002:adf:a3c1:: with SMTP id m1mr8264522wrb.357.1611135067352;
        Wed, 20 Jan 2021 01:31:07 -0800 (PST)
Received: from dell.default ([91.110.221.158])
        by smtp.gmail.com with ESMTPSA id z130sm2889201wmb.33.2021.01.20.01.31.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jan 2021 01:31:06 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        =?UTF-8?q?S=C3=B6ren=20Brinkmann?= <soren.brinkmann@xilinx.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 20/20] clk: zynq: clkc: Remove various instances of an unused variable 'clk'
Date:   Wed, 20 Jan 2021 09:30:40 +0000
Message-Id: <20210120093040.1719407-21-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210120093040.1719407-1-lee.jones@linaro.org>
References: <20210120093040.1719407-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/clk/zynq/clkc.c: In function ‘zynq_clk_register_fclk’:
 drivers/clk/zynq/clkc.c:106:14: warning: variable ‘clk’ set but not used [-Wunused-but-set-variable]
 drivers/clk/zynq/clkc.c: In function ‘zynq_clk_register_periph_clk’:
 drivers/clk/zynq/clkc.c:179:14: warning: variable ‘clk’ set but not used [-Wunused-but-set-variable]
 drivers/clk/zynq/clkc.c: In function ‘zynq_clk_setup’:
 drivers/clk/zynq/clkc.c:220:14: warning: variable ‘clk’ set but not used [-Wunused-but-set-variable]

Cc: Michael Turquette <mturquette@baylibre.com>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: Michal Simek <michal.simek@xilinx.com>
Cc: "Sören Brinkmann" <soren.brinkmann@xilinx.com>
Cc: linux-clk@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/clk/zynq/clkc.c | 73 ++++++++++++++++++++---------------------
 1 file changed, 35 insertions(+), 38 deletions(-)

diff --git a/drivers/clk/zynq/clkc.c b/drivers/clk/zynq/clkc.c
index ffbb9008c1c99..204b83d911b90 100644
--- a/drivers/clk/zynq/clkc.c
+++ b/drivers/clk/zynq/clkc.c
@@ -103,7 +103,6 @@ static void __init zynq_clk_register_fclk(enum zynq_clk fclk,
 		const char *clk_name, void __iomem *fclk_ctrl_reg,
 		const char **parents, int enable)
 {
-	struct clk *clk;
 	u32 enable_reg;
 	char *mux_name;
 	char *div0_name;
@@ -131,15 +130,15 @@ static void __init zynq_clk_register_fclk(enum zynq_clk fclk,
 	if (!div1_name)
 		goto err_div1_name;
 
-	clk = clk_register_mux(NULL, mux_name, parents, 4,
+	clk_register_mux(NULL, mux_name, parents, 4,
 			CLK_SET_RATE_NO_REPARENT, fclk_ctrl_reg, 4, 2, 0,
 			fclk_lock);
 
-	clk = clk_register_divider(NULL, div0_name, mux_name,
+	clk_register_divider(NULL, div0_name, mux_name,
 			0, fclk_ctrl_reg, 8, 6, CLK_DIVIDER_ONE_BASED |
 			CLK_DIVIDER_ALLOW_ZERO, fclk_lock);
 
-	clk = clk_register_divider(NULL, div1_name, div0_name,
+	clk_register_divider(NULL, div1_name, div0_name,
 			CLK_SET_RATE_PARENT, fclk_ctrl_reg, 20, 6,
 			CLK_DIVIDER_ONE_BASED | CLK_DIVIDER_ALLOW_ZERO,
 			fclk_lock);
@@ -176,7 +175,6 @@ static void __init zynq_clk_register_periph_clk(enum zynq_clk clk0,
 		const char *clk_name1, void __iomem *clk_ctrl,
 		const char **parents, unsigned int two_gates)
 {
-	struct clk *clk;
 	char *mux_name;
 	char *div_name;
 	spinlock_t *lock;
@@ -189,10 +187,10 @@ static void __init zynq_clk_register_periph_clk(enum zynq_clk clk0,
 	mux_name = kasprintf(GFP_KERNEL, "%s_mux", clk_name0);
 	div_name = kasprintf(GFP_KERNEL, "%s_div", clk_name0);
 
-	clk = clk_register_mux(NULL, mux_name, parents, 4,
+	clk_register_mux(NULL, mux_name, parents, 4,
 			CLK_SET_RATE_NO_REPARENT, clk_ctrl, 4, 2, 0, lock);
 
-	clk = clk_register_divider(NULL, div_name, mux_name, 0, clk_ctrl, 8, 6,
+	clk_register_divider(NULL, div_name, mux_name, 0, clk_ctrl, 8, 6,
 			CLK_DIVIDER_ONE_BASED | CLK_DIVIDER_ALLOW_ZERO, lock);
 
 	clks[clk0] = clk_register_gate(NULL, clk_name0, div_name,
@@ -217,7 +215,6 @@ static void __init zynq_clk_setup(struct device_node *np)
 	int i;
 	u32 tmp;
 	int ret;
-	struct clk *clk;
 	char *clk_name;
 	unsigned int fclk_enable = 0;
 	const char *clk_output_name[clk_max];
@@ -257,19 +254,19 @@ static void __init zynq_clk_setup(struct device_node *np)
 	ps_clk = clk_register_fixed_rate(NULL, "ps_clk", NULL, 0, tmp);
 
 	/* PLLs */
-	clk = clk_register_zynq_pll("armpll_int", "ps_clk", SLCR_ARMPLL_CTRL,
+	clk_register_zynq_pll("armpll_int", "ps_clk", SLCR_ARMPLL_CTRL,
 			SLCR_PLL_STATUS, 0, &armpll_lock);
 	clks[armpll] = clk_register_mux(NULL, clk_output_name[armpll],
 			armpll_parents, 2, CLK_SET_RATE_NO_REPARENT,
 			SLCR_ARMPLL_CTRL, 4, 1, 0, &armpll_lock);
 
-	clk = clk_register_zynq_pll("ddrpll_int", "ps_clk", SLCR_DDRPLL_CTRL,
+	clk_register_zynq_pll("ddrpll_int", "ps_clk", SLCR_DDRPLL_CTRL,
 			SLCR_PLL_STATUS, 1, &ddrpll_lock);
 	clks[ddrpll] = clk_register_mux(NULL, clk_output_name[ddrpll],
 			ddrpll_parents, 2, CLK_SET_RATE_NO_REPARENT,
 			SLCR_DDRPLL_CTRL, 4, 1, 0, &ddrpll_lock);
 
-	clk = clk_register_zynq_pll("iopll_int", "ps_clk", SLCR_IOPLL_CTRL,
+	clk_register_zynq_pll("iopll_int", "ps_clk", SLCR_IOPLL_CTRL,
 			SLCR_PLL_STATUS, 2, &iopll_lock);
 	clks[iopll] = clk_register_mux(NULL, clk_output_name[iopll],
 			iopll_parents, 2, CLK_SET_RATE_NO_REPARENT,
@@ -277,10 +274,10 @@ static void __init zynq_clk_setup(struct device_node *np)
 
 	/* CPU clocks */
 	tmp = readl(SLCR_621_TRUE) & 1;
-	clk = clk_register_mux(NULL, "cpu_mux", cpu_parents, 4,
+	clk_register_mux(NULL, "cpu_mux", cpu_parents, 4,
 			CLK_SET_RATE_NO_REPARENT, SLCR_ARM_CLK_CTRL, 4, 2, 0,
 			&armclk_lock);
-	clk = clk_register_divider(NULL, "cpu_div", "cpu_mux", 0,
+	clk_register_divider(NULL, "cpu_div", "cpu_mux", 0,
 			SLCR_ARM_CLK_CTRL, 8, 6, CLK_DIVIDER_ONE_BASED |
 			CLK_DIVIDER_ALLOW_ZERO, &armclk_lock);
 
@@ -288,20 +285,20 @@ static void __init zynq_clk_setup(struct device_node *np)
 			"cpu_div", CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
 			SLCR_ARM_CLK_CTRL, 24, 0, &armclk_lock);
 
-	clk = clk_register_fixed_factor(NULL, "cpu_3or2x_div", "cpu_div", 0,
+	clk_register_fixed_factor(NULL, "cpu_3or2x_div", "cpu_div", 0,
 			1, 2);
 	clks[cpu_3or2x] = clk_register_gate(NULL, clk_output_name[cpu_3or2x],
 			"cpu_3or2x_div", CLK_IGNORE_UNUSED,
 			SLCR_ARM_CLK_CTRL, 25, 0, &armclk_lock);
 
-	clk = clk_register_fixed_factor(NULL, "cpu_2x_div", "cpu_div", 0, 1,
+	clk_register_fixed_factor(NULL, "cpu_2x_div", "cpu_div", 0, 1,
 			2 + tmp);
 	clks[cpu_2x] = clk_register_gate(NULL, clk_output_name[cpu_2x],
 			"cpu_2x_div", CLK_IGNORE_UNUSED, SLCR_ARM_CLK_CTRL,
 			26, 0, &armclk_lock);
 	clk_prepare_enable(clks[cpu_2x]);
 
-	clk = clk_register_fixed_factor(NULL, "cpu_1x_div", "cpu_div", 0, 1,
+	clk_register_fixed_factor(NULL, "cpu_1x_div", "cpu_div", 0, 1,
 			4 + 2 * tmp);
 	clks[cpu_1x] = clk_register_gate(NULL, clk_output_name[cpu_1x],
 			"cpu_1x_div", CLK_IGNORE_UNUSED, SLCR_ARM_CLK_CTRL, 27,
@@ -324,23 +321,23 @@ static void __init zynq_clk_setup(struct device_node *np)
 			&swdtclk_lock);
 
 	/* DDR clocks */
-	clk = clk_register_divider(NULL, "ddr2x_div", "ddrpll", 0,
+	clk_register_divider(NULL, "ddr2x_div", "ddrpll", 0,
 			SLCR_DDR_CLK_CTRL, 26, 6, CLK_DIVIDER_ONE_BASED |
 			CLK_DIVIDER_ALLOW_ZERO, &ddrclk_lock);
 	clks[ddr2x] = clk_register_gate(NULL, clk_output_name[ddr2x],
 			"ddr2x_div", 0, SLCR_DDR_CLK_CTRL, 1, 0, &ddrclk_lock);
 	clk_prepare_enable(clks[ddr2x]);
-	clk = clk_register_divider(NULL, "ddr3x_div", "ddrpll", 0,
+	clk_register_divider(NULL, "ddr3x_div", "ddrpll", 0,
 			SLCR_DDR_CLK_CTRL, 20, 6, CLK_DIVIDER_ONE_BASED |
 			CLK_DIVIDER_ALLOW_ZERO, &ddrclk_lock);
 	clks[ddr3x] = clk_register_gate(NULL, clk_output_name[ddr3x],
 			"ddr3x_div", 0, SLCR_DDR_CLK_CTRL, 0, 0, &ddrclk_lock);
 	clk_prepare_enable(clks[ddr3x]);
 
-	clk = clk_register_divider(NULL, "dci_div0", "ddrpll", 0,
+	clk_register_divider(NULL, "dci_div0", "ddrpll", 0,
 			SLCR_DCI_CLK_CTRL, 8, 6, CLK_DIVIDER_ONE_BASED |
 			CLK_DIVIDER_ALLOW_ZERO, &dciclk_lock);
-	clk = clk_register_divider(NULL, "dci_div1", "dci_div0",
+	clk_register_divider(NULL, "dci_div1", "dci_div0",
 			CLK_SET_RATE_PARENT, SLCR_DCI_CLK_CTRL, 20, 6,
 			CLK_DIVIDER_ONE_BASED | CLK_DIVIDER_ALLOW_ZERO,
 			&dciclk_lock);
@@ -385,17 +382,17 @@ static void __init zynq_clk_setup(struct device_node *np)
 			gem0_mux_parents[i + 1] = of_clk_get_parent_name(np,
 					idx);
 	}
-	clk = clk_register_mux(NULL, "gem0_mux", periph_parents, 4,
+	clk_register_mux(NULL, "gem0_mux", periph_parents, 4,
 			CLK_SET_RATE_NO_REPARENT, SLCR_GEM0_CLK_CTRL, 4, 2, 0,
 			&gem0clk_lock);
-	clk = clk_register_divider(NULL, "gem0_div0", "gem0_mux", 0,
+	clk_register_divider(NULL, "gem0_div0", "gem0_mux", 0,
 			SLCR_GEM0_CLK_CTRL, 8, 6, CLK_DIVIDER_ONE_BASED |
 			CLK_DIVIDER_ALLOW_ZERO, &gem0clk_lock);
-	clk = clk_register_divider(NULL, "gem0_div1", "gem0_div0",
+	clk_register_divider(NULL, "gem0_div1", "gem0_div0",
 			CLK_SET_RATE_PARENT, SLCR_GEM0_CLK_CTRL, 20, 6,
 			CLK_DIVIDER_ONE_BASED | CLK_DIVIDER_ALLOW_ZERO,
 			&gem0clk_lock);
-	clk = clk_register_mux(NULL, "gem0_emio_mux", gem0_mux_parents, 2,
+	clk_register_mux(NULL, "gem0_emio_mux", gem0_mux_parents, 2,
 			CLK_SET_RATE_PARENT | CLK_SET_RATE_NO_REPARENT,
 			SLCR_GEM0_CLK_CTRL, 6, 1, 0,
 			&gem0clk_lock);
@@ -410,17 +407,17 @@ static void __init zynq_clk_setup(struct device_node *np)
 			gem1_mux_parents[i + 1] = of_clk_get_parent_name(np,
 					idx);
 	}
-	clk = clk_register_mux(NULL, "gem1_mux", periph_parents, 4,
+	clk_register_mux(NULL, "gem1_mux", periph_parents, 4,
 			CLK_SET_RATE_NO_REPARENT, SLCR_GEM1_CLK_CTRL, 4, 2, 0,
 			&gem1clk_lock);
-	clk = clk_register_divider(NULL, "gem1_div0", "gem1_mux", 0,
+	clk_register_divider(NULL, "gem1_div0", "gem1_mux", 0,
 			SLCR_GEM1_CLK_CTRL, 8, 6, CLK_DIVIDER_ONE_BASED |
 			CLK_DIVIDER_ALLOW_ZERO, &gem1clk_lock);
-	clk = clk_register_divider(NULL, "gem1_div1", "gem1_div0",
+	clk_register_divider(NULL, "gem1_div1", "gem1_div0",
 			CLK_SET_RATE_PARENT, SLCR_GEM1_CLK_CTRL, 20, 6,
 			CLK_DIVIDER_ONE_BASED | CLK_DIVIDER_ALLOW_ZERO,
 			&gem1clk_lock);
-	clk = clk_register_mux(NULL, "gem1_emio_mux", gem1_mux_parents, 2,
+	clk_register_mux(NULL, "gem1_emio_mux", gem1_mux_parents, 2,
 			CLK_SET_RATE_PARENT | CLK_SET_RATE_NO_REPARENT,
 			SLCR_GEM1_CLK_CTRL, 6, 1, 0,
 			&gem1clk_lock);
@@ -442,27 +439,27 @@ static void __init zynq_clk_setup(struct device_node *np)
 			can_mio_mux_parents[i] = dummy_nm;
 	}
 	kfree(clk_name);
-	clk = clk_register_mux(NULL, "can_mux", periph_parents, 4,
+	clk_register_mux(NULL, "can_mux", periph_parents, 4,
 			CLK_SET_RATE_NO_REPARENT, SLCR_CAN_CLK_CTRL, 4, 2, 0,
 			&canclk_lock);
-	clk = clk_register_divider(NULL, "can_div0", "can_mux", 0,
+	clk_register_divider(NULL, "can_div0", "can_mux", 0,
 			SLCR_CAN_CLK_CTRL, 8, 6, CLK_DIVIDER_ONE_BASED |
 			CLK_DIVIDER_ALLOW_ZERO, &canclk_lock);
-	clk = clk_register_divider(NULL, "can_div1", "can_div0",
+	clk_register_divider(NULL, "can_div1", "can_div0",
 			CLK_SET_RATE_PARENT, SLCR_CAN_CLK_CTRL, 20, 6,
 			CLK_DIVIDER_ONE_BASED | CLK_DIVIDER_ALLOW_ZERO,
 			&canclk_lock);
-	clk = clk_register_gate(NULL, "can0_gate", "can_div1",
+	clk_register_gate(NULL, "can0_gate", "can_div1",
 			CLK_SET_RATE_PARENT, SLCR_CAN_CLK_CTRL, 0, 0,
 			&canclk_lock);
-	clk = clk_register_gate(NULL, "can1_gate", "can_div1",
+	clk_register_gate(NULL, "can1_gate", "can_div1",
 			CLK_SET_RATE_PARENT, SLCR_CAN_CLK_CTRL, 1, 0,
 			&canclk_lock);
-	clk = clk_register_mux(NULL, "can0_mio_mux",
+	clk_register_mux(NULL, "can0_mio_mux",
 			can_mio_mux_parents, 54, CLK_SET_RATE_PARENT |
 			CLK_SET_RATE_NO_REPARENT, SLCR_CAN_MIOCLK_CTRL, 0, 6, 0,
 			&canmioclk_lock);
-	clk = clk_register_mux(NULL, "can1_mio_mux",
+	clk_register_mux(NULL, "can1_mio_mux",
 			can_mio_mux_parents, 54, CLK_SET_RATE_PARENT |
 			CLK_SET_RATE_NO_REPARENT, SLCR_CAN_MIOCLK_CTRL, 16, 6,
 			0, &canmioclk_lock);
@@ -482,13 +479,13 @@ static void __init zynq_clk_setup(struct device_node *np)
 			dbg_emio_mux_parents[i + 1] = of_clk_get_parent_name(np,
 					idx);
 	}
-	clk = clk_register_mux(NULL, "dbg_mux", periph_parents, 4,
+	clk_register_mux(NULL, "dbg_mux", periph_parents, 4,
 			CLK_SET_RATE_NO_REPARENT, SLCR_DBG_CLK_CTRL, 4, 2, 0,
 			&dbgclk_lock);
-	clk = clk_register_divider(NULL, "dbg_div", "dbg_mux", 0,
+	clk_register_divider(NULL, "dbg_div", "dbg_mux", 0,
 			SLCR_DBG_CLK_CTRL, 8, 6, CLK_DIVIDER_ONE_BASED |
 			CLK_DIVIDER_ALLOW_ZERO, &dbgclk_lock);
-	clk = clk_register_mux(NULL, "dbg_emio_mux", dbg_emio_mux_parents, 2,
+	clk_register_mux(NULL, "dbg_emio_mux", dbg_emio_mux_parents, 2,
 			CLK_SET_RATE_NO_REPARENT, SLCR_DBG_CLK_CTRL, 6, 1, 0,
 			&dbgclk_lock);
 	clks[dbg_trc] = clk_register_gate(NULL, clk_output_name[dbg_trc],
-- 
2.25.1

