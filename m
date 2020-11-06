Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E5512A9327
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 10:47:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726654AbgKFJrN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 04:47:13 -0500
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:41920 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726423AbgKFJrL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 04:47:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1604656031; x=1636192031;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=en16SVLAKrczUT/KRFuaGjEExoJsYxU+UhGvhOduIqk=;
  b=IIfudtwFcvbh81jHZ6KObLNRGV0j9HreSMS3GQtuFQlAzPuhJIA8YpND
   KsrbfMJlD2K7GnL8Cmzy1/3vPPqX8qodqUUXabYZa4RO4s60Fk5FwDw46
   eficZGyfSPhTNHgya3yCM7NerH8/5yMOq+gIeZcCrxjxMHhOWBZ9V9rWc
   HrNZidtWEKshB5Qlq0Ud+oQ2979Z0xhXy2sVpC/Ynufeyl/bYeQcIEu4Q
   veTyt3QtOhrejmKaLs7fUT71cwqUUTeXAbIPg33j+5MA1xJItWo2PQb72
   FvgHL1XPgQwHW/elet+Xh+JWM/9h6/Vsz3cFRfotlIKze0thtXoWqHzpT
   w==;
IronPort-SDR: uViAHAPj6VJPa45FFlqM/tQ6/z4CcsTLHXFxPhHn9e7KdQMpTXsTUC8N9vUag5u50KaY5xBG8d
 FkueF3Vo8HhdRgu369BdI/s64JEl5WXeUG0lLrmIW0HfMNrgpbGU8TXT586DeCaiLwj4NBCb6D
 cB7Ta5HEkIG70DQAQdK2iVu9rz1cwuyiqGqXpYT7MCyTpfacLtlzKlZf8eX0E30ZymGzONDbb4
 ZBZM0BoT0wXa4M6RY5n7syKmS9ZNQqCU0PkSn4t81tftAw5HaYN1Pc7jtJGxotNcN7rgTISSaM
 lK4=
X-IronPort-AV: E=Sophos;i="5.77,456,1596524400"; 
   d="scan'208";a="97428399"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 06 Nov 2020 02:47:11 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 6 Nov 2020 02:47:10 -0700
Received: from m18063-ThinkPad-T460p.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Fri, 6 Nov 2020 02:47:04 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>, <robh+dt@kernel.org>
CC:     <eugen.hristev@microchip.com>, <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v4 06/11] clk: at91: clk-sam9x60-pll: allow runtime changes for pll
Date:   Fri, 6 Nov 2020 11:46:23 +0200
Message-ID: <1604655988-353-7-git-send-email-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1604655988-353-1-git-send-email-claudiu.beznea@microchip.com>
References: <1604655988-353-1-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow runtime frequency changes for PLLs registered with proper flags.
This is necessary for CPU PLL on SAMA7G5 which is used by DVFS.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/clk/at91/clk-sam9x60-pll.c | 102 ++++++++++++++++++++++++++++++-------
 drivers/clk/at91/pmc.h             |   4 +-
 drivers/clk/at91/sam9x60.c         |  13 +++--
 drivers/clk/at91/sama7g5.c         |  48 ++++++++++-------
 4 files changed, 127 insertions(+), 40 deletions(-)

diff --git a/drivers/clk/at91/clk-sam9x60-pll.c b/drivers/clk/at91/clk-sam9x60-pll.c
index 78f458a7b2ef..6fe5d8530a0c 100644
--- a/drivers/clk/at91/clk-sam9x60-pll.c
+++ b/drivers/clk/at91/clk-sam9x60-pll.c
@@ -225,8 +225,51 @@ static int sam9x60_frac_pll_set_rate(struct clk_hw *hw, unsigned long rate,
 				     unsigned long parent_rate)
 {
 	struct sam9x60_pll_core *core = to_sam9x60_pll_core(hw);
+	struct sam9x60_frac *frac = to_sam9x60_frac(core);
+	struct regmap *regmap = core->regmap;
+	unsigned long irqflags, clkflags = clk_hw_get_flags(hw);
+	unsigned int val, cfrac, cmul;
+	long ret;
+
+	ret = sam9x60_frac_pll_compute_mul_frac(core, rate, parent_rate, true);
+	if (ret <= 0 || (clkflags & CLK_SET_RATE_GATE))
+		return ret;
+
+	spin_lock_irqsave(core->lock, irqflags);
+
+	regmap_update_bits(regmap, AT91_PMC_PLL_UPDT, AT91_PMC_PLL_UPDT_ID_MSK,
+			   core->id);
+	regmap_read(regmap, AT91_PMC_PLL_CTRL1, &val);
+	cmul = (val & core->layout->mul_mask) >> core->layout->mul_shift;
+	cfrac = (val & core->layout->frac_mask) >> core->layout->frac_shift;
+
+	if (cmul == frac->mul && cfrac == frac->frac)
+		goto unlock;
+
+	regmap_write(regmap, AT91_PMC_PLL_CTRL1,
+		     (frac->mul << core->layout->mul_shift) |
+		     (frac->frac << core->layout->frac_shift));
+
+	regmap_update_bits(regmap, AT91_PMC_PLL_UPDT,
+			   AT91_PMC_PLL_UPDT_UPDATE | AT91_PMC_PLL_UPDT_ID_MSK,
+			   AT91_PMC_PLL_UPDT_UPDATE | core->id);
+
+	regmap_update_bits(regmap, AT91_PMC_PLL_CTRL0,
+			   AT91_PMC_PLL_CTRL0_ENLOCK | AT91_PMC_PLL_CTRL0_ENPLL,
+			   AT91_PMC_PLL_CTRL0_ENLOCK |
+			   AT91_PMC_PLL_CTRL0_ENPLL);
+
+	regmap_update_bits(regmap, AT91_PMC_PLL_UPDT,
+			   AT91_PMC_PLL_UPDT_UPDATE | AT91_PMC_PLL_UPDT_ID_MSK,
+			   AT91_PMC_PLL_UPDT_UPDATE | core->id);
 
-	return sam9x60_frac_pll_compute_mul_frac(core, rate, parent_rate, true);
+	while (!sam9x60_pll_ready(regmap, core->id))
+		cpu_relax();
+
+unlock:
+	spin_unlock_irqrestore(core->lock, irqflags);
+
+	return ret;
 }
 
 static const struct clk_ops sam9x60_frac_pll_ops = {
@@ -378,9 +421,39 @@ static int sam9x60_div_pll_set_rate(struct clk_hw *hw, unsigned long rate,
 {
 	struct sam9x60_pll_core *core = to_sam9x60_pll_core(hw);
 	struct sam9x60_div *div = to_sam9x60_div(core);
+	struct regmap *regmap = core->regmap;
+	unsigned long irqflags, clkflags = clk_hw_get_flags(hw);
+	unsigned int val, cdiv;
 
 	div->div = DIV_ROUND_CLOSEST(parent_rate, rate) - 1;
 
+	if (clkflags & CLK_SET_RATE_GATE)
+		return 0;
+
+	spin_lock_irqsave(core->lock, irqflags);
+	regmap_update_bits(regmap, AT91_PMC_PLL_UPDT, AT91_PMC_PLL_UPDT_ID_MSK,
+			   core->id);
+	regmap_read(regmap, AT91_PMC_PLL_CTRL0, &val);
+	cdiv = (val & core->layout->div_mask) >> core->layout->div_shift;
+
+	/* Stop if nothing changed. */
+	if (cdiv == div->div)
+		goto unlock;
+
+	regmap_update_bits(regmap, AT91_PMC_PLL_CTRL0,
+			   core->layout->div_mask,
+			   (div->div << core->layout->div_shift));
+
+	regmap_update_bits(regmap, AT91_PMC_PLL_UPDT,
+			   AT91_PMC_PLL_UPDT_UPDATE | AT91_PMC_PLL_UPDT_ID_MSK,
+			   AT91_PMC_PLL_UPDT_UPDATE | core->id);
+
+	while (!sam9x60_pll_ready(regmap, core->id))
+		cpu_relax();
+
+unlock:
+	spin_unlock_irqrestore(core->lock, irqflags);
+
 	return 0;
 }
 
@@ -398,12 +471,12 @@ sam9x60_clk_register_frac_pll(struct regmap *regmap, spinlock_t *lock,
 			      const char *name, const char *parent_name,
 			      struct clk_hw *parent_hw, u8 id,
 			      const struct clk_pll_characteristics *characteristics,
-			      const struct clk_pll_layout *layout, bool critical)
+			      const struct clk_pll_layout *layout, u32 flags)
 {
 	struct sam9x60_frac *frac;
 	struct clk_hw *hw;
 	struct clk_init_data init;
-	unsigned long parent_rate, flags;
+	unsigned long parent_rate, irqflags;
 	unsigned int val;
 	int ret;
 
@@ -418,9 +491,7 @@ sam9x60_clk_register_frac_pll(struct regmap *regmap, spinlock_t *lock,
 	init.parent_names = &parent_name;
 	init.num_parents = 1;
 	init.ops = &sam9x60_frac_pll_ops;
-	init.flags = CLK_SET_RATE_GATE;
-	if (critical)
-		init.flags |= CLK_IS_CRITICAL;
+	init.flags = flags;
 
 	frac->core.id = id;
 	frac->core.hw.init = &init;
@@ -429,7 +500,7 @@ sam9x60_clk_register_frac_pll(struct regmap *regmap, spinlock_t *lock,
 	frac->core.regmap = regmap;
 	frac->core.lock = lock;
 
-	spin_lock_irqsave(frac->core.lock, flags);
+	spin_lock_irqsave(frac->core.lock, irqflags);
 	if (sam9x60_pll_ready(regmap, id)) {
 		regmap_update_bits(regmap, AT91_PMC_PLL_UPDT,
 				   AT91_PMC_PLL_UPDT_ID_MSK, id);
@@ -457,7 +528,7 @@ sam9x60_clk_register_frac_pll(struct regmap *regmap, spinlock_t *lock,
 			goto free;
 		}
 	}
-	spin_unlock_irqrestore(frac->core.lock, flags);
+	spin_unlock_irqrestore(frac->core.lock, irqflags);
 
 	hw = &frac->core.hw;
 	ret = clk_hw_register(NULL, hw);
@@ -469,7 +540,7 @@ sam9x60_clk_register_frac_pll(struct regmap *regmap, spinlock_t *lock,
 	return hw;
 
 free:
-	spin_unlock_irqrestore(frac->core.lock, flags);
+	spin_unlock_irqrestore(frac->core.lock, irqflags);
 	kfree(frac);
 	return hw;
 }
@@ -478,12 +549,12 @@ struct clk_hw * __init
 sam9x60_clk_register_div_pll(struct regmap *regmap, spinlock_t *lock,
 			     const char *name, const char *parent_name, u8 id,
 			     const struct clk_pll_characteristics *characteristics,
-			     const struct clk_pll_layout *layout, bool critical)
+			     const struct clk_pll_layout *layout, u32 flags)
 {
 	struct sam9x60_div *div;
 	struct clk_hw *hw;
 	struct clk_init_data init;
-	unsigned long flags;
+	unsigned long irqflags;
 	unsigned int val;
 	int ret;
 
@@ -498,10 +569,7 @@ sam9x60_clk_register_div_pll(struct regmap *regmap, spinlock_t *lock,
 	init.parent_names = &parent_name;
 	init.num_parents = 1;
 	init.ops = &sam9x60_div_pll_ops;
-	init.flags = CLK_SET_RATE_GATE | CLK_SET_PARENT_GATE |
-		     CLK_SET_RATE_PARENT;
-	if (critical)
-		init.flags |= CLK_IS_CRITICAL;
+	init.flags = flags;
 
 	div->core.id = id;
 	div->core.hw.init = &init;
@@ -510,14 +578,14 @@ sam9x60_clk_register_div_pll(struct regmap *regmap, spinlock_t *lock,
 	div->core.regmap = regmap;
 	div->core.lock = lock;
 
-	spin_lock_irqsave(div->core.lock, flags);
+	spin_lock_irqsave(div->core.lock, irqflags);
 
 	regmap_update_bits(regmap, AT91_PMC_PLL_UPDT,
 			   AT91_PMC_PLL_UPDT_ID_MSK, id);
 	regmap_read(regmap, AT91_PMC_PLL_CTRL0, &val);
 	div->div = FIELD_GET(PMC_PLL_CTRL0_DIV_MSK, val);
 
-	spin_unlock_irqrestore(div->core.lock, flags);
+	spin_unlock_irqrestore(div->core.lock, irqflags);
 
 	hw = &div->core.hw;
 	ret = clk_hw_register(NULL, hw);
diff --git a/drivers/clk/at91/pmc.h b/drivers/clk/at91/pmc.h
index 0a9364bde339..bedcd85ad750 100644
--- a/drivers/clk/at91/pmc.h
+++ b/drivers/clk/at91/pmc.h
@@ -190,14 +190,14 @@ struct clk_hw * __init
 sam9x60_clk_register_div_pll(struct regmap *regmap, spinlock_t *lock,
 			     const char *name, const char *parent_name, u8 id,
 			     const struct clk_pll_characteristics *characteristics,
-			     const struct clk_pll_layout *layout, bool critical);
+			     const struct clk_pll_layout *layout, u32 flags);
 
 struct clk_hw * __init
 sam9x60_clk_register_frac_pll(struct regmap *regmap, spinlock_t *lock,
 			      const char *name, const char *parent_name,
 			      struct clk_hw *parent_hw, u8 id,
 			      const struct clk_pll_characteristics *characteristics,
-			      const struct clk_pll_layout *layout, bool critical);
+			      const struct clk_pll_layout *layout, u32 flags);
 
 struct clk_hw * __init
 at91_clk_register_programmable(struct regmap *regmap, const char *name,
diff --git a/drivers/clk/at91/sam9x60.c b/drivers/clk/at91/sam9x60.c
index 3c4c95603595..e5094c69e606 100644
--- a/drivers/clk/at91/sam9x60.c
+++ b/drivers/clk/at91/sam9x60.c
@@ -228,13 +228,15 @@ static void __init sam9x60_pmc_setup(struct device_node *np)
 	hw = sam9x60_clk_register_frac_pll(regmap, &pmc_pll_lock, "pllack_fracck",
 					   "mainck", sam9x60_pmc->chws[PMC_MAIN],
 					   0, &plla_characteristics,
-					   &pll_frac_layout, true);
+					   &pll_frac_layout,
+					   CLK_IS_CRITICAL | CLK_SET_RATE_GATE);
 	if (IS_ERR(hw))
 		goto err_free;
 
 	hw = sam9x60_clk_register_div_pll(regmap, &pmc_pll_lock, "pllack_divck",
 					  "pllack_fracck", 0, &plla_characteristics,
-					  &pll_div_layout, true);
+					  &pll_div_layout,
+					  CLK_IS_CRITICAL | CLK_SET_RATE_GATE);
 	if (IS_ERR(hw))
 		goto err_free;
 
@@ -243,13 +245,16 @@ static void __init sam9x60_pmc_setup(struct device_node *np)
 	hw = sam9x60_clk_register_frac_pll(regmap, &pmc_pll_lock, "upllck_fracck",
 					   "main_osc", main_osc_hw, 1,
 					   &upll_characteristics,
-					   &pll_frac_layout, false);
+					   &pll_frac_layout, CLK_SET_RATE_GATE);
 	if (IS_ERR(hw))
 		goto err_free;
 
 	hw = sam9x60_clk_register_div_pll(regmap, &pmc_pll_lock, "upllck_divck",
 					  "upllck_fracck", 1, &upll_characteristics,
-					  &pll_div_layout, false);
+					  &pll_div_layout,
+					  CLK_SET_RATE_GATE |
+					  CLK_SET_PARENT_GATE |
+					  CLK_SET_RATE_PARENT);
 	if (IS_ERR(hw))
 		goto err_free;
 
diff --git a/drivers/clk/at91/sama7g5.c b/drivers/clk/at91/sama7g5.c
index d685e22b2014..33faf7c6d9fb 100644
--- a/drivers/clk/at91/sama7g5.c
+++ b/drivers/clk/at91/sama7g5.c
@@ -95,15 +95,15 @@ static const struct clk_pll_layout pll_layout_divio = {
  * @p:		clock parent
  * @l:		clock layout
  * @t:		clock type
- * @f:		true if clock is critical and cannot be disabled
+ * @f:		clock flags
  * @eid:	export index in sama7g5->chws[] array
  */
 static const struct {
 	const char *n;
 	const char *p;
 	const struct clk_pll_layout *l;
+	u32 f;
 	u8 t;
-	u8 c;
 	u8 eid;
 } sama7g5_plls[][PLL_ID_MAX] = {
 	[PLL_ID_CPU] = {
@@ -111,13 +111,13 @@ static const struct {
 		  .p = "mainck",
 		  .l = &pll_layout_frac,
 		  .t = PLL_TYPE_FRAC,
-		  .c = 1, },
+		  .f = CLK_IS_CRITICAL, },
 
 		{ .n = "cpupll_divpmcck",
 		  .p = "cpupll_fracck",
 		  .l = &pll_layout_divpmc,
 		  .t = PLL_TYPE_DIV,
-		  .c = 1,
+		  .f = CLK_IS_CRITICAL | CLK_SET_RATE_PARENT,
 		  .eid = PMC_CPUPLL, },
 	},
 
@@ -126,13 +126,13 @@ static const struct {
 		  .p = "mainck",
 		  .l = &pll_layout_frac,
 		  .t = PLL_TYPE_FRAC,
-		  .c = 1, },
+		  .f = CLK_IS_CRITICAL | CLK_SET_RATE_GATE, },
 
 		{ .n = "syspll_divpmcck",
 		  .p = "syspll_fracck",
 		  .l = &pll_layout_divpmc,
 		  .t = PLL_TYPE_DIV,
-		  .c = 1,
+		  .f = CLK_IS_CRITICAL | CLK_SET_RATE_GATE,
 		  .eid = PMC_SYSPLL, },
 	},
 
@@ -141,55 +141,66 @@ static const struct {
 		  .p = "mainck",
 		  .l = &pll_layout_frac,
 		  .t = PLL_TYPE_FRAC,
-		  .c = 1, },
+		  .f = CLK_IS_CRITICAL | CLK_SET_RATE_GATE, },
 
 		{ .n = "ddrpll_divpmcck",
 		  .p = "ddrpll_fracck",
 		  .l = &pll_layout_divpmc,
 		  .t = PLL_TYPE_DIV,
-		  .c = 1, },
+		  .f = CLK_IS_CRITICAL | CLK_SET_RATE_GATE, },
 	},
 
 	[PLL_ID_IMG] = {
 		{ .n = "imgpll_fracck",
 		  .p = "mainck",
 		  .l = &pll_layout_frac,
-		  .t = PLL_TYPE_FRAC, },
+		  .t = PLL_TYPE_FRAC,
+		  .f = CLK_SET_RATE_GATE, },
 
 		{ .n = "imgpll_divpmcck",
 		  .p = "imgpll_fracck",
 		  .l = &pll_layout_divpmc,
-		  .t = PLL_TYPE_DIV, },
+		  .t = PLL_TYPE_DIV,
+		  .f = CLK_SET_RATE_GATE | CLK_SET_PARENT_GATE |
+		       CLK_SET_RATE_PARENT, },
 	},
 
 	[PLL_ID_BAUD] = {
 		{ .n = "baudpll_fracck",
 		  .p = "mainck",
 		  .l = &pll_layout_frac,
-		  .t = PLL_TYPE_FRAC, },
+		  .t = PLL_TYPE_FRAC,
+		  .f = CLK_SET_RATE_GATE, },
 
 		{ .n = "baudpll_divpmcck",
 		  .p = "baudpll_fracck",
 		  .l = &pll_layout_divpmc,
-		  .t = PLL_TYPE_DIV, },
+		  .t = PLL_TYPE_DIV,
+		  .f = CLK_SET_RATE_GATE | CLK_SET_PARENT_GATE |
+		       CLK_SET_RATE_PARENT, },
 	},
 
 	[PLL_ID_AUDIO] = {
 		{ .n = "audiopll_fracck",
 		  .p = "main_xtal",
 		  .l = &pll_layout_frac,
-		  .t = PLL_TYPE_FRAC, },
+		  .t = PLL_TYPE_FRAC,
+		  .f = CLK_SET_RATE_GATE, },
 
 		{ .n = "audiopll_divpmcck",
 		  .p = "audiopll_fracck",
 		  .l = &pll_layout_divpmc,
 		  .t = PLL_TYPE_DIV,
+		  .f = CLK_SET_RATE_GATE | CLK_SET_PARENT_GATE |
+		       CLK_SET_RATE_PARENT,
 		  .eid = PMC_AUDIOPMCPLL, },
 
 		{ .n = "audiopll_diviock",
 		  .p = "audiopll_fracck",
 		  .l = &pll_layout_divio,
 		  .t = PLL_TYPE_DIV,
+		  .f = CLK_SET_RATE_GATE | CLK_SET_PARENT_GATE |
+		       CLK_SET_RATE_PARENT,
 		  .eid = PMC_AUDIOIOPLL, },
 	},
 
@@ -197,12 +208,15 @@ static const struct {
 		{ .n = "ethpll_fracck",
 		  .p = "main_xtal",
 		  .l = &pll_layout_frac,
-		  .t = PLL_TYPE_FRAC, },
+		  .t = PLL_TYPE_FRAC,
+		  .f = CLK_SET_RATE_GATE, },
 
 		{ .n = "ethpll_divpmcck",
 		  .p = "ethpll_fracck",
 		  .l = &pll_layout_divpmc,
-		  .t = PLL_TYPE_DIV, },
+		  .t = PLL_TYPE_DIV,
+		  .f = CLK_SET_RATE_GATE | CLK_SET_PARENT_GATE |
+		       CLK_SET_RATE_PARENT, },
 	},
 };
 
@@ -890,7 +904,7 @@ static void __init sama7g5_pmc_setup(struct device_node *np)
 					sama7g5_plls[i][j].p, parent_hw, i,
 					&pll_characteristics,
 					sama7g5_plls[i][j].l,
-					sama7g5_plls[i][j].c);
+					sama7g5_plls[i][j].f);
 				break;
 
 			case PLL_TYPE_DIV:
@@ -899,7 +913,7 @@ static void __init sama7g5_pmc_setup(struct device_node *np)
 					sama7g5_plls[i][j].p, i,
 					&pll_characteristics,
 					sama7g5_plls[i][j].l,
-					sama7g5_plls[i][j].c);
+					sama7g5_plls[i][j].f);
 				break;
 
 			default:
-- 
2.7.4

