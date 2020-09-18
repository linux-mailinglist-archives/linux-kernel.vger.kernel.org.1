Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9898B26FE48
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 15:26:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726818AbgIRNXX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 09:23:23 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:59474 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726773AbgIRNXQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 09:23:16 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 87433CAB032223C9E7FE;
        Fri, 18 Sep 2020 21:23:13 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.177.253) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.487.0; Fri, 18 Sep 2020 21:23:02 +0800
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
Subject: [PATCH v3 7/9] clocksource: sp804: add support for Hisilicon sp804 timer
Date:   Fri, 18 Sep 2020 21:22:35 +0800
Message-ID: <20200918132237.3552-8-thunder.leizhen@huawei.com>
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

The ARM SP804 supports a maximum of 32-bit counter, but Hisilicon extends
it to 64-bit. That means, the registers: TimerXload, TimerXValue and
TimerXBGLoad are 64bits, all other registers are the same as those in the
SP804. The driver code can be completely reused except that the register
offset is different.

Use compatible = "hisilicon,sp804" mark as Hisilicon sp804 timer.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 drivers/clocksource/timer-sp804.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/clocksource/timer-sp804.c b/drivers/clocksource/timer-sp804.c
index 5f4f979a8ef2c10..f0783d19522f048 100644
--- a/drivers/clocksource/timer-sp804.c
+++ b/drivers/clocksource/timer-sp804.c
@@ -20,6 +20,18 @@
 
 #include "timer-sp.h"
 
+/* Hisilicon 64-bit timer(a variant of ARM SP804) */
+#define HISI_TIMER_1_BASE	0x00
+#define HISI_TIMER_2_BASE	0x40
+#define HISI_TIMER_LOAD		0x00
+#define HISI_TIMER_VALUE	0x08
+#define HISI_TIMER_CTRL		0x10
+#define HISI_TIMER_INTCLR	0x14
+#define HISI_TIMER_RIS		0x18
+#define HISI_TIMER_MIS		0x1c
+#define HISI_TIMER_BGLOAD	0x20
+
+
 struct sp804_timer __initdata arm_sp804_timer = {
 	.load		= TIMER_LOAD,
 	.value		= TIMER_VALUE,
@@ -29,6 +41,15 @@ struct sp804_timer __initdata arm_sp804_timer = {
 	.width		= 32,
 };
 
+struct sp804_timer __initdata hisi_sp804_timer = {
+	.load		= HISI_TIMER_LOAD,
+	.value		= HISI_TIMER_VALUE,
+	.ctrl		= HISI_TIMER_CTRL,
+	.intclr		= HISI_TIMER_INTCLR,
+	.timer_base	= {HISI_TIMER_1_BASE, HISI_TIMER_2_BASE},
+	.width		= 64,
+};
+
 static struct sp804_clkevt sp804_clkevt[NR_TIMERS];
 
 static long __init sp804_get_clock_rate(struct clk *clk, const char *name)
@@ -315,6 +336,12 @@ static int __init arm_sp804_of_init(struct device_node *np)
 }
 TIMER_OF_DECLARE(sp804, "arm,sp804", arm_sp804_of_init);
 
+static int __init hisi_sp804_of_init(struct device_node *np)
+{
+	return sp804_of_init(np, &hisi_sp804_timer);
+}
+TIMER_OF_DECLARE(hisi_sp804, "hisilicon,sp804", hisi_sp804_of_init);
+
 static int __init integrator_cp_of_init(struct device_node *np)
 {
 	static int init_count = 0;
-- 
1.8.3


