Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99A742FE8BB
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 12:28:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727482AbhAUL06 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 06:26:58 -0500
Received: from esa.microchip.iphmx.com ([68.232.154.123]:36685 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730160AbhAULWK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 06:22:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1611228129; x=1642764129;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=Dj943bFWYvDTKdvYb5Gy1NA68TPM2jJcOfig0XFI1RA=;
  b=nrwYBcDrO19D7IEsUibzZOGrhAEC1P1KOSi3G//EG6Gi7gWt+J4Kyeax
   KDN/EGpstN/dMdmm7n2+/wiSihdLA81zuCGI6lqfT4QeUxNo9Z5Q0l1/Y
   N5ull51Zvvh/oIs1g5s1Qiaoy+7bJK4973lGmNDhpouIviS4o3w55Y7zi
   wTdfnhp5jF444ErdzIh7e+aY8UPpwTHyTTkBgoxHS3uC8wamnB8aEvUr3
   VmmjY3er3CLfiY1c2GZSHRnjbN8FbjSAwskV/7ThUfQuuu3GRt047UegF
   wISVytvSiZpDPraOTEKiREpRKjMr8xNowZPNzWSJA42N1kqn36TGiSUB1
   g==;
IronPort-SDR: hzOE5rmNcC4mVWcnXKHPIbVR8pF9D19tQpWFPLjMQCjQvrtmg9E7EuVJeo/Fwc2TuU2H10VqRs
 U7/kgyHhjLcYFtRmR4w12bTXL2bN6mu0YdAtdj+EmVLNOjPMv64pvnU7CjhBBNhEV8LGCnfQGE
 YTVh+QP1bkKmbjM0WhobJR+fL3iuioLL91FzhSQnshJucOIT9pxgGddgiPIDqgmUPdh5wCHuS+
 YmTdJPOtA4JgGMLfoyM47sKne8Jaa5Zo0ScvT1wdRWQlH30zL9i5qCndaBdkPnWqmpw6J6l/+e
 Nb8=
X-IronPort-AV: E=Sophos;i="5.79,363,1602572400"; 
   d="scan'208";a="100892463"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 21 Jan 2021 04:19:50 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 21 Jan 2021 04:19:49 -0700
Received: from m18063-ThinkPad-T460p.microchip.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Thu, 21 Jan 2021 04:19:45 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>
CC:     <viresh.kumar@linaro.org>, <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 5/5] clk: at91: clk-master: update for dvfs
Date:   Thu, 21 Jan 2021 13:19:11 +0200
Message-ID: <1611227951-4590-6-git-send-email-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1611227951-4590-1-git-send-email-claudiu.beznea@microchip.com>
References: <1611227951-4590-1-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SAMA7G5 supports CPU DVFS. The hardware block diagram for the clock
system generating CPU clock is as follows:

                               +--------+
                           +-->|divider1|--> CPU clock
                           |   +--------+
+--------+   +----------+  |   +--------+
|CPU PLL |-->|prescaller|--+-->|divider0|--> MCK0 clock
+--------+   +----------+      +--------+

The divider1 is not implemented in software since the supported CPU
frequencies could be directly retrieved from CPU PLL + prescaller.
Every time the CPU clock needs to be changed the MCK0 should also be
changed to avoid its over/under clocking and also to preserve its
initial value (200MHz). MCK0 feeds IPs that are glitch free aware.

The initial approach for implementing DVFS was to implement MCK0 and
CPU clocks as 2 different Linux clocks, to pass these two clocks to CPUFreq
driver and in CPUFreq driver to run clk_set_rate() on CPU and MCK clocks
accordingly. E.g. if 1GHz speed was requested by CPUFreq subsystem the
following were executed in CPUFreq driver:

/* ... */
clk_set_rate(mck0, intermediary_freq_to_avoid_over_under_clocking);
clk_set_rate(cpu, 1000000000);
clk_set_rate(mck0, initial_freq);
/ ... */

However, it has been proposed in [1] to use the generic cpufreq-dt driver
and to overload the necessary clocks operations in the proper clock
driver.

To address this proposal the master clock prescaller registers a clock
notifier that will update properly the master clock divider on
PRE_RATE_CHANGE and POST_RATE_CHANGE events to avoid master clock
divider over/under clocking and also to preserve its initial value
(200MHz).

[1] https://lore.kernel.org/lkml/1609842147-8161-1-git-send-email-claudiu.beznea@microchip.com/

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/clk/at91/at91rm9200.c  |   2 +-
 drivers/clk/at91/at91sam9260.c |   2 +-
 drivers/clk/at91/at91sam9g45.c |   2 +-
 drivers/clk/at91/at91sam9n12.c |   2 +-
 drivers/clk/at91/at91sam9rl.c  |   2 +-
 drivers/clk/at91/at91sam9x5.c  |   2 +-
 drivers/clk/at91/clk-master.c  | 187 +++++++++++++++++++++++++----------------
 drivers/clk/at91/dt-compat.c   |   2 +-
 drivers/clk/at91/pmc.h         |   3 +-
 drivers/clk/at91/sam9x60.c     |   2 +-
 drivers/clk/at91/sama5d2.c     |   2 +-
 drivers/clk/at91/sama5d3.c     |   2 +-
 drivers/clk/at91/sama5d4.c     |   2 +-
 drivers/clk/at91/sama7g5.c     |   2 +-
 14 files changed, 130 insertions(+), 84 deletions(-)

diff --git a/drivers/clk/at91/at91rm9200.c b/drivers/clk/at91/at91rm9200.c
index 0fad1009f315..749c0b1e9c3d 100644
--- a/drivers/clk/at91/at91rm9200.c
+++ b/drivers/clk/at91/at91rm9200.c
@@ -144,7 +144,7 @@ static void __init at91rm9200_pmc_setup(struct device_node *np)
 					   &at91rm9200_master_layout,
 					   &rm9200_mck_characteristics,
 					   &rm9200_mck_lock, CLK_SET_RATE_GATE,
-					   INT_MIN);
+					   INT_MIN, 0);
 	if (IS_ERR(hw))
 		goto err_free;
 
diff --git a/drivers/clk/at91/at91sam9260.c b/drivers/clk/at91/at91sam9260.c
index ceb5495f723a..c01d9455f6d4 100644
--- a/drivers/clk/at91/at91sam9260.c
+++ b/drivers/clk/at91/at91sam9260.c
@@ -420,7 +420,7 @@ static void __init at91sam926x_pmc_setup(struct device_node *np,
 					   &at91rm9200_master_layout,
 					   data->mck_characteristics,
 					   &at91sam9260_mck_lock,
-					   CLK_SET_RATE_GATE, INT_MIN);
+					   CLK_SET_RATE_GATE, INT_MIN, 0);
 	if (IS_ERR(hw))
 		goto err_free;
 
diff --git a/drivers/clk/at91/at91sam9g45.c b/drivers/clk/at91/at91sam9g45.c
index 0214333dedd3..8364e7a06cfc 100644
--- a/drivers/clk/at91/at91sam9g45.c
+++ b/drivers/clk/at91/at91sam9g45.c
@@ -155,7 +155,7 @@ static void __init at91sam9g45_pmc_setup(struct device_node *np)
 					   &at91rm9200_master_layout,
 					   &mck_characteristics,
 					   &at91sam9g45_mck_lock,
-					   CLK_SET_RATE_GATE, INT_MIN);
+					   CLK_SET_RATE_GATE, INT_MIN, 0);
 	if (IS_ERR(hw))
 		goto err_free;
 
diff --git a/drivers/clk/at91/at91sam9n12.c b/drivers/clk/at91/at91sam9n12.c
index f9db5316a7f1..ddcae243a4ea 100644
--- a/drivers/clk/at91/at91sam9n12.c
+++ b/drivers/clk/at91/at91sam9n12.c
@@ -182,7 +182,7 @@ static void __init at91sam9n12_pmc_setup(struct device_node *np)
 					   &at91sam9x5_master_layout,
 					   &mck_characteristics,
 					   &at91sam9n12_mck_lock,
-					   CLK_SET_RATE_GATE, INT_MIN);
+					   CLK_SET_RATE_GATE, INT_MIN, 0);
 	if (IS_ERR(hw))
 		goto err_free;
 
diff --git a/drivers/clk/at91/at91sam9rl.c b/drivers/clk/at91/at91sam9rl.c
index 66736e03cfef..e87b50aaa9a2 100644
--- a/drivers/clk/at91/at91sam9rl.c
+++ b/drivers/clk/at91/at91sam9rl.c
@@ -124,7 +124,7 @@ static void __init at91sam9rl_pmc_setup(struct device_node *np)
 					   &at91rm9200_master_layout,
 					   &sam9rl_mck_characteristics,
 					   &sam9rl_mck_lock, CLK_SET_RATE_GATE,
-					   INT_MIN);
+					   INT_MIN, 0);
 	if (IS_ERR(hw))
 		goto err_free;
 
diff --git a/drivers/clk/at91/at91sam9x5.c b/drivers/clk/at91/at91sam9x5.c
index 79b9d3667228..4b6819f003be 100644
--- a/drivers/clk/at91/at91sam9x5.c
+++ b/drivers/clk/at91/at91sam9x5.c
@@ -202,7 +202,7 @@ static void __init at91sam9x5_pmc_setup(struct device_node *np,
 					   parent_names,
 					   &at91sam9x5_master_layout,
 					   &mck_characteristics, &mck_lock,
-					   CLK_SET_RATE_GATE, INT_MIN);
+					   CLK_SET_RATE_GATE, INT_MIN, 0);
 	if (IS_ERR(hw))
 		goto err_free;
 
diff --git a/drivers/clk/at91/clk-master.c b/drivers/clk/at91/clk-master.c
index a6a393bb1def..5e78f0416f05 100644
--- a/drivers/clk/at91/clk-master.c
+++ b/drivers/clk/at91/clk-master.c
@@ -5,6 +5,7 @@
 
 #include <linux/clk-provider.h>
 #include <linux/clkdev.h>
+#include <linux/clk.h>
 #include <linux/clk/at91_pmc.h>
 #include <linux/of.h>
 #include <linux/mfd/syscon.h>
@@ -38,6 +39,9 @@ struct clk_master {
 	u8 div;
 };
 
+/* MCK div reference to be used by notifier. */
+static struct clk_master *master_div;
+
 static inline bool clk_master_ready(struct clk_master *master)
 {
 	unsigned int bit = master->id ? AT91_PMC_MCKXRDY : AT91_PMC_MCKRDY;
@@ -153,107 +157,127 @@ static const struct clk_ops master_div_ops = {
 	.restore_context = clk_master_div_restore_context,
 };
 
-static int clk_master_div_set_rate(struct clk_hw *hw, unsigned long rate,
-				   unsigned long parent_rate)
+static int clk_master_div_set(struct clk_master *master,
+			      unsigned long parent_rate, int div)
 {
-	struct clk_master *master = to_clk_master(hw);
 	const struct clk_master_characteristics *characteristics =
 						master->characteristics;
-	unsigned long flags;
-	unsigned int mckr, tmp;
-	int div, i;
+	unsigned long rate = parent_rate;
+	unsigned int max_div = 0, div_index = 0, max_div_index = 0;
+	unsigned int i, mckr, tmp;
 	int ret;
 
-	div = DIV_ROUND_CLOSEST(parent_rate, rate);
-	if (div > ARRAY_SIZE(characteristics->divisors))
-		return -EINVAL;
-
 	for (i = 0; i < ARRAY_SIZE(characteristics->divisors); i++) {
 		if (!characteristics->divisors[i])
 			break;
 
-		if (div == characteristics->divisors[i]) {
-			div = i;
-			break;
+		if (div == characteristics->divisors[i])
+			div_index = i;
+
+		if (max_div < characteristics->divisors[i]) {
+			max_div = characteristics->divisors[i];
+			max_div_index = i;
 		}
 	}
 
-	if (i == ARRAY_SIZE(characteristics->divisors))
-		return -EINVAL;
+	if (div > max_div)
+		div_index = max_div_index;
 
-	spin_lock_irqsave(master->lock, flags);
 	ret = regmap_read(master->regmap, master->layout->offset, &mckr);
 	if (ret)
-		goto unlock;
+		return ret;
 
 	tmp = mckr & master->layout->mask;
 	tmp = (tmp >> MASTER_DIV_SHIFT) & MASTER_DIV_MASK;
-	if (tmp == div)
-		goto unlock;
+	if (tmp == div_index)
+		return 0;
+
+	rate /= characteristics->divisors[div_index];
+	if (rate < characteristics->output.min)
+		pr_warn("master clk div is underclocked");
+	else if (rate > characteristics->output.max)
+		pr_warn("master clk div is overclocked");
 
 	mckr &= ~(MASTER_DIV_MASK << MASTER_DIV_SHIFT);
-	mckr |= (div << MASTER_DIV_SHIFT);
+	mckr |= (div_index << MASTER_DIV_SHIFT);
 	ret = regmap_write(master->regmap, master->layout->offset, mckr);
 	if (ret)
-		goto unlock;
+		return ret;
 
 	while (!clk_master_ready(master))
 		cpu_relax();
-unlock:
-	spin_unlock_irqrestore(master->lock, flags);
+
+	master->div = characteristics->divisors[div_index];
 
 	return 0;
 }
 
-static int clk_master_div_determine_rate(struct clk_hw *hw,
-					 struct clk_rate_request *req)
+static int at91_clk_master_div_notifier(struct notifier_block *notifier,
+					unsigned long code, void *data)
 {
-	struct clk_master *master = to_clk_master(hw);
 	const struct clk_master_characteristics *characteristics =
-						master->characteristics;
-	struct clk_hw *parent;
-	unsigned long parent_rate, tmp_rate, best_rate = 0;
-	int i, best_diff = INT_MIN, tmp_diff;
-
-	parent = clk_hw_get_parent(hw);
-	if (!parent)
-		return -EINVAL;
-
-	parent_rate = clk_hw_get_rate(parent);
-	if (!parent_rate)
-		return -EINVAL;
-
-	for (i = 0; i < ARRAY_SIZE(characteristics->divisors); i++) {
-		if (!characteristics->divisors[i])
-			break;
-
-		tmp_rate = DIV_ROUND_CLOSEST_ULL(parent_rate,
-						 characteristics->divisors[i]);
-		tmp_diff = abs(tmp_rate - req->rate);
+						master_div->characteristics;
+	struct clk_notifier_data *cnd = data;
+	unsigned long cur_rate, flags;
+	unsigned int mckr, cur_div, diff_div;
+	static unsigned int new_div;
+
+	/*
+	 * Need to increase/decrease div to avoid master div clock over/under
+	 * clocking
+	 */
+	spin_lock_irqsave(master_div->lock, flags);
+	switch (code) {
+	case PRE_RATE_CHANGE:
+		regmap_read(master_div->regmap, master_div->layout->offset,
+			    &mckr);
+		mckr &= master_div->layout->mask;
+		mckr = (mckr >> MASTER_DIV_SHIFT) & MASTER_DIV_MASK;
+
+		cur_div = characteristics->divisors[mckr];
+		cur_rate = DIV_ROUND_CLOSEST_ULL(cnd->old_rate, cur_div);
+		new_div = DIV_ROUND_CLOSEST(cnd->new_rate, cur_rate);
+		diff_div = abs(cur_div - new_div);
+
+		clk_master_div_set(master_div, cnd->old_rate,
+				   cur_div + diff_div);
+		break;
+
+	case POST_RATE_CHANGE:
+		clk_master_div_set(master_div, cnd->new_rate, new_div);
+		break;
+
+	default:
+		break;
+	}
+	spin_unlock_irqrestore(master_div->lock, flags);
 
-		if (!best_rate || best_diff > tmp_diff) {
-			best_diff = tmp_diff;
-			best_rate = tmp_rate;
-		}
+	return 0;
+}
 
-		if (!best_diff)
-			break;
-	}
+static struct notifier_block clk_master_notifier = {
+	.notifier_call = at91_clk_master_div_notifier,
+};
 
-	req->best_parent_rate = best_rate;
-	req->best_parent_hw = parent;
-	req->rate = best_rate;
+static unsigned long clk_master_div_recalc_rate_chg(struct clk_hw *hw,
+						    unsigned long parent_rate)
+{
+	struct clk_master *master = to_clk_master(hw);
 
-	return 0;
+	return DIV_ROUND_CLOSEST_ULL(parent_rate, master->div);
 }
 
 static void clk_master_div_restore_context_chg(struct clk_hw *hw)
 {
 	struct clk_master *master = to_clk_master(hw);
+	unsigned long flags;
 	int ret;
 
-	ret = clk_master_div_set_rate(hw, master->pms.rate,
-				      master->pms.parent_rate);
+	spin_lock_irqsave(master->lock, flags);
+	ret = clk_master_div_set(master, master->pms.parent_rate,
+				 DIV_ROUND_CLOSEST(master->pms.parent_rate,
+						   master->pms.rate));
+	spin_unlock_irqrestore(master->lock, flags);
 	if (ret)
 		pr_warn("Failed to restore MCK DIV clock\n");
 }
@@ -261,9 +285,7 @@ static void clk_master_div_restore_context_chg(struct clk_hw *hw)
 static const struct clk_ops master_div_ops_chg = {
 	.prepare = clk_master_prepare,
 	.is_prepared = clk_master_is_prepared,
-	.recalc_rate = clk_master_div_recalc_rate,
-	.determine_rate = clk_master_div_determine_rate,
-	.set_rate = clk_master_div_set_rate,
+	.recalc_rate = clk_master_div_recalc_rate_chg,
 	.save_context = clk_master_div_save_context,
 	.restore_context = clk_master_div_restore_context_chg,
 };
@@ -488,6 +510,8 @@ at91_clk_register_master_internal(struct regmap *regmap,
 	struct clk_master *master;
 	struct clk_init_data init;
 	struct clk_hw *hw;
+	unsigned int mckr;
+	unsigned long irqflags;
 	int ret;
 
 	if (!name || !num_parents || !parent_names || !lock)
@@ -510,6 +534,16 @@ at91_clk_register_master_internal(struct regmap *regmap,
 	master->chg_pid = chg_pid;
 	master->lock = lock;
 
+	if (ops == &master_div_ops_chg) {
+		spin_lock_irqsave(master->lock, irqflags);
+		regmap_read(master->regmap, master->layout->offset, &mckr);
+		spin_unlock_irqrestore(master->lock, irqflags);
+
+		mckr &= layout->mask;
+		mckr = (mckr >> MASTER_DIV_SHIFT) & MASTER_DIV_MASK;
+		master->div = characteristics->divisors[mckr];
+	}
+
 	hw = &master->hw;
 	ret = clk_hw_register(NULL, &master->hw);
 	if (ret) {
@@ -526,19 +560,24 @@ at91_clk_register_master_pres(struct regmap *regmap,
 		const char **parent_names,
 		const struct clk_master_layout *layout,
 		const struct clk_master_characteristics *characteristics,
-		spinlock_t *lock, u32 flags, int chg_pid)
+		spinlock_t *lock, u32 flags, int chg_pid, bool notifier)
 {
 	const struct clk_ops *ops;
+	struct clk_hw *hw;
 
 	if (flags & CLK_SET_RATE_GATE)
 		ops = &master_pres_ops;
 	else
 		ops = &master_pres_ops_chg;
 
-	return at91_clk_register_master_internal(regmap, name, num_parents,
-						 parent_names, layout,
-						 characteristics, ops,
-						 lock, flags, chg_pid);
+	hw = at91_clk_register_master_internal(regmap, name, num_parents,
+					       parent_names, layout,
+					       characteristics, ops,
+					       lock, flags, chg_pid);
+	if (!IS_ERR(hw) && notifier)
+		clk_notifier_register(hw->clk, &clk_master_notifier);
+
+	return hw;
 }
 
 struct clk_hw * __init
@@ -549,16 +588,22 @@ at91_clk_register_master_div(struct regmap *regmap,
 		spinlock_t *lock, u32 flags)
 {
 	const struct clk_ops *ops;
+	struct clk_hw *hw;
 
 	if (flags & CLK_SET_RATE_GATE)
 		ops = &master_div_ops;
 	else
 		ops = &master_div_ops_chg;
 
-	return at91_clk_register_master_internal(regmap, name, 1,
-						 &parent_name, layout,
-						 characteristics, ops,
-						 lock, flags, -EINVAL);
+	hw = at91_clk_register_master_internal(regmap, name, 1,
+					       &parent_name, layout,
+					       characteristics, ops,
+					       lock, flags, -EINVAL);
+
+	if (!IS_ERR(hw))
+		master_div = to_clk_master(hw);
+
+	return hw;
 }
 
 static unsigned long
diff --git a/drivers/clk/at91/dt-compat.c b/drivers/clk/at91/dt-compat.c
index a97b99c2dc12..99ad43ea6169 100644
--- a/drivers/clk/at91/dt-compat.c
+++ b/drivers/clk/at91/dt-compat.c
@@ -393,7 +393,7 @@ of_at91_clk_master_setup(struct device_node *np,
 	hw = at91_clk_register_master_pres(regmap, "masterck_pres", num_parents,
 					   parent_names, layout,
 					   characteristics, &mck_lock,
-					   CLK_SET_RATE_GATE, INT_MIN);
+					   CLK_SET_RATE_GATE, INT_MIN, 0);
 	if (IS_ERR(hw))
 		goto out_free_characteristics;
 
diff --git a/drivers/clk/at91/pmc.h b/drivers/clk/at91/pmc.h
index 86580ebd9ad9..2263f4df3a82 100644
--- a/drivers/clk/at91/pmc.h
+++ b/drivers/clk/at91/pmc.h
@@ -175,7 +175,8 @@ at91_clk_register_master_pres(struct regmap *regmap, const char *name,
 			      int num_parents, const char **parent_names,
 			      const struct clk_master_layout *layout,
 			      const struct clk_master_characteristics *characteristics,
-			      spinlock_t *lock, u32 flags, int chg_pid);
+			      spinlock_t *lock, u32 flags, int chg_pid,
+			      bool notifier);
 
 struct clk_hw * __init
 at91_clk_register_master_div(struct regmap *regmap, const char *name,
diff --git a/drivers/clk/at91/sam9x60.c b/drivers/clk/at91/sam9x60.c
index 5f6fa89571b7..8e1b89e05724 100644
--- a/drivers/clk/at91/sam9x60.c
+++ b/drivers/clk/at91/sam9x60.c
@@ -272,7 +272,7 @@ static void __init sam9x60_pmc_setup(struct device_node *np)
 	hw = at91_clk_register_master_pres(regmap, "masterck_pres", 3,
 					   parent_names, &sam9x60_master_layout,
 					   &mck_characteristics, &mck_lock,
-					   CLK_SET_RATE_GATE, INT_MIN);
+					   CLK_SET_RATE_GATE, INT_MIN, 0);
 	if (IS_ERR(hw))
 		goto err_free;
 
diff --git a/drivers/clk/at91/sama5d2.c b/drivers/clk/at91/sama5d2.c
index 9a5cbc7cd55a..406d4b33562e 100644
--- a/drivers/clk/at91/sama5d2.c
+++ b/drivers/clk/at91/sama5d2.c
@@ -241,7 +241,7 @@ static void __init sama5d2_pmc_setup(struct device_node *np)
 					   parent_names,
 					   &at91sam9x5_master_layout,
 					   &mck_characteristics, &mck_lock,
-					   CLK_SET_RATE_GATE, INT_MIN);
+					   CLK_SET_RATE_GATE, INT_MIN, 0);
 	if (IS_ERR(hw))
 		goto err_free;
 
diff --git a/drivers/clk/at91/sama5d3.c b/drivers/clk/at91/sama5d3.c
index 87009ee8effc..164a080c53fa 100644
--- a/drivers/clk/at91/sama5d3.c
+++ b/drivers/clk/at91/sama5d3.c
@@ -176,7 +176,7 @@ static void __init sama5d3_pmc_setup(struct device_node *np)
 					   parent_names,
 					   &at91sam9x5_master_layout,
 					   &mck_characteristics, &mck_lock,
-					   CLK_SET_RATE_GATE, INT_MIN);
+					   CLK_SET_RATE_GATE, INT_MIN, 0);
 	if (IS_ERR(hw))
 		goto err_free;
 
diff --git a/drivers/clk/at91/sama5d4.c b/drivers/clk/at91/sama5d4.c
index 57fff790188b..9253aa2e6039 100644
--- a/drivers/clk/at91/sama5d4.c
+++ b/drivers/clk/at91/sama5d4.c
@@ -191,7 +191,7 @@ static void __init sama5d4_pmc_setup(struct device_node *np)
 					   parent_names,
 					   &at91sam9x5_master_layout,
 					   &mck_characteristics, &mck_lock,
-					   CLK_SET_RATE_GATE, INT_MIN);
+					   CLK_SET_RATE_GATE, INT_MIN, 0);
 	if (IS_ERR(hw))
 		goto err_free;
 
diff --git a/drivers/clk/at91/sama7g5.c b/drivers/clk/at91/sama7g5.c
index 28e26fb90417..3bb630ac0f53 100644
--- a/drivers/clk/at91/sama7g5.c
+++ b/drivers/clk/at91/sama7g5.c
@@ -986,7 +986,7 @@ static void __init sama7g5_pmc_setup(struct device_node *np)
 	hw = at91_clk_register_master_pres(regmap, "cpuck", 1, parent_names,
 					   &mck0_layout, &mck0_characteristics,
 					   &pmc_mck0_lock,
-					   CLK_SET_RATE_PARENT, 0);
+					   CLK_SET_RATE_PARENT, 0, 1);
 	if (IS_ERR(hw))
 		goto err_free;
 
-- 
2.7.4

