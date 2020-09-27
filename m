Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C14027A185
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Sep 2020 17:07:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726314AbgI0PHW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Sep 2020 11:07:22 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:39450 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726196AbgI0PHW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Sep 2020 11:07:22 -0400
Date:   Sun, 27 Sep 2020 15:06:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1601219240;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=Fl8JFJ4gRkBMYg+KBqqcn30Ipo0kiNAnbl7YILaEPsM=;
        b=I+xuK3+rKuvKJIk2tlvzV5/QsXItECFYsE4Y4aP5KaY54z7KW4+0MsSBSPb2K7KuL5/aku
        jpDH9hn+Gfny4SWU2+EGtxRmWIRjRJ/SxFpc7iqnczZxno6Rcdu5c2gNchW7Bm0sdNYFzq
        RLTZpfFF8xIbLzT9wHCOh4krEw+jA4J72EiM66/dtSsdlcNqF8d34uZUN3TMPRzsrx3FBp
        yTAtzGzxt/kK2kp6flhyRMRCEv8HZfvYgKRur5rfAfs89SScVvKRGI1a8x+Qi4qEalSfdz
        I5cMoX617ECZIPVwXAdmfyrx4uczGkTUnPIILoWqE3AD2MituHav04BXwbcJcw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1601219240;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=Fl8JFJ4gRkBMYg+KBqqcn30Ipo0kiNAnbl7YILaEPsM=;
        b=+rdUb4PpEw/En+VFHiGAWICwI8rTXbpsP0AwrTy4nhn0WyfPpcOeR7FQmbWF3mwcwz9IY1
        0ELZ16U+9HmfxIDA==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] timers/urgent for for
Message-ID: <160121921194.23623.5568205948074131939.tglx@nanos>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest timers/urgent branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-urgent-2020-09-27

up to:  a7b6c0feda15: Merge tag 'timers-v5.9-rc4' of https://git.linaro.org/people/daniel.lezcano/linux into timers/urgent

A set of clocksource/clockevents updates:

 - Reset the TI/DM timer before enabling it instead of doing it the other
   way round.

 - Initialize the reload value for the GX6605s timer correctly so the
   hardware counter starts at 0 again after overrun.

 - Make error return value negative in the h8300 timer init function

Thanks,

	tglx

------------------>
Guo Ren (1):
      clocksource/drivers/timer-gx6605s: Fixup counter reload

Tianjia Zhang (1):
      clocksource/drivers/h8300_timer8: Fix wrong return value in h8300_8timer_init()

Tony Lindgren (1):
      clocksource/drivers/timer-ti-dm: Do reset before enable


 drivers/clocksource/h8300_timer8.c         |  2 +-
 drivers/clocksource/timer-gx6605s.c        |  1 +
 drivers/clocksource/timer-ti-dm-systimer.c | 44 ++++++++++++++++--------------
 3 files changed, 25 insertions(+), 22 deletions(-)

diff --git a/drivers/clocksource/h8300_timer8.c b/drivers/clocksource/h8300_timer8.c
index 1d740a8c42ab..47114c2a7cb5 100644
--- a/drivers/clocksource/h8300_timer8.c
+++ b/drivers/clocksource/h8300_timer8.c
@@ -169,7 +169,7 @@ static int __init h8300_8timer_init(struct device_node *node)
 		return PTR_ERR(clk);
 	}
 
-	ret = ENXIO;
+	ret = -ENXIO;
 	base = of_iomap(node, 0);
 	if (!base) {
 		pr_err("failed to map registers for clockevent\n");
diff --git a/drivers/clocksource/timer-gx6605s.c b/drivers/clocksource/timer-gx6605s.c
index 80d0939d040b..8d386adbe800 100644
--- a/drivers/clocksource/timer-gx6605s.c
+++ b/drivers/clocksource/timer-gx6605s.c
@@ -28,6 +28,7 @@ static irqreturn_t gx6605s_timer_interrupt(int irq, void *dev)
 	void __iomem *base = timer_of_base(to_timer_of(ce));
 
 	writel_relaxed(GX6605S_STATUS_CLR, base + TIMER_STATUS);
+	writel_relaxed(0, base + TIMER_INI);
 
 	ce->event_handler(ce);
 
diff --git a/drivers/clocksource/timer-ti-dm-systimer.c b/drivers/clocksource/timer-ti-dm-systimer.c
index f6fd1c1cc527..33b3e8aa2cc5 100644
--- a/drivers/clocksource/timer-ti-dm-systimer.c
+++ b/drivers/clocksource/timer-ti-dm-systimer.c
@@ -69,12 +69,33 @@ static bool dmtimer_systimer_revision1(struct dmtimer_systimer *t)
 	return !(tidr >> 16);
 }
 
+static void dmtimer_systimer_enable(struct dmtimer_systimer *t)
+{
+	u32 val;
+
+	if (dmtimer_systimer_revision1(t))
+		val = DMTIMER_TYPE1_ENABLE;
+	else
+		val = DMTIMER_TYPE2_ENABLE;
+
+	writel_relaxed(val, t->base + t->sysc);
+}
+
+static void dmtimer_systimer_disable(struct dmtimer_systimer *t)
+{
+	if (!dmtimer_systimer_revision1(t))
+		return;
+
+	writel_relaxed(DMTIMER_TYPE1_DISABLE, t->base + t->sysc);
+}
+
 static int __init dmtimer_systimer_type1_reset(struct dmtimer_systimer *t)
 {
 	void __iomem *syss = t->base + OMAP_TIMER_V1_SYS_STAT_OFFSET;
 	int ret;
 	u32 l;
 
+	dmtimer_systimer_enable(t);
 	writel_relaxed(BIT(1) | BIT(2), t->base + t->ifctrl);
 	ret = readl_poll_timeout_atomic(syss, l, l & BIT(0), 100,
 					DMTIMER_RESET_WAIT);
@@ -88,6 +109,7 @@ static int __init dmtimer_systimer_type2_reset(struct dmtimer_systimer *t)
 	void __iomem *sysc = t->base + t->sysc;
 	u32 l;
 
+	dmtimer_systimer_enable(t);
 	l = readl_relaxed(sysc);
 	l |= BIT(0);
 	writel_relaxed(l, sysc);
@@ -336,26 +358,6 @@ static int __init dmtimer_systimer_init_clock(struct dmtimer_systimer *t,
 	return 0;
 }
 
-static void dmtimer_systimer_enable(struct dmtimer_systimer *t)
-{
-	u32 val;
-
-	if (dmtimer_systimer_revision1(t))
-		val = DMTIMER_TYPE1_ENABLE;
-	else
-		val = DMTIMER_TYPE2_ENABLE;
-
-	writel_relaxed(val, t->base + t->sysc);
-}
-
-static void dmtimer_systimer_disable(struct dmtimer_systimer *t)
-{
-	if (!dmtimer_systimer_revision1(t))
-		return;
-
-	writel_relaxed(DMTIMER_TYPE1_DISABLE, t->base + t->sysc);
-}
-
 static int __init dmtimer_systimer_setup(struct device_node *np,
 					 struct dmtimer_systimer *t)
 {
@@ -409,8 +411,8 @@ static int __init dmtimer_systimer_setup(struct device_node *np,
 	t->wakeup = regbase + _OMAP_TIMER_WAKEUP_EN_OFFSET;
 	t->ifctrl = regbase + _OMAP_TIMER_IF_CTRL_OFFSET;
 
-	dmtimer_systimer_enable(t);
 	dmtimer_systimer_reset(t);
+	dmtimer_systimer_enable(t);
 	pr_debug("dmtimer rev %08x sysc %08x\n", readl_relaxed(t->base),
 		 readl_relaxed(t->base + t->sysc));
 

