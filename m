Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4125E2B9695
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 16:44:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728792AbgKSPoJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 10:44:09 -0500
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:51606 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728544AbgKSPn7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 10:43:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1605800637; x=1637336637;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=ZTgzxZXxs5XWFXM8USHf3KXwg1v3ek3JHGpy46Q/DAU=;
  b=laADPdqvw/ddkf9vvyaIQpOykqPCrbEHop3bem+ITTEs/f/I8tSKk6Xo
   RRi8tDQ/VEbVvqvn8T0KycJ8JRGfuyGGF1NkMx56nOvvdgtvZnFIEMd19
   geUswDUDKzQihDFjE5adNpv0UD/u71u58zwXDh7txieCV+I8XEwCwcNvm
   s4E8v9d366ArUke2YVfV2lnnARNmJYz4waKvhWZXgyxiI2a+Vq8z4lcyt
   ZZUeg14kDBwRfnfiIavSl//pN90S4rBGvhThfx9/rJZhexWFoEgVe4c2B
   07CcjguFj3JA0AwW4e0Apih/Oy+yf1Mn3dPbcmfcdnP42dRL3vGGdWtfX
   A==;
IronPort-SDR: 7c9/tMAe7UeJn37yeZxblFvclxFucnQUNenEK52GTNh26eTXanApGrsd39HguYlGuJrzTjjSTy
 1+8CeCOgAkkxlCf8d+jBBlqHaSO9D45Gukwuxq1UbWxepaqw5dZ+GIQGJkH2g0PwSWquoiokiX
 qBNsQZxCb2V3oTw/KE9bpV8VpEkxawqqWqeB4z7Qb1n4x2cQv3nY0GfT/ttSGvbkzMMkuFkq8h
 qozPexmf1Xsg7OhD5Jq7+3THZZ9Afxh3ZuZaiZMDKDR6jblluMbtnMLD/MrNZ9O887zwbnbh/+
 6FM=
X-IronPort-AV: E=Sophos;i="5.78,490,1599548400"; 
   d="scan'208";a="96942031"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 19 Nov 2020 08:43:57 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 19 Nov 2020 08:43:57 -0700
Received: from m18063-ThinkPad-T460p.microchip.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Thu, 19 Nov 2020 08:43:53 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>, <robh+dt@kernel.org>
CC:     <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v6 06/11] clk: at91: clk-sam9x60-pll: allow runtime changes for pll
Date:   Thu, 19 Nov 2020 17:43:12 +0200
Message-ID: <1605800597-16720-7-git-send-email-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1605800597-16720-1-git-send-email-claudiu.beznea@microchip.com>
References: <1605800597-16720-1-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow runtime frequency changes for PLLs registered with proper flags.
This is necessary for CPU PLL on SAMA7G5 which is used by DVFS.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/clk/at91/clk-sam9x60-pll.c | 145 ++++++++++++++++++++++++++++++++-----
 drivers/clk/at91/pmc.h             |   4 +-
 drivers/clk/at91/sam9x60.c         |  22 +++++-
 drivers/clk/at91/sama7g5.c         |  67 ++++++++++++-----
 4 files changed, 197 insertions(+), 41 deletions(-)

diff --git a/drivers/clk/at91/clk-sam9x60-pll.c b/drivers/clk/at91/clk-sam9x60-pll.c
index 78f458a7b2ef..34e3ab13741a 100644
--- a/drivers/clk/at91/clk-sam9x60-pll.c
+++ b/drivers/clk/at91/clk-sam9x60-pll.c
@@ -229,6 +229,57 @@ static int sam9x60_frac_pll_set_rate(struct clk_hw *hw, unsigned long rate,
 	return sam9x60_frac_pll_compute_mul_frac(core, rate, parent_rate, true);
 }
 
+static int sam9x60_frac_pll_set_rate_chg(struct clk_hw *hw, unsigned long rate,
+					 unsigned long parent_rate)
+{
+	struct sam9x60_pll_core *core = to_sam9x60_pll_core(hw);
+	struct sam9x60_frac *frac = to_sam9x60_frac(core);
+	struct regmap *regmap = core->regmap;
+	unsigned long irqflags;
+	unsigned int val, cfrac, cmul;
+	long ret;
+
+	ret = sam9x60_frac_pll_compute_mul_frac(core, rate, parent_rate, true);
+	if (ret <= 0)
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
+
+	while (!sam9x60_pll_ready(regmap, core->id))
+		cpu_relax();
+
+unlock:
+	spin_unlock_irqrestore(core->lock, irqflags);
+
+	return ret;
+}
+
 static const struct clk_ops sam9x60_frac_pll_ops = {
 	.prepare = sam9x60_frac_pll_prepare,
 	.unprepare = sam9x60_frac_pll_unprepare,
@@ -238,6 +289,15 @@ static const struct clk_ops sam9x60_frac_pll_ops = {
 	.set_rate = sam9x60_frac_pll_set_rate,
 };
 
+static const struct clk_ops sam9x60_frac_pll_ops_chg = {
+	.prepare = sam9x60_frac_pll_prepare,
+	.unprepare = sam9x60_frac_pll_unprepare,
+	.is_prepared = sam9x60_frac_pll_is_prepared,
+	.recalc_rate = sam9x60_frac_pll_recalc_rate,
+	.round_rate = sam9x60_frac_pll_round_rate,
+	.set_rate = sam9x60_frac_pll_set_rate_chg,
+};
+
 static int sam9x60_div_pll_prepare(struct clk_hw *hw)
 {
 	struct sam9x60_pll_core *core = to_sam9x60_pll_core(hw);
@@ -384,6 +444,44 @@ static int sam9x60_div_pll_set_rate(struct clk_hw *hw, unsigned long rate,
 	return 0;
 }
 
+static int sam9x60_div_pll_set_rate_chg(struct clk_hw *hw, unsigned long rate,
+					unsigned long parent_rate)
+{
+	struct sam9x60_pll_core *core = to_sam9x60_pll_core(hw);
+	struct sam9x60_div *div = to_sam9x60_div(core);
+	struct regmap *regmap = core->regmap;
+	unsigned long irqflags;
+	unsigned int val, cdiv;
+
+	div->div = DIV_ROUND_CLOSEST(parent_rate, rate) - 1;
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
+	return 0;
+}
+
 static const struct clk_ops sam9x60_div_pll_ops = {
 	.prepare = sam9x60_div_pll_prepare,
 	.unprepare = sam9x60_div_pll_unprepare,
@@ -393,17 +491,26 @@ static const struct clk_ops sam9x60_div_pll_ops = {
 	.set_rate = sam9x60_div_pll_set_rate,
 };
 
+static const struct clk_ops sam9x60_div_pll_ops_chg = {
+	.prepare = sam9x60_div_pll_prepare,
+	.unprepare = sam9x60_div_pll_unprepare,
+	.is_prepared = sam9x60_div_pll_is_prepared,
+	.recalc_rate = sam9x60_div_pll_recalc_rate,
+	.round_rate = sam9x60_div_pll_round_rate,
+	.set_rate = sam9x60_div_pll_set_rate_chg,
+};
+
 struct clk_hw * __init
 sam9x60_clk_register_frac_pll(struct regmap *regmap, spinlock_t *lock,
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
 
@@ -417,10 +524,12 @@ sam9x60_clk_register_frac_pll(struct regmap *regmap, spinlock_t *lock,
 	init.name = name;
 	init.parent_names = &parent_name;
 	init.num_parents = 1;
-	init.ops = &sam9x60_frac_pll_ops;
-	init.flags = CLK_SET_RATE_GATE;
-	if (critical)
-		init.flags |= CLK_IS_CRITICAL;
+	if (flags & CLK_SET_RATE_GATE)
+		init.ops = &sam9x60_frac_pll_ops;
+	else
+		init.ops = &sam9x60_frac_pll_ops_chg;
+
+	init.flags = flags;
 
 	frac->core.id = id;
 	frac->core.hw.init = &init;
@@ -429,7 +538,7 @@ sam9x60_clk_register_frac_pll(struct regmap *regmap, spinlock_t *lock,
 	frac->core.regmap = regmap;
 	frac->core.lock = lock;
 
-	spin_lock_irqsave(frac->core.lock, flags);
+	spin_lock_irqsave(frac->core.lock, irqflags);
 	if (sam9x60_pll_ready(regmap, id)) {
 		regmap_update_bits(regmap, AT91_PMC_PLL_UPDT,
 				   AT91_PMC_PLL_UPDT_ID_MSK, id);
@@ -457,7 +566,7 @@ sam9x60_clk_register_frac_pll(struct regmap *regmap, spinlock_t *lock,
 			goto free;
 		}
 	}
-	spin_unlock_irqrestore(frac->core.lock, flags);
+	spin_unlock_irqrestore(frac->core.lock, irqflags);
 
 	hw = &frac->core.hw;
 	ret = clk_hw_register(NULL, hw);
@@ -469,7 +578,7 @@ sam9x60_clk_register_frac_pll(struct regmap *regmap, spinlock_t *lock,
 	return hw;
 
 free:
-	spin_unlock_irqrestore(frac->core.lock, flags);
+	spin_unlock_irqrestore(frac->core.lock, irqflags);
 	kfree(frac);
 	return hw;
 }
@@ -478,12 +587,12 @@ struct clk_hw * __init
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
 
@@ -497,11 +606,11 @@ sam9x60_clk_register_div_pll(struct regmap *regmap, spinlock_t *lock,
 	init.name = name;
 	init.parent_names = &parent_name;
 	init.num_parents = 1;
-	init.ops = &sam9x60_div_pll_ops;
-	init.flags = CLK_SET_RATE_GATE | CLK_SET_PARENT_GATE |
-		     CLK_SET_RATE_PARENT;
-	if (critical)
-		init.flags |= CLK_IS_CRITICAL;
+	if (flags & CLK_SET_RATE_GATE)
+		init.ops = &sam9x60_div_pll_ops;
+	else
+		init.ops = &sam9x60_div_pll_ops_chg;
+	init.flags = flags;
 
 	div->core.id = id;
 	div->core.hw.init = &init;
@@ -510,14 +619,14 @@ sam9x60_clk_register_div_pll(struct regmap *regmap, spinlock_t *lock,
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
index 3c4c95603595..dd62bb2880cf 100644
--- a/drivers/clk/at91/sam9x60.c
+++ b/drivers/clk/at91/sam9x60.c
@@ -228,13 +228,24 @@ static void __init sam9x60_pmc_setup(struct device_node *np)
 	hw = sam9x60_clk_register_frac_pll(regmap, &pmc_pll_lock, "pllack_fracck",
 					   "mainck", sam9x60_pmc->chws[PMC_MAIN],
 					   0, &plla_characteristics,
-					   &pll_frac_layout, true);
+					   &pll_frac_layout,
+					   /*
+					    * This feeds pllack_divck which
+					    * feeds CPU. It should not be
+					    * disabled.
+					    */
+					   CLK_IS_CRITICAL | CLK_SET_RATE_GATE);
 	if (IS_ERR(hw))
 		goto err_free;
 
 	hw = sam9x60_clk_register_div_pll(regmap, &pmc_pll_lock, "pllack_divck",
 					  "pllack_fracck", 0, &plla_characteristics,
-					  &pll_div_layout, true);
+					  &pll_div_layout,
+					   /*
+					    * This feeds CPU. It should not
+					    * be disabled.
+					    */
+					  CLK_IS_CRITICAL | CLK_SET_RATE_GATE);
 	if (IS_ERR(hw))
 		goto err_free;
 
@@ -243,13 +254,16 @@ static void __init sam9x60_pmc_setup(struct device_node *np)
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
index d685e22b2014..d7c2b731ad20 100644
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
+	unsigned long f;
 	u8 t;
-	u8 c;
 	u8 eid;
 } sama7g5_plls[][PLL_ID_MAX] = {
 	[PLL_ID_CPU] = {
@@ -111,13 +111,18 @@ static const struct {
 		  .p = "mainck",
 		  .l = &pll_layout_frac,
 		  .t = PLL_TYPE_FRAC,
-		  .c = 1, },
+		   /*
+		    * This feeds cpupll_divpmcck which feeds CPU. It should
+		    * not be disabled.
+		    */
+		  .f = CLK_IS_CRITICAL, },
 
 		{ .n = "cpupll_divpmcck",
 		  .p = "cpupll_fracck",
 		  .l = &pll_layout_divpmc,
 		  .t = PLL_TYPE_DIV,
-		  .c = 1,
+		   /* This feeds CPU. It should not be disabled. */
+		  .f = CLK_IS_CRITICAL | CLK_SET_RATE_PARENT,
 		  .eid = PMC_CPUPLL, },
 	},
 
@@ -126,13 +131,22 @@ static const struct {
 		  .p = "mainck",
 		  .l = &pll_layout_frac,
 		  .t = PLL_TYPE_FRAC,
-		  .c = 1, },
+		   /*
+		    * This feeds syspll_divpmcck which may feed critial parts
+		    * of the systems like timers. Therefore it should not be
+		    * disabled.
+		    */
+		  .f = CLK_IS_CRITICAL | CLK_SET_RATE_GATE, },
 
 		{ .n = "syspll_divpmcck",
 		  .p = "syspll_fracck",
 		  .l = &pll_layout_divpmc,
 		  .t = PLL_TYPE_DIV,
-		  .c = 1,
+		   /*
+		    * This may feed critial parts of the systems like timers.
+		    * Therefore it should not be disabled.
+		    */
+		  .f = CLK_IS_CRITICAL | CLK_SET_RATE_GATE,
 		  .eid = PMC_SYSPLL, },
 	},
 
@@ -141,55 +155,71 @@ static const struct {
 		  .p = "mainck",
 		  .l = &pll_layout_frac,
 		  .t = PLL_TYPE_FRAC,
-		  .c = 1, },
+		   /*
+		    * This feeds ddrpll_divpmcck which feeds DDR. It should not
+		    * be disabled.
+		    */
+		  .f = CLK_IS_CRITICAL | CLK_SET_RATE_GATE, },
 
 		{ .n = "ddrpll_divpmcck",
 		  .p = "ddrpll_fracck",
 		  .l = &pll_layout_divpmc,
 		  .t = PLL_TYPE_DIV,
-		  .c = 1, },
+		   /* This feeds DDR. It should not be disabled. */
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
 
@@ -197,12 +227,15 @@ static const struct {
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
 
@@ -890,7 +923,7 @@ static void __init sama7g5_pmc_setup(struct device_node *np)
 					sama7g5_plls[i][j].p, parent_hw, i,
 					&pll_characteristics,
 					sama7g5_plls[i][j].l,
-					sama7g5_plls[i][j].c);
+					sama7g5_plls[i][j].f);
 				break;
 
 			case PLL_TYPE_DIV:
@@ -899,7 +932,7 @@ static void __init sama7g5_pmc_setup(struct device_node *np)
 					sama7g5_plls[i][j].p, i,
 					&pll_characteristics,
 					sama7g5_plls[i][j].l,
-					sama7g5_plls[i][j].c);
+					sama7g5_plls[i][j].f);
 				break;
 
 			default:
-- 
2.7.4

