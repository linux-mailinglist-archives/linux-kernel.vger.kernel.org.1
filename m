Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78BF926FE57
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 15:26:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726873AbgIRNXr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 09:23:47 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:13304 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726239AbgIRNXM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 09:23:12 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 854B552CD0D633A645F3;
        Fri, 18 Sep 2020 21:23:08 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.177.253) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.487.0; Fri, 18 Sep 2020 21:23:01 +0800
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
Subject: [PATCH v3 5/9] clocksource: sp804: prepare for support non-standard register offset
Date:   Fri, 18 Sep 2020 21:22:33 +0800
Message-ID: <20200918132237.3552-6-thunder.leizhen@huawei.com>
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

Add two local variables: timer1_base and timer2_base in sp804_of_init(),
to avoid repeatedly calculate the base address of timer2, and make it
easier to recognize timer1. Hope to make the next patch looks more clear.

No functional change.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 drivers/clocksource/timer-sp804.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/clocksource/timer-sp804.c b/drivers/clocksource/timer-sp804.c
index a443f392a8e7d63..471c5c6aaf51afd 100644
--- a/drivers/clocksource/timer-sp804.c
+++ b/drivers/clocksource/timer-sp804.c
@@ -188,6 +188,8 @@ static int __init sp804_of_init(struct device_node *np)
 {
 	static bool initialized = false;
 	void __iomem *base;
+	void __iomem *timer1_base;
+	void __iomem *timer2_base;
 	int irq, ret = -EINVAL;
 	u32 irq_num = 0;
 	struct clk *clk1, *clk2;
@@ -197,9 +199,12 @@ static int __init sp804_of_init(struct device_node *np)
 	if (!base)
 		return -ENXIO;
 
+	timer1_base = base;
+	timer2_base = base + TIMER_2_BASE;
+
 	/* Ensure timers are disabled */
-	writel(0, base + TIMER_CTRL);
-	writel(0, base + TIMER_2_BASE + TIMER_CTRL);
+	writel(0, timer1_base + TIMER_CTRL);
+	writel(0, timer2_base + TIMER_CTRL);
 
 	if (initialized || !of_device_is_available(np)) {
 		ret = -EINVAL;
@@ -228,21 +233,21 @@ static int __init sp804_of_init(struct device_node *np)
 	of_property_read_u32(np, "arm,sp804-has-irq", &irq_num);
 	if (irq_num == 2) {
 
-		ret = sp804_clockevents_init(base + TIMER_2_BASE, irq, clk2, name);
+		ret = sp804_clockevents_init(timer2_base, irq, clk2, name);
 		if (ret)
 			goto err;
 
-		ret = sp804_clocksource_and_sched_clock_init(base,
+		ret = sp804_clocksource_and_sched_clock_init(timer1_base,
 							     name, clk1, 1);
 		if (ret)
 			goto err;
 	} else {
 
-		ret = sp804_clockevents_init(base, irq, clk1, name);
+		ret = sp804_clockevents_init(timer1_base, irq, clk1, name);
 		if (ret)
 			goto err;
 
-		ret = sp804_clocksource_and_sched_clock_init(base + TIMER_2_BASE,
+		ret = sp804_clocksource_and_sched_clock_init(timer2_base,
 							     name, clk2, 1);
 		if (ret)
 			goto err;
-- 
1.8.3


