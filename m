Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6E592E7694
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Dec 2020 07:33:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726602AbgL3Gae (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Dec 2020 01:30:34 -0500
Received: from mga09.intel.com ([134.134.136.24]:5563 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726189AbgL3Gad (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Dec 2020 01:30:33 -0500
IronPort-SDR: 44qaucBZoKWqUWpOKOzxaA6g12buhClGQtfrLDi2BgT+gaCnspKiRCLGp4GR7Rx7xzbMWrIG9Z
 dCxzjxqYev0A==
X-IronPort-AV: E=McAfee;i="6000,8403,9849"; a="176728439"
X-IronPort-AV: E=Sophos;i="5.78,460,1599548400"; 
   d="scan'208";a="176728439"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2020 22:29:51 -0800
IronPort-SDR: yd5W+M3ZisLqcVzsQuPQ4Wuldq+0+VXS8Q57uWEZkYtFKRnVtCSWf0LbU86yPG0JRmIuFx+K88
 Oq2bQsZwdn7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,460,1599548400"; 
   d="scan'208";a="460372538"
Received: from ubuntu18.png.intel.com ([10.88.229.38])
  by fmsmga001.fm.intel.com with ESMTP; 29 Dec 2020 22:29:41 -0800
From:   vijayakannan.ayyathurai@intel.com
To:     daniel.lezcano@linaro.org, tglx@linutronix.de, robh+dt@kernel.org,
        catalin.marinas@arm.com, will@kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        andriy.shevchenko@linux.intel.com, mgross@linux.intel.com,
        wan.ahmad.zainie.wan.mohamad@intel.com,
        lakshmi.bai.raja.subramanian@intel.com, chen.yong.seow@intel.com,
        vijayakannan.ayyathurai@intel.com
Subject: [PATCH v2 2/2] clocksource: Add Intel Keem Bay Timer Support
Date:   Wed, 30 Dec 2020 14:25:27 +0800
Message-Id: <2a7038bc170e31a668995c367bbae018bf805dbe.1609306622.git.vijayakannan.ayyathurai@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1609306622.git.vijayakannan.ayyathurai@intel.com>
References: <cover.1609306622.git.vijayakannan.ayyathurai@intel.com>
In-Reply-To: <cover.1609306622.git.vijayakannan.ayyathurai@intel.com>
References: <cover.1609306622.git.vijayakannan.ayyathurai@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vijayakannan Ayyathurai <vijayakannan.ayyathurai@intel.com>

Add generic clocksource and clockevent driver for the timer IP used
in Intel Keem Bay SoC.

One free running Counter used as a clocksource device and one Timer
used as a clockevent device. Both are enabled through TIM_GEN_CONFIG
register. This register is in the DT resource index 2.

Timer and Counter base register is in the DT resource index 0 and 1
respectively. This register map/unmap handled by TIMER OF api.

Acked-by: Mark Gross <mgross@linux.intel.com>
Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Vijayakannan Ayyathurai <vijayakannan.ayyathurai@intel.com>
---
 arch/arm64/Kconfig.platforms        |   1 +
 drivers/clocksource/Kconfig         |  10 ++
 drivers/clocksource/Makefile        |   1 +
 drivers/clocksource/timer-keembay.c | 225 ++++++++++++++++++++++++++++
 4 files changed, 237 insertions(+)
 create mode 100644 drivers/clocksource/timer-keembay.c

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index 6eecdef538bd..12c0c39a27ff 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -146,6 +146,7 @@ config ARCH_HISI
 
 config ARCH_KEEMBAY
 	bool "Keem Bay SoC"
+	select KEEMBAY_TIMER
 	help
 	  This enables support for Intel Movidius SoC code-named Keem Bay.
 
diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index 14c7c4712478..cebe774fe104 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -728,4 +728,14 @@ config MICROCHIP_PIT64B
 	  modes and high resolution. It is used as a clocksource
 	  and a clockevent.
 
+config KEEMBAY_TIMER
+	bool "Intel Keembay timer driver"
+	depends on ARCH_KEEMBAY || (ARM64 && COMPILE_TEST)
+	select TIMER_OF
+	help
+	  This option enables the support for the Intel Keembay general
+	  purpose timer and free running counter driver. Each timer can
+	  generate an individual interrupt and the 64 bit counter can also
+	  be used as one of the clock source.
+
 endmenu
diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
index 3c75cbbf8533..584628a56c76 100644
--- a/drivers/clocksource/Makefile
+++ b/drivers/clocksource/Makefile
@@ -93,3 +93,4 @@ obj-$(CONFIG_CSKY_MP_TIMER)		+= timer-mp-csky.o
 obj-$(CONFIG_GX6605S_TIMER)		+= timer-gx6605s.o
 obj-$(CONFIG_HYPERV_TIMER)		+= hyperv_timer.o
 obj-$(CONFIG_MICROCHIP_PIT64B)		+= timer-microchip-pit64b.o
+obj-$(CONFIG_KEEMBAY_TIMER)		+= timer-keembay.o
diff --git a/drivers/clocksource/timer-keembay.c b/drivers/clocksource/timer-keembay.c
new file mode 100644
index 000000000000..f5465b907ba4
--- /dev/null
+++ b/drivers/clocksource/timer-keembay.c
@@ -0,0 +1,225 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Intel Keembay Timer driver
+ *
+ * Copyright (C) 2020 Intel Corporation
+ */
+
+#include <linux/bits.h>
+#include <linux/interrupt.h>
+#include <linux/io-64-nonatomic-lo-hi.h>
+#include <linux/module.h>
+#include <linux/of_address.h>
+#include <linux/sizes.h>
+
+#include "timer-of.h"
+
+/* Registers offset */
+#define TIM_CNT_VAL_OFFSET		0
+#define TIM_RELOAD_VAL_OFFSET		SZ_4
+#define TIM_CONFIG_OFFSET		SZ_8
+
+/* Bit fields of TIM_GEN_CONFIG register */
+#define TIM_CONFIG_PRESCALER_ENABLE	BIT(2)
+
+/* Bit fields of TIM_CONFIG registers */
+#define TIM_CONFIG_INTERRUPT_PENDING	BIT(4)
+#define TIM_CONFIG_INTERRUPT_ENABLE	BIT(2)
+#define TIM_CONFIG_RESTART		BIT(1)
+#define TIM_CONFIG_ENABLE		BIT(0)
+
+#define TIM_RATING			200
+#define TIM_CLKSRC_BITS			SZ_64
+
+struct keembay_init_data {
+	struct timer_of	*cfg;
+	void __iomem	*base;
+	u32		mask;
+};
+
+static inline void keembay_timer_disable(void __iomem *base)
+{
+	writel(0, base + TIM_CONFIG_OFFSET);
+}
+
+static inline void keembay_timer_enable(void __iomem *base, u32 flags)
+{
+	writel(TIM_CONFIG_ENABLE | flags, base + TIM_CONFIG_OFFSET);
+}
+
+static inline void keembay_timer_update_counter(void __iomem *base, u32 val)
+{
+	writel(val, base + TIM_CNT_VAL_OFFSET);
+	writel(val, base + TIM_RELOAD_VAL_OFFSET);
+}
+
+static int keembay_timer_set_next_event(unsigned long evt, struct clock_event_device *ce)
+{
+	u32 flags = TIM_CONFIG_INTERRUPT_ENABLE;
+	struct timer_of *to = to_timer_of(ce);
+
+	keembay_timer_disable(timer_of_base(to));
+	keembay_timer_update_counter(timer_of_base(to), evt);
+	keembay_timer_enable(timer_of_base(to), flags);
+
+	return 0;
+}
+
+static int keembay_timer_periodic(struct clock_event_device *ce)
+{
+	u32 flags = TIM_CONFIG_INTERRUPT_ENABLE | TIM_CONFIG_RESTART;
+	struct timer_of *to = to_timer_of(ce);
+
+	keembay_timer_disable(timer_of_base(to));
+	keembay_timer_update_counter(timer_of_base(to), timer_of_period(to));
+	keembay_timer_enable(timer_of_base(to), flags);
+
+	return 0;
+}
+
+static int keembay_timer_shutdown(struct clock_event_device *ce)
+{
+	struct timer_of *to = to_timer_of(ce);
+
+	keembay_timer_disable(timer_of_base(to));
+
+	return 0;
+}
+
+static irqreturn_t keembay_timer_isr(int irq, void *dev_id)
+{
+	struct clock_event_device *evt = dev_id;
+	struct timer_of *to = to_timer_of(evt);
+	u32 val;
+
+	val = readl(timer_of_base(to) + TIM_CONFIG_OFFSET);
+	val &= ~TIM_CONFIG_INTERRUPT_PENDING;
+	writel(val, timer_of_base(to) + TIM_CONFIG_OFFSET);
+
+	if (clockevent_state_oneshot(evt))
+		keembay_timer_disable(timer_of_base(to));
+
+	evt->event_handler(evt);
+
+	return IRQ_HANDLED;
+}
+
+static int __init keembay_timer_setup(struct device_node *np, struct keembay_init_data *data)
+{
+	struct timer_of *to = data->cfg;
+	u32 val;
+
+	val = readl(data->base + TIM_CONFIG_OFFSET);
+	if (!(val & data->mask))
+		return -ENODEV;
+
+	return timer_of_init(np, to);
+}
+
+static void keembay_timer_cleanup(struct device_node *np, struct keembay_init_data *data)
+{
+	iounmap(data->base);
+}
+
+static struct timer_of keembay_ce_to = {
+	.flags	= TIMER_OF_IRQ | TIMER_OF_BASE | TIMER_OF_CLOCK,
+	.clkevt = {
+		.name			= "keembay_sys_clkevt",
+		.features		= CLOCK_EVT_FEAT_PERIODIC |
+					  CLOCK_EVT_FEAT_ONESHOT  |
+					  CLOCK_EVT_FEAT_DYNIRQ,
+		.rating			= TIM_RATING,
+		.set_next_event		= keembay_timer_set_next_event,
+		.set_state_periodic	= keembay_timer_periodic,
+		.set_state_shutdown	= keembay_timer_shutdown,
+	},
+	.of_base = {
+		.index = 0,
+	},
+	.of_irq = {
+		.handler = keembay_timer_isr,
+		.flags = IRQF_TIMER | IRQF_IRQPOLL,
+	},
+};
+
+static int __init keembay_clockevent_init(struct device_node *np,
+					  struct keembay_init_data *data)
+{
+	u32 val;
+	int ret;
+
+	data->mask = TIM_CONFIG_PRESCALER_ENABLE;
+	data->cfg = &keembay_ce_to;
+	ret = keembay_timer_setup(np, data);
+	if (ret)
+		return ret;
+
+	val = readl(data->base + TIM_RELOAD_VAL_OFFSET);
+
+	keembay_ce_to.clkevt.cpumask = cpumask_of(0);
+	keembay_ce_to.of_clk.rate = keembay_ce_to.of_clk.rate / (val + 1);
+
+	keembay_timer_disable(timer_of_base(&keembay_ce_to));
+
+	clockevents_config_and_register(&keembay_ce_to.clkevt,
+					timer_of_rate(&keembay_ce_to), 1, U32_MAX);
+	return 0;
+}
+
+static struct timer_of keembay_cs_to = {
+	.flags	= TIMER_OF_BASE | TIMER_OF_CLOCK,
+	.of_base = {
+		.index = 1,
+	},
+};
+
+static u64 notrace keembay_clocksource_read(struct clocksource *cs)
+{
+	return lo_hi_readq(timer_of_base(&keembay_cs_to));
+}
+
+static struct clocksource keembay_counter = {
+	.name			= "keembay_sys_counter",
+	.rating			= TIM_RATING,
+	.read			= keembay_clocksource_read,
+	.mask			= CLOCKSOURCE_MASK(TIM_CLKSRC_BITS),
+	.flags			= CLOCK_SOURCE_IS_CONTINUOUS |
+				  CLOCK_SOURCE_SUSPEND_NONSTOP,
+};
+
+static int __init keembay_clocksource_init(struct device_node *np,
+					   struct keembay_init_data *data)
+{
+	int ret;
+
+	data->mask = TIM_CONFIG_ENABLE;
+	data->cfg = &keembay_cs_to;
+	ret = keembay_timer_setup(np, data);
+	if (ret)
+		return ret;
+
+	return clocksource_register_hz(&keembay_counter, timer_of_rate(&keembay_cs_to));
+}
+
+static int __init keembay_timer_init(struct device_node *np)
+{
+	struct keembay_init_data data;
+	int ret;
+
+	data.base = of_iomap(np, 2);
+	if (!data.base)
+		return -ENXIO;
+
+	ret = keembay_clocksource_init(np, &data);
+	if (ret)
+		goto exit;
+
+	ret = keembay_clockevent_init(np, &data);
+
+exit:
+	keembay_timer_cleanup(np, &data);
+
+	return ret;
+}
+
+TIMER_OF_DECLARE(keembay_timer, "intel,keembay-timer", keembay_timer_init);
-- 
2.17.1

