Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 184E228D890
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 04:36:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728885AbgJNCgO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 22:36:14 -0400
Received: from lucky1.263xmail.com ([211.157.147.132]:33178 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726044AbgJNCgF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 22:36:05 -0400
Received: from localhost (unknown [192.168.167.32])
        by lucky1.263xmail.com (Postfix) with ESMTP id A9102EF3A8;
        Wed, 14 Oct 2020 10:28:55 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-ABS-CHECKED: 0
Received: from localhost.localdomain (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P19667T139951086470912S1602642534014047_;
        Wed, 14 Oct 2020 10:28:55 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <b1fe43c2b2aef226d2287d271475e7bf>
X-RL-SENDER: zhangqing@rock-chips.com
X-SENDER: zhangqing@rock-chips.com
X-LOGIN-NAME: zhangqing@rock-chips.com
X-FST-TO: heiko@sntech.de
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
X-System-Flag: 0
From:   Elaine Zhang <zhangqing@rock-chips.com>
To:     heiko@sntech.de
Cc:     mturquette@baylibre.com, sboyd@kernel.org,
        linux-clk@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-kernel@vger.kernel.org, xxx@rock-chips.com,
        xf@rock-chips.com, huangtao@rock-chips.com,
        kever.yang@rock-chips.com, Elaine Zhang <zhangqing@rock-chips.com>
Subject: [PATCH v4 5/5] clk: rockchip: support pll setting by auto
Date:   Wed, 14 Oct 2020 10:28:53 +0800
Message-Id: <20201014022853.7039-1-zhangqing@rock-chips.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201014022812.6733-1-zhangqing@rock-chips.com>
References: <20201014022812.6733-1-zhangqing@rock-chips.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If setting freq is not support in rockchip_pll_rate_table,
It can calculate and set pll params by auto.

Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
---
 drivers/clk/rockchip/clk-pll.c | 215 ++++++++++++++++++++++++++++++---
 1 file changed, 200 insertions(+), 15 deletions(-)

diff --git a/drivers/clk/rockchip/clk-pll.c b/drivers/clk/rockchip/clk-pll.c
index 8adc6f54a605..e8ca86f5b7d1 100644
--- a/drivers/clk/rockchip/clk-pll.c
+++ b/drivers/clk/rockchip/clk-pll.c
@@ -15,6 +15,7 @@
 #include <linux/iopoll.h>
 #include <linux/regmap.h>
 #include <linux/clk.h>
+#include <linux/gcd.h>
 #include "clk.h"
 
 #define PLL_MODE_MASK		0x3
@@ -47,6 +48,198 @@ struct rockchip_clk_pll {
 #define to_rockchip_clk_pll_nb(nb) \
 			container_of(nb, struct rockchip_clk_pll, clk_nb)
 
+#define MHZ			(1000UL * 1000UL)
+#define KHZ			(1000UL)
+
+/* CLK_PLL_TYPE_RK3066_AUTO type ops */
+#define PLL_FREF_MIN		(269 * KHZ)
+#define PLL_FREF_MAX		(2200 * MHZ)
+
+#define PLL_FVCO_MIN		(440 * MHZ)
+#define PLL_FVCO_MAX		(2200 * MHZ)
+
+#define PLL_FOUT_MIN		(27500 * KHZ)
+#define PLL_FOUT_MAX		(2200 * MHZ)
+
+#define PLL_NF_MAX		(4096)
+#define PLL_NR_MAX		(64)
+#define PLL_NO_MAX		(16)
+
+/* CLK_PLL_TYPE_RK3036/3366/3399_AUTO type ops */
+#define MIN_FOUTVCO_FREQ	(800 * MHZ)
+#define MAX_FOUTVCO_FREQ	(2000 * MHZ)
+
+static struct rockchip_pll_rate_table auto_table;
+
+static struct rockchip_pll_rate_table *rk_pll_rate_table_get(void)
+{
+	return &auto_table;
+}
+
+static int rockchip_pll_clk_set_postdiv(unsigned long fout_hz,
+					u32 *postdiv1,
+					u32 *postdiv2,
+					u32 *foutvco)
+{
+	unsigned long freq;
+
+	if (fout_hz < MIN_FOUTVCO_FREQ) {
+		for (*postdiv1 = 1; *postdiv1 <= 7; (*postdiv1)++) {
+			for (*postdiv2 = 1; *postdiv2 <= 7; (*postdiv2)++) {
+				freq = fout_hz * (*postdiv1) * (*postdiv2);
+				if (freq >= MIN_FOUTVCO_FREQ &&
+				    freq <= MAX_FOUTVCO_FREQ) {
+					*foutvco = freq;
+					return 0;
+				}
+			}
+		}
+		pr_err("CANNOT FIND postdiv1/2 to make fout in range from 800M to 2000M,fout = %lu\n",
+		       fout_hz);
+	} else {
+		*postdiv1 = 1;
+		*postdiv2 = 1;
+	}
+	return 0;
+}
+
+static struct rockchip_pll_rate_table *
+rockchip_pll_clk_set_by_auto(struct rockchip_clk_pll *pll,
+			     unsigned long fin_hz,
+			     unsigned long fout_hz)
+{
+	struct rockchip_pll_rate_table *rate_table = rk_pll_rate_table_get();
+	/* FIXME set postdiv1/2 always 1*/
+	u32 foutvco = fout_hz;
+	u64 fin_64, frac_64;
+	u32 f_frac, postdiv1, postdiv2;
+	unsigned long clk_gcd = 0;
+
+	if (fin_hz == 0 || fout_hz == 0 || fout_hz == fin_hz)
+		return NULL;
+
+	rockchip_pll_clk_set_postdiv(fout_hz, &postdiv1, &postdiv2, &foutvco);
+	rate_table->postdiv1 = postdiv1;
+	rate_table->postdiv2 = postdiv2;
+	rate_table->dsmpd = 1;
+
+	if (fin_hz / MHZ * MHZ == fin_hz && fout_hz / MHZ * MHZ == fout_hz) {
+		fin_hz /= MHZ;
+		foutvco /= MHZ;
+		clk_gcd = gcd(fin_hz, foutvco);
+		rate_table->refdiv = fin_hz / clk_gcd;
+		rate_table->fbdiv = foutvco / clk_gcd;
+
+		rate_table->frac = 0;
+
+		pr_debug("fin = %lu, fout = %lu, clk_gcd = %lu, refdiv = %u, fbdiv = %u, postdiv1 = %u, postdiv2 = %u, frac = %u\n",
+			 fin_hz, fout_hz, clk_gcd, rate_table->refdiv,
+			 rate_table->fbdiv, rate_table->postdiv1,
+			 rate_table->postdiv2, rate_table->frac);
+	} else {
+		pr_debug("frac div running, fin_hz = %lu, fout_hz = %lu, fin_INT_mhz = %lu, fout_INT_mhz = %lu\n",
+			 fin_hz, fout_hz,
+			 fin_hz / MHZ * MHZ,
+			 fout_hz / MHZ * MHZ);
+		pr_debug("frac get postdiv1 = %u,  postdiv2 = %u, foutvco = %u\n",
+			 rate_table->postdiv1, rate_table->postdiv2, foutvco);
+		clk_gcd = gcd(fin_hz / MHZ, foutvco / MHZ);
+		rate_table->refdiv = fin_hz / MHZ / clk_gcd;
+		rate_table->fbdiv = foutvco / MHZ / clk_gcd;
+		pr_debug("frac get refdiv = %u,  fbdiv = %u\n",
+			 rate_table->refdiv, rate_table->fbdiv);
+
+		rate_table->frac = 0;
+
+		f_frac = (foutvco % MHZ);
+		fin_64 = fin_hz;
+		do_div(fin_64, (u64)rate_table->refdiv);
+		frac_64 = (u64)f_frac << 24;
+		do_div(frac_64, fin_64);
+		rate_table->frac = (u32)frac_64;
+		if (rate_table->frac > 0)
+			rate_table->dsmpd = 0;
+		pr_debug("frac = %x\n", rate_table->frac);
+	}
+	return rate_table;
+}
+
+static struct rockchip_pll_rate_table *
+rockchip_rk3066_pll_clk_set_by_auto(struct rockchip_clk_pll *pll,
+				    unsigned long fin_hz,
+				    unsigned long fout_hz)
+{
+	struct rockchip_pll_rate_table *rate_table = rk_pll_rate_table_get();
+	u32 nr, nf, no, nonr;
+	u32 nr_out, nf_out, no_out;
+	u32 n;
+	u32 numerator, denominator;
+	u64 fref, fvco, fout;
+	unsigned long clk_gcd = 0;
+
+	nr_out = PLL_NR_MAX + 1;
+	no_out = 0;
+	nf_out = 0;
+
+	if (fin_hz == 0 || fout_hz == 0 || fout_hz == fin_hz)
+		return NULL;
+
+	clk_gcd = gcd(fin_hz, fout_hz);
+
+	numerator = fout_hz / clk_gcd;
+	denominator = fin_hz / clk_gcd;
+
+	for (n = 1;; n++) {
+		nf = numerator * n;
+		nonr = denominator * n;
+		if (nf > PLL_NF_MAX || nonr > (PLL_NO_MAX * PLL_NR_MAX))
+			break;
+
+		for (no = 1; no <= PLL_NO_MAX; no++) {
+			if (!(no == 1 || !(no % 2)))
+				continue;
+
+			if (nonr % no)
+				continue;
+			nr = nonr / no;
+
+			if (nr > PLL_NR_MAX)
+				continue;
+
+			fref = fin_hz / nr;
+			if (fref < PLL_FREF_MIN || fref > PLL_FREF_MAX)
+				continue;
+
+			fvco = fref * nf;
+			if (fvco < PLL_FVCO_MIN || fvco > PLL_FVCO_MAX)
+				continue;
+
+			fout = fvco / no;
+			if (fout < PLL_FOUT_MIN || fout > PLL_FOUT_MAX)
+				continue;
+
+			/* select the best from all available PLL settings */
+			if ((no > no_out) ||
+			    ((no == no_out) && (nr < nr_out))) {
+				nr_out = nr;
+				nf_out = nf;
+				no_out = no;
+			}
+		}
+	}
+
+	/* output the best PLL setting */
+	if ((nr_out <= PLL_NR_MAX) && (no_out > 0)) {
+		rate_table->nr = nr_out;
+		rate_table->nf = nf_out;
+		rate_table->no = no_out;
+	} else {
+		return NULL;
+	}
+
+	return rate_table;
+}
+
 static const struct rockchip_pll_rate_table *rockchip_get_pll_settings(
 			    struct rockchip_clk_pll *pll, unsigned long rate)
 {
@@ -58,24 +251,16 @@ static const struct rockchip_pll_rate_table *rockchip_get_pll_settings(
 			return &rate_table[i];
 	}
 
-	return NULL;
+	if (pll->type == pll_rk3066)
+		return rockchip_rk3066_pll_clk_set_by_auto(pll, 24 * MHZ, rate);
+	else
+		return rockchip_pll_clk_set_by_auto(pll, 24 * MHZ, rate);
 }
 
 static long rockchip_pll_round_rate(struct clk_hw *hw,
 			    unsigned long drate, unsigned long *prate)
 {
-	struct rockchip_clk_pll *pll = to_rockchip_clk_pll(hw);
-	const struct rockchip_pll_rate_table *rate_table = pll->rate_table;
-	int i;
-
-	/* Assumming rate_table is in descending order */
-	for (i = 0; i < pll->rate_count; i++) {
-		if (drate >= rate_table[i].rate)
-			return rate_table[i].rate;
-	}
-
-	/* return minimum supported value */
-	return rate_table[i - 1].rate;
+	return drate;
 }
 
 /*
@@ -165,7 +350,7 @@ static unsigned long rockchip_rk3036_pll_recalc_rate(struct clk_hw *hw,
 {
 	struct rockchip_clk_pll *pll = to_rockchip_clk_pll(hw);
 	struct rockchip_pll_rate_table cur;
-	u64 rate64 = prate;
+	u64 rate64 = prate, frac_rate64 = prate;
 
 	rockchip_rk3036_pll_get_params(pll, &cur);
 
@@ -174,7 +359,7 @@ static unsigned long rockchip_rk3036_pll_recalc_rate(struct clk_hw *hw,
 
 	if (cur.dsmpd == 0) {
 		/* fractional mode */
-		u64 frac_rate64 = prate * cur.frac;
+		frac_rate64 *= cur.frac;
 
 		do_div(frac_rate64, cur.refdiv);
 		rate64 += frac_rate64 >> 24;
-- 
2.17.1



