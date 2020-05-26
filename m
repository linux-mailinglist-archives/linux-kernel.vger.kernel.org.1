Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C1B71C6AFC
	for <lists+linux-kernel@lfdr.de>; Wed,  6 May 2020 10:10:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728680AbgEFIJx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 May 2020 04:09:53 -0400
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:3603 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728635AbgEFIJu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 04:09:50 -0400
X-Originating-IP: 86.202.105.35
Received: from localhost (lfbn-lyo-1-9-35.w86-202.abo.wanadoo.fr [86.202.105.35])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id 7517E240006;
        Wed,  6 May 2020 08:09:47 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        kamel.bouhara@bootlin.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH v3 7/9] clocksource/drivers/timer-atmel-tcb: stop using the 32kHz for clockevents
Date:   Wed,  6 May 2020 10:05:52 +0200
Message-Id: <20200506080554.283177-8-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200506080554.283177-1-alexandre.belloni@bootlin.com>
References: <20200506080554.283177-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Stop using the slow clock as the clock source for 32 bit counters because
even at 10MHz, they are able to handle delays up to two minutes. This
provides a way better resolution.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/clocksource/timer-atmel-tcb.c | 61 ++++++++++++++-------------
 1 file changed, 32 insertions(+), 29 deletions(-)

diff --git a/drivers/clocksource/timer-atmel-tcb.c b/drivers/clocksource/timer-atmel-tcb.c
index 423af2f9835f..8fcd4d74c54b 100644
--- a/drivers/clocksource/timer-atmel-tcb.c
+++ b/drivers/clocksource/timer-atmel-tcb.c
@@ -27,9 +27,10 @@
  *   - Some chips support 32 bit counter. A single channel is used for
  *     this 32 bit free-running counter. the second channel is not used.
  *
- *   - The third channel may be used to provide a 16-bit clockevent
- *     source, used in either periodic or oneshot mode.  This runs
- *     at 32 KiHZ, and can handle delays of up to two seconds.
+ *   - The third channel may be used to provide a clockevent source, used in
+ *   either periodic or oneshot mode. For 16-bit counter its runs at 32 KiHZ,
+ *   and can handle delays of up to two seconds. For 32-bit counters, it runs at
+ *   the same rate as the clocksource
  *
  * REVISIT behavior during system suspend states... we should disable
  * all clocks and save the power.  Easily done for clockevent devices,
@@ -47,6 +48,8 @@ static struct
 } tcb_cache[3];
 static u32 bmr_cache;
 
+static const u8 atmel_tcb_divisors[] = { 2, 8, 32, 128 };
+
 static u64 tc_get_cycles(struct clocksource *cs)
 {
 	unsigned long	flags;
@@ -151,13 +154,6 @@ static struct tc_clkevt_device *to_tc_clkevt(struct clock_event_device *clkevt)
 	return container_of(clkevt, struct tc_clkevt_device, clkevt);
 }
 
-/* For now, we always use the 32K clock ... this optimizes for NO_HZ,
- * because using one of the divided clocks would usually mean the
- * tick rate can never be less than several dozen Hz (vs 0.5 Hz).
- *
- * A divided clock could be good for high resolution timers, since
- * 30.5 usec resolution can seem "low".
- */
 static u32 timer_clock;
 
 static int tc_shutdown(struct clock_event_device *d)
@@ -183,7 +179,7 @@ static int tc_set_oneshot(struct clock_event_device *d)
 
 	clk_enable(tcd->clk);
 
-	/* slow clock, count up to RC, then irq and stop */
+	/* count up to RC, then irq and stop */
 	writel(timer_clock | ATMEL_TC_CPCSTOP | ATMEL_TC_WAVE |
 		     ATMEL_TC_WAVESEL_UP_AUTO, regs + ATMEL_TC_REG(2, CMR));
 	writel(ATMEL_TC_CPCS, regs + ATMEL_TC_REG(2, IER));
@@ -205,7 +201,7 @@ static int tc_set_periodic(struct clock_event_device *d)
 	 */
 	clk_enable(tcd->clk);
 
-	/* slow clock, count up to RC, then irq and restart */
+	/* count up to RC, then irq and restart */
 	writel(timer_clock | ATMEL_TC_WAVE | ATMEL_TC_WAVESEL_UP_AUTO,
 		     regs + ATMEL_TC_REG(2, CMR));
 	writel((32768 + HZ / 2) / HZ, tcaddr + ATMEL_TC_REG(2, RC));
@@ -256,47 +252,56 @@ static irqreturn_t ch2_irq(int irq, void *handle)
 	return IRQ_NONE;
 }
 
-static int __init setup_clkevents(struct atmel_tc *tc, int clk32k_divisor_idx)
+static int __init setup_clkevents(struct atmel_tc *tc, int divisor_idx)
 {
+	u32 rate;
 	int ret;
 	struct clk *t2_clk = tc->clk[2];
 	int irq = tc->irq[2];
-
-	ret = clk_prepare_enable(tc->slow_clk);
-	if (ret)
-		return ret;
+	int bits = tc->tcb_config->counter_width;
 
 	/* try to enable t2 clk to avoid future errors in mode change */
 	ret = clk_prepare_enable(t2_clk);
-	if (ret) {
-		clk_disable_unprepare(tc->slow_clk);
+	if (ret)
 		return ret;
-	}
-
-	clk_disable(t2_clk);
 
 	clkevt.regs = tc->regs;
 	clkevt.clk = t2_clk;
 
-	timer_clock = clk32k_divisor_idx;
+	if (bits == 32) {
+		timer_clock = divisor_idx;
+		rate = clk_get_rate(t2_clk) / atmel_tcb_divisors[divisor_idx];
+	} else {
+		ret = clk_prepare_enable(tc->slow_clk);
+		if (ret) {
+			clk_disable_unprepare(t2_clk);
+			return ret;
+		}
+
+		rate = clk_get_rate(tc->slow_clk);
+		timer_clock = ATMEL_TC_TIMER_CLOCK5;
+	}
+
+	clk_disable(t2_clk);
 
 	clkevt.clkevt.cpumask = cpumask_of(0);
 
 	ret = request_irq(irq, ch2_irq, IRQF_TIMER, "tc_clkevt", &clkevt);
 	if (ret) {
 		clk_unprepare(t2_clk);
-		clk_disable_unprepare(tc->slow_clk);
+		if (bits != 32)
+			clk_disable_unprepare(tc->slow_clk);
 		return ret;
 	}
 
-	clockevents_config_and_register(&clkevt.clkevt, 32768, 1, 0xffff);
+	clockevents_config_and_register(&clkevt.clkevt, rate, 1, BIT(bits) - 1);
 
 	return ret;
 }
 
 #else /* !CONFIG_GENERIC_CLOCKEVENTS */
 
-static int __init setup_clkevents(struct atmel_tc *tc, int clk32k_divisor_idx)
+static int __init setup_clkevents(struct atmel_tc *tc, int divisor_idx)
 {
 	/* NOTHING */
 	return 0;
@@ -346,8 +351,6 @@ static void __init tcb_setup_single_chan(struct atmel_tc *tc, int mck_divisor_id
 	writel(ATMEL_TC_SYNC, tcaddr + ATMEL_TC_BCR);
 }
 
-static const u8 atmel_tcb_divisors[] = { 2, 8, 32, 128 };
-
 static struct atmel_tcb_config tcb_rm9200_config = {
 	.counter_width = 16,
 };
@@ -472,7 +475,7 @@ static int __init tcb_clksrc_init(struct device_node *node)
 		goto err_disable_t1;
 
 	/* channel 2:  periodic and oneshot timer support */
-	ret = setup_clkevents(&tc, ATMEL_TC_TIMER_CLOCK5);
+	ret = setup_clkevents(&tc, best_divisor_idx);
 	if (ret)
 		goto err_unregister_clksrc;
 
-- 
2.26.2

