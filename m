Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4D2C26FE58
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 15:26:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726884AbgIRNXt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 09:23:49 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:13307 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726192AbgIRNXM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 09:23:12 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 803D653A966E1384A3D6;
        Fri, 18 Sep 2020 21:23:08 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.177.253) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.487.0; Fri, 18 Sep 2020 21:22:59 +0800
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
Subject: [PATCH v3 2/9] clocksource: sp804: remove unused sp804_timer_disable() and timer-sp804.h
Date:   Fri, 18 Sep 2020 21:22:30 +0800
Message-ID: <20200918132237.3552-3-thunder.leizhen@huawei.com>
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

Since commit 7484c727b636 ("ARM: realview: delete the RealView board
files") and commit 16956fed35fe ("ARM: versatile: switch to DT only
booting and remove legacy code"), there's no one to use the functions
defined or declared in include/clocksource/timer-sp804.h. Delete it.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 drivers/clocksource/timer-sp804.c |  7 -------
 include/clocksource/timer-sp804.h | 29 -----------------------------
 2 files changed, 36 deletions(-)
 delete mode 100644 include/clocksource/timer-sp804.h

diff --git a/drivers/clocksource/timer-sp804.c b/drivers/clocksource/timer-sp804.c
index bec2d372e0df018..97b41a493253e0a 100644
--- a/drivers/clocksource/timer-sp804.c
+++ b/drivers/clocksource/timer-sp804.c
@@ -18,8 +18,6 @@
 #include <linux/of_irq.h>
 #include <linux/sched_clock.h>
 
-#include <clocksource/timer-sp804.h>
-
 #include "timer-sp.h"
 
 static long __init sp804_get_clock_rate(struct clk *clk, const char *name)
@@ -67,11 +65,6 @@ static u64 notrace sp804_read(void)
 	return ~readl_relaxed(sched_clock_base + TIMER_VALUE);
 }
 
-void __init sp804_timer_disable(void __iomem *base)
-{
-	writel(0, base + TIMER_CTRL);
-}
-
 int  __init __sp804_clocksource_and_sched_clock_init(void __iomem *base,
 						     const char *name,
 						     struct clk *clk,
diff --git a/include/clocksource/timer-sp804.h b/include/clocksource/timer-sp804.h
deleted file mode 100644
index a5b41f31a1c256a..000000000000000
--- a/include/clocksource/timer-sp804.h
+++ /dev/null
@@ -1,29 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef __CLKSOURCE_TIMER_SP804_H
-#define __CLKSOURCE_TIMER_SP804_H
-
-struct clk;
-
-int __sp804_clocksource_and_sched_clock_init(void __iomem *,
-					     const char *, struct clk *, int);
-int __sp804_clockevents_init(void __iomem *, unsigned int,
-			     struct clk *, const char *);
-void sp804_timer_disable(void __iomem *);
-
-static inline void sp804_clocksource_init(void __iomem *base, const char *name)
-{
-	__sp804_clocksource_and_sched_clock_init(base, name, NULL, 0);
-}
-
-static inline void sp804_clocksource_and_sched_clock_init(void __iomem *base,
-							  const char *name)
-{
-	__sp804_clocksource_and_sched_clock_init(base, name, NULL, 1);
-}
-
-static inline void sp804_clockevents_init(void __iomem *base, unsigned int irq, const char *name)
-{
-	__sp804_clockevents_init(base, irq, NULL, name);
-
-}
-#endif
-- 
1.8.3


