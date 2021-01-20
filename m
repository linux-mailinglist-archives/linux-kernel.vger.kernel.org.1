Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C86C02FD1BC
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 14:55:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388473AbhATNZW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 08:25:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:53918 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730131AbhATNRT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 08:17:19 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2FD462339D;
        Wed, 20 Jan 2021 13:16:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611148573;
        bh=Jdpl5KFdkR/9KAmD8YJewd6d0wpTmXMLG20c3vcQFS4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Jwcp0Hb4rOaEuoH1DbiiZumYE5REdhKjaKlKh3CfpWQfj0OHGQfi8ETodBpnVVxWY
         SGUELJ99ARv08b0PVvRfP/TcsJKZl0+RWewofOtXey/EWkPrlmNMVsgjI7KeMW2iW+
         jRAJeEoslxjvHZm7YCbM2CTYPIh5W032kwuwk1y8PwTqHYve00fZrT27B1b3jMSt84
         llmufNMxMdgLrv41BOFbV2/OgPivJJgCSnQcJWxbNFzdI23JDkQBx31kQa15TjdP/b
         dqYSLfIKvYvdbz1T6ffognTkQWhi7RMzAmN3VJ8ohGG5M4C1Lx3HXao2uwVIpobh2g
         7PjDqccPAhVHQ==
From:   Arnd Bergmann <arnd@kernel.org>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Mans Rullgard <mans@mansr.com>
Subject: [PATCH 2/4] timer: remove tango driver
Date:   Wed, 20 Jan 2021 14:15:57 +0100
Message-Id: <20210120131559.1971359-3-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210120131559.1971359-1-arnd@kernel.org>
References: <20210120131559.1971359-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The tango platform is getting removed, so the driver is no
longer needed.

Cc: Marc Gonzalez <marc.w.gonzalez@free.fr>
Cc: Mans Rullgard <mans@mansr.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/clocksource/Kconfig            |  8 ----
 drivers/clocksource/Makefile           |  1 -
 drivers/clocksource/timer-tango-xtal.c | 57 --------------------------
 3 files changed, 66 deletions(-)
 delete mode 100644 drivers/clocksource/timer-tango-xtal.c

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index 824a0f6b77d4..1feadd067677 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -560,14 +560,6 @@ config CLKSRC_MIPS_GIC
 	select CLOCKSOURCE_WATCHDOG
 	select TIMER_OF
 
-config CLKSRC_TANGO_XTAL
-	bool "Clocksource for Tango SoC" if COMPILE_TEST
-	depends on ARM
-	select TIMER_OF
-	select CLKSRC_MMIO
-	help
-	  This enables the clocksource for Tango SoC.
-
 config CLKSRC_PXA
 	bool "Clocksource for PXA or SA-11x0 platform" if COMPILE_TEST
 	depends on HAS_IOMEM
diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
index 41c154478a1a..1089f2ed8560 100644
--- a/drivers/clocksource/Makefile
+++ b/drivers/clocksource/Makefile
@@ -72,7 +72,6 @@ obj-$(CONFIG_KEYSTONE_TIMER)		+= timer-keystone.o
 obj-$(CONFIG_INTEGRATOR_AP_TIMER)	+= timer-integrator-ap.o
 obj-$(CONFIG_CLKSRC_VERSATILE)		+= timer-versatile.o
 obj-$(CONFIG_CLKSRC_MIPS_GIC)		+= mips-gic-timer.o
-obj-$(CONFIG_CLKSRC_TANGO_XTAL)		+= timer-tango-xtal.o
 obj-$(CONFIG_CLKSRC_IMX_GPT)		+= timer-imx-gpt.o
 obj-$(CONFIG_CLKSRC_IMX_TPM)		+= timer-imx-tpm.o
 obj-$(CONFIG_TIMER_IMX_SYS_CTR)		+= timer-imx-sysctr.o
diff --git a/drivers/clocksource/timer-tango-xtal.c b/drivers/clocksource/timer-tango-xtal.c
deleted file mode 100644
index 3f94e454ef99..000000000000
--- a/drivers/clocksource/timer-tango-xtal.c
+++ /dev/null
@@ -1,57 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-#include <linux/clocksource.h>
-#include <linux/sched_clock.h>
-#include <linux/of_address.h>
-#include <linux/printk.h>
-#include <linux/delay.h>
-#include <linux/init.h>
-#include <linux/clk.h>
-
-static void __iomem *xtal_in_cnt;
-static struct delay_timer delay_timer;
-
-static unsigned long notrace read_xtal_counter(void)
-{
-	return readl_relaxed(xtal_in_cnt);
-}
-
-static u64 notrace read_sched_clock(void)
-{
-	return read_xtal_counter();
-}
-
-static int __init tango_clocksource_init(struct device_node *np)
-{
-	struct clk *clk;
-	int xtal_freq, ret;
-
-	xtal_in_cnt = of_iomap(np, 0);
-	if (xtal_in_cnt == NULL) {
-		pr_err("%pOF: invalid address\n", np);
-		return -ENXIO;
-	}
-
-	clk = of_clk_get(np, 0);
-	if (IS_ERR(clk)) {
-		pr_err("%pOF: invalid clock\n", np);
-		return PTR_ERR(clk);
-	}
-
-	xtal_freq = clk_get_rate(clk);
-	delay_timer.freq = xtal_freq;
-	delay_timer.read_current_timer = read_xtal_counter;
-
-	ret = clocksource_mmio_init(xtal_in_cnt, "tango-xtal", xtal_freq, 350,
-				    32, clocksource_mmio_readl_up);
-	if (ret) {
-		pr_err("%pOF: registration failed\n", np);
-		return ret;
-	}
-
-	sched_clock_register(read_sched_clock, 32, xtal_freq);
-	register_current_timer_delay(&delay_timer);
-
-	return 0;
-}
-
-TIMER_OF_DECLARE(tango, "sigma,tick-counter", tango_clocksource_init);
-- 
2.29.2

