Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E84FC26FE4B
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 15:26:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726829AbgIRNX1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 09:23:27 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:59478 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726778AbgIRNXT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 09:23:19 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 81C4D9DA680EC872A5B6;
        Fri, 18 Sep 2020 21:23:13 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.177.253) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.487.0; Fri, 18 Sep 2020 21:23:03 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Rob Herring <robh+dt@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Haojian Zhuang <haojian.zhuang@linaro.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>,
        Libin <huawei.libin@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Jianguo Chen <chenjianguo3@huawei.com>
Subject: [PATCH v3 8/9] clocksource: sp804: enable Hisilicon sp804 timer 64bit mode
Date:   Fri, 18 Sep 2020 21:22:36 +0800
Message-ID: <20200918132237.3552-9-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
In-Reply-To: <20200918132237.3552-1-thunder.leizhen@huawei.com>
References: <20200918132237.3552-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.177.253]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A 100MHZ 32-bit timer will be wrapped up less than 43s. Although the
kernel maintains a software high 32-bit count in the tick IRQ. But it's
not applicable to the user mode APPs.

Note: The kernel still uses the lower 32 bits of the timer.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 drivers/clocksource/timer-sp.h    |  6 ++++++
 drivers/clocksource/timer-sp804.c | 11 +++++++++++
 2 files changed, 17 insertions(+)

diff --git a/drivers/clocksource/timer-sp.h b/drivers/clocksource/timer-sp.h
index 1ab75cbed0e09e5..811f840be0e52fd 100644
--- a/drivers/clocksource/timer-sp.h
+++ b/drivers/clocksource/timer-sp.h
@@ -33,12 +33,15 @@
 
 struct sp804_timer {
 	int load;
+	int load_h;
 	int value;
+	int value_h;
 	int ctrl;
 	int intclr;
 	int ris;
 	int mis;
 	int bgload;
+	int bgload_h;
 	int timer_base[NR_TIMERS];
 	int width;
 };
@@ -46,12 +49,15 @@ struct sp804_timer {
 struct sp804_clkevt {
 	void __iomem *base;
 	void __iomem *load;
+	void __iomem *load_h;
 	void __iomem *value;
+	void __iomem *value_h;
 	void __iomem *ctrl;
 	void __iomem *intclr;
 	void __iomem *ris;
 	void __iomem *mis;
 	void __iomem *bgload;
+	void __iomem *bgload_h;
 	unsigned long reload;
 	int width;
 };
diff --git a/drivers/clocksource/timer-sp804.c b/drivers/clocksource/timer-sp804.c
index f0783d19522f048..6e8ad4a4ea3c737 100644
--- a/drivers/clocksource/timer-sp804.c
+++ b/drivers/clocksource/timer-sp804.c
@@ -24,12 +24,15 @@
 #define HISI_TIMER_1_BASE	0x00
 #define HISI_TIMER_2_BASE	0x40
 #define HISI_TIMER_LOAD		0x00
+#define HISI_TIMER_LOAD_H	0x04
 #define HISI_TIMER_VALUE	0x08
+#define HISI_TIMER_VALUE_H	0x0c
 #define HISI_TIMER_CTRL		0x10
 #define HISI_TIMER_INTCLR	0x14
 #define HISI_TIMER_RIS		0x18
 #define HISI_TIMER_MIS		0x1c
 #define HISI_TIMER_BGLOAD	0x20
+#define HISI_TIMER_BGLOAD_H	0x24
 
 
 struct sp804_timer __initdata arm_sp804_timer = {
@@ -43,7 +46,9 @@ struct sp804_timer __initdata arm_sp804_timer = {
 
 struct sp804_timer __initdata hisi_sp804_timer = {
 	.load		= HISI_TIMER_LOAD,
+	.load_h		= HISI_TIMER_LOAD_H,
 	.value		= HISI_TIMER_VALUE,
+	.value_h	= HISI_TIMER_VALUE_H,
 	.ctrl		= HISI_TIMER_CTRL,
 	.intclr		= HISI_TIMER_INTCLR,
 	.timer_base	= {HISI_TIMER_1_BASE, HISI_TIMER_2_BASE},
@@ -129,6 +134,10 @@ int __init sp804_clocksource_and_sched_clock_init(void __iomem *base,
 	writel(0, clkevt->ctrl);
 	writel(0xffffffff, clkevt->load);
 	writel(0xffffffff, clkevt->value);
+	if (clkevt->width == 64) {
+		writel(0xffffffff, clkevt->load_h);
+		writel(0xffffffff, clkevt->value_h);
+	}
 	writel(TIMER_CTRL_32BIT | TIMER_CTRL_ENABLE | TIMER_CTRL_PERIODIC,
 		clkevt->ctrl);
 
@@ -245,7 +254,9 @@ static void __init sp804_clkevt_init(struct sp804_timer *timer, void __iomem *ba
 		clkevt = &sp804_clkevt[i];
 		clkevt->base	= timer_base;
 		clkevt->load	= timer_base + timer->load;
+		clkevt->load_h	= timer_base + timer->load_h;
 		clkevt->value	= timer_base + timer->value;
+		clkevt->value_h	= timer_base + timer->value_h;
 		clkevt->ctrl	= timer_base + timer->ctrl;
 		clkevt->intclr	= timer_base + timer->intclr;
 		clkevt->width	= timer->width;
-- 
1.8.3


