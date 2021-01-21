Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D405A2FE97C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 13:00:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730849AbhAUL61 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 06:58:27 -0500
Received: from esa.microchip.iphmx.com ([68.232.153.233]:32933 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728846AbhAULUt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 06:20:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1611228049; x=1642764049;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=flG5MMrq5cQvWlQMS/pGE7Z+MV49hWAUBa4dmmIzsdQ=;
  b=AVZX23oVCO+1RIY9WtFJWLdeT6WFUZcR9InM4jZyFJHBbRHRnbqwkmDT
   h9D353VHcXeFUfKQcctUuJqvnLbMu9vtYF1gGStUY2n4AwCcNNtz5OIsG
   NLxtfUpGkY2MKxPqxKMDRTL20/xQHMOtb16YNpxsGL7QLKY/Xv3z8uHjp
   ZRYS/j3c9UajIRf8Upia42cxgtIHssQ30I2N5H8OQ9AnRZ9IsUnBLPsT5
   FI7u3BtBCzmExJlTsj+Me04pV9VXQ6rWIlqvn+9pjlBH6qb0ln2/gsACy
   0pDMY9yhsJVc8nO4AUw7hCDWzNkDdr9MnTlUrMKZOHlury2bpkm+TWNFx
   Q==;
IronPort-SDR: 6UL++JOEtVod+6Yka+nXZCFYF0SVMbhuagM0lOhu3ivqVkNXIiU8HD6MSbwTmGD+7pU9bGyo2G
 B1se4BCINVJCAh4SBLQfvo0o3eyD9k2TrLtabcrnf2N3gz+E453Z5afH5KKrJIt7Gb1J1FJ26j
 TGMiHn6SymuepO6v6RmGEWlzJQs8rx/fjvZ5bOMHH9ELSYAP8r4CQPHlenynvuLAoO3fr4mv+R
 vQIVkxKoo52ea9dE7gd0ceS/TPzxSzi6mA5E1uHrVEKhSFgYXhmjERTU/VGisWLBsSBlqh/825
 EnI=
X-IronPort-AV: E=Sophos;i="5.79,363,1602572400"; 
   d="scan'208";a="106240959"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 21 Jan 2021 04:19:32 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 21 Jan 2021 04:19:31 -0700
Received: from m18063-ThinkPad-T460p.microchip.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Thu, 21 Jan 2021 04:19:26 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>
CC:     <viresh.kumar@linaro.org>, <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 1/5] clk: at91: re-factor clocks suspend/resume
Date:   Thu, 21 Jan 2021 13:19:07 +0200
Message-ID: <1611227951-4590-2-git-send-email-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1611227951-4590-1-git-send-email-claudiu.beznea@microchip.com>
References: <1611227951-4590-1-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SAMA5D2 and SAMA7G5 have a special power saving mode (backup mode) where
most of the SoC's components are powered off (including PMC). Resuming
from this mode is done with the help of bootloader. Peripherals are not
aware of the power saving mode thus most of them are disabling clocks in
proper suspend API and re-enable them in resume API without taking into
account the previously setup rate. Moreover some of the peripherals are
acting as wakeup sources and are not disabling the clocks in this
scenario, when suspending. Since backup mode cuts the power for
peripherals, in resume part these clocks needs to be re-configured.

The initial PMC suspend/resume code was designed with SAMA5D2's PMC
in mind. SAMA7G's PMC is different (few new functionalities, different
registers offsets, different offsets in registers for each
functionalities). To address both SAMA5D2 and SAMA7G5 PMC add
.save_context()/.resume_context() support to each clocks driver and call
this from PMC driver.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/clk/at91/clk-generated.c    |  45 +++++++--
 drivers/clk/at91/clk-main.c         |  66 +++++++++++++
 drivers/clk/at91/clk-master.c       | 183 ++++++++++++++++++++++++++++++++++--
 drivers/clk/at91/clk-peripheral.c   |  38 +++++++-
 drivers/clk/at91/clk-pll.c          |  37 ++++++++
 drivers/clk/at91/clk-programmable.c |  29 +++++-
 drivers/clk/at91/clk-sam9x60-pll.c  |  68 +++++++++++++-
 drivers/clk/at91/clk-system.c       |  20 ++++
 drivers/clk/at91/clk-usb.c          |  27 ++++++
 drivers/clk/at91/clk-utmi.c         |  47 ++++++++-
 drivers/clk/at91/pmc.c              | 149 ++---------------------------
 drivers/clk/at91/pmc.h              |  24 +++--
 12 files changed, 554 insertions(+), 179 deletions(-)

diff --git a/drivers/clk/at91/clk-generated.c b/drivers/clk/at91/clk-generated.c
index b4fc8d71daf2..0e436f9e7508 100644
--- a/drivers/clk/at91/clk-generated.c
+++ b/drivers/clk/at91/clk-generated.c
@@ -27,6 +27,7 @@ struct clk_generated {
 	u32 id;
 	u32 gckdiv;
 	const struct clk_pcr_layout *layout;
+	struct at91_clk_pms pms;
 	u8 parent_id;
 	int chg_pid;
 };
@@ -34,25 +35,34 @@ struct clk_generated {
 #define to_clk_generated(hw) \
 	container_of(hw, struct clk_generated, hw)
 
-static int clk_generated_enable(struct clk_hw *hw)
+static int clk_generated_set(struct clk_generated *gck, int status)
 {
-	struct clk_generated *gck = to_clk_generated(hw);
 	unsigned long flags;
 
-	pr_debug("GCLK: %s, gckdiv = %d, parent id = %d\n",
-		 __func__, gck->gckdiv, gck->parent_id);
-
 	spin_lock_irqsave(gck->lock, flags);
 	regmap_write(gck->regmap, gck->layout->offset,
 		     (gck->id & gck->layout->pid_mask));
 	regmap_update_bits(gck->regmap, gck->layout->offset,
 			   AT91_PMC_PCR_GCKDIV_MASK | gck->layout->gckcss_mask |
-			   gck->layout->cmd | AT91_PMC_PCR_GCKEN,
+			   gck->layout->cmd | (status ? AT91_PMC_PCR_GCKEN : 0),
 			   field_prep(gck->layout->gckcss_mask, gck->parent_id) |
 			   gck->layout->cmd |
 			   FIELD_PREP(AT91_PMC_PCR_GCKDIV_MASK, gck->gckdiv) |
-			   AT91_PMC_PCR_GCKEN);
+			   (status ? AT91_PMC_PCR_GCKEN : 0));
 	spin_unlock_irqrestore(gck->lock, flags);
+
+	return 0;
+}
+
+static int clk_generated_enable(struct clk_hw *hw)
+{
+	struct clk_generated *gck = to_clk_generated(hw);
+
+	pr_debug("GCLK: %s, gckdiv = %d, parent id = %d\n",
+		 __func__, gck->gckdiv, gck->parent_id);
+
+	clk_generated_set(gck, 1);
+
 	return 0;
 }
 
@@ -239,6 +249,23 @@ static int clk_generated_set_rate(struct clk_hw *hw,
 	return 0;
 }
 
+static int clk_generated_save_context(struct clk_hw *hw)
+{
+	struct clk_generated *gck = to_clk_generated(hw);
+
+	gck->pms.status = clk_generated_is_enabled(&gck->hw);
+
+	return 0;
+}
+
+static void clk_generated_restore_context(struct clk_hw *hw)
+{
+	struct clk_generated *gck = to_clk_generated(hw);
+
+	if (gck->pms.status)
+		clk_generated_set(gck, gck->pms.status);
+}
+
 static const struct clk_ops generated_ops = {
 	.enable = clk_generated_enable,
 	.disable = clk_generated_disable,
@@ -248,6 +275,8 @@ static const struct clk_ops generated_ops = {
 	.get_parent = clk_generated_get_parent,
 	.set_parent = clk_generated_set_parent,
 	.set_rate = clk_generated_set_rate,
+	.save_context = clk_generated_save_context,
+	.restore_context = clk_generated_restore_context,
 };
 
 /**
@@ -314,8 +343,6 @@ at91_clk_register_generated(struct regmap *regmap, spinlock_t *lock,
 	if (ret) {
 		kfree(gck);
 		hw = ERR_PTR(ret);
-	} else {
-		pmc_register_id(id);
 	}
 
 	return hw;
diff --git a/drivers/clk/at91/clk-main.c b/drivers/clk/at91/clk-main.c
index cfae2f59df66..8601b27c1ae0 100644
--- a/drivers/clk/at91/clk-main.c
+++ b/drivers/clk/at91/clk-main.c
@@ -28,6 +28,7 @@
 struct clk_main_osc {
 	struct clk_hw hw;
 	struct regmap *regmap;
+	struct at91_clk_pms pms;
 };
 
 #define to_clk_main_osc(hw) container_of(hw, struct clk_main_osc, hw)
@@ -37,6 +38,7 @@ struct clk_main_rc_osc {
 	struct regmap *regmap;
 	unsigned long frequency;
 	unsigned long accuracy;
+	struct at91_clk_pms pms;
 };
 
 #define to_clk_main_rc_osc(hw) container_of(hw, struct clk_main_rc_osc, hw)
@@ -51,6 +53,7 @@ struct clk_rm9200_main {
 struct clk_sam9x5_main {
 	struct clk_hw hw;
 	struct regmap *regmap;
+	struct at91_clk_pms pms;
 	u8 parent;
 };
 
@@ -120,10 +123,29 @@ static int clk_main_osc_is_prepared(struct clk_hw *hw)
 	return (status & AT91_PMC_MOSCS) && clk_main_parent_select(tmp);
 }
 
+static int clk_main_osc_save_context(struct clk_hw *hw)
+{
+	struct clk_main_osc *osc = to_clk_main_osc(hw);
+
+	osc->pms.status = clk_main_osc_is_prepared(hw);
+
+	return 0;
+}
+
+static void clk_main_osc_restore_context(struct clk_hw *hw)
+{
+	struct clk_main_osc *osc = to_clk_main_osc(hw);
+
+	if (osc->pms.status)
+		clk_main_osc_prepare(hw);
+}
+
 static const struct clk_ops main_osc_ops = {
 	.prepare = clk_main_osc_prepare,
 	.unprepare = clk_main_osc_unprepare,
 	.is_prepared = clk_main_osc_is_prepared,
+	.save_context = clk_main_osc_save_context,
+	.restore_context = clk_main_osc_restore_context,
 };
 
 struct clk_hw * __init
@@ -240,12 +262,31 @@ static unsigned long clk_main_rc_osc_recalc_accuracy(struct clk_hw *hw,
 	return osc->accuracy;
 }
 
+static int clk_main_rc_osc_save_context(struct clk_hw *hw)
+{
+	struct clk_main_rc_osc *osc = to_clk_main_rc_osc(hw);
+
+	osc->pms.status = clk_main_rc_osc_is_prepared(hw);
+
+	return 0;
+}
+
+static void clk_main_rc_osc_restore_context(struct clk_hw *hw)
+{
+	struct clk_main_rc_osc *osc = to_clk_main_rc_osc(hw);
+
+	if (osc->pms.status)
+		clk_main_rc_osc_prepare(hw);
+}
+
 static const struct clk_ops main_rc_osc_ops = {
 	.prepare = clk_main_rc_osc_prepare,
 	.unprepare = clk_main_rc_osc_unprepare,
 	.is_prepared = clk_main_rc_osc_is_prepared,
 	.recalc_rate = clk_main_rc_osc_recalc_rate,
 	.recalc_accuracy = clk_main_rc_osc_recalc_accuracy,
+	.save_context = clk_main_rc_osc_save_context,
+	.restore_context = clk_main_rc_osc_restore_context,
 };
 
 struct clk_hw * __init
@@ -465,12 +506,37 @@ static u8 clk_sam9x5_main_get_parent(struct clk_hw *hw)
 	return clk_main_parent_select(status);
 }
 
+static int clk_sam9x5_main_save_context(struct clk_hw *hw)
+{
+	struct clk_sam9x5_main *clkmain = to_clk_sam9x5_main(hw);
+
+	clkmain->pms.status = clk_main_rc_osc_is_prepared(&clkmain->hw);
+	clkmain->pms.parent = clk_sam9x5_main_get_parent(&clkmain->hw);
+
+	return 0;
+}
+
+static void clk_sam9x5_main_restore_context(struct clk_hw *hw)
+{
+	struct clk_sam9x5_main *clkmain = to_clk_sam9x5_main(hw);
+	int ret;
+
+	ret = clk_sam9x5_main_set_parent(hw, clkmain->pms.parent);
+	if (ret)
+		return;
+
+	if (clkmain->pms.status)
+		clk_sam9x5_main_prepare(hw);
+}
+
 static const struct clk_ops sam9x5_main_ops = {
 	.prepare = clk_sam9x5_main_prepare,
 	.is_prepared = clk_sam9x5_main_is_prepared,
 	.recalc_rate = clk_sam9x5_main_recalc_rate,
 	.set_parent = clk_sam9x5_main_set_parent,
 	.get_parent = clk_sam9x5_main_get_parent,
+	.save_context = clk_sam9x5_main_save_context,
+	.restore_context = clk_sam9x5_main_restore_context,
 };
 
 struct clk_hw * __init
diff --git a/drivers/clk/at91/clk-master.c b/drivers/clk/at91/clk-master.c
index a80427980bf7..6f1fb2eb2a8d 100644
--- a/drivers/clk/at91/clk-master.c
+++ b/drivers/clk/at91/clk-master.c
@@ -37,6 +37,7 @@ struct clk_master {
 	spinlock_t *lock;
 	const struct clk_master_layout *layout;
 	const struct clk_master_characteristics *characteristics;
+	struct at91_clk_pms pms;
 	u32 *mux_table;
 	u32 mckr;
 	int chg_pid;
@@ -112,10 +113,52 @@ static unsigned long clk_master_div_recalc_rate(struct clk_hw *hw,
 	return rate;
 }
 
+static int clk_master_div_save_context(struct clk_hw *hw)
+{
+	struct clk_master *master = to_clk_master(hw);
+	struct clk_hw *parent_hw = clk_hw_get_parent(hw);
+	unsigned long flags;
+	unsigned int mckr, div;
+
+	spin_lock_irqsave(master->lock, flags);
+	regmap_read(master->regmap, master->layout->offset, &mckr);
+	spin_unlock_irqrestore(master->lock, flags);
+
+	mckr &= master->layout->mask;
+	div = (mckr >> MASTER_DIV_SHIFT) & MASTER_DIV_MASK;
+	div = master->characteristics->divisors[div];
+
+	master->pms.parent_rate = clk_hw_get_rate(parent_hw);
+	master->pms.rate = DIV_ROUND_CLOSEST(master->pms.parent_rate, div);
+
+	return 0;
+}
+
+static void clk_master_div_restore_context(struct clk_hw *hw)
+{
+	struct clk_master *master = to_clk_master(hw);
+	unsigned long flags;
+	unsigned int mckr;
+	u8 div;
+
+	spin_lock_irqsave(master->lock, flags);
+	regmap_read(master->regmap, master->layout->offset, &mckr);
+	spin_unlock_irqrestore(master->lock, flags);
+
+	mckr &= master->layout->mask;
+	div = (mckr >> MASTER_DIV_SHIFT) & MASTER_DIV_MASK;
+	div = master->characteristics->divisors[div];
+
+	if (div != DIV_ROUND_CLOSEST(master->pms.parent_rate, master->pms.rate))
+		pr_warn("MCKR DIV not configured properly by firmware!\n");
+}
+
 static const struct clk_ops master_div_ops = {
 	.prepare = clk_master_prepare,
 	.is_prepared = clk_master_is_prepared,
 	.recalc_rate = clk_master_div_recalc_rate,
+	.save_context = clk_master_div_save_context,
+	.restore_context = clk_master_div_restore_context,
 };
 
 static int clk_master_div_set_rate(struct clk_hw *hw, unsigned long rate,
@@ -125,7 +168,9 @@ static int clk_master_div_set_rate(struct clk_hw *hw, unsigned long rate,
 	const struct clk_master_characteristics *characteristics =
 						master->characteristics;
 	unsigned long flags;
+	unsigned int mckr, tmp;
 	int div, i;
+	int ret;
 
 	div = DIV_ROUND_CLOSEST(parent_rate, rate);
 	if (div > ARRAY_SIZE(characteristics->divisors))
@@ -145,11 +190,24 @@ static int clk_master_div_set_rate(struct clk_hw *hw, unsigned long rate,
 		return -EINVAL;
 
 	spin_lock_irqsave(master->lock, flags);
-	regmap_update_bits(master->regmap, master->layout->offset,
-			   (MASTER_DIV_MASK << MASTER_DIV_SHIFT),
-			   (div << MASTER_DIV_SHIFT));
+	ret = regmap_read(master->regmap, master->layout->offset, &mckr);
+	if (ret)
+		goto unlock;
+
+	tmp = mckr & master->layout->mask;
+	tmp = (tmp >> MASTER_DIV_SHIFT) & MASTER_DIV_MASK;
+	if (tmp == div)
+		goto unlock;
+
+	mckr &= ~(MASTER_DIV_MASK << MASTER_DIV_SHIFT);
+	mckr |= (div << MASTER_DIV_SHIFT);
+	ret = regmap_write(master->regmap, master->layout->offset, mckr);
+	if (ret)
+		goto unlock;
+
 	while (!clk_master_ready(master))
 		cpu_relax();
+unlock:
 	spin_unlock_irqrestore(master->lock, flags);
 
 	return 0;
@@ -197,12 +255,25 @@ static int clk_master_div_determine_rate(struct clk_hw *hw,
 	return 0;
 }
 
+static void clk_master_div_restore_context_chg(struct clk_hw *hw)
+{
+	struct clk_master *master = to_clk_master(hw);
+	int ret;
+
+	ret = clk_master_div_set_rate(hw, master->pms.rate,
+				      master->pms.parent_rate);
+	if (ret)
+		pr_warn("Failed to restore MCK DIV clock\n");
+}
+
 static const struct clk_ops master_div_ops_chg = {
 	.prepare = clk_master_prepare,
 	.is_prepared = clk_master_is_prepared,
 	.recalc_rate = clk_master_div_recalc_rate,
 	.determine_rate = clk_master_div_determine_rate,
 	.set_rate = clk_master_div_set_rate,
+	.save_context = clk_master_div_save_context,
+	.restore_context = clk_master_div_restore_context_chg,
 };
 
 static void clk_sama7g5_master_best_diff(struct clk_rate_request *req,
@@ -272,7 +343,8 @@ static int clk_master_pres_set_rate(struct clk_hw *hw, unsigned long rate,
 {
 	struct clk_master *master = to_clk_master(hw);
 	unsigned long flags;
-	unsigned int pres;
+	unsigned int pres, val;
+	int ret;
 
 	pres = DIV_ROUND_CLOSEST(parent_rate, rate);
 	if (pres > MASTER_PRES_MAX)
@@ -284,15 +356,24 @@ static int clk_master_pres_set_rate(struct clk_hw *hw, unsigned long rate,
 		pres = ffs(pres) - 1;
 
 	spin_lock_irqsave(master->lock, flags);
+	ret = regmap_read(master->regmap, master->layout->offset, &val);
+	if (ret)
+		goto unlock;
+
+	val = (val >> master->layout->pres_shift) & MASTER_PRES_MASK;
+	if (pres == val)
+		goto unlock;
+
 	regmap_update_bits(master->regmap, master->layout->offset,
 			   (MASTER_PRES_MASK << master->layout->pres_shift),
 			   (pres << master->layout->pres_shift));
 
 	while (!clk_master_ready(master))
 		cpu_relax();
+unlock:
 	spin_unlock_irqrestore(master->lock, flags);
 
-	return 0;
+	return ret;
 }
 
 static unsigned long clk_master_pres_recalc_rate(struct clk_hw *hw,
@@ -330,11 +411,66 @@ static u8 clk_master_pres_get_parent(struct clk_hw *hw)
 	return mckr & AT91_PMC_CSS;
 }
 
+static int clk_master_pres_save_context(struct clk_hw *hw)
+{
+	struct clk_master *master = to_clk_master(hw);
+	struct clk_hw *parent_hw = clk_hw_get_parent(hw);
+	unsigned long flags;
+	unsigned int val, pres;
+
+	spin_lock_irqsave(master->lock, flags);
+	regmap_read(master->regmap, master->layout->offset, &val);
+	spin_unlock_irqrestore(master->lock, flags);
+
+	pres = (val >> master->layout->pres_shift) & MASTER_PRES_MASK;
+	if (pres == 3 && master->characteristics->have_div3_pres)
+		pres = 3;
+	else
+		pres = (1 << pres);
+
+	master->pms.parent = val & AT91_PMC_CSS;
+	master->pms.parent_rate = clk_hw_get_rate(parent_hw);
+	master->pms.rate = DIV_ROUND_CLOSEST_ULL(master->pms.parent_rate, pres);
+
+	return 0;
+}
+
+static void clk_master_pres_restore_context(struct clk_hw *hw)
+{
+	struct clk_master *master = to_clk_master(hw);
+	unsigned long flags;
+	unsigned int val, pres;
+
+	spin_lock_irqsave(master->lock, flags);
+	regmap_read(master->regmap, master->layout->offset, &val);
+	spin_unlock_irqrestore(master->lock, flags);
+
+	pres = (val >> master->layout->pres_shift) & MASTER_PRES_MASK;
+	if (pres == 3 && master->characteristics->have_div3_pres)
+		pres = 3;
+	else
+		pres = (1 << pres);
+
+	if ((master->pms.rate !=
+	     DIV_ROUND_CLOSEST_ULL(master->pms.parent_rate, pres)) ||
+	    (master->pms.parent != (val & AT91_PMC_CSS)))
+		pr_warn("MCKR PRES was not configured properly by firmware!\n");
+}
+
+static void clk_master_pres_restore_context_chg(struct clk_hw *hw)
+{
+	struct clk_master *master = to_clk_master(hw);
+
+	clk_master_pres_set_rate(hw, master->pms.rate, master->pms.parent_rate);
+}
+
 static const struct clk_ops master_pres_ops = {
 	.prepare = clk_master_prepare,
 	.is_prepared = clk_master_is_prepared,
 	.recalc_rate = clk_master_pres_recalc_rate,
 	.get_parent = clk_master_pres_get_parent,
+	.save_context = clk_master_pres_save_context,
+	.restore_context = clk_master_pres_restore_context,
 };
 
 static const struct clk_ops master_pres_ops_chg = {
@@ -344,6 +480,8 @@ static const struct clk_ops master_pres_ops_chg = {
 	.recalc_rate = clk_master_pres_recalc_rate,
 	.get_parent = clk_master_pres_get_parent,
 	.set_rate = clk_master_pres_set_rate,
+	.save_context = clk_master_pres_save_context,
+	.restore_context = clk_master_pres_restore_context_chg,
 };
 
 static struct clk_hw * __init
@@ -539,9 +677,9 @@ static int clk_sama7g5_master_set_parent(struct clk_hw *hw, u8 index)
 	return 0;
 }
 
-static int clk_sama7g5_master_enable(struct clk_hw *hw)
+static void clk_sama7g5_master_set(struct clk_master *master,
+				   unsigned int status)
 {
-	struct clk_master *master = to_clk_master(hw);
 	unsigned long flags;
 	unsigned int val, cparent;
 
@@ -550,9 +688,10 @@ static int clk_sama7g5_master_enable(struct clk_hw *hw)
 	regmap_write(master->regmap, PMC_MCR, PMC_MCR_ID(master->id));
 	regmap_read(master->regmap, PMC_MCR, &val);
 	regmap_update_bits(master->regmap, PMC_MCR,
-			   PMC_MCR_EN | PMC_MCR_CSS | PMC_MCR_DIV |
+			   (status ? PMC_MCR_EN : 0) | PMC_MCR_CSS | PMC_MCR_DIV |
 			   PMC_MCR_CMD | PMC_MCR_ID_MSK,
-			   PMC_MCR_EN | (master->parent << PMC_MCR_CSS_SHIFT) |
+			   (status ? PMC_MCR_EN : 0) |
+			   (master->parent << PMC_MCR_CSS_SHIFT) |
 			   (master->div << MASTER_DIV_SHIFT) |
 			   PMC_MCR_CMD | PMC_MCR_ID(master->id));
 
@@ -563,6 +702,13 @@ static int clk_sama7g5_master_enable(struct clk_hw *hw)
 		cpu_relax();
 
 	spin_unlock_irqrestore(master->lock, flags);
+}
+
+static int clk_sama7g5_master_enable(struct clk_hw *hw)
+{
+	struct clk_master *master = to_clk_master(hw);
+
+	clk_sama7g5_master_set(master, 1);
 
 	return 0;
 }
@@ -620,6 +766,23 @@ static int clk_sama7g5_master_set_rate(struct clk_hw *hw, unsigned long rate,
 	return 0;
 }
 
+static int clk_sama7g5_master_save_context(struct clk_hw *hw)
+{
+	struct clk_master *master = to_clk_master(hw);
+
+	master->pms.status = clk_sama7g5_master_is_enabled(hw);
+
+	return 0;
+}
+
+static void clk_sama7g5_master_restore_context(struct clk_hw *hw)
+{
+	struct clk_master *master = to_clk_master(hw);
+
+	if (master->pms.status)
+		clk_sama7g5_master_set(master, master->pms.status);
+}
+
 static const struct clk_ops sama7g5_master_ops = {
 	.enable = clk_sama7g5_master_enable,
 	.disable = clk_sama7g5_master_disable,
@@ -629,6 +792,8 @@ static const struct clk_ops sama7g5_master_ops = {
 	.set_rate = clk_sama7g5_master_set_rate,
 	.get_parent = clk_sama7g5_master_get_parent,
 	.set_parent = clk_sama7g5_master_set_parent,
+	.save_context = clk_sama7g5_master_save_context,
+	.restore_context = clk_sama7g5_master_restore_context,
 };
 
 struct clk_hw * __init
diff --git a/drivers/clk/at91/clk-peripheral.c b/drivers/clk/at91/clk-peripheral.c
index 7a27ba8e0577..bf088cd06225 100644
--- a/drivers/clk/at91/clk-peripheral.c
+++ b/drivers/clk/at91/clk-peripheral.c
@@ -37,6 +37,7 @@ struct clk_sam9x5_peripheral {
 	u32 id;
 	u32 div;
 	const struct clk_pcr_layout *layout;
+	struct at91_clk_pms pms;
 	bool auto_div;
 	int chg_pid;
 };
@@ -155,9 +156,9 @@ static void clk_sam9x5_peripheral_autodiv(struct clk_sam9x5_peripheral *periph)
 	periph->div = shift;
 }
 
-static int clk_sam9x5_peripheral_enable(struct clk_hw *hw)
+static int clk_sam9x5_peripheral_set(struct clk_sam9x5_peripheral *periph,
+				     unsigned int status)
 {
-	struct clk_sam9x5_peripheral *periph = to_clk_sam9x5_peripheral(hw);
 	unsigned long flags;
 
 	if (periph->id < PERIPHERAL_ID_MIN)
@@ -168,15 +169,22 @@ static int clk_sam9x5_peripheral_enable(struct clk_hw *hw)
 		     (periph->id & periph->layout->pid_mask));
 	regmap_update_bits(periph->regmap, periph->layout->offset,
 			   periph->layout->div_mask | periph->layout->cmd |
-			   AT91_PMC_PCR_EN,
+			   (status ? AT91_PMC_PCR_EN : 0),
 			   field_prep(periph->layout->div_mask, periph->div) |
 			   periph->layout->cmd |
-			   AT91_PMC_PCR_EN);
+			   (status ? AT91_PMC_PCR_EN : 0));
 	spin_unlock_irqrestore(periph->lock, flags);
 
 	return 0;
 }
 
+static int clk_sam9x5_peripheral_enable(struct clk_hw *hw)
+{
+	struct clk_sam9x5_peripheral *periph = to_clk_sam9x5_peripheral(hw);
+
+	return clk_sam9x5_peripheral_set(periph, 1);
+}
+
 static void clk_sam9x5_peripheral_disable(struct clk_hw *hw)
 {
 	struct clk_sam9x5_peripheral *periph = to_clk_sam9x5_peripheral(hw);
@@ -393,6 +401,23 @@ static int clk_sam9x5_peripheral_set_rate(struct clk_hw *hw,
 	return -EINVAL;
 }
 
+static int clk_sam9x5_peripheral_save_context(struct clk_hw *hw)
+{
+	struct clk_sam9x5_peripheral *periph = to_clk_sam9x5_peripheral(hw);
+
+	periph->pms.status = clk_sam9x5_peripheral_is_enabled(hw);
+
+	return 0;
+}
+
+static void clk_sam9x5_peripheral_restore_context(struct clk_hw *hw)
+{
+	struct clk_sam9x5_peripheral *periph = to_clk_sam9x5_peripheral(hw);
+
+	if (periph->pms.status)
+		clk_sam9x5_peripheral_set(periph, periph->pms.status);
+}
+
 static const struct clk_ops sam9x5_peripheral_ops = {
 	.enable = clk_sam9x5_peripheral_enable,
 	.disable = clk_sam9x5_peripheral_disable,
@@ -400,6 +425,8 @@ static const struct clk_ops sam9x5_peripheral_ops = {
 	.recalc_rate = clk_sam9x5_peripheral_recalc_rate,
 	.round_rate = clk_sam9x5_peripheral_round_rate,
 	.set_rate = clk_sam9x5_peripheral_set_rate,
+	.save_context = clk_sam9x5_peripheral_save_context,
+	.restore_context = clk_sam9x5_peripheral_restore_context,
 };
 
 static const struct clk_ops sam9x5_peripheral_chg_ops = {
@@ -409,6 +436,8 @@ static const struct clk_ops sam9x5_peripheral_chg_ops = {
 	.recalc_rate = clk_sam9x5_peripheral_recalc_rate,
 	.determine_rate = clk_sam9x5_peripheral_determine_rate,
 	.set_rate = clk_sam9x5_peripheral_set_rate,
+	.save_context = clk_sam9x5_peripheral_save_context,
+	.restore_context = clk_sam9x5_peripheral_restore_context,
 };
 
 struct clk_hw * __init
@@ -460,7 +489,6 @@ at91_clk_register_sam9x5_peripheral(struct regmap *regmap, spinlock_t *lock,
 		hw = ERR_PTR(ret);
 	} else {
 		clk_sam9x5_peripheral_autodiv(periph);
-		pmc_register_id(id);
 	}
 
 	return hw;
diff --git a/drivers/clk/at91/clk-pll.c b/drivers/clk/at91/clk-pll.c
index 6ed986d3eee0..31964622c658 100644
--- a/drivers/clk/at91/clk-pll.c
+++ b/drivers/clk/at91/clk-pll.c
@@ -40,6 +40,7 @@ struct clk_pll {
 	u16 mul;
 	const struct clk_pll_layout *layout;
 	const struct clk_pll_characteristics *characteristics;
+	struct at91_clk_pms pms;
 };
 
 static inline bool clk_pll_ready(struct regmap *regmap, int id)
@@ -260,6 +261,40 @@ static int clk_pll_set_rate(struct clk_hw *hw, unsigned long rate,
 	return 0;
 }
 
+static int clk_pll_save_context(struct clk_hw *hw)
+{
+	struct clk_pll *pll = to_clk_pll(hw);
+	struct clk_hw *parent_hw = clk_hw_get_parent(hw);
+
+	pll->pms.parent_rate = clk_hw_get_rate(parent_hw);
+	pll->pms.rate = clk_pll_recalc_rate(&pll->hw, pll->pms.parent_rate);
+	pll->pms.status = clk_pll_ready(pll->regmap, PLL_REG(pll->id));
+
+	return 0;
+}
+
+static void clk_pll_restore_context(struct clk_hw *hw)
+{
+	struct clk_pll *pll = to_clk_pll(hw);
+	unsigned long calc_rate;
+	unsigned int pllr;
+	u8 out = 0;
+
+	if (pll->characteristics->out)
+		out = pll->characteristics->out[pll->range];
+
+	regmap_read(pll->regmap, PLL_REG(pll->id), &pllr);
+
+	calc_rate = (pll->pms.parent_rate / PLL_DIV(pllr)) *
+		     (PLL_MUL(pllr, pll->layout) + 1);
+
+	if (pll->pms.rate != calc_rate ||
+	    pll->pms.status != clk_pll_ready(pll->regmap, PLL_REG(pll->id)) ||
+	    (((pllr >> PLL_COUNT_SHIFT) & PLL_MAX_COUNT) != PLL_MAX_COUNT) ||
+	    (out && ((pllr >> PLL_OUT_SHIFT) & out) != out))
+		pr_warn("PLLAR was not configured properly by firmware\n");
+}
+
 static const struct clk_ops pll_ops = {
 	.prepare = clk_pll_prepare,
 	.unprepare = clk_pll_unprepare,
@@ -267,6 +302,8 @@ static const struct clk_ops pll_ops = {
 	.recalc_rate = clk_pll_recalc_rate,
 	.round_rate = clk_pll_round_rate,
 	.set_rate = clk_pll_set_rate,
+	.save_context = clk_pll_save_context,
+	.restore_context = clk_pll_restore_context,
 };
 
 struct clk_hw * __init
diff --git a/drivers/clk/at91/clk-programmable.c b/drivers/clk/at91/clk-programmable.c
index fcf8f6a1c2c6..6c4b259d31d3 100644
--- a/drivers/clk/at91/clk-programmable.c
+++ b/drivers/clk/at91/clk-programmable.c
@@ -24,6 +24,7 @@ struct clk_programmable {
 	u32 *mux_table;
 	u8 id;
 	const struct clk_programmable_layout *layout;
+	struct at91_clk_pms pms;
 };
 
 #define to_clk_programmable(hw) container_of(hw, struct clk_programmable, hw)
@@ -177,12 +178,38 @@ static int clk_programmable_set_rate(struct clk_hw *hw, unsigned long rate,
 	return 0;
 }
 
+static int clk_programmable_save_context(struct clk_hw *hw)
+{
+	struct clk_programmable *prog = to_clk_programmable(hw);
+	struct clk_hw *parent_hw = clk_hw_get_parent(hw);
+
+	prog->pms.parent = clk_programmable_get_parent(hw);
+	prog->pms.parent_rate = clk_hw_get_rate(parent_hw);
+	prog->pms.rate = clk_programmable_recalc_rate(hw, prog->pms.parent_rate);
+
+	return 0;
+}
+
+static void clk_programmable_restore_context(struct clk_hw *hw)
+{
+	struct clk_programmable *prog = to_clk_programmable(hw);
+	int ret;
+
+	ret = clk_programmable_set_parent(hw, prog->pms.parent);
+	if (ret)
+		return;
+
+	clk_programmable_set_rate(hw, prog->pms.rate, prog->pms.parent_rate);
+}
+
 static const struct clk_ops programmable_ops = {
 	.recalc_rate = clk_programmable_recalc_rate,
 	.determine_rate = clk_programmable_determine_rate,
 	.get_parent = clk_programmable_get_parent,
 	.set_parent = clk_programmable_set_parent,
 	.set_rate = clk_programmable_set_rate,
+	.save_context = clk_programmable_save_context,
+	.restore_context = clk_programmable_restore_context,
 };
 
 struct clk_hw * __init
@@ -221,8 +248,6 @@ at91_clk_register_programmable(struct regmap *regmap,
 	if (ret) {
 		kfree(prog);
 		hw = ERR_PTR(ret);
-	} else {
-		pmc_register_pck(id);
 	}
 
 	return hw;
diff --git a/drivers/clk/at91/clk-sam9x60-pll.c b/drivers/clk/at91/clk-sam9x60-pll.c
index 34e3ab13741a..7020d3bf6e13 100644
--- a/drivers/clk/at91/clk-sam9x60-pll.c
+++ b/drivers/clk/at91/clk-sam9x60-pll.c
@@ -38,12 +38,14 @@ struct sam9x60_pll_core {
 
 struct sam9x60_frac {
 	struct sam9x60_pll_core core;
+	struct at91_clk_pms pms;
 	u32 frac;
 	u16 mul;
 };
 
 struct sam9x60_div {
 	struct sam9x60_pll_core core;
+	struct at91_clk_pms pms;
 	u8 div;
 };
 
@@ -75,9 +77,8 @@ static unsigned long sam9x60_frac_pll_recalc_rate(struct clk_hw *hw,
 		((u64)parent_rate * frac->frac >> 22));
 }
 
-static int sam9x60_frac_pll_prepare(struct clk_hw *hw)
+static int sam9x60_frac_pll_set(struct sam9x60_pll_core *core)
 {
-	struct sam9x60_pll_core *core = to_sam9x60_pll_core(hw);
 	struct sam9x60_frac *frac = to_sam9x60_frac(core);
 	struct regmap *regmap = core->regmap;
 	unsigned int val, cfrac, cmul;
@@ -141,6 +142,13 @@ static int sam9x60_frac_pll_prepare(struct clk_hw *hw)
 	return 0;
 }
 
+static int sam9x60_frac_pll_prepare(struct clk_hw *hw)
+{
+	struct sam9x60_pll_core *core = to_sam9x60_pll_core(hw);
+
+	return sam9x60_frac_pll_set(core);
+}
+
 static void sam9x60_frac_pll_unprepare(struct clk_hw *hw)
 {
 	struct sam9x60_pll_core *core = to_sam9x60_pll_core(hw);
@@ -280,6 +288,25 @@ static int sam9x60_frac_pll_set_rate_chg(struct clk_hw *hw, unsigned long rate,
 	return ret;
 }
 
+static int sam9x60_frac_pll_save_context(struct clk_hw *hw)
+{
+	struct sam9x60_pll_core *core = to_sam9x60_pll_core(hw);
+	struct sam9x60_frac *frac = to_sam9x60_frac(core);
+
+	frac->pms.status = sam9x60_pll_ready(core->regmap, core->id);
+
+	return 0;
+}
+
+static void sam9x60_frac_pll_restore_context(struct clk_hw *hw)
+{
+	struct sam9x60_pll_core *core = to_sam9x60_pll_core(hw);
+	struct sam9x60_frac *frac = to_sam9x60_frac(core);
+
+	if (frac->pms.status)
+		sam9x60_frac_pll_set(core);
+}
+
 static const struct clk_ops sam9x60_frac_pll_ops = {
 	.prepare = sam9x60_frac_pll_prepare,
 	.unprepare = sam9x60_frac_pll_unprepare,
@@ -287,6 +314,8 @@ static const struct clk_ops sam9x60_frac_pll_ops = {
 	.recalc_rate = sam9x60_frac_pll_recalc_rate,
 	.round_rate = sam9x60_frac_pll_round_rate,
 	.set_rate = sam9x60_frac_pll_set_rate,
+	.save_context = sam9x60_frac_pll_save_context,
+	.restore_context = sam9x60_frac_pll_restore_context,
 };
 
 static const struct clk_ops sam9x60_frac_pll_ops_chg = {
@@ -296,11 +325,12 @@ static const struct clk_ops sam9x60_frac_pll_ops_chg = {
 	.recalc_rate = sam9x60_frac_pll_recalc_rate,
 	.round_rate = sam9x60_frac_pll_round_rate,
 	.set_rate = sam9x60_frac_pll_set_rate_chg,
+	.save_context = sam9x60_frac_pll_save_context,
+	.restore_context = sam9x60_frac_pll_restore_context,
 };
 
-static int sam9x60_div_pll_prepare(struct clk_hw *hw)
+static int sam9x60_div_pll_set(struct sam9x60_pll_core *core)
 {
-	struct sam9x60_pll_core *core = to_sam9x60_pll_core(hw);
 	struct sam9x60_div *div = to_sam9x60_div(core);
 	struct regmap *regmap = core->regmap;
 	unsigned long flags;
@@ -334,6 +364,13 @@ static int sam9x60_div_pll_prepare(struct clk_hw *hw)
 	return 0;
 }
 
+static int sam9x60_div_pll_prepare(struct clk_hw *hw)
+{
+	struct sam9x60_pll_core *core = to_sam9x60_pll_core(hw);
+
+	return sam9x60_div_pll_set(core);
+}
+
 static void sam9x60_div_pll_unprepare(struct clk_hw *hw)
 {
 	struct sam9x60_pll_core *core = to_sam9x60_pll_core(hw);
@@ -482,6 +519,25 @@ static int sam9x60_div_pll_set_rate_chg(struct clk_hw *hw, unsigned long rate,
 	return 0;
 }
 
+static int sam9x60_div_pll_save_context(struct clk_hw *hw)
+{
+	struct sam9x60_pll_core *core = to_sam9x60_pll_core(hw);
+	struct sam9x60_div *div = to_sam9x60_div(core);
+
+	div->pms.status = sam9x60_div_pll_is_prepared(hw);
+
+	return 0;
+}
+
+static void sam9x60_div_pll_restore_context(struct clk_hw *hw)
+{
+	struct sam9x60_pll_core *core = to_sam9x60_pll_core(hw);
+	struct sam9x60_div *div = to_sam9x60_div(core);
+
+	if (div->pms.status)
+		sam9x60_div_pll_set(core);
+}
+
 static const struct clk_ops sam9x60_div_pll_ops = {
 	.prepare = sam9x60_div_pll_prepare,
 	.unprepare = sam9x60_div_pll_unprepare,
@@ -489,6 +545,8 @@ static const struct clk_ops sam9x60_div_pll_ops = {
 	.recalc_rate = sam9x60_div_pll_recalc_rate,
 	.round_rate = sam9x60_div_pll_round_rate,
 	.set_rate = sam9x60_div_pll_set_rate,
+	.save_context = sam9x60_div_pll_save_context,
+	.restore_context = sam9x60_div_pll_restore_context,
 };
 
 static const struct clk_ops sam9x60_div_pll_ops_chg = {
@@ -498,6 +556,8 @@ static const struct clk_ops sam9x60_div_pll_ops_chg = {
 	.recalc_rate = sam9x60_div_pll_recalc_rate,
 	.round_rate = sam9x60_div_pll_round_rate,
 	.set_rate = sam9x60_div_pll_set_rate_chg,
+	.save_context = sam9x60_div_pll_save_context,
+	.restore_context = sam9x60_div_pll_restore_context,
 };
 
 struct clk_hw * __init
diff --git a/drivers/clk/at91/clk-system.c b/drivers/clk/at91/clk-system.c
index f83ec0de86c3..80720fd1a9cf 100644
--- a/drivers/clk/at91/clk-system.c
+++ b/drivers/clk/at91/clk-system.c
@@ -20,6 +20,7 @@
 struct clk_system {
 	struct clk_hw hw;
 	struct regmap *regmap;
+	struct at91_clk_pms pms;
 	u8 id;
 };
 
@@ -77,10 +78,29 @@ static int clk_system_is_prepared(struct clk_hw *hw)
 	return !!(status & (1 << sys->id));
 }
 
+static int clk_system_save_context(struct clk_hw *hw)
+{
+	struct clk_system *sys = to_clk_system(hw);
+
+	sys->pms.status = clk_system_is_prepared(hw);
+
+	return 0;
+}
+
+static void clk_system_restore_context(struct clk_hw *hw)
+{
+	struct clk_system *sys = to_clk_system(hw);
+
+	if (sys->pms.status)
+		clk_system_prepare(&sys->hw);
+}
+
 static const struct clk_ops system_ops = {
 	.prepare = clk_system_prepare,
 	.unprepare = clk_system_unprepare,
 	.is_prepared = clk_system_is_prepared,
+	.save_context = clk_system_save_context,
+	.restore_context = clk_system_restore_context,
 };
 
 struct clk_hw * __init
diff --git a/drivers/clk/at91/clk-usb.c b/drivers/clk/at91/clk-usb.c
index 31d5c45e30d7..b0696a928aa9 100644
--- a/drivers/clk/at91/clk-usb.c
+++ b/drivers/clk/at91/clk-usb.c
@@ -24,6 +24,7 @@
 struct at91sam9x5_clk_usb {
 	struct clk_hw hw;
 	struct regmap *regmap;
+	struct at91_clk_pms pms;
 	u32 usbs_mask;
 	u8 num_parents;
 };
@@ -148,12 +149,38 @@ static int at91sam9x5_clk_usb_set_rate(struct clk_hw *hw, unsigned long rate,
 	return 0;
 }
 
+static int at91sam9x5_usb_save_context(struct clk_hw *hw)
+{
+	struct at91sam9x5_clk_usb *usb = to_at91sam9x5_clk_usb(hw);
+	struct clk_hw *parent_hw = clk_hw_get_parent(hw);
+
+	usb->pms.parent = at91sam9x5_clk_usb_get_parent(hw);
+	usb->pms.parent_rate = clk_hw_get_rate(parent_hw);
+	usb->pms.rate = at91sam9x5_clk_usb_recalc_rate(hw, usb->pms.parent_rate);
+
+	return 0;
+}
+
+static void at91sam9x5_usb_restore_context(struct clk_hw *hw)
+{
+	struct at91sam9x5_clk_usb *usb = to_at91sam9x5_clk_usb(hw);
+	int ret;
+
+	ret = at91sam9x5_clk_usb_set_parent(hw, usb->pms.parent);
+	if (ret)
+		return;
+
+	at91sam9x5_clk_usb_set_rate(hw, usb->pms.rate, usb->pms.parent_rate);
+}
+
 static const struct clk_ops at91sam9x5_usb_ops = {
 	.recalc_rate = at91sam9x5_clk_usb_recalc_rate,
 	.determine_rate = at91sam9x5_clk_usb_determine_rate,
 	.get_parent = at91sam9x5_clk_usb_get_parent,
 	.set_parent = at91sam9x5_clk_usb_set_parent,
 	.set_rate = at91sam9x5_clk_usb_set_rate,
+	.save_context = at91sam9x5_usb_save_context,
+	.restore_context = at91sam9x5_usb_restore_context,
 };
 
 static int at91sam9n12_clk_usb_enable(struct clk_hw *hw)
diff --git a/drivers/clk/at91/clk-utmi.c b/drivers/clk/at91/clk-utmi.c
index df9f3fc3b6a6..2b102ee2a7d3 100644
--- a/drivers/clk/at91/clk-utmi.c
+++ b/drivers/clk/at91/clk-utmi.c
@@ -23,6 +23,7 @@ struct clk_utmi {
 	struct clk_hw hw;
 	struct regmap *regmap_pmc;
 	struct regmap *regmap_sfr;
+	struct at91_clk_pms pms;
 };
 
 #define to_clk_utmi(hw) container_of(hw, struct clk_utmi, hw)
@@ -113,11 +114,30 @@ static unsigned long clk_utmi_recalc_rate(struct clk_hw *hw,
 	return UTMI_RATE;
 }
 
+static int clk_utmi_save_context(struct clk_hw *hw)
+{
+	struct clk_utmi *utmi = to_clk_utmi(hw);
+
+	utmi->pms.status = clk_utmi_is_prepared(hw);
+
+	return 0;
+}
+
+static void clk_utmi_restore_context(struct clk_hw *hw)
+{
+	struct clk_utmi *utmi = to_clk_utmi(hw);
+
+	if (utmi->pms.status)
+		clk_utmi_prepare(hw);
+}
+
 static const struct clk_ops utmi_ops = {
 	.prepare = clk_utmi_prepare,
 	.unprepare = clk_utmi_unprepare,
 	.is_prepared = clk_utmi_is_prepared,
 	.recalc_rate = clk_utmi_recalc_rate,
+	.save_context = clk_utmi_save_context,
+	.restore_context = clk_utmi_restore_context,
 };
 
 static struct clk_hw * __init
@@ -232,10 +252,35 @@ static int clk_utmi_sama7g5_is_prepared(struct clk_hw *hw)
 	return 0;
 }
 
+static unsigned long clk_utmi_sama7g5_recalc_rate(struct clk_hw *hw,
+						  unsigned long parent_rate)
+{
+	return 480000000;
+}
+
+static int clk_utmi_sama7g5_save_context(struct clk_hw *hw)
+{
+	struct clk_utmi *utmi = to_clk_utmi(hw);
+
+	utmi->pms.status = clk_utmi_sama7g5_is_prepared(hw);
+
+	return 0;
+}
+
+static void clk_utmi_sama7g5_restore_context(struct clk_hw *hw)
+{
+	struct clk_utmi *utmi = to_clk_utmi(hw);
+
+	if (utmi->pms.status)
+		clk_utmi_sama7g5_prepare(hw);
+}
+
 static const struct clk_ops sama7g5_utmi_ops = {
 	.prepare = clk_utmi_sama7g5_prepare,
 	.is_prepared = clk_utmi_sama7g5_is_prepared,
-	.recalc_rate = clk_utmi_recalc_rate,
+	.recalc_rate = clk_utmi_sama7g5_recalc_rate,
+	.save_context = clk_utmi_sama7g5_save_context,
+	.restore_context = clk_utmi_sama7g5_restore_context,
 };
 
 struct clk_hw * __init
diff --git a/drivers/clk/at91/pmc.c b/drivers/clk/at91/pmc.c
index 20ee9dccee78..77b57c9f5dcb 100644
--- a/drivers/clk/at91/pmc.c
+++ b/drivers/clk/at91/pmc.c
@@ -3,6 +3,7 @@
  *  Copyright (C) 2013 Boris BREZILLON <b.brezillon@overkiz.com>
  */
 
+#include <linux/clk.h>
 #include <linux/clk-provider.h>
 #include <linux/clkdev.h>
 #include <linux/clk/at91_pmc.h>
@@ -14,8 +15,6 @@
 
 #include <asm/proc-fns.h>
 
-#include <dt-bindings/clock/at91.h>
-
 #include "pmc.h"
 
 #define PMC_MAX_IDS 128
@@ -111,147 +110,19 @@ struct pmc_data *pmc_data_allocate(unsigned int ncore, unsigned int nsystem,
 }
 
 #ifdef CONFIG_PM
-static struct regmap *pmcreg;
-
-static u8 registered_ids[PMC_MAX_IDS];
-static u8 registered_pcks[PMC_MAX_PCKS];
-
-static struct
-{
-	u32 scsr;
-	u32 pcsr0;
-	u32 uckr;
-	u32 mor;
-	u32 mcfr;
-	u32 pllar;
-	u32 mckr;
-	u32 usb;
-	u32 imr;
-	u32 pcsr1;
-	u32 pcr[PMC_MAX_IDS];
-	u32 audio_pll0;
-	u32 audio_pll1;
-	u32 pckr[PMC_MAX_PCKS];
-} pmc_cache;
-
-/*
- * As Peripheral ID 0 is invalid on AT91 chips, the identifier is stored
- * without alteration in the table, and 0 is for unused clocks.
- */
-void pmc_register_id(u8 id)
-{
-	int i;
-
-	for (i = 0; i < PMC_MAX_IDS; i++) {
-		if (registered_ids[i] == 0) {
-			registered_ids[i] = id;
-			break;
-		}
-		if (registered_ids[i] == id)
-			break;
-	}
-}
-
-/*
- * As Programmable Clock 0 is valid on AT91 chips, there is an offset
- * of 1 between the stored value and the real clock ID.
- */
-void pmc_register_pck(u8 pck)
-{
-	int i;
-
-	for (i = 0; i < PMC_MAX_PCKS; i++) {
-		if (registered_pcks[i] == 0) {
-			registered_pcks[i] = pck + 1;
-			break;
-		}
-		if (registered_pcks[i] == (pck + 1))
-			break;
-	}
-}
-
-static int pmc_suspend(void)
+static int at91_pmc_suspend(void)
 {
-	int i;
-	u8 num;
-
-	regmap_read(pmcreg, AT91_PMC_SCSR, &pmc_cache.scsr);
-	regmap_read(pmcreg, AT91_PMC_PCSR, &pmc_cache.pcsr0);
-	regmap_read(pmcreg, AT91_CKGR_UCKR, &pmc_cache.uckr);
-	regmap_read(pmcreg, AT91_CKGR_MOR, &pmc_cache.mor);
-	regmap_read(pmcreg, AT91_CKGR_MCFR, &pmc_cache.mcfr);
-	regmap_read(pmcreg, AT91_CKGR_PLLAR, &pmc_cache.pllar);
-	regmap_read(pmcreg, AT91_PMC_MCKR, &pmc_cache.mckr);
-	regmap_read(pmcreg, AT91_PMC_USB, &pmc_cache.usb);
-	regmap_read(pmcreg, AT91_PMC_IMR, &pmc_cache.imr);
-	regmap_read(pmcreg, AT91_PMC_PCSR1, &pmc_cache.pcsr1);
-
-	for (i = 0; registered_ids[i]; i++) {
-		regmap_write(pmcreg, AT91_PMC_PCR,
-			     (registered_ids[i] & AT91_PMC_PCR_PID_MASK));
-		regmap_read(pmcreg, AT91_PMC_PCR,
-			    &pmc_cache.pcr[registered_ids[i]]);
-	}
-	for (i = 0; registered_pcks[i]; i++) {
-		num = registered_pcks[i] - 1;
-		regmap_read(pmcreg, AT91_PMC_PCKR(num), &pmc_cache.pckr[num]);
-	}
-
-	return 0;
+	return clk_save_context();
 }
 
-static bool pmc_ready(unsigned int mask)
+static void at91_pmc_resume(void)
 {
-	unsigned int status;
-
-	regmap_read(pmcreg, AT91_PMC_SR, &status);
-
-	return ((status & mask) == mask) ? 1 : 0;
-}
-
-static void pmc_resume(void)
-{
-	int i;
-	u8 num;
-	u32 tmp;
-	u32 mask = AT91_PMC_MCKRDY | AT91_PMC_LOCKA;
-
-	regmap_read(pmcreg, AT91_PMC_MCKR, &tmp);
-	if (pmc_cache.mckr != tmp)
-		pr_warn("MCKR was not configured properly by the firmware\n");
-	regmap_read(pmcreg, AT91_CKGR_PLLAR, &tmp);
-	if (pmc_cache.pllar != tmp)
-		pr_warn("PLLAR was not configured properly by the firmware\n");
-
-	regmap_write(pmcreg, AT91_PMC_SCER, pmc_cache.scsr);
-	regmap_write(pmcreg, AT91_PMC_PCER, pmc_cache.pcsr0);
-	regmap_write(pmcreg, AT91_CKGR_UCKR, pmc_cache.uckr);
-	regmap_write(pmcreg, AT91_CKGR_MOR, pmc_cache.mor);
-	regmap_write(pmcreg, AT91_CKGR_MCFR, pmc_cache.mcfr);
-	regmap_write(pmcreg, AT91_PMC_USB, pmc_cache.usb);
-	regmap_write(pmcreg, AT91_PMC_IMR, pmc_cache.imr);
-	regmap_write(pmcreg, AT91_PMC_PCER1, pmc_cache.pcsr1);
-
-	for (i = 0; registered_ids[i]; i++) {
-		regmap_write(pmcreg, AT91_PMC_PCR,
-			     pmc_cache.pcr[registered_ids[i]] |
-			     AT91_PMC_PCR_CMD);
-	}
-	for (i = 0; registered_pcks[i]; i++) {
-		num = registered_pcks[i] - 1;
-		regmap_write(pmcreg, AT91_PMC_PCKR(num), pmc_cache.pckr[num]);
-	}
-
-	if (pmc_cache.uckr & AT91_PMC_UPLLEN)
-		mask |= AT91_PMC_LOCKU;
-
-	while (!pmc_ready(mask))
-		cpu_relax();
+	clk_restore_context();
 }
 
 static struct syscore_ops pmc_syscore_ops = {
-	.suspend = pmc_suspend,
-	.resume = pmc_resume,
+	.suspend = at91_pmc_suspend,
+	.resume = at91_pmc_resume,
 };
 
 static const struct of_device_id sama5d2_pmc_dt_ids[] = {
@@ -265,12 +136,8 @@ static int __init pmc_register_ops(void)
 
 	np = of_find_matching_node(NULL, sama5d2_pmc_dt_ids);
 	if (!np)
-		return -ENODEV;
-
-	pmcreg = device_node_to_regmap(np);
+		return 0;
 	of_node_put(np);
-	if (IS_ERR(pmcreg))
-		return PTR_ERR(pmcreg);
 
 	register_syscore_ops(&pmc_syscore_ops);
 
diff --git a/drivers/clk/at91/pmc.h b/drivers/clk/at91/pmc.h
index a49076c804a9..86580ebd9ad9 100644
--- a/drivers/clk/at91/pmc.h
+++ b/drivers/clk/at91/pmc.h
@@ -13,6 +13,8 @@
 #include <linux/regmap.h>
 #include <linux/spinlock.h>
 
+#include <dt-bindings/clock/at91.h>
+
 extern spinlock_t pmc_pcr_lock;
 
 struct pmc_data {
@@ -98,6 +100,20 @@ struct clk_pcr_layout {
 	u32 pid_mask;
 };
 
+/**
+ * struct at91_clk_pms - Power management state for AT91 clock
+ * @status: clock status (enabled or disabled)
+ * @parent: clock parent index
+ * @parent_rate: clock parent rate
+ * @rate: clock rate
+ */
+struct at91_clk_pms {
+	unsigned int status;
+	unsigned int parent;
+	unsigned long parent_rate;
+	unsigned long rate;
+};
+
 #define field_get(_mask, _reg) (((_reg) & (_mask)) >> (ffs(_mask) - 1))
 #define field_prep(_mask, _val) (((_val) << (ffs(_mask) - 1)) & (_mask))
 
@@ -248,12 +264,4 @@ struct clk_hw * __init
 at91_clk_sama7g5_register_utmi(struct regmap *regmap, const char *name,
 			       const char *parent_name);
 
-#ifdef CONFIG_PM
-void pmc_register_id(u8 id);
-void pmc_register_pck(u8 pck);
-#else
-static inline void pmc_register_id(u8 id) {}
-static inline void pmc_register_pck(u8 pck) {}
-#endif
-
 #endif /* __PMC_H_ */
-- 
2.7.4

