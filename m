Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C40C128B564
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 15:00:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728854AbgJLNAQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 09:00:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728392AbgJLNAN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 09:00:13 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 991CDC0613D0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 06:00:12 -0700 (PDT)
Date:   Mon, 12 Oct 2020 12:59:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1602507611;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=9lZQJw1xogyUZubSNwQkju6fZi0lUjk4QJrDZIJMWT0=;
        b=0A/8AdpyPc4YIUgjkjIWh3RulKV190HO7UzJJzp282pcVls+Z5ojpCsqtridXinh4YLQsN
        EkK4jKBuzFDu7qnH4zL50o4EUARVM5ykETlICrIOQzKefBmdbCxM3TT3PfBgBmaqFQxoYy
        rDrNPUoGStEiVI8w5+U+KBUQZZuWfKViUl0SaP/K6p58e1ADqo0HyBDq4YqoM1giS5qXtU
        2Anw+g1+bMDPl0nr5gyKhMOtE+ckjvqFapPK6SmK4Mf6BzMhhOqiFx65Ymp3q3fYa9g6sz
        C3QDP6okXvtrVOx8G1NwVy0XHXttuVm17QeuVudBiSp9RXA5adSFvXZPEnGu4w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1602507611;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=9lZQJw1xogyUZubSNwQkju6fZi0lUjk4QJrDZIJMWT0=;
        b=+sjxJfKqjC2rmiD1Qf6GBVUf6gzC8dJRsFIwj8G6BVHn8DNKdUolcoSwzRYSPg+MvYLDV/
        hcDV/q7hJAy9y+Ag==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] timers/core for 5.10-rc1
References: <160250758161.26264.880601562259119308.tglx@nanos>
Message-ID: <160250758404.26264.2443446427592733269.tglx@nanos>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest timers/core branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-core-2020-10-12

up to:  1b80043ed218: clocksource/drivers/armada-370-xp: Use semicolons rather than commas to separate statements

Updates for timekeeping, timers and related drivers:

 Core:

  - Early boot support for the NMI safe timekeeper by utilizing
    local_clock() up to the point where timekeeping is initialized. This
    allows printk() to store multiple timestamps in the ringbuffer which is
    useful for coordinating dmesg information across a fleet of machines.

  - Provide a multi-timestamp accessor for printk()

  - Make timer init more robust by checking for invalid timer flags.

  - Comma vs. semicolon fixes

 Drivers:
 
  - Support for new platforms in existing drivers (SP804 and Renesas CMT)

  - Comma vs. semicolon fixes

Thanks,

	tglx

------------------>
Julia Lawall (2):
      clocksource/drivers/mps2-timer: Use semicolons rather than commas to separate statements
      clocksource/drivers/armada-370-xp: Use semicolons rather than commas to separate statements

Kefeng Wang (1):
      clocksource/drivers/sp804: Cleanup clk_get_sys()

Lad Prabhakar (2):
      dt-bindings: timer: renesas,cmt: Document r8a7742 CMT support
      dt-bindings: timer: renesas,cmt: Document r8a774e1 CMT support

Qianli Zhao (1):
      timers: Mask invalid flags in do_init_timer()

Thomas Gleixner (2):
      timekeeping: Utilize local_clock() for NMI safe timekeeper during early boot
      timekeeping: Provide multi-timestamp accessor to NMI safe timekeeper

Xu Wang (1):
      alarmtimer: Convert comma to semicolon

Zhen Lei (7):
      clocksource/drivers/sp804: Remove unused sp804_timer_disable() and timer-sp804.h
      clocksource/drivers/sp804: Delete the leading "__" of some functions
      clocksource/drivers/sp804: Remove a mismatched comment
      clocksource/drivers/sp804: Prepare for support non-standard register offset
      clocksource/drivers/sp804: Support non-standard register offset
      clocksource/drivers/sp804: Add support for Hisilicon sp804 timer
      clocksource/drivers/sp804: Enable Hisilicon sp804 timer 64bit mode


 .../devicetree/bindings/timer/renesas,cmt.yaml     |   4 +
 drivers/clocksource/mps2-timer.c                   |   6 +-
 drivers/clocksource/timer-armada-370-xp.c          |   8 +-
 drivers/clocksource/timer-sp.h                     |  32 ++++
 drivers/clocksource/timer-sp804.c                  | 210 ++++++++++++++-------
 include/clocksource/timer-sp804.h                  |  29 ---
 include/linux/timekeeping.h                        |  15 ++
 include/linux/timer.h                              |   1 +
 kernel/time/alarmtimer.c                           |   2 +-
 kernel/time/timekeeping.c                          | 109 +++++++++--
 kernel/time/timer.c                                |   2 +
 11 files changed, 299 insertions(+), 119 deletions(-)
 delete mode 100644 include/clocksource/timer-sp804.h

diff --git a/Documentation/devicetree/bindings/timer/renesas,cmt.yaml b/Documentation/devicetree/bindings/timer/renesas,cmt.yaml
index 7e4dc5623da8..428db3a21bb9 100644
--- a/Documentation/devicetree/bindings/timer/renesas,cmt.yaml
+++ b/Documentation/devicetree/bindings/timer/renesas,cmt.yaml
@@ -39,6 +39,7 @@ properties:
       - items:
           - enum:
               - renesas,r8a73a4-cmt0      # 32-bit CMT0 on R-Mobile APE6
+              - renesas,r8a7742-cmt0      # 32-bit CMT0 on RZ/G1H
               - renesas,r8a7743-cmt0      # 32-bit CMT0 on RZ/G1M
               - renesas,r8a7744-cmt0      # 32-bit CMT0 on RZ/G1N
               - renesas,r8a7745-cmt0      # 32-bit CMT0 on RZ/G1E
@@ -53,6 +54,7 @@ properties:
       - items:
           - enum:
               - renesas,r8a73a4-cmt1      # 48-bit CMT1 on R-Mobile APE6
+              - renesas,r8a7742-cmt1      # 48-bit CMT1 on RZ/G1H
               - renesas,r8a7743-cmt1      # 48-bit CMT1 on RZ/G1M
               - renesas,r8a7744-cmt1      # 48-bit CMT1 on RZ/G1N
               - renesas,r8a7745-cmt1      # 48-bit CMT1 on RZ/G1E
@@ -69,6 +71,7 @@ properties:
               - renesas,r8a774a1-cmt0     # 32-bit CMT0 on RZ/G2M
               - renesas,r8a774b1-cmt0     # 32-bit CMT0 on RZ/G2N
               - renesas,r8a774c0-cmt0     # 32-bit CMT0 on RZ/G2E
+              - renesas,r8a774e1-cmt0     # 32-bit CMT0 on RZ/G2H
               - renesas,r8a7795-cmt0      # 32-bit CMT0 on R-Car H3
               - renesas,r8a7796-cmt0      # 32-bit CMT0 on R-Car M3-W
               - renesas,r8a77965-cmt0     # 32-bit CMT0 on R-Car M3-N
@@ -83,6 +86,7 @@ properties:
               - renesas,r8a774a1-cmt1     # 48-bit CMT on RZ/G2M
               - renesas,r8a774b1-cmt1     # 48-bit CMT on RZ/G2N
               - renesas,r8a774c0-cmt1     # 48-bit CMT on RZ/G2E
+              - renesas,r8a774e1-cmt1     # 48-bit CMT on RZ/G2H
               - renesas,r8a7795-cmt1      # 48-bit CMT on R-Car H3
               - renesas,r8a7796-cmt1      # 48-bit CMT on R-Car M3-W
               - renesas,r8a77965-cmt1     # 48-bit CMT on R-Car M3-N
diff --git a/drivers/clocksource/mps2-timer.c b/drivers/clocksource/mps2-timer.c
index 2e64d984c83a..efe8cad8f2a5 100644
--- a/drivers/clocksource/mps2-timer.c
+++ b/drivers/clocksource/mps2-timer.c
@@ -149,9 +149,9 @@ static int __init mps2_clockevent_init(struct device_node *np)
 	ce->clkevt.rating = 200;
 	ce->clkevt.features = CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT;
 	ce->clkevt.cpumask = cpu_possible_mask;
-	ce->clkevt.set_state_shutdown	= mps2_timer_shutdown,
-	ce->clkevt.set_state_periodic	= mps2_timer_set_periodic,
-	ce->clkevt.set_state_oneshot	= mps2_timer_shutdown,
+	ce->clkevt.set_state_shutdown	= mps2_timer_shutdown;
+	ce->clkevt.set_state_periodic	= mps2_timer_set_periodic;
+	ce->clkevt.set_state_oneshot	= mps2_timer_shutdown;
 	ce->clkevt.set_next_event	= mps2_timer_set_next_event;
 
 	/* Ensure timer is disabled */
diff --git a/drivers/clocksource/timer-armada-370-xp.c b/drivers/clocksource/timer-armada-370-xp.c
index edf1a46269f1..e3acc3c631b7 100644
--- a/drivers/clocksource/timer-armada-370-xp.c
+++ b/drivers/clocksource/timer-armada-370-xp.c
@@ -181,12 +181,12 @@ static int armada_370_xp_timer_starting_cpu(unsigned int cpu)
 		clr = TIMER0_25MHZ;
 	local_timer_ctrl_clrset(clr, set);
 
-	evt->name		= "armada_370_xp_per_cpu_tick",
+	evt->name		= "armada_370_xp_per_cpu_tick";
 	evt->features		= CLOCK_EVT_FEAT_ONESHOT |
 				  CLOCK_EVT_FEAT_PERIODIC;
-	evt->shift		= 32,
-	evt->rating		= 300,
-	evt->set_next_event	= armada_370_xp_clkevt_next_event,
+	evt->shift		= 32;
+	evt->rating		= 300;
+	evt->set_next_event	= armada_370_xp_clkevt_next_event;
 	evt->set_state_shutdown	= armada_370_xp_clkevt_shutdown;
 	evt->set_state_periodic	= armada_370_xp_clkevt_set_periodic;
 	evt->set_state_oneshot	= armada_370_xp_clkevt_shutdown;
diff --git a/drivers/clocksource/timer-sp.h b/drivers/clocksource/timer-sp.h
index b2037eb94a41..811f840be0e5 100644
--- a/drivers/clocksource/timer-sp.h
+++ b/drivers/clocksource/timer-sp.h
@@ -10,6 +10,7 @@
  *
  * Every SP804 contains two identical timers.
  */
+#define NR_TIMERS	2
 #define TIMER_1_BASE	0x00
 #define TIMER_2_BASE	0x20
 
@@ -29,3 +30,34 @@
 #define TIMER_RIS	0x10			/*  CVR ro */
 #define TIMER_MIS	0x14			/*  CVR ro */
 #define TIMER_BGLOAD	0x18			/*  CVR rw */
+
+struct sp804_timer {
+	int load;
+	int load_h;
+	int value;
+	int value_h;
+	int ctrl;
+	int intclr;
+	int ris;
+	int mis;
+	int bgload;
+	int bgload_h;
+	int timer_base[NR_TIMERS];
+	int width;
+};
+
+struct sp804_clkevt {
+	void __iomem *base;
+	void __iomem *load;
+	void __iomem *load_h;
+	void __iomem *value;
+	void __iomem *value_h;
+	void __iomem *ctrl;
+	void __iomem *intclr;
+	void __iomem *ris;
+	void __iomem *mis;
+	void __iomem *bgload;
+	void __iomem *bgload_h;
+	unsigned long reload;
+	int width;
+};
diff --git a/drivers/clocksource/timer-sp804.c b/drivers/clocksource/timer-sp804.c
index 5cd0abf9b396..6e8ad4a4ea3c 100644
--- a/drivers/clocksource/timer-sp804.c
+++ b/drivers/clocksource/timer-sp804.c
@@ -18,15 +18,57 @@
 #include <linux/of_irq.h>
 #include <linux/sched_clock.h>
 
-#include <clocksource/timer-sp804.h>
-
 #include "timer-sp.h"
 
-static long __init sp804_get_clock_rate(struct clk *clk)
+/* Hisilicon 64-bit timer(a variant of ARM SP804) */
+#define HISI_TIMER_1_BASE	0x00
+#define HISI_TIMER_2_BASE	0x40
+#define HISI_TIMER_LOAD		0x00
+#define HISI_TIMER_LOAD_H	0x04
+#define HISI_TIMER_VALUE	0x08
+#define HISI_TIMER_VALUE_H	0x0c
+#define HISI_TIMER_CTRL		0x10
+#define HISI_TIMER_INTCLR	0x14
+#define HISI_TIMER_RIS		0x18
+#define HISI_TIMER_MIS		0x1c
+#define HISI_TIMER_BGLOAD	0x20
+#define HISI_TIMER_BGLOAD_H	0x24
+
+
+struct sp804_timer __initdata arm_sp804_timer = {
+	.load		= TIMER_LOAD,
+	.value		= TIMER_VALUE,
+	.ctrl		= TIMER_CTRL,
+	.intclr		= TIMER_INTCLR,
+	.timer_base	= {TIMER_1_BASE, TIMER_2_BASE},
+	.width		= 32,
+};
+
+struct sp804_timer __initdata hisi_sp804_timer = {
+	.load		= HISI_TIMER_LOAD,
+	.load_h		= HISI_TIMER_LOAD_H,
+	.value		= HISI_TIMER_VALUE,
+	.value_h	= HISI_TIMER_VALUE_H,
+	.ctrl		= HISI_TIMER_CTRL,
+	.intclr		= HISI_TIMER_INTCLR,
+	.timer_base	= {HISI_TIMER_1_BASE, HISI_TIMER_2_BASE},
+	.width		= 64,
+};
+
+static struct sp804_clkevt sp804_clkevt[NR_TIMERS];
+
+static long __init sp804_get_clock_rate(struct clk *clk, const char *name)
 {
 	long rate;
 	int err;
 
+	if (!clk)
+		clk = clk_get_sys("sp804", name);
+	if (IS_ERR(clk)) {
+		pr_err("sp804: %s clock not found: %ld\n", name, PTR_ERR(clk));
+		return PTR_ERR(clk);
+	}
+
 	err = clk_prepare(clk);
 	if (err) {
 		pr_err("sp804: clock failed to prepare: %d\n", err);
@@ -53,50 +95,57 @@ static long __init sp804_get_clock_rate(struct clk *clk)
 	return rate;
 }
 
-static void __iomem *sched_clock_base;
-
-static u64 notrace sp804_read(void)
+static struct sp804_clkevt * __init sp804_clkevt_get(void __iomem *base)
 {
-	return ~readl_relaxed(sched_clock_base + TIMER_VALUE);
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
 }
 
-void __init sp804_timer_disable(void __iomem *base)
+static struct sp804_clkevt *sched_clkevt;
+
+static u64 notrace sp804_read(void)
 {
-	writel(0, base + TIMER_CTRL);
+	return ~readl_relaxed(sched_clkevt->value);
 }
 
-int  __init __sp804_clocksource_and_sched_clock_init(void __iomem *base,
-						     const char *name,
-						     struct clk *clk,
-						     int use_sched_clock)
+int __init sp804_clocksource_and_sched_clock_init(void __iomem *base,
+						  const char *name,
+						  struct clk *clk,
+						  int use_sched_clock)
 {
 	long rate;
+	struct sp804_clkevt *clkevt;
 
-	if (!clk) {
-		clk = clk_get_sys("sp804", name);
-		if (IS_ERR(clk)) {
-			pr_err("sp804: clock not found: %d\n",
-			       (int)PTR_ERR(clk));
-			return PTR_ERR(clk);
-		}
-	}
-
-	rate = sp804_get_clock_rate(clk);
+	rate = sp804_get_clock_rate(clk, name);
 	if (rate < 0)
 		return -EINVAL;
 
-	/* setup timer 0 as free-running clocksource */
-	writel(0, base + TIMER_CTRL);
-	writel(0xffffffff, base + TIMER_LOAD);
-	writel(0xffffffff, base + TIMER_VALUE);
+	clkevt = sp804_clkevt_get(base);
+
+	writel(0, clkevt->ctrl);
+	writel(0xffffffff, clkevt->load);
+	writel(0xffffffff, clkevt->value);
+	if (clkevt->width == 64) {
+		writel(0xffffffff, clkevt->load_h);
+		writel(0xffffffff, clkevt->value_h);
+	}
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
 
@@ -104,8 +153,7 @@ int  __init __sp804_clocksource_and_sched_clock_init(void __iomem *base,
 }
 
 
-static void __iomem *clkevt_base;
-static unsigned long clkevt_reload;
+static struct sp804_clkevt *common_clkevt;
 
 /*
  * IRQ handler for the timer
@@ -115,7 +163,7 @@ static irqreturn_t sp804_timer_interrupt(int irq, void *dev_id)
 	struct clock_event_device *evt = dev_id;
 
 	/* clear the interrupt */
-	writel(1, clkevt_base + TIMER_INTCLR);
+	writel(1, common_clkevt->intclr);
 
 	evt->event_handler(evt);
 
@@ -124,7 +172,7 @@ static irqreturn_t sp804_timer_interrupt(int irq, void *dev_id)
 
 static inline void timer_shutdown(struct clock_event_device *evt)
 {
-	writel(0, clkevt_base + TIMER_CTRL);
+	writel(0, common_clkevt->ctrl);
 }
 
 static int sp804_shutdown(struct clock_event_device *evt)
@@ -139,8 +187,8 @@ static int sp804_set_periodic(struct clock_event_device *evt)
 			     TIMER_CTRL_PERIODIC | TIMER_CTRL_ENABLE;
 
 	timer_shutdown(evt);
-	writel(clkevt_reload, clkevt_base + TIMER_LOAD);
-	writel(ctrl, clkevt_base + TIMER_CTRL);
+	writel(common_clkevt->reload, common_clkevt->load);
+	writel(ctrl, common_clkevt->ctrl);
 	return 0;
 }
 
@@ -150,8 +198,8 @@ static int sp804_set_next_event(unsigned long next,
 	unsigned long ctrl = TIMER_CTRL_32BIT | TIMER_CTRL_IE |
 			     TIMER_CTRL_ONESHOT | TIMER_CTRL_ENABLE;
 
-	writel(next, clkevt_base + TIMER_LOAD);
-	writel(ctrl, clkevt_base + TIMER_CTRL);
+	writel(next, common_clkevt->load);
+	writel(ctrl, common_clkevt->ctrl);
 
 	return 0;
 }
@@ -168,30 +216,23 @@ static struct clock_event_device sp804_clockevent = {
 	.rating			= 300,
 };
 
-int __init __sp804_clockevents_init(void __iomem *base, unsigned int irq, struct clk *clk, const char *name)
+int __init sp804_clockevents_init(void __iomem *base, unsigned int irq,
+				  struct clk *clk, const char *name)
 {
 	struct clock_event_device *evt = &sp804_clockevent;
 	long rate;
 
-	if (!clk)
-		clk = clk_get_sys("sp804", name);
-	if (IS_ERR(clk)) {
-		pr_err("sp804: %s clock not found: %d\n", name,
-			(int)PTR_ERR(clk));
-		return PTR_ERR(clk);
-	}
-
-	rate = sp804_get_clock_rate(clk);
+	rate = sp804_get_clock_rate(clk, name);
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
@@ -201,10 +242,33 @@ int __init __sp804_clockevents_init(void __iomem *base, unsigned int irq, struct
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
+		clkevt->load_h	= timer_base + timer->load_h;
+		clkevt->value	= timer_base + timer->value;
+		clkevt->value_h	= timer_base + timer->value_h;
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
+	void __iomem *timer1_base;
+	void __iomem *timer2_base;
 	int irq, ret = -EINVAL;
 	u32 irq_num = 0;
 	struct clk *clk1, *clk2;
@@ -214,9 +278,12 @@ static int __init sp804_of_init(struct device_node *np)
 	if (!base)
 		return -ENXIO;
 
+	timer1_base = base + timer->timer_base[0];
+	timer2_base = base + timer->timer_base[1];
+
 	/* Ensure timers are disabled */
-	writel(0, base + TIMER_CTRL);
-	writel(0, base + TIMER_2_BASE + TIMER_CTRL);
+	writel(0, timer1_base + timer->ctrl);
+	writel(0, timer2_base + timer->ctrl);
 
 	if (initialized || !of_device_is_available(np)) {
 		ret = -EINVAL;
@@ -242,24 +309,27 @@ static int __init sp804_of_init(struct device_node *np)
 	if (irq <= 0)
 		goto err;
 
+	sp804_clkevt_init(timer, base);
+
 	of_property_read_u32(np, "arm,sp804-has-irq", &irq_num);
 	if (irq_num == 2) {
 
-		ret = __sp804_clockevents_init(base + TIMER_2_BASE, irq, clk2, name);
+		ret = sp804_clockevents_init(timer2_base, irq, clk2, name);
 		if (ret)
 			goto err;
 
-		ret = __sp804_clocksource_and_sched_clock_init(base, name, clk1, 1);
+		ret = sp804_clocksource_and_sched_clock_init(timer1_base,
+							     name, clk1, 1);
 		if (ret)
 			goto err;
 	} else {
 
-		ret = __sp804_clockevents_init(base, irq, clk1 , name);
+		ret = sp804_clockevents_init(timer1_base, irq, clk1, name);
 		if (ret)
 			goto err;
 
-		ret =__sp804_clocksource_and_sched_clock_init(base + TIMER_2_BASE,
-							      name, clk2, 1);
+		ret = sp804_clocksource_and_sched_clock_init(timer2_base,
+							     name, clk2, 1);
 		if (ret)
 			goto err;
 	}
@@ -270,7 +340,18 @@ static int __init sp804_of_init(struct device_node *np)
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
+
+static int __init hisi_sp804_of_init(struct device_node *np)
+{
+	return sp804_of_init(np, &hisi_sp804_timer);
+}
+TIMER_OF_DECLARE(hisi_sp804, "hisilicon,sp804", hisi_sp804_of_init);
 
 static int __init integrator_cp_of_init(struct device_node *np)
 {
@@ -293,13 +374,16 @@ static int __init integrator_cp_of_init(struct device_node *np)
 	}
 
 	/* Ensure timer is disabled */
-	writel(0, base + TIMER_CTRL);
+	writel(0, base + arm_sp804_timer.ctrl);
 
 	if (init_count == 2 || !of_device_is_available(np))
 		goto err;
 
+	sp804_clkevt_init(&arm_sp804_timer, base);
+
 	if (!init_count) {
-		ret = __sp804_clocksource_and_sched_clock_init(base, name, clk, 0);
+		ret = sp804_clocksource_and_sched_clock_init(base,
+							     name, clk, 0);
 		if (ret)
 			goto err;
 	} else {
@@ -307,7 +391,7 @@ static int __init integrator_cp_of_init(struct device_node *np)
 		if (irq <= 0)
 			goto err;
 
-		ret = __sp804_clockevents_init(base, irq, clk, name);
+		ret = sp804_clockevents_init(base, irq, clk, name);
 		if (ret)
 			goto err;
 	}
diff --git a/include/clocksource/timer-sp804.h b/include/clocksource/timer-sp804.h
deleted file mode 100644
index a5b41f31a1c2..000000000000
--- a/include/clocksource/timer-sp804.h
+++ /dev/null
@@ -1,29 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef __CLKSOURCE_TIMER_SP804_H
-#define __CLKSOURCE_TIMER_SP804_H
-
-struct clk;
-
-int __sp804_clocksource_and_sched_clock_init(void __iomem *,
-					     const char *, struct clk *, int);
-int __sp804_clockevents_init(void __iomem *, unsigned int,
-			     struct clk *, const char *);
-void sp804_timer_disable(void __iomem *);
-
-static inline void sp804_clocksource_init(void __iomem *base, const char *name)
-{
-	__sp804_clocksource_and_sched_clock_init(base, name, NULL, 0);
-}
-
-static inline void sp804_clocksource_and_sched_clock_init(void __iomem *base,
-							  const char *name)
-{
-	__sp804_clocksource_and_sched_clock_init(base, name, NULL, 1);
-}
-
-static inline void sp804_clockevents_init(void __iomem *base, unsigned int irq, const char *name)
-{
-	__sp804_clockevents_init(base, irq, NULL, name);
-
-}
-#endif
diff --git a/include/linux/timekeeping.h b/include/linux/timekeeping.h
index d5471d6fa778..7f7e4a3f4394 100644
--- a/include/linux/timekeeping.h
+++ b/include/linux/timekeeping.h
@@ -222,6 +222,18 @@ extern bool timekeeping_rtc_skipresume(void);
 
 extern void timekeeping_inject_sleeptime64(const struct timespec64 *delta);
 
+/*
+ * struct ktime_timestanps - Simultaneous mono/boot/real timestamps
+ * @mono:	Monotonic timestamp
+ * @boot:	Boottime timestamp
+ * @real:	Realtime timestamp
+ */
+struct ktime_timestamps {
+	u64		mono;
+	u64		boot;
+	u64		real;
+};
+
 /**
  * struct system_time_snapshot - simultaneous raw/real time capture with
  *				 counter value
@@ -280,6 +292,9 @@ extern int get_device_system_crosststamp(
  */
 extern void ktime_get_snapshot(struct system_time_snapshot *systime_snapshot);
 
+/* NMI safe mono/boot/realtime timestamps */
+extern void ktime_get_fast_timestamps(struct ktime_timestamps *snap);
+
 /*
  * Persistent clock related interfaces
  */
diff --git a/include/linux/timer.h b/include/linux/timer.h
index 07910ae5ddd9..d10bc7e73b41 100644
--- a/include/linux/timer.h
+++ b/include/linux/timer.h
@@ -67,6 +67,7 @@ struct timer_list {
 #define TIMER_DEFERRABLE	0x00080000
 #define TIMER_PINNED		0x00100000
 #define TIMER_IRQSAFE		0x00200000
+#define TIMER_INIT_FLAGS	(TIMER_DEFERRABLE | TIMER_PINNED | TIMER_IRQSAFE)
 #define TIMER_ARRAYSHIFT	22
 #define TIMER_ARRAYMASK		0xFFC00000
 
diff --git a/kernel/time/alarmtimer.c b/kernel/time/alarmtimer.c
index ca223a89530a..f4ace1bf8382 100644
--- a/kernel/time/alarmtimer.c
+++ b/kernel/time/alarmtimer.c
@@ -908,7 +908,7 @@ static int __init alarmtimer_init(void)
 	/* Initialize alarm bases */
 	alarm_bases[ALARM_REALTIME].base_clockid = CLOCK_REALTIME;
 	alarm_bases[ALARM_REALTIME].get_ktime = &ktime_get_real;
-	alarm_bases[ALARM_REALTIME].get_timespec = ktime_get_real_ts64,
+	alarm_bases[ALARM_REALTIME].get_timespec = ktime_get_real_ts64;
 	alarm_bases[ALARM_BOOTTIME].base_clockid = CLOCK_BOOTTIME;
 	alarm_bases[ALARM_BOOTTIME].get_ktime = &ktime_get_boottime;
 	alarm_bases[ALARM_BOOTTIME].get_timespec = get_boottime_timespec;
diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index 4c47f388a83f..ba7657685e22 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -54,6 +54,9 @@ static struct {
 
 static struct timekeeper shadow_timekeeper;
 
+/* flag for if timekeeping is suspended */
+int __read_mostly timekeeping_suspended;
+
 /**
  * struct tk_fast - NMI safe timekeeper
  * @seq:	Sequence counter for protecting updates. The lowest bit
@@ -73,28 +76,42 @@ static u64 cycles_at_suspend;
 
 static u64 dummy_clock_read(struct clocksource *cs)
 {
-	return cycles_at_suspend;
+	if (timekeeping_suspended)
+		return cycles_at_suspend;
+	return local_clock();
 }
 
 static struct clocksource dummy_clock = {
 	.read = dummy_clock_read,
 };
 
+/*
+ * Boot time initialization which allows local_clock() to be utilized
+ * during early boot when clocksources are not available. local_clock()
+ * returns nanoseconds already so no conversion is required, hence mult=1
+ * and shift=0. When the first proper clocksource is installed then
+ * the fast time keepers are updated with the correct values.
+ */
+#define FAST_TK_INIT						\
+	{							\
+		.clock		= &dummy_clock,			\
+		.mask		= CLOCKSOURCE_MASK(64),		\
+		.mult		= 1,				\
+		.shift		= 0,				\
+	}
+
 static struct tk_fast tk_fast_mono ____cacheline_aligned = {
 	.seq     = SEQCNT_RAW_SPINLOCK_ZERO(tk_fast_mono.seq, &timekeeper_lock),
-	.base[0] = { .clock = &dummy_clock, },
-	.base[1] = { .clock = &dummy_clock, },
+	.base[0] = FAST_TK_INIT,
+	.base[1] = FAST_TK_INIT,
 };
 
 static struct tk_fast tk_fast_raw  ____cacheline_aligned = {
 	.seq     = SEQCNT_RAW_SPINLOCK_ZERO(tk_fast_raw.seq, &timekeeper_lock),
-	.base[0] = { .clock = &dummy_clock, },
-	.base[1] = { .clock = &dummy_clock, },
+	.base[0] = FAST_TK_INIT,
+	.base[1] = FAST_TK_INIT,
 };
 
-/* flag for if timekeeping is suspended */
-int __read_mostly timekeeping_suspended;
-
 static inline void tk_normalize_xtime(struct timekeeper *tk)
 {
 	while (tk->tkr_mono.xtime_nsec >= ((u64)NSEC_PER_SEC << tk->tkr_mono.shift)) {
@@ -513,29 +530,29 @@ u64 notrace ktime_get_boot_fast_ns(void)
 }
 EXPORT_SYMBOL_GPL(ktime_get_boot_fast_ns);
 
-
 /*
  * See comment for __ktime_get_fast_ns() vs. timestamp ordering
  */
-static __always_inline u64 __ktime_get_real_fast_ns(struct tk_fast *tkf)
+static __always_inline u64 __ktime_get_real_fast(struct tk_fast *tkf, u64 *mono)
 {
 	struct tk_read_base *tkr;
+	u64 basem, baser, delta;
 	unsigned int seq;
-	u64 now;
 
 	do {
 		seq = raw_read_seqcount_latch(&tkf->seq);
 		tkr = tkf->base + (seq & 0x01);
-		now = ktime_to_ns(tkr->base_real);
+		basem = ktime_to_ns(tkr->base);
+		baser = ktime_to_ns(tkr->base_real);
 
-		now += timekeeping_delta_to_ns(tkr,
-				clocksource_delta(
-					tk_clock_read(tkr),
-					tkr->cycle_last,
-					tkr->mask));
+		delta = timekeeping_delta_to_ns(tkr,
+				clocksource_delta(tk_clock_read(tkr),
+				tkr->cycle_last, tkr->mask));
 	} while (read_seqcount_retry(&tkf->seq, seq));
 
-	return now;
+	if (mono)
+		*mono = basem + delta;
+	return baser + delta;
 }
 
 /**
@@ -543,10 +560,64 @@ static __always_inline u64 __ktime_get_real_fast_ns(struct tk_fast *tkf)
  */
 u64 ktime_get_real_fast_ns(void)
 {
-	return __ktime_get_real_fast_ns(&tk_fast_mono);
+	return __ktime_get_real_fast(&tk_fast_mono, NULL);
 }
 EXPORT_SYMBOL_GPL(ktime_get_real_fast_ns);
 
+/**
+ * ktime_get_fast_timestamps: - NMI safe timestamps
+ * @snapshot:	Pointer to timestamp storage
+ *
+ * Stores clock monotonic, boottime and realtime timestamps.
+ *
+ * Boot time is a racy access on 32bit systems if the sleep time injection
+ * happens late during resume and not in timekeeping_resume(). That could
+ * be avoided by expanding struct tk_read_base with boot offset for 32bit
+ * and adding more overhead to the update. As this is a hard to observe
+ * once per resume event which can be filtered with reasonable effort using
+ * the accurate mono/real timestamps, it's probably not worth the trouble.
+ *
+ * Aside of that it might be possible on 32 and 64 bit to observe the
+ * following when the sleep time injection happens late:
+ *
+ * CPU 0				CPU 1
+ * timekeeping_resume()
+ * ktime_get_fast_timestamps()
+ *	mono, real = __ktime_get_real_fast()
+ *					inject_sleep_time()
+ *					   update boot offset
+ *	boot = mono + bootoffset;
+ *
+ * That means that boot time already has the sleep time adjustment, but
+ * real time does not. On the next readout both are in sync again.
+ *
+ * Preventing this for 64bit is not really feasible without destroying the
+ * careful cache layout of the timekeeper because the sequence count and
+ * struct tk_read_base would then need two cache lines instead of one.
+ *
+ * Access to the time keeper clock source is disabled accross the innermost
+ * steps of suspend/resume. The accessors still work, but the timestamps
+ * are frozen until time keeping is resumed which happens very early.
+ *
+ * For regular suspend/resume there is no observable difference vs. sched
+ * clock, but it might affect some of the nasty low level debug printks.
+ *
+ * OTOH, access to sched clock is not guaranteed accross suspend/resume on
+ * all systems either so it depends on the hardware in use.
+ *
+ * If that turns out to be a real problem then this could be mitigated by
+ * using sched clock in a similar way as during early boot. But it's not as
+ * trivial as on early boot because it needs some careful protection
+ * against the clock monotonic timestamp jumping backwards on resume.
+ */
+void ktime_get_fast_timestamps(struct ktime_timestamps *snapshot)
+{
+	struct timekeeper *tk = &tk_core.timekeeper;
+
+	snapshot->real = __ktime_get_real_fast(&tk_fast_mono, &snapshot->mono);
+	snapshot->boot = snapshot->mono + ktime_to_ns(data_race(tk->offs_boot));
+}
+
 /**
  * halt_fast_timekeeper - Prevent fast timekeeper from accessing clocksource.
  * @tk: Timekeeper to snapshot.
diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index a16764b0116e..25e048d0e660 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -794,6 +794,8 @@ static void do_init_timer(struct timer_list *timer,
 {
 	timer->entry.pprev = NULL;
 	timer->function = func;
+	if (WARN_ON_ONCE(flags & ~TIMER_INIT_FLAGS))
+		flags &= TIMER_INIT_FLAGS;
 	timer->flags = flags | raw_smp_processor_id();
 	lockdep_init_map(&timer->lockdep_map, name, key, 0);
 }

