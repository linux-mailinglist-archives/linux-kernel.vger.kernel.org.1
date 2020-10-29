Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC74229EBDB
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 13:28:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726598AbgJ2M1w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 08:27:52 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:6930 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725771AbgJ2M1t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 08:27:49 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4CMPpg448vz70Xl;
        Thu, 29 Oct 2020 20:27:39 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.487.0; Thu, 29 Oct 2020 20:27:30 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        <linux-kernel@vger.kernel.org>
CC:     Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH 4/4] clocksource/drivers/sp804: Use pr_fmt
Date:   Thu, 29 Oct 2020 20:33:17 +0800
Message-ID: <20201029123317.90286-5-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201029123317.90286-1-wangkefeng.wang@huawei.com>
References: <20201029123317.90286-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add pr_fmt to prefix pr_<level> output.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 drivers/clocksource/timer-sp804.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/clocksource/timer-sp804.c b/drivers/clocksource/timer-sp804.c
index e0b48ecf20ab..778ad71a77ac 100644
--- a/drivers/clocksource/timer-sp804.c
+++ b/drivers/clocksource/timer-sp804.c
@@ -5,6 +5,9 @@
  *  Copyright (C) 1999 - 2003 ARM Limited
  *  Copyright (C) 2000 Deep Blue Solutions Ltd
  */
+
+#define pr_fmt(fmt)    KBUILD_MODNAME ": " fmt
+
 #include <linux/clk.h>
 #include <linux/clocksource.h>
 #include <linux/clockchips.h>
@@ -63,13 +66,13 @@ static long __init sp804_get_clock_rate(struct clk *clk, const char *name)
 	if (!clk)
 		clk = clk_get_sys("sp804", name);
 	if (IS_ERR(clk)) {
-		pr_err("sp804: %s clock not found: %ld\n", name, PTR_ERR(clk));
+		pr_err("%s clock not found: %ld\n", name, PTR_ERR(clk));
 		return PTR_ERR(clk);
 	}
 
 	err = clk_prepare_enable(clk);
 	if (err) {
-		pr_err("sp804: clock failed to enable: %d\n", err);
+		pr_err("clock failed to enable: %d\n", err);
 		clk_put(clk);
 		return err;
 	}
@@ -218,7 +221,7 @@ static int __init sp804_clockevents_init(void __iomem *base, unsigned int irq,
 
 	if (request_irq(irq, sp804_timer_interrupt, IRQF_TIMER | IRQF_IRQPOLL,
 			"timer", &sp804_clockevent))
-		pr_err("%s: request_irq() failed\n", "timer");
+		pr_err("request_irq() failed\n");
 	clockevents_config_and_register(evt, rate, 0xf, 0xffffffff);
 
 	return 0;
@@ -280,7 +283,7 @@ static int __init sp804_of_init(struct device_node *np, struct sp804_timer *time
 	if (of_clk_get_parent_count(np) == 3) {
 		clk2 = of_clk_get(np, 1);
 		if (IS_ERR(clk2)) {
-			pr_err("sp804: %pOFn clock not found: %d\n", np,
+			pr_err("%pOFn clock not found: %d\n", np,
 				(int)PTR_ERR(clk2));
 			clk2 = NULL;
 		}
-- 
2.26.2

