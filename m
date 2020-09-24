Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 153E8276CC5
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 11:06:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727422AbgIXJGV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 05:06:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727375AbgIXJGK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 05:06:10 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 850CAC0613D3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 02:06:09 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id j2so2918705wrx.7
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 02:06:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=c1C4cLl6LSRxV9W9hTi6nNQ3oWlHyh0lmagjyhT+zKY=;
        b=mm+Gb0tuR6xvKKo21M7qD199v3OW+13fNsRr/cIfowsW4vCB5um6WOC0yvTBPiRxvi
         6yOPA9L4OF+rgPzWWVn0d/cLrZN8YIikOPewm14OlE3a6BTYz82vq85ayxLqhemumqYl
         tl6dlL8m4cieNAG5hsWcU3L+zH+g+ZWyocoVAVpHCDDC4WcrqJHnvarJIlPAMEQLlWQ7
         iICVj10W9xvDCNTPh0qTYdvjB9uAwII4DNr8fdcttdU7b0kFqzS0kKnNTVLzd/WqTzia
         gCaZ7mRGaScl1l1ljnXuRoFAFUiHM99NETmM0EzUFa3IACDkhGQp0hdGAXnsi7Y5KSZp
         2yrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=c1C4cLl6LSRxV9W9hTi6nNQ3oWlHyh0lmagjyhT+zKY=;
        b=Zfix/mp/C18u1K+6BgOVhImFB2g/zlPrCoItcVRdXTBIButzL9ss+Cr7RVZb/3eaP4
         MRD85sZ04B5YtbctMBbs/4qbiHzcGnvGNzzfN4Vs+DrNKd9GYLB2+6pHZ1u5MVJQJ2kh
         SwSe3tJYEcpJWQfCgtBF3QcFS7w1br5IASWCOB9LK+xqV0N8yLXDC9RhkAgBIyMj05Fc
         VpSlvuiDaeRTJGP1NQ9vjyCPReIFEaAIuFD9y5OTgXzXqusQ2rFaLUmbY6KYQIxtMM2R
         OF1Ko3UGOeuzFH44WWmTh55zwcInO7S4EYP5+fGSS5/R7suzNpCimOtlEa58wwlZVwof
         TE8w==
X-Gm-Message-State: AOAM533/D9fEccqrs8rtdC9oix7axRhH6UlVtlc9ys+ZH1qIsetl8DT0
        BIK9WB/M8rYYpYmtJZmzLDOnkg==
X-Google-Smtp-Source: ABdhPJy7nSAm8EE2tEOYv/UpD6Owr2TlqAOk/J/2zYKR/3CBUqmCMcfafCqTzWZiTU1FY/mnMoxY1w==
X-Received: by 2002:adf:f4c6:: with SMTP id h6mr3934274wrp.310.1600938368019;
        Thu, 24 Sep 2020 02:06:08 -0700 (PDT)
Received: from mai.imgcgcw.net ([2a01:e34:ed2f:f020:11e1:db8b:493b:54f4])
        by smtp.gmail.com with ESMTPSA id h2sm2861461wrp.69.2020.09.24.02.06.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2020 02:06:07 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     tglx@linutronix.de
Cc:     Zhen Lei <thunder.leizhen@huawei.com>,
        linux-kernel@vger.kernel.org (open list:CLOCKSOURCE, CLOCKEVENT DRIVERS)
Subject: [PATCH 08/10] clocksource/drivers/sp804: Support non-standard register offset
Date:   Thu, 24 Sep 2020 11:05:32 +0200
Message-Id: <20200924090534.2004630-8-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200924090534.2004630-1-daniel.lezcano@linaro.org>
References: <1f4f3f8f-2472-44af-0536-6bc76741d276@linaro.org>
 <20200924090534.2004630-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhen Lei <thunder.leizhen@huawei.com>

The ARM SP804 supports a maximum of 32-bit counter, but Hisilicon extends
it to 64-bit. That means, the registers: TimerXload, TimerXValue and
TimerXBGLoad are 64bits, all other registers are the same as those in the
SP804. The driver code can be completely reused except that the register
offset is different.

Currently, we get a timer register address by: add the constant register
offset to the timer base address. e.g. "base + TIMER_CTRL". It can not be
dynamically adjusted at run time.

So create a new structure "sp804_timer" to record the original registers
offset, and create a new structure "sp804_clkevt" to record the
calculated registers address. So the "base + TIMER_CTRL" is changed to
"clkevt->ctrl", this will faster than "base + timer->ctrl".

For example:
	struct sp804_timer arm_sp804_timer = {
		.ctrl	= TIMER_CTRL,
	};

	struct sp804_clkevt clkevt;

	clkevt.ctrl = base + arm_sp804_timer.ctrl.

-	writel(0, base + TIMER_CTRL);
+	writel(0, clkevt->ctrl);

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20200918132237.3552-7-thunder.leizhen@huawei.com
---
 drivers/clocksource/timer-sp.h    |  26 +++++++
 drivers/clocksource/timer-sp804.c | 108 +++++++++++++++++++++++-------
 2 files changed, 108 insertions(+), 26 deletions(-)

diff --git a/drivers/clocksource/timer-sp.h b/drivers/clocksource/timer-sp.h
index b2037eb94a41..1ab75cbed0e0 100644
--- a/drivers/clocksource/timer-sp.h
+++ b/drivers/clocksource/timer-sp.h
@@ -10,6 +10,7 @@
  *
  * Every SP804 contains two identical timers.
  */
+#define NR_TIMERS	2
 #define TIMER_1_BASE	0x00
 #define TIMER_2_BASE	0x20
 
@@ -29,3 +30,28 @@
 #define TIMER_RIS	0x10			/*  CVR ro */
 #define TIMER_MIS	0x14			/*  CVR ro */
 #define TIMER_BGLOAD	0x18			/*  CVR rw */
+
+struct sp804_timer {
+	int load;
+	int value;
+	int ctrl;
+	int intclr;
+	int ris;
+	int mis;
+	int bgload;
+	int timer_base[NR_TIMERS];
+	int width;
+};
+
+struct sp804_clkevt {
+	void __iomem *base;
+	void __iomem *load;
+	void __iomem *value;
+	void __iomem *ctrl;
+	void __iomem *intclr;
+	void __iomem *ris;
+	void __iomem *mis;
+	void __iomem *bgload;
+	unsigned long reload;
+	int width;
+};
diff --git a/drivers/clocksource/timer-sp804.c b/drivers/clocksource/timer-sp804.c
index 471c5c6aaf51..5f4f979a8ef2 100644
--- a/drivers/clocksource/timer-sp804.c
+++ b/drivers/clocksource/timer-sp804.c
@@ -20,6 +20,17 @@
 
 #include "timer-sp.h"
 
+struct sp804_timer __initdata arm_sp804_timer = {
+	.load		= TIMER_LOAD,
+	.value		= TIMER_VALUE,
+	.ctrl		= TIMER_CTRL,
+	.intclr		= TIMER_INTCLR,
+	.timer_base	= {TIMER_1_BASE, TIMER_2_BASE},
+	.width		= 32,
+};
+
+static struct sp804_clkevt sp804_clkevt[NR_TIMERS];
+
 static long __init sp804_get_clock_rate(struct clk *clk, const char *name)
 {
 	long rate;
@@ -58,11 +69,26 @@ static long __init sp804_get_clock_rate(struct clk *clk, const char *name)
 	return rate;
 }
 
-static void __iomem *sched_clock_base;
+static struct sp804_clkevt * __init sp804_clkevt_get(void __iomem *base)
+{
+	int i;
+
+	for (i = 0; i < NR_TIMERS; i++) {
+		if (sp804_clkevt[i].base == base)
+			return &sp804_clkevt[i];
+	}
+
+	/* It's impossible to reach here */
+	WARN_ON(1);
+
+	return NULL;
+}
+
+static struct sp804_clkevt *sched_clkevt;
 
 static u64 notrace sp804_read(void)
 {
-	return ~readl_relaxed(sched_clock_base + TIMER_VALUE);
+	return ~readl_relaxed(sched_clkevt->value);
 }
 
 int __init sp804_clocksource_and_sched_clock_init(void __iomem *base,
@@ -71,22 +97,25 @@ int __init sp804_clocksource_and_sched_clock_init(void __iomem *base,
 						  int use_sched_clock)
 {
 	long rate;
+	struct sp804_clkevt *clkevt;
 
 	rate = sp804_get_clock_rate(clk, name);
 	if (rate < 0)
 		return -EINVAL;
 
-	writel(0, base + TIMER_CTRL);
-	writel(0xffffffff, base + TIMER_LOAD);
-	writel(0xffffffff, base + TIMER_VALUE);
+	clkevt = sp804_clkevt_get(base);
+
+	writel(0, clkevt->ctrl);
+	writel(0xffffffff, clkevt->load);
+	writel(0xffffffff, clkevt->value);
 	writel(TIMER_CTRL_32BIT | TIMER_CTRL_ENABLE | TIMER_CTRL_PERIODIC,
-		base + TIMER_CTRL);
+		clkevt->ctrl);
 
-	clocksource_mmio_init(base + TIMER_VALUE, name,
+	clocksource_mmio_init(clkevt->value, name,
 		rate, 200, 32, clocksource_mmio_readl_down);
 
 	if (use_sched_clock) {
-		sched_clock_base = base;
+		sched_clkevt = clkevt;
 		sched_clock_register(sp804_read, 32, rate);
 	}
 
@@ -94,8 +123,7 @@ int __init sp804_clocksource_and_sched_clock_init(void __iomem *base,
 }
 
 
-static void __iomem *clkevt_base;
-static unsigned long clkevt_reload;
+static struct sp804_clkevt *common_clkevt;
 
 /*
  * IRQ handler for the timer
@@ -105,7 +133,7 @@ static irqreturn_t sp804_timer_interrupt(int irq, void *dev_id)
 	struct clock_event_device *evt = dev_id;
 
 	/* clear the interrupt */
-	writel(1, clkevt_base + TIMER_INTCLR);
+	writel(1, common_clkevt->intclr);
 
 	evt->event_handler(evt);
 
@@ -114,7 +142,7 @@ static irqreturn_t sp804_timer_interrupt(int irq, void *dev_id)
 
 static inline void timer_shutdown(struct clock_event_device *evt)
 {
-	writel(0, clkevt_base + TIMER_CTRL);
+	writel(0, common_clkevt->ctrl);
 }
 
 static int sp804_shutdown(struct clock_event_device *evt)
@@ -129,8 +157,8 @@ static int sp804_set_periodic(struct clock_event_device *evt)
 			     TIMER_CTRL_PERIODIC | TIMER_CTRL_ENABLE;
 
 	timer_shutdown(evt);
-	writel(clkevt_reload, clkevt_base + TIMER_LOAD);
-	writel(ctrl, clkevt_base + TIMER_CTRL);
+	writel(common_clkevt->reload, common_clkevt->load);
+	writel(ctrl, common_clkevt->ctrl);
 	return 0;
 }
 
@@ -140,8 +168,8 @@ static int sp804_set_next_event(unsigned long next,
 	unsigned long ctrl = TIMER_CTRL_32BIT | TIMER_CTRL_IE |
 			     TIMER_CTRL_ONESHOT | TIMER_CTRL_ENABLE;
 
-	writel(next, clkevt_base + TIMER_LOAD);
-	writel(ctrl, clkevt_base + TIMER_CTRL);
+	writel(next, common_clkevt->load);
+	writel(ctrl, common_clkevt->ctrl);
 
 	return 0;
 }
@@ -168,13 +196,13 @@ int __init sp804_clockevents_init(void __iomem *base, unsigned int irq,
 	if (rate < 0)
 		return -EINVAL;
 
-	clkevt_base = base;
-	clkevt_reload = DIV_ROUND_CLOSEST(rate, HZ);
+	common_clkevt = sp804_clkevt_get(base);
+	common_clkevt->reload = DIV_ROUND_CLOSEST(rate, HZ);
 	evt->name = name;
 	evt->irq = irq;
 	evt->cpumask = cpu_possible_mask;
 
-	writel(0, base + TIMER_CTRL);
+	writel(0, common_clkevt->ctrl);
 
 	if (request_irq(irq, sp804_timer_interrupt, IRQF_TIMER | IRQF_IRQPOLL,
 			"timer", &sp804_clockevent))
@@ -184,7 +212,26 @@ int __init sp804_clockevents_init(void __iomem *base, unsigned int irq,
 	return 0;
 }
 
-static int __init sp804_of_init(struct device_node *np)
+static void __init sp804_clkevt_init(struct sp804_timer *timer, void __iomem *base)
+{
+	int i;
+
+	for (i = 0; i < NR_TIMERS; i++) {
+		void __iomem *timer_base;
+		struct sp804_clkevt *clkevt;
+
+		timer_base = base + timer->timer_base[i];
+		clkevt = &sp804_clkevt[i];
+		clkevt->base	= timer_base;
+		clkevt->load	= timer_base + timer->load;
+		clkevt->value	= timer_base + timer->value;
+		clkevt->ctrl	= timer_base + timer->ctrl;
+		clkevt->intclr	= timer_base + timer->intclr;
+		clkevt->width	= timer->width;
+	}
+}
+
+static int __init sp804_of_init(struct device_node *np, struct sp804_timer *timer)
 {
 	static bool initialized = false;
 	void __iomem *base;
@@ -199,12 +246,12 @@ static int __init sp804_of_init(struct device_node *np)
 	if (!base)
 		return -ENXIO;
 
-	timer1_base = base;
-	timer2_base = base + TIMER_2_BASE;
+	timer1_base = base + timer->timer_base[0];
+	timer2_base = base + timer->timer_base[1];
 
 	/* Ensure timers are disabled */
-	writel(0, timer1_base + TIMER_CTRL);
-	writel(0, timer2_base + TIMER_CTRL);
+	writel(0, timer1_base + timer->ctrl);
+	writel(0, timer2_base + timer->ctrl);
 
 	if (initialized || !of_device_is_available(np)) {
 		ret = -EINVAL;
@@ -230,6 +277,8 @@ static int __init sp804_of_init(struct device_node *np)
 	if (irq <= 0)
 		goto err;
 
+	sp804_clkevt_init(timer, base);
+
 	of_property_read_u32(np, "arm,sp804-has-irq", &irq_num);
 	if (irq_num == 2) {
 
@@ -259,7 +308,12 @@ static int __init sp804_of_init(struct device_node *np)
 	iounmap(base);
 	return ret;
 }
-TIMER_OF_DECLARE(sp804, "arm,sp804", sp804_of_init);
+
+static int __init arm_sp804_of_init(struct device_node *np)
+{
+	return sp804_of_init(np, &arm_sp804_timer);
+}
+TIMER_OF_DECLARE(sp804, "arm,sp804", arm_sp804_of_init);
 
 static int __init integrator_cp_of_init(struct device_node *np)
 {
@@ -282,11 +336,13 @@ static int __init integrator_cp_of_init(struct device_node *np)
 	}
 
 	/* Ensure timer is disabled */
-	writel(0, base + TIMER_CTRL);
+	writel(0, base + arm_sp804_timer.ctrl);
 
 	if (init_count == 2 || !of_device_is_available(np))
 		goto err;
 
+	sp804_clkevt_init(&arm_sp804_timer, base);
+
 	if (!init_count) {
 		ret = sp804_clocksource_and_sched_clock_init(base,
 							     name, clk, 0);
-- 
2.25.1

