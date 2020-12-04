Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCFE22CF0DA
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 16:39:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730522AbgLDPhh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 10:37:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:39804 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727570AbgLDPhg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 10:37:36 -0500
From:   Dinh Nguyen <dinguyen@kernel.org>
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     daniel.lezcano@linaro.org
Cc:     dinguyen@kernel.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, Jisheng.Zhang@synaptics.com, arnd@arndb.de
Subject: [PATCHv2] clocksource: dw_apb_timer_of: add error handling if no clock available
Date:   Fri,  4 Dec 2020 09:36:43 -0600
Message-Id: <20201204153643.129897-1-dinguyen@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit ("b0fc70ce1f02 arm64: berlin: Select DW_APB_TIMER_OF") added the
support for the dw_apb_timer into the arm64 defconfig. However, for some
platforms like the Intel Stratix10 and Agilex, the clock manager doesn't
get loaded until after the timer driver get loaded. Thus, the driver hits
the panic "No clock nor clock-frequency property for" because it cannot
properly get the clock.

This patch adds the error handling needed for the timer driver so that
the kernel can continue booting instead of just hitting the panic.

Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
---
v2: address comments from Daniel Lezcano
    update commit message
---
 drivers/clocksource/dw_apb_timer_of.c | 60 ++++++++++++++++++---------
 1 file changed, 41 insertions(+), 19 deletions(-)

diff --git a/drivers/clocksource/dw_apb_timer_of.c b/drivers/clocksource/dw_apb_timer_of.c
index ab3ddebe8344..809f4c9327f9 100644
--- a/drivers/clocksource/dw_apb_timer_of.c
+++ b/drivers/clocksource/dw_apb_timer_of.c
@@ -14,12 +14,13 @@
 #include <linux/reset.h>
 #include <linux/sched_clock.h>
 
-static void __init timer_get_base_and_rate(struct device_node *np,
+static int __init timer_get_base_and_rate(struct device_node *np,
 				    void __iomem **base, u32 *rate)
 {
 	struct clk *timer_clk;
 	struct clk *pclk;
 	struct reset_control *rstc;
+	int ret;
 
 	*base = of_iomap(np, 0);
 
@@ -46,55 +47,68 @@ static void __init timer_get_base_and_rate(struct device_node *np,
 			pr_warn("pclk for %pOFn is present, but could not be activated\n",
 				np);
 
+	if (!of_property_read_u32(np, "clock-freq", rate) &&
+	    !of_property_read_u32(np, "clock-frequency", rate))
+		return 0;
+
 	timer_clk = of_clk_get_by_name(np, "timer");
-	if (IS_ERR(timer_clk))
-		goto try_clock_freq;
+	ret = PTR_ERR(timer_clk);
+	if (ret)
+		return ret;
 
-	if (!clk_prepare_enable(timer_clk)) {
-		*rate = clk_get_rate(timer_clk);
-		return;
-	}
+	ret = clk_prepare_enable(timer_clk);
+	if (ret)
+		return ret;
+
+	*rate = clk_get_rate(timer_clk);
+	if (!(*rate))
+		return -EINVAL;
 
-try_clock_freq:
-	if (of_property_read_u32(np, "clock-freq", rate) &&
-	    of_property_read_u32(np, "clock-frequency", rate))
-		panic("No clock nor clock-frequency property for %pOFn", np);
+	return 0;
 }
 
-static void __init add_clockevent(struct device_node *event_timer)
+static int __init add_clockevent(struct device_node *event_timer)
 {
 	void __iomem *iobase;
 	struct dw_apb_clock_event_device *ced;
 	u32 irq, rate;
+	int ret = 0;
 
 	irq = irq_of_parse_and_map(event_timer, 0);
 	if (irq == 0)
 		panic("No IRQ for clock event timer");
 
-	timer_get_base_and_rate(event_timer, &iobase, &rate);
+	ret = timer_get_base_and_rate(event_timer, &iobase, &rate);
+	if (ret)
+		return ret;
 
 	ced = dw_apb_clockevent_init(-1, event_timer->name, 300, iobase, irq,
 				     rate);
 	if (!ced)
-		panic("Unable to initialise clockevent device");
+		return -EINVAL;
 
 	dw_apb_clockevent_register(ced);
+
+	return 0;
 }
 
 static void __iomem *sched_io_base;
 static u32 sched_rate;
 
-static void __init add_clocksource(struct device_node *source_timer)
+static int __init add_clocksource(struct device_node *source_timer)
 {
 	void __iomem *iobase;
 	struct dw_apb_clocksource *cs;
 	u32 rate;
+	int ret;
 
-	timer_get_base_and_rate(source_timer, &iobase, &rate);
+	ret = timer_get_base_and_rate(source_timer, &iobase, &rate);
+	if (ret)
+		return ret;
 
 	cs = dw_apb_clocksource_init(300, source_timer->name, iobase, rate);
 	if (!cs)
-		panic("Unable to initialise clocksource device");
+		return -EINVAL;
 
 	dw_apb_clocksource_start(cs);
 	dw_apb_clocksource_register(cs);
@@ -106,6 +120,8 @@ static void __init add_clocksource(struct device_node *source_timer)
 	 */
 	sched_io_base = iobase + 0x04;
 	sched_rate = rate;
+
+	return 0;
 }
 
 static u64 notrace read_sched_clock(void)
@@ -146,10 +162,14 @@ static struct delay_timer dw_apb_delay_timer = {
 static int num_called;
 static int __init dw_apb_timer_init(struct device_node *timer)
 {
+	int ret = 0;
+
 	switch (num_called) {
 	case 1:
 		pr_debug("%s: found clocksource timer\n", __func__);
-		add_clocksource(timer);
+		ret = add_clocksource(timer);
+		if (ret)
+			return ret;
 		init_sched_clock();
 #ifdef CONFIG_ARM
 		dw_apb_delay_timer.freq = sched_rate;
@@ -158,7 +178,9 @@ static int __init dw_apb_timer_init(struct device_node *timer)
 		break;
 	default:
 		pr_debug("%s: found clockevent timer\n", __func__);
-		add_clockevent(timer);
+		ret = add_clockevent(timer);
+		if (ret)
+			return ret;
 		break;
 	}
 
-- 
2.25.1

