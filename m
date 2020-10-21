Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6989F29464A
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 03:24:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2411089AbgJUBYB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 21:24:01 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:15757 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2411083AbgJUBYB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 21:24:01 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id DE3CDBB2DA24E56513F3;
        Wed, 21 Oct 2020 09:23:58 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.177.134) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.487.0; Wed, 21 Oct 2020 09:23:48 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        kbuild-all <kbuild-all@lists.01.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH v2 1/1] clocksource: sp804: add static for functions such as sp804_clockevents_init()
Date:   Wed, 21 Oct 2020 09:22:59 +0800
Message-ID: <20201021012259.2067-2-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
In-Reply-To: <20201021012259.2067-1-thunder.leizhen@huawei.com>
References: <20201021012259.2067-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.177.134]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add static for sp804_clocksource_and_sched_clock_init() and
sp804_clockevents_init(), they are only used in timer-sp804.c now.
Otherwise, the following warning will be reported:

drivers/clocksource/timer-sp804.c:68:12: warning: no previous prototype \
for 'sp804_clocksource_and_sched_clock_init' [-Wmissing-prototypes]
drivers/clocksource/timer-sp804.c:162:12: warning: no previous prototype \
for 'sp804_clockevents_init' [-Wmissing-prototypes]

Fixes: 975434f8b24a ("clocksource/drivers/sp804: Delete the leading "__" of some functions")
Fixes: 65f4d7ddc7b6 ("clocksource/drivers/sp804: Remove unused sp804_timer_disable() and timer-sp804.h")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 drivers/clocksource/timer-sp804.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/clocksource/timer-sp804.c b/drivers/clocksource/timer-sp804.c
index 6e8ad4a4ea3c737..db5330cc49bca72 100644
--- a/drivers/clocksource/timer-sp804.c
+++ b/drivers/clocksource/timer-sp804.c
@@ -117,10 +117,10 @@ static u64 notrace sp804_read(void)
 	return ~readl_relaxed(sched_clkevt->value);
 }
 
-int __init sp804_clocksource_and_sched_clock_init(void __iomem *base,
-						  const char *name,
-						  struct clk *clk,
-						  int use_sched_clock)
+static int __init sp804_clocksource_and_sched_clock_init(void __iomem *base,
+							 const char *name,
+							 struct clk *clk,
+							 int use_sched_clock)
 {
 	long rate;
 	struct sp804_clkevt *clkevt;
@@ -216,8 +216,8 @@ static int sp804_set_next_event(unsigned long next,
 	.rating			= 300,
 };
 
-int __init sp804_clockevents_init(void __iomem *base, unsigned int irq,
-				  struct clk *clk, const char *name)
+static int __init sp804_clockevents_init(void __iomem *base, unsigned int irq,
+					 struct clk *clk, const char *name)
 {
 	struct clock_event_device *evt = &sp804_clockevent;
 	long rate;
-- 
1.8.3


