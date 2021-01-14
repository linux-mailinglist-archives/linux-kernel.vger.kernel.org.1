Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 633032F6417
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 16:20:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729387AbhANPRT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 10:17:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727181AbhANPRS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 10:17:18 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE82AC0613C1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 07:16:37 -0800 (PST)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1l04MS-00021z-S2; Thu, 14 Jan 2021 16:16:32 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1l04MS-00012r-Ha; Thu, 14 Jan 2021 16:16:32 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     soc@kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@pengutronix.de, linux-kernel@vger.kernel.org
Subject: [PATCH v1 3/7] clocksource: Drop unused efm32 timer code
Date:   Thu, 14 Jan 2021 16:16:26 +0100
Message-Id: <20210114151630.128830-4-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210114151630.128830-1-u.kleine-koenig@pengutronix.de>
References: <20210114151630.128830-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support for this machine was just removed, so drop the now unused timer
code, too.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/clocksource/Kconfig       |   9 -
 drivers/clocksource/Makefile      |   1 -
 drivers/clocksource/timer-efm32.c | 278 ------------------------------
 3 files changed, 288 deletions(-)
 delete mode 100644 drivers/clocksource/timer-efm32.c

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index 14c7c4712478..1416a32140c5 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -242,15 +242,6 @@ config INTEGRATOR_AP_TIMER
 	help
 	  Enables support for the Integrator-AP timer.
 
-config CLKSRC_EFM32
-	bool "Clocksource for Energy Micro's EFM32 SoCs" if !ARCH_EFM32
-	depends on OF && ARM && (ARCH_EFM32 || COMPILE_TEST)
-	select CLKSRC_MMIO
-	default ARCH_EFM32
-	help
-	  Support to use the timers of EFM32 SoCs as clock source and clock
-	  event device.
-
 config CLKSRC_LPC32XX
 	bool "Clocksource for LPC32XX" if COMPILE_TEST
 	depends on HAS_IOMEM
diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
index 3c75cbbf8533..08173383f2d9 100644
--- a/drivers/clocksource/Makefile
+++ b/drivers/clocksource/Makefile
@@ -43,7 +43,6 @@ obj-$(CONFIG_VT8500_TIMER)	+= timer-vt8500.o
 obj-$(CONFIG_NSPIRE_TIMER)	+= timer-zevio.o
 obj-$(CONFIG_BCM_KONA_TIMER)	+= bcm_kona_timer.o
 obj-$(CONFIG_CADENCE_TTC_TIMER)	+= timer-cadence-ttc.o
-obj-$(CONFIG_CLKSRC_EFM32)	+= timer-efm32.o
 obj-$(CONFIG_CLKSRC_STM32)	+= timer-stm32.o
 obj-$(CONFIG_CLKSRC_STM32_LP)	+= timer-stm32-lp.o
 obj-$(CONFIG_CLKSRC_EXYNOS_MCT)	+= exynos_mct.o
diff --git a/drivers/clocksource/timer-efm32.c b/drivers/clocksource/timer-efm32.c
deleted file mode 100644
index 441a4b916841..000000000000
--- a/drivers/clocksource/timer-efm32.c
+++ /dev/null
@@ -1,278 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * Copyright (C) 2013 Pengutronix
- * Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>
- */
-
-#define pr_fmt(fmt)	KBUILD_MODNAME ": " fmt
-
-#include <linux/kernel.h>
-#include <linux/clocksource.h>
-#include <linux/clockchips.h>
-#include <linux/irq.h>
-#include <linux/interrupt.h>
-#include <linux/of.h>
-#include <linux/of_address.h>
-#include <linux/of_irq.h>
-#include <linux/clk.h>
-
-#define TIMERn_CTRL			0x00
-#define TIMERn_CTRL_PRESC(val)			(((val) & 0xf) << 24)
-#define TIMERn_CTRL_PRESC_1024			TIMERn_CTRL_PRESC(10)
-#define TIMERn_CTRL_CLKSEL(val)			(((val) & 0x3) << 16)
-#define TIMERn_CTRL_CLKSEL_PRESCHFPERCLK	TIMERn_CTRL_CLKSEL(0)
-#define TIMERn_CTRL_OSMEN			0x00000010
-#define TIMERn_CTRL_MODE(val)			(((val) & 0x3) <<  0)
-#define TIMERn_CTRL_MODE_UP			TIMERn_CTRL_MODE(0)
-#define TIMERn_CTRL_MODE_DOWN			TIMERn_CTRL_MODE(1)
-
-#define TIMERn_CMD			0x04
-#define TIMERn_CMD_START			0x00000001
-#define TIMERn_CMD_STOP				0x00000002
-
-#define TIMERn_IEN			0x0c
-#define TIMERn_IF			0x10
-#define TIMERn_IFS			0x14
-#define TIMERn_IFC			0x18
-#define TIMERn_IRQ_UF				0x00000002
-
-#define TIMERn_TOP			0x1c
-#define TIMERn_CNT			0x24
-
-struct efm32_clock_event_ddata {
-	struct clock_event_device evtdev;
-	void __iomem *base;
-	unsigned periodic_top;
-};
-
-static int efm32_clock_event_shutdown(struct clock_event_device *evtdev)
-{
-	struct efm32_clock_event_ddata *ddata =
-		container_of(evtdev, struct efm32_clock_event_ddata, evtdev);
-
-	writel_relaxed(TIMERn_CMD_STOP, ddata->base + TIMERn_CMD);
-	return 0;
-}
-
-static int efm32_clock_event_set_oneshot(struct clock_event_device *evtdev)
-{
-	struct efm32_clock_event_ddata *ddata =
-		container_of(evtdev, struct efm32_clock_event_ddata, evtdev);
-
-	writel_relaxed(TIMERn_CMD_STOP, ddata->base + TIMERn_CMD);
-	writel_relaxed(TIMERn_CTRL_PRESC_1024 |
-		       TIMERn_CTRL_CLKSEL_PRESCHFPERCLK |
-		       TIMERn_CTRL_OSMEN |
-		       TIMERn_CTRL_MODE_DOWN,
-		       ddata->base + TIMERn_CTRL);
-	return 0;
-}
-
-static int efm32_clock_event_set_periodic(struct clock_event_device *evtdev)
-{
-	struct efm32_clock_event_ddata *ddata =
-		container_of(evtdev, struct efm32_clock_event_ddata, evtdev);
-
-	writel_relaxed(TIMERn_CMD_STOP, ddata->base + TIMERn_CMD);
-	writel_relaxed(ddata->periodic_top, ddata->base + TIMERn_TOP);
-	writel_relaxed(TIMERn_CTRL_PRESC_1024 |
-		       TIMERn_CTRL_CLKSEL_PRESCHFPERCLK |
-		       TIMERn_CTRL_MODE_DOWN,
-		       ddata->base + TIMERn_CTRL);
-	writel_relaxed(TIMERn_CMD_START, ddata->base + TIMERn_CMD);
-	return 0;
-}
-
-static int efm32_clock_event_set_next_event(unsigned long evt,
-					    struct clock_event_device *evtdev)
-{
-	struct efm32_clock_event_ddata *ddata =
-		container_of(evtdev, struct efm32_clock_event_ddata, evtdev);
-
-	writel_relaxed(TIMERn_CMD_STOP, ddata->base + TIMERn_CMD);
-	writel_relaxed(evt, ddata->base + TIMERn_CNT);
-	writel_relaxed(TIMERn_CMD_START, ddata->base + TIMERn_CMD);
-
-	return 0;
-}
-
-static irqreturn_t efm32_clock_event_handler(int irq, void *dev_id)
-{
-	struct efm32_clock_event_ddata *ddata = dev_id;
-
-	writel_relaxed(TIMERn_IRQ_UF, ddata->base + TIMERn_IFC);
-
-	ddata->evtdev.event_handler(&ddata->evtdev);
-
-	return IRQ_HANDLED;
-}
-
-static struct efm32_clock_event_ddata clock_event_ddata = {
-	.evtdev = {
-		.name = "efm32 clockevent",
-		.features = CLOCK_EVT_FEAT_ONESHOT | CLOCK_EVT_FEAT_PERIODIC,
-		.set_state_shutdown = efm32_clock_event_shutdown,
-		.set_state_periodic = efm32_clock_event_set_periodic,
-		.set_state_oneshot = efm32_clock_event_set_oneshot,
-		.set_next_event = efm32_clock_event_set_next_event,
-		.rating = 200,
-	},
-};
-
-static int __init efm32_clocksource_init(struct device_node *np)
-{
-	struct clk *clk;
-	void __iomem *base;
-	unsigned long rate;
-	int ret;
-
-	clk = of_clk_get(np, 0);
-	if (IS_ERR(clk)) {
-		ret = PTR_ERR(clk);
-		pr_err("failed to get clock for clocksource (%d)\n", ret);
-		goto err_clk_get;
-	}
-
-	ret = clk_prepare_enable(clk);
-	if (ret) {
-		pr_err("failed to enable timer clock for clocksource (%d)\n",
-		       ret);
-		goto err_clk_enable;
-	}
-	rate = clk_get_rate(clk);
-
-	base = of_iomap(np, 0);
-	if (!base) {
-		ret = -EADDRNOTAVAIL;
-		pr_err("failed to map registers for clocksource\n");
-		goto err_iomap;
-	}
-
-	writel_relaxed(TIMERn_CTRL_PRESC_1024 |
-		       TIMERn_CTRL_CLKSEL_PRESCHFPERCLK |
-		       TIMERn_CTRL_MODE_UP, base + TIMERn_CTRL);
-	writel_relaxed(TIMERn_CMD_START, base + TIMERn_CMD);
-
-	ret = clocksource_mmio_init(base + TIMERn_CNT, "efm32 timer",
-				    DIV_ROUND_CLOSEST(rate, 1024), 200, 16,
-				    clocksource_mmio_readl_up);
-	if (ret) {
-		pr_err("failed to init clocksource (%d)\n", ret);
-		goto err_clocksource_init;
-	}
-
-	return 0;
-
-err_clocksource_init:
-
-	iounmap(base);
-err_iomap:
-
-	clk_disable_unprepare(clk);
-err_clk_enable:
-
-	clk_put(clk);
-err_clk_get:
-
-	return ret;
-}
-
-static int __init efm32_clockevent_init(struct device_node *np)
-{
-	struct clk *clk;
-	void __iomem *base;
-	unsigned long rate;
-	int irq;
-	int ret;
-
-	clk = of_clk_get(np, 0);
-	if (IS_ERR(clk)) {
-		ret = PTR_ERR(clk);
-		pr_err("failed to get clock for clockevent (%d)\n", ret);
-		goto err_clk_get;
-	}
-
-	ret = clk_prepare_enable(clk);
-	if (ret) {
-		pr_err("failed to enable timer clock for clockevent (%d)\n",
-		       ret);
-		goto err_clk_enable;
-	}
-	rate = clk_get_rate(clk);
-
-	base = of_iomap(np, 0);
-	if (!base) {
-		ret = -EADDRNOTAVAIL;
-		pr_err("failed to map registers for clockevent\n");
-		goto err_iomap;
-	}
-
-	irq = irq_of_parse_and_map(np, 0);
-	if (!irq) {
-		ret = -ENOENT;
-		pr_err("failed to get irq for clockevent\n");
-		goto err_get_irq;
-	}
-
-	writel_relaxed(TIMERn_IRQ_UF, base + TIMERn_IEN);
-
-	clock_event_ddata.base = base;
-	clock_event_ddata.periodic_top = DIV_ROUND_CLOSEST(rate, 1024 * HZ);
-
-	clockevents_config_and_register(&clock_event_ddata.evtdev,
-					DIV_ROUND_CLOSEST(rate, 1024),
-					0xf, 0xffff);
-
-	ret = request_irq(irq, efm32_clock_event_handler, IRQF_TIMER,
-			  "efm32 clockevent", &clock_event_ddata);
-	if (ret) {
-		pr_err("Failed setup irq\n");
-		goto err_setup_irq;
-	}
-
-	return 0;
-
-err_setup_irq:
-err_get_irq:
-
-	iounmap(base);
-err_iomap:
-
-	clk_disable_unprepare(clk);
-err_clk_enable:
-
-	clk_put(clk);
-err_clk_get:
-
-	return ret;
-}
-
-/*
- * This function asserts that we have exactly one clocksource and one
- * clock_event_device in the end.
- */
-static int __init efm32_timer_init(struct device_node *np)
-{
-	static int has_clocksource, has_clockevent;
-	int ret = 0;
-
-	if (!has_clocksource) {
-		ret = efm32_clocksource_init(np);
-		if (!ret) {
-			has_clocksource = 1;
-			return 0;
-		}
-	}
-
-	if (!has_clockevent) {
-		ret = efm32_clockevent_init(np);
-		if (!ret) {
-			has_clockevent = 1;
-			return 0;
-		}
-	}
-
-	return ret;
-}
-TIMER_OF_DECLARE(efm32compat, "efm32,timer", efm32_timer_init);
-TIMER_OF_DECLARE(efm32, "energymicro,efm32-timer", efm32_timer_init);
-- 
2.29.2

