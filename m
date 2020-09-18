Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EF2626FE50
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 15:26:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726753AbgIRNXg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 09:23:36 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:13310 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726767AbgIRNXO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 09:23:14 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 94EF0F938245AE61D408;
        Fri, 18 Sep 2020 21:23:08 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.177.253) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.487.0; Fri, 18 Sep 2020 21:23:00 +0800
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
Subject: [PATCH v3 3/9] clocksource: sp804: delete the leading "__" of some functions
Date:   Fri, 18 Sep 2020 21:22:31 +0800
Message-ID: <20200918132237.3552-4-thunder.leizhen@huawei.com>
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

Delete the leading "__" of __sp804_clocksource_and_sched_clock_init() and
__sp804_clockevents_init(), make it looks a little more comfortable.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 drivers/clocksource/timer-sp804.c | 27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/drivers/clocksource/timer-sp804.c b/drivers/clocksource/timer-sp804.c
index 97b41a493253e0a..097f5a83163c6e1 100644
--- a/drivers/clocksource/timer-sp804.c
+++ b/drivers/clocksource/timer-sp804.c
@@ -65,10 +65,10 @@ static u64 notrace sp804_read(void)
 	return ~readl_relaxed(sched_clock_base + TIMER_VALUE);
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
 
@@ -159,7 +159,8 @@ static int sp804_set_next_event(unsigned long next,
 	.rating			= 300,
 };
 
-int __init __sp804_clockevents_init(void __iomem *base, unsigned int irq, struct clk *clk, const char *name)
+int __init sp804_clockevents_init(void __iomem *base, unsigned int irq,
+				  struct clk *clk, const char *name)
 {
 	struct clock_event_device *evt = &sp804_clockevent;
 	long rate;
@@ -228,21 +229,22 @@ static int __init sp804_of_init(struct device_node *np)
 	of_property_read_u32(np, "arm,sp804-has-irq", &irq_num);
 	if (irq_num == 2) {
 
-		ret = __sp804_clockevents_init(base + TIMER_2_BASE, irq, clk2, name);
+		ret = sp804_clockevents_init(base + TIMER_2_BASE, irq, clk2, name);
 		if (ret)
 			goto err;
 
-		ret = __sp804_clocksource_and_sched_clock_init(base, name, clk1, 1);
+		ret = sp804_clocksource_and_sched_clock_init(base,
+							     name, clk1, 1);
 		if (ret)
 			goto err;
 	} else {
 
-		ret = __sp804_clockevents_init(base, irq, clk1 , name);
+		ret = sp804_clockevents_init(base, irq, clk1, name);
 		if (ret)
 			goto err;
 
-		ret =__sp804_clocksource_and_sched_clock_init(base + TIMER_2_BASE,
-							      name, clk2, 1);
+		ret = sp804_clocksource_and_sched_clock_init(base + TIMER_2_BASE,
+							     name, clk2, 1);
 		if (ret)
 			goto err;
 	}
@@ -282,7 +284,8 @@ static int __init integrator_cp_of_init(struct device_node *np)
 		goto err;
 
 	if (!init_count) {
-		ret = __sp804_clocksource_and_sched_clock_init(base, name, clk, 0);
+		ret = sp804_clocksource_and_sched_clock_init(base,
+							     name, clk, 0);
 		if (ret)
 			goto err;
 	} else {
@@ -290,7 +293,7 @@ static int __init integrator_cp_of_init(struct device_node *np)
 		if (irq <= 0)
 			goto err;
 
-		ret = __sp804_clockevents_init(base, irq, clk, name);
+		ret = sp804_clockevents_init(base, irq, clk, name);
 		if (ret)
 			goto err;
 	}
-- 
1.8.3


