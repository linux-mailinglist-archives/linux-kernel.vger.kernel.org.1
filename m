Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9075D2FD1C1
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 14:55:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389348AbhATNZ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 08:25:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:53944 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730924AbhATNRU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 08:17:20 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id DB54E23383;
        Wed, 20 Jan 2021 13:16:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611148577;
        bh=Z5roE3TIPC9Gmt8f8p1FJ/HKbpIwPxWDuiXZbbfyvW0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XrkjCNwH9W/x4DT2EpxittA4oLspU5g9Ssgi3N6XntSPd7v7Ans6BSgWurGS58ahv
         QydBHP5689rSHKrodEBEL+TjHehJ89NsaxHUio9wp8CTwvS8cCD3SKzFEXag6YSExC
         EIIx+jeamcrnFvrqZ3Ji/CjBOfToYacyDJkM1M65SOGtKhUIGoRmpX7wtVmszsdhpE
         X6RV5sehWlCIReoJUARO10xWx4vW8YVR2Tl3eCFRdYskwHd4D/MDY4FurIBAA4bqR6
         qzkkhUynBbSiZ2VB5KDPGyeXkZeuUDqkhcfdbvCAGPP2JUwuuzO/N5xjPcwJoCEk7+
         IG3AAuJ85VUCQ==
From:   Arnd Bergmann <arnd@kernel.org>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Arnd Bergmann <arnd@arndb.de>, Barry Song <baohua@kernel.org>
Subject: [PATCH 4/4] timer: remove sirf prima driver
Date:   Wed, 20 Jan 2021 14:15:59 +0100
Message-Id: <20210120131559.1971359-5-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210120131559.1971359-1-arnd@kernel.org>
References: <20210120131559.1971359-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The CSR SiRF prima2/atlas platforms are getting removed, so this driver
is no longer needed.

Cc: Barry Song <baohua@kernel.org>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/clocksource/Kconfig        |   6 -
 drivers/clocksource/Makefile       |   1 -
 drivers/clocksource/timer-prima2.c | 242 -----------------------------
 3 files changed, 249 deletions(-)
 delete mode 100644 drivers/clocksource/timer-prima2.c

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index ac6de462591a..a2d932825975 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -204,12 +204,6 @@ config MXS_TIMER
 	help
 	  Enables support for the MXS timer.
 
-config PRIMA2_TIMER
-	bool "Prima2 timer driver" if COMPILE_TEST
-	select CLKSRC_MMIO
-	help
-	  Enables support for the Prima2 timer.
-
 config NSPIRE_TIMER
 	bool "NSpire timer driver" if COMPILE_TEST
 	select CLKSRC_MMIO
diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
index 49496637700f..d6ffe3d77d7e 100644
--- a/drivers/clocksource/Makefile
+++ b/drivers/clocksource/Makefile
@@ -32,7 +32,6 @@ obj-$(CONFIG_BCM2835_TIMER)	+= bcm2835_timer.o
 obj-$(CONFIG_CLPS711X_TIMER)	+= clps711x-timer.o
 obj-$(CONFIG_MXS_TIMER)		+= mxs_timer.o
 obj-$(CONFIG_CLKSRC_PXA)	+= timer-pxa.o
-obj-$(CONFIG_PRIMA2_TIMER)	+= timer-prima2.o
 obj-$(CONFIG_SUN4I_TIMER)	+= timer-sun4i.o
 obj-$(CONFIG_SUN5I_HSTIMER)	+= timer-sun5i.o
 obj-$(CONFIG_MESON6_TIMER)	+= timer-meson6.o
diff --git a/drivers/clocksource/timer-prima2.c b/drivers/clocksource/timer-prima2.c
deleted file mode 100644
index c5d469342a9d..000000000000
--- a/drivers/clocksource/timer-prima2.c
+++ /dev/null
@@ -1,242 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/*
- * System timer for CSR SiRFprimaII
- *
- * Copyright (c) 2011 Cambridge Silicon Radio Limited, a CSR plc group company.
- */
-
-#include <linux/kernel.h>
-#include <linux/interrupt.h>
-#include <linux/clockchips.h>
-#include <linux/clocksource.h>
-#include <linux/bitops.h>
-#include <linux/irq.h>
-#include <linux/clk.h>
-#include <linux/err.h>
-#include <linux/slab.h>
-#include <linux/of.h>
-#include <linux/of_irq.h>
-#include <linux/of_address.h>
-#include <linux/sched_clock.h>
-
-#define PRIMA2_CLOCK_FREQ 1000000
-
-#define SIRFSOC_TIMER_COUNTER_LO	0x0000
-#define SIRFSOC_TIMER_COUNTER_HI	0x0004
-#define SIRFSOC_TIMER_MATCH_0		0x0008
-#define SIRFSOC_TIMER_MATCH_1		0x000C
-#define SIRFSOC_TIMER_MATCH_2		0x0010
-#define SIRFSOC_TIMER_MATCH_3		0x0014
-#define SIRFSOC_TIMER_MATCH_4		0x0018
-#define SIRFSOC_TIMER_MATCH_5		0x001C
-#define SIRFSOC_TIMER_STATUS		0x0020
-#define SIRFSOC_TIMER_INT_EN		0x0024
-#define SIRFSOC_TIMER_WATCHDOG_EN	0x0028
-#define SIRFSOC_TIMER_DIV		0x002C
-#define SIRFSOC_TIMER_LATCH		0x0030
-#define SIRFSOC_TIMER_LATCHED_LO	0x0034
-#define SIRFSOC_TIMER_LATCHED_HI	0x0038
-
-#define SIRFSOC_TIMER_WDT_INDEX		5
-
-#define SIRFSOC_TIMER_LATCH_BIT	 BIT(0)
-
-#define SIRFSOC_TIMER_REG_CNT 11
-
-static const u32 sirfsoc_timer_reg_list[SIRFSOC_TIMER_REG_CNT] = {
-	SIRFSOC_TIMER_MATCH_0, SIRFSOC_TIMER_MATCH_1, SIRFSOC_TIMER_MATCH_2,
-	SIRFSOC_TIMER_MATCH_3, SIRFSOC_TIMER_MATCH_4, SIRFSOC_TIMER_MATCH_5,
-	SIRFSOC_TIMER_INT_EN, SIRFSOC_TIMER_WATCHDOG_EN, SIRFSOC_TIMER_DIV,
-	SIRFSOC_TIMER_LATCHED_LO, SIRFSOC_TIMER_LATCHED_HI,
-};
-
-static u32 sirfsoc_timer_reg_val[SIRFSOC_TIMER_REG_CNT];
-
-static void __iomem *sirfsoc_timer_base;
-
-/* timer0 interrupt handler */
-static irqreturn_t sirfsoc_timer_interrupt(int irq, void *dev_id)
-{
-	struct clock_event_device *ce = dev_id;
-
-	WARN_ON(!(readl_relaxed(sirfsoc_timer_base + SIRFSOC_TIMER_STATUS) &
-		BIT(0)));
-
-	/* clear timer0 interrupt */
-	writel_relaxed(BIT(0), sirfsoc_timer_base + SIRFSOC_TIMER_STATUS);
-
-	ce->event_handler(ce);
-
-	return IRQ_HANDLED;
-}
-
-/* read 64-bit timer counter */
-static u64 notrace sirfsoc_timer_read(struct clocksource *cs)
-{
-	u64 cycles;
-
-	/* latch the 64-bit timer counter */
-	writel_relaxed(SIRFSOC_TIMER_LATCH_BIT,
-		sirfsoc_timer_base + SIRFSOC_TIMER_LATCH);
-	cycles = readl_relaxed(sirfsoc_timer_base + SIRFSOC_TIMER_LATCHED_HI);
-	cycles = (cycles << 32) |
-		readl_relaxed(sirfsoc_timer_base + SIRFSOC_TIMER_LATCHED_LO);
-
-	return cycles;
-}
-
-static int sirfsoc_timer_set_next_event(unsigned long delta,
-	struct clock_event_device *ce)
-{
-	unsigned long now, next;
-
-	writel_relaxed(SIRFSOC_TIMER_LATCH_BIT,
-		sirfsoc_timer_base + SIRFSOC_TIMER_LATCH);
-	now = readl_relaxed(sirfsoc_timer_base + SIRFSOC_TIMER_LATCHED_LO);
-	next = now + delta;
-	writel_relaxed(next, sirfsoc_timer_base + SIRFSOC_TIMER_MATCH_0);
-	writel_relaxed(SIRFSOC_TIMER_LATCH_BIT,
-		sirfsoc_timer_base + SIRFSOC_TIMER_LATCH);
-	now = readl_relaxed(sirfsoc_timer_base + SIRFSOC_TIMER_LATCHED_LO);
-
-	return next - now > delta ? -ETIME : 0;
-}
-
-static int sirfsoc_timer_shutdown(struct clock_event_device *evt)
-{
-	u32 val = readl_relaxed(sirfsoc_timer_base + SIRFSOC_TIMER_INT_EN);
-
-	writel_relaxed(val & ~BIT(0),
-		       sirfsoc_timer_base + SIRFSOC_TIMER_INT_EN);
-	return 0;
-}
-
-static int sirfsoc_timer_set_oneshot(struct clock_event_device *evt)
-{
-	u32 val = readl_relaxed(sirfsoc_timer_base + SIRFSOC_TIMER_INT_EN);
-
-	writel_relaxed(val | BIT(0), sirfsoc_timer_base + SIRFSOC_TIMER_INT_EN);
-	return 0;
-}
-
-static void sirfsoc_clocksource_suspend(struct clocksource *cs)
-{
-	int i;
-
-	writel_relaxed(SIRFSOC_TIMER_LATCH_BIT,
-		sirfsoc_timer_base + SIRFSOC_TIMER_LATCH);
-
-	for (i = 0; i < SIRFSOC_TIMER_REG_CNT; i++)
-		sirfsoc_timer_reg_val[i] =
-			readl_relaxed(sirfsoc_timer_base +
-				sirfsoc_timer_reg_list[i]);
-}
-
-static void sirfsoc_clocksource_resume(struct clocksource *cs)
-{
-	int i;
-
-	for (i = 0; i < SIRFSOC_TIMER_REG_CNT - 2; i++)
-		writel_relaxed(sirfsoc_timer_reg_val[i],
-			sirfsoc_timer_base + sirfsoc_timer_reg_list[i]);
-
-	writel_relaxed(sirfsoc_timer_reg_val[SIRFSOC_TIMER_REG_CNT - 2],
-		sirfsoc_timer_base + SIRFSOC_TIMER_COUNTER_LO);
-	writel_relaxed(sirfsoc_timer_reg_val[SIRFSOC_TIMER_REG_CNT - 1],
-		sirfsoc_timer_base + SIRFSOC_TIMER_COUNTER_HI);
-}
-
-static struct clock_event_device sirfsoc_clockevent = {
-	.name = "sirfsoc_clockevent",
-	.rating = 200,
-	.features = CLOCK_EVT_FEAT_ONESHOT,
-	.set_state_shutdown = sirfsoc_timer_shutdown,
-	.set_state_oneshot = sirfsoc_timer_set_oneshot,
-	.set_next_event = sirfsoc_timer_set_next_event,
-};
-
-static struct clocksource sirfsoc_clocksource = {
-	.name = "sirfsoc_clocksource",
-	.rating = 200,
-	.mask = CLOCKSOURCE_MASK(64),
-	.flags = CLOCK_SOURCE_IS_CONTINUOUS,
-	.read = sirfsoc_timer_read,
-	.suspend = sirfsoc_clocksource_suspend,
-	.resume = sirfsoc_clocksource_resume,
-};
-
-/* Overwrite weak default sched_clock with more precise one */
-static u64 notrace sirfsoc_read_sched_clock(void)
-{
-	return sirfsoc_timer_read(NULL);
-}
-
-static void __init sirfsoc_clockevent_init(void)
-{
-	sirfsoc_clockevent.cpumask = cpumask_of(0);
-	clockevents_config_and_register(&sirfsoc_clockevent, PRIMA2_CLOCK_FREQ,
-					2, -2);
-}
-
-/* initialize the kernel jiffy timer source */
-static int __init sirfsoc_prima2_timer_init(struct device_node *np)
-{
-	unsigned long rate;
-	unsigned int irq;
-	struct clk *clk;
-	int ret;
-
-	clk = of_clk_get(np, 0);
-	if (IS_ERR(clk)) {
-		pr_err("Failed to get clock\n");
-		return PTR_ERR(clk);
-	}
-
-	ret = clk_prepare_enable(clk);
-	if (ret) {
-		pr_err("Failed to enable clock\n");
-		return ret;
-	}
-
-	rate = clk_get_rate(clk);
-
-	if (rate < PRIMA2_CLOCK_FREQ || rate % PRIMA2_CLOCK_FREQ) {
-		pr_err("Invalid clock rate\n");
-		return -EINVAL;
-	}
-
-	sirfsoc_timer_base = of_iomap(np, 0);
-	if (!sirfsoc_timer_base) {
-		pr_err("unable to map timer cpu registers\n");
-		return -ENXIO;
-	}
-
-	irq = irq_of_parse_and_map(np, 0);
-
-	writel_relaxed(rate / PRIMA2_CLOCK_FREQ / 2 - 1,
-		sirfsoc_timer_base + SIRFSOC_TIMER_DIV);
-	writel_relaxed(0, sirfsoc_timer_base + SIRFSOC_TIMER_COUNTER_LO);
-	writel_relaxed(0, sirfsoc_timer_base + SIRFSOC_TIMER_COUNTER_HI);
-	writel_relaxed(BIT(0), sirfsoc_timer_base + SIRFSOC_TIMER_STATUS);
-
-	ret = clocksource_register_hz(&sirfsoc_clocksource, PRIMA2_CLOCK_FREQ);
-	if (ret) {
-		pr_err("Failed to register clocksource\n");
-		return ret;
-	}
-
-	sched_clock_register(sirfsoc_read_sched_clock, 64, PRIMA2_CLOCK_FREQ);
-
-	ret = request_irq(irq, sirfsoc_timer_interrupt, IRQF_TIMER,
-			  "sirfsoc_timer0", &sirfsoc_clockevent);
-	if (ret) {
-		pr_err("Failed to setup irq\n");
-		return ret;
-	}
-
-	sirfsoc_clockevent_init();
-
-	return 0;
-}
-TIMER_OF_DECLARE(sirfsoc_prima2_timer,
-	"sirf,prima2-tick", sirfsoc_prima2_timer_init);
-- 
2.29.2

