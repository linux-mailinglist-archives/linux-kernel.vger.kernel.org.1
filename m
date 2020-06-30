Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6117820FA54
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jun 2020 19:16:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390177AbgF3RQn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Jun 2020 13:16:43 -0400
Received: from out28-197.mail.aliyun.com ([115.124.28.197]:48607 "EHLO
        out28-197.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726642AbgF3RQj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 13:16:39 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.04436282|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_alarm|0.0450754-0.00220666-0.952718;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03294;MF=zhouyanjie@wanyeetech.com;NM=1;PH=DS;RN=12;RT=12;SR=0;TI=SMTPD_---.HvKRuu7_1593537376;
Received: from localhost.localdomain(mailfrom:zhouyanjie@wanyeetech.com fp:SMTPD_---.HvKRuu7_1593537376)
          by smtp.aliyun-inc.com(10.147.41.178);
          Wed, 01 Jul 2020 01:16:26 +0800
From:   =?UTF-8?q?=E5=91=A8=E7=90=B0=E6=9D=B0=20=28Zhou=20Yanjie=29?= 
        <zhouyanjie@wanyeetech.com>
To:     linux-kernel@vger.kernel.org
Cc:     devicetree@vger.kernel.org, daniel.lezcano@linaro.org,
        tglx@linutronix.de, robh+dt@kernel.org, paul@crapouillou.net,
        dongsheng.qiu@ingenic.com, aric.pzqi@ingenic.com,
        rick.tyliu@ingenic.com, yanfei.li@ingenic.com,
        sernia.zhou@foxmail.com, zhenwenjin@gmail.com
Subject: [PATCH v3 2/2] clocksource: Ingenic: Add support for the Ingenic X1000 OST.
Date:   Wed,  1 Jul 2020 01:15:53 +0800
Message-Id: <20200630171553.70670-3-zhouyanjie@wanyeetech.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200630171553.70670-1-zhouyanjie@wanyeetech.com>
References: <20200630171553.70670-1-zhouyanjie@wanyeetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

X1000 and SoCs after X1000 (such as X1500 and X1830) had a separate
OST, it no longer belongs to TCU. This driver will register both a
clocksource and a sched_clock to the system.

Tested-by: 周正 (Zhou Zheng) <sernia.zhou@foxmail.com>
Co-developed-by: 漆鹏振 (Qi Pengzhen) <aric.pzqi@ingenic.com>
Signed-off-by: 漆鹏振 (Qi Pengzhen) <aric.pzqi@ingenic.com>
Signed-off-by: 周琰杰 (Zhou Yanjie) <zhouyanjie@wanyeetech.com>
---

Notes:
    v1->v2:
    Fix compile warnings.
    Reported-by: kernel test robot <lkp@intel.com>
    
    v2->v3:
    No change.

 drivers/clocksource/Kconfig          |  19 +-
 drivers/clocksource/Makefile         |   1 +
 drivers/clocksource/ingenic-sysost.c | 509 +++++++++++++++++++++++++++++++++++
 3 files changed, 525 insertions(+), 4 deletions(-)
 create mode 100644 drivers/clocksource/ingenic-sysost.c

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index 91418381fcd4..172397a00f3e 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -686,7 +686,7 @@ config MILBEAUT_TIMER
 	  Enables the support for Milbeaut timer driver.
 
 config INGENIC_TIMER
-	bool "Clocksource/timer using the TCU in Ingenic JZ SoCs"
+	bool "Clocksource/timer using the TCU in Ingenic SoCs"
 	default MACH_INGENIC
 	depends on MIPS || COMPILE_TEST
 	depends on COMMON_CLK
@@ -694,15 +694,26 @@ config INGENIC_TIMER
 	select TIMER_OF
 	select IRQ_DOMAIN
 	help
-	  Support for the timer/counter unit of the Ingenic JZ SoCs.
+	  Support for the timer/counter unit of the Ingenic SoCs.
+
+config INGENIC_SYSOST
+	bool "Clocksource/timer using the SYSOST in Ingenic SoCs"
+	default MACH_INGENIC
+	depends on MIPS || COMPILE_TEST
+	depends on COMMON_CLK
+	select MFD_SYSCON
+	select TIMER_OF
+	select IRQ_DOMAIN
+	help
+	  This option enables support for SYSOST in Ingenic SoCs .
 
 config INGENIC_OST
-	bool "Clocksource for Ingenic OS Timer"
+	bool "Clocksource for Ingenic OST"
 	depends on MIPS || COMPILE_TEST
 	depends on COMMON_CLK
 	select MFD_SYSCON
 	help
-	  Support for the Operating System Timer of the Ingenic JZ SoCs.
+	  Support for the Operating System Timer of the Ingenic SoCs.
 
 config MICROCHIP_PIT64B
 	bool "Microchip PIT64B support"
diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
index bdda1a2e4097..3994e221e262 100644
--- a/drivers/clocksource/Makefile
+++ b/drivers/clocksource/Makefile
@@ -82,6 +82,7 @@ obj-$(CONFIG_H8300_TMR8)		+= h8300_timer8.o
 obj-$(CONFIG_H8300_TMR16)		+= h8300_timer16.o
 obj-$(CONFIG_H8300_TPU)			+= h8300_tpu.o
 obj-$(CONFIG_INGENIC_OST)		+= ingenic-ost.o
+obj-$(CONFIG_INGENIC_SYSOST)	+= ingenic-sysost.o
 obj-$(CONFIG_INGENIC_TIMER)		+= ingenic-timer.o
 obj-$(CONFIG_CLKSRC_ST_LPC)		+= clksrc_st_lpc.o
 obj-$(CONFIG_X86_NUMACHIP)		+= numachip.o
diff --git a/drivers/clocksource/ingenic-sysost.c b/drivers/clocksource/ingenic-sysost.c
new file mode 100644
index 000000000000..d3e1b7582221
--- /dev/null
+++ b/drivers/clocksource/ingenic-sysost.c
@@ -0,0 +1,509 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Ingenic XBurst SoCs SYSOST clocks driver
+ * Copyright (c) 2020 周琰杰 (Zhou Yanjie) <zhouyanjie@wanyeetech.com>
+ */
+
+#include <linux/bitops.h>
+#include <linux/clk.h>
+#include <linux/clk-provider.h>
+#include <linux/clockchips.h>
+#include <linux/clocksource.h>
+#include <linux/interrupt.h>
+#include <linux/mfd/syscon.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
+#include <linux/sched_clock.h>
+#include <linux/slab.h>
+#include <linux/syscore_ops.h>
+
+#include <dt-bindings/clock/ingenic,ost.h>
+
+/* OST register offsets */
+#define OST_REG_OSTCCR			0x00
+#define OST_REG_OSTCR			0x08
+#define OST_REG_OSTFR			0x0c
+#define OST_REG_OSTMR			0x10
+#define OST_REG_OST1DFR			0x14
+#define OST_REG_OST1CNT			0x18
+#define OST_REG_OST2CNTL		0x20
+#define OST_REG_OSTCNT2HBUF		0x24
+#define OST_REG_OSTESR			0x34
+#define OST_REG_OSTECR			0x38
+
+/* bits within the OSTCCR register */
+#define OSTCCR_PRESCALE1_MASK	0x3
+#define OSTCCR_PRESCALE2_MASK	0xc
+#define OSTCCR_PRESCALE1_LSB	0
+#define OSTCCR_PRESCALE2_LSB	2
+
+/* bits within the OSTCR register */
+#define OSTCR_OST1CLR			BIT(0)
+#define OSTCR_OST2CLR			BIT(1)
+
+/* bits within the OSTFR register */
+#define OSTFR_FFLAG				BIT(0)
+
+/* bits within the OSTMR register */
+#define OSTMR_FMASK				BIT(0)
+
+/* bits within the OSTESR register */
+#define OSTESR_OST1ENS			BIT(0)
+#define OSTESR_OST2ENS			BIT(1)
+
+/* bits within the OSTECR register */
+#define OSTECR_OST1ENC			BIT(0)
+#define OSTECR_OST2ENC			BIT(1)
+
+enum ost_clk_parent {
+	OST_PARENT_EXT,
+};
+
+struct ingenic_soc_info {
+	unsigned int num_channels;
+};
+
+struct ingenic_ost_clk_info {
+	struct clk_init_data init_data;
+	u8 ostccr_reg;
+};
+
+struct ingenic_ost_clk {
+	struct clk_hw hw;
+	unsigned int idx;
+	struct ingenic_ost *ost;
+	const struct ingenic_ost_clk_info *info;
+};
+
+struct ingenic_ost {
+	void __iomem *base;
+	const struct ingenic_soc_info *soc_info;
+	struct clk *clk, *percpu_timer_clk, *global_timer_clk;
+	unsigned int percpu_timer_channel, global_timer_channel;
+	struct clock_event_device cevt;
+	struct clocksource cs;
+	char name[20];
+
+	struct clk_hw_onecell_data *clocks;
+};
+
+static struct ingenic_ost *ingenic_ost;
+
+static inline struct ingenic_ost_clk *to_ost_clk(struct clk_hw *hw)
+{
+	return container_of(hw, struct ingenic_ost_clk, hw);
+}
+
+static unsigned long ingenic_ost_recalc_rate(struct clk_hw *hw,
+		unsigned long parent_rate)
+{
+	struct ingenic_ost_clk *ost_clk = to_ost_clk(hw);
+	const struct ingenic_ost_clk_info *info = ost_clk->info;
+	unsigned int prescale;
+
+	prescale = readl(ost_clk->ost->base + info->ostccr_reg);
+
+	if (ost_clk->idx == OST_CLK_PERCPU_TIMER)
+		prescale = (prescale & OSTCCR_PRESCALE1_MASK) >> OSTCCR_PRESCALE1_LSB;
+	else if (ost_clk->idx == OST_CLK_GLOBAL_TIMER)
+		prescale = (prescale & OSTCCR_PRESCALE2_MASK) >> OSTCCR_PRESCALE2_LSB;
+
+	return parent_rate >> (prescale * 2);
+}
+
+static u8 ingenic_ost_get_prescale(unsigned long rate, unsigned long req_rate)
+{
+	u8 prescale;
+
+	for (prescale = 0; prescale < 2; prescale++)
+		if ((rate >> (prescale * 2)) <= req_rate)
+			return prescale;
+
+	return 2; /* /16 divider */
+}
+
+static long ingenic_ost_round_rate(struct clk_hw *hw, unsigned long req_rate,
+		unsigned long *parent_rate)
+{
+	unsigned long rate = *parent_rate;
+	u8 prescale;
+
+	if (req_rate > rate)
+		return rate;
+
+	prescale = ingenic_ost_get_prescale(rate, req_rate);
+
+	return rate >> (prescale * 2);
+}
+
+static int ingenic_ost_set_rate(struct clk_hw *hw, unsigned long req_rate,
+		unsigned long parent_rate)
+{
+	struct ingenic_ost_clk *ost_clk = to_ost_clk(hw);
+	const struct ingenic_ost_clk_info *info = ost_clk->info;
+	u8 prescale = ingenic_ost_get_prescale(parent_rate, req_rate);
+	int val;
+
+	if (ost_clk->idx == OST_CLK_PERCPU_TIMER) {
+		val = readl(ost_clk->ost->base + info->ostccr_reg);
+		val = (val & ~OSTCCR_PRESCALE1_MASK) | (prescale << OSTCCR_PRESCALE1_LSB);
+		writel(val, ost_clk->ost->base + info->ostccr_reg);
+	} else if (ost_clk->idx == OST_CLK_GLOBAL_TIMER) {
+		val = readl(ost_clk->ost->base + info->ostccr_reg);
+		val = (val & ~OSTCCR_PRESCALE2_MASK) | (prescale << OSTCCR_PRESCALE2_LSB);
+		writel(val, ost_clk->ost->base + info->ostccr_reg);
+	}
+
+	return 0;
+}
+
+static const struct clk_ops ingenic_ost_clk_ops = {
+	.recalc_rate	= ingenic_ost_recalc_rate,
+	.round_rate	= ingenic_ost_round_rate,
+	.set_rate	= ingenic_ost_set_rate,
+};
+
+static const char * const ingenic_ost_clk_parents[] = {
+	[OST_PARENT_EXT]  = "ext",
+};
+
+#define DEF_TIMER(_name, _ostccr) { \
+	.init_data = { \
+		.name = _name, \
+		.parent_names = ingenic_ost_clk_parents, \
+		.num_parents = ARRAY_SIZE(ingenic_ost_clk_parents), \
+		.ops = &ingenic_ost_clk_ops, \
+		.flags = CLK_SET_RATE_UNGATE, \
+	}, \
+	.ostccr_reg = _ostccr, \
+}
+
+static const struct ingenic_ost_clk_info ingenic_ost_clk_info[] = {
+	[OST_CLK_PERCPU_TIMER] = DEF_TIMER("percpu timer", OST_REG_OSTCCR),
+	[OST_CLK_GLOBAL_TIMER] = DEF_TIMER("global timer", OST_REG_OSTCCR),
+};
+
+#undef DEF_TIMER
+
+static u64 notrace ingenic_ost_global_timer_read_cntl(void)
+{
+	struct ingenic_ost *ost = ingenic_ost;
+	unsigned int count;
+
+	count = readl(ost->base + OST_REG_OST2CNTL);
+
+	return count;
+}
+
+static u64 notrace ingenic_ost_clocksource_read(struct clocksource *cs)
+{
+	return ingenic_ost_global_timer_read_cntl();
+}
+
+static inline struct ingenic_ost *to_ingenic_ost(struct clock_event_device *evt)
+{
+	return container_of(evt, struct ingenic_ost, cevt);
+}
+
+static int ingenic_ost_cevt_set_state_shutdown(struct clock_event_device *evt)
+{
+	struct ingenic_ost *ost = to_ingenic_ost(evt);
+
+	writel(OSTECR_OST1ENC, ost->base + OST_REG_OSTECR);
+
+	return 0;
+}
+
+static int ingenic_ost_cevt_set_next(unsigned long next,
+				     struct clock_event_device *evt)
+{
+	struct ingenic_ost *ost = to_ingenic_ost(evt);
+
+	writel((u32)~OSTFR_FFLAG, ost->base + OST_REG_OSTFR);
+	writel(next, ost->base + OST_REG_OST1DFR);
+	writel(OSTCR_OST1CLR, ost->base + OST_REG_OSTCR);
+	writel(OSTESR_OST1ENS, ost->base + OST_REG_OSTESR);
+	writel((u32)~OSTMR_FMASK, ost->base + OST_REG_OSTMR);
+
+	return 0;
+}
+
+static irqreturn_t ingenic_ost_cevt_cb(int irq, void *dev_id)
+{
+	struct clock_event_device *evt = dev_id;
+	struct ingenic_ost *ost = to_ingenic_ost(evt);
+
+	writel(OSTECR_OST1ENC, ost->base + OST_REG_OSTECR);
+
+	if (evt->event_handler)
+		evt->event_handler(evt);
+
+	return IRQ_HANDLED;
+}
+
+static int __init ingenic_ost_register_clock(struct ingenic_ost *ost,
+			unsigned int idx, const struct ingenic_ost_clk_info *info,
+			struct clk_hw_onecell_data *clocks)
+{
+	struct ingenic_ost_clk *ost_clk;
+	int val, err;
+
+	ost_clk = kzalloc(sizeof(*ost_clk), GFP_KERNEL);
+	if (!ost_clk)
+		return -ENOMEM;
+
+	ost_clk->hw.init = &info->init_data;
+	ost_clk->idx = idx;
+	ost_clk->info = info;
+	ost_clk->ost = ost;
+
+	/* Reset clock divider */
+	val = readl(ost->base + info->ostccr_reg);
+	val &= ~(OSTCCR_PRESCALE1_MASK | OSTCCR_PRESCALE2_MASK);
+	writel(val, ost->base + info->ostccr_reg);
+
+	err = clk_hw_register(NULL, &ost_clk->hw);
+	if (err) {
+		kfree(ost_clk);
+		return err;
+	}
+
+	clocks->hws[idx] = &ost_clk->hw;
+
+	return 0;
+}
+
+static struct clk * __init ingenic_ost_get_clock(struct device_node *np, int id)
+{
+	struct of_phandle_args args;
+
+	args.np = np;
+	args.args_count = 1;
+	args.args[0] = id;
+
+	return of_clk_get_from_provider(&args);
+}
+
+static int __init ingenic_ost_percpu_timer_init(struct device_node *np,
+					 struct ingenic_ost *ost)
+{
+	unsigned int timer_virq, channel = ost->percpu_timer_channel;
+	unsigned long rate;
+	int err;
+
+	ost->percpu_timer_clk = ingenic_ost_get_clock(np, channel);
+	if (IS_ERR(ost->percpu_timer_clk))
+		return PTR_ERR(ost->percpu_timer_clk);
+
+	err = clk_prepare_enable(ost->percpu_timer_clk);
+	if (err)
+		goto err_clk_put;
+
+	rate = clk_get_rate(ost->percpu_timer_clk);
+	if (!rate) {
+		err = -EINVAL;
+		goto err_clk_disable;
+	}
+
+	timer_virq = of_irq_get(np, 0);
+	if (!timer_virq) {
+		err = -EINVAL;
+		goto err_clk_disable;
+	}
+
+	snprintf(ost->name, sizeof(ost->name), "OST percpu timer");
+
+	err = request_irq(timer_virq, ingenic_ost_cevt_cb, IRQF_TIMER,
+			  ost->name, &ost->cevt);
+	if (err)
+		goto err_irq_dispose_mapping;
+
+	ost->cevt.cpumask = cpumask_of(smp_processor_id());
+	ost->cevt.features = CLOCK_EVT_FEAT_ONESHOT;
+	ost->cevt.name = ost->name;
+	ost->cevt.rating = 400;
+	ost->cevt.set_state_shutdown = ingenic_ost_cevt_set_state_shutdown;
+	ost->cevt.set_next_event = ingenic_ost_cevt_set_next;
+
+	clockevents_config_and_register(&ost->cevt, rate, 4, 0xffffffff);
+
+	return 0;
+
+err_irq_dispose_mapping:
+	irq_dispose_mapping(timer_virq);
+err_clk_disable:
+	clk_disable_unprepare(ost->percpu_timer_clk);
+err_clk_put:
+	clk_put(ost->percpu_timer_clk);
+	return err;
+}
+
+static int __init ingenic_ost_global_timer_init(struct device_node *np,
+					       struct ingenic_ost *ost)
+{
+	unsigned int channel = ost->global_timer_channel;
+	struct clocksource *cs = &ost->cs;
+	unsigned long rate;
+	int err;
+
+	ost->global_timer_clk = ingenic_ost_get_clock(np, channel);
+	if (IS_ERR(ost->global_timer_clk))
+		return PTR_ERR(ost->global_timer_clk);
+
+	err = clk_prepare_enable(ost->global_timer_clk);
+	if (err)
+		goto err_clk_put;
+
+	rate = clk_get_rate(ost->global_timer_clk);
+	if (!rate) {
+		err = -EINVAL;
+		goto err_clk_disable;
+	}
+
+	/* Clear counter CNT registers */
+	writel(OSTCR_OST2CLR, ost->base + OST_REG_OSTCR);
+
+	/* Enable OST channel */
+	writel(OSTESR_OST2ENS, ost->base + OST_REG_OSTESR);
+
+	cs->name = "ingenic-ost";
+	cs->rating = 400;
+	cs->flags = CLOCK_SOURCE_IS_CONTINUOUS;
+	cs->mask = CLOCKSOURCE_MASK(32);
+	cs->read = ingenic_ost_clocksource_read;
+
+	err = clocksource_register_hz(cs, rate);
+	if (err)
+		goto err_clk_disable;
+
+	return 0;
+
+err_clk_disable:
+	clk_disable_unprepare(ost->global_timer_clk);
+err_clk_put:
+	clk_put(ost->global_timer_clk);
+	return err;
+}
+
+static const struct ingenic_soc_info x1000_soc_info = {
+	.num_channels = 2,
+};
+
+static const struct of_device_id __maybe_unused ingenic_ost_of_match[] __initconst = {
+	{ .compatible = "ingenic,x1000-ost", .data = &x1000_soc_info, },
+	{ /* sentinel */ }
+};
+
+static int __init ingenic_ost_probe(struct device_node *np)
+{
+	const struct of_device_id *id = of_match_node(ingenic_ost_of_match, np);
+	struct ingenic_ost *ost;
+	unsigned int i;
+	int ret;
+
+	ost = kzalloc(sizeof(*ost), GFP_KERNEL);
+	if (!ost)
+		return -ENOMEM;
+
+	ost->base = of_iomap(np, 0);
+	if (IS_ERR(ost->base)) {
+		pr_err("%s: Failed to map OST registers\n", __func__);
+		ret = PTR_ERR(ost->base);
+		goto err_free_ost;
+	}
+
+	ost->clk = of_clk_get_by_name(np, "ost");
+	if (IS_ERR(ost->clk)) {
+		ret = PTR_ERR(ost->clk);
+		pr_crit("%s: Cannot get OST clock\n", __func__);
+		goto err_free_ost;
+	}
+
+	ret = clk_prepare_enable(ost->clk);
+	if (ret) {
+		pr_crit("%s: Unable to enable OST clock\n", __func__);
+		goto err_put_clk;
+	}
+
+	ost->soc_info = id->data;
+
+	ost->clocks = kzalloc(struct_size(ost->clocks, hws, ost->soc_info->num_channels),
+			      GFP_KERNEL);
+	if (!ost->clocks) {
+		ret = -ENOMEM;
+		goto err_clk_disable;
+	}
+
+	ost->clocks->num = ost->soc_info->num_channels;
+
+	for (i = 0; i < ost->clocks->num; i++) {
+		ret = ingenic_ost_register_clock(ost, i, &ingenic_ost_clk_info[i], ost->clocks);
+		if (ret) {
+			pr_crit("%s: Cannot register clock %d\n", __func__, i);
+			goto err_unregister_ost_clocks;
+		}
+	}
+
+	ret = of_clk_add_hw_provider(np, of_clk_hw_onecell_get, ost->clocks);
+	if (ret) {
+		pr_crit("%s: Cannot add OF clock provider\n", __func__);
+		goto err_unregister_ost_clocks;
+	}
+
+	ost->percpu_timer_channel = OST_CLK_PERCPU_TIMER;
+	ost->global_timer_channel = OST_CLK_GLOBAL_TIMER;
+
+	ingenic_ost = ost;
+
+	return 0;
+
+err_unregister_ost_clocks:
+	for (i = 0; i < ost->clocks->num; i++)
+		if (ost->clocks->hws[i])
+			clk_hw_unregister(ost->clocks->hws[i]);
+	kfree(ost->clocks);
+err_clk_disable:
+	clk_disable_unprepare(ost->clk);
+err_put_clk:
+	clk_put(ost->clk);
+err_free_ost:
+	kfree(ost);
+	return ret;
+}
+
+static int __init ingenic_ost_init(struct device_node *np)
+{
+	unsigned long rate;
+	int ret = ingenic_ost_probe(np);
+
+	if (ret)
+		pr_crit("%s: Failed to initialize OST clocks: %d\n", __func__, ret);
+
+	of_node_clear_flag(np, OF_POPULATED);
+
+	ret = ingenic_ost_global_timer_init(np, ingenic_ost);
+	if (ret) {
+		pr_crit("%s: Unable to init global timer: %x\n", __func__, ret);
+		goto err_free_ingenic_ost;
+	}
+
+	ret = ingenic_ost_percpu_timer_init(np, ingenic_ost);
+	if (ret)
+		goto err_ost_global_timer_cleanup;
+
+	/* Register the sched_clock at the end as there's no way to undo it */
+	rate = clk_get_rate(ingenic_ost->global_timer_clk);
+	sched_clock_register(ingenic_ost_global_timer_read_cntl, 32, rate);
+
+	return 0;
+
+err_ost_global_timer_cleanup:
+	clocksource_unregister(&ingenic_ost->cs);
+	clk_disable_unprepare(ingenic_ost->global_timer_clk);
+	clk_put(ingenic_ost->global_timer_clk);
+err_free_ingenic_ost:
+	kfree(ingenic_ost);
+	return ret;
+}
+
+TIMER_OF_DECLARE(x1000_ost,  "ingenic,x1000-ost",  ingenic_ost_init);
-- 
2.11.0

