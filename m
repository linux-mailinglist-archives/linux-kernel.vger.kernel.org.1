Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4289726FE43
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 15:26:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726787AbgIRNXP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 09:23:15 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:13306 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726121AbgIRNXL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 09:23:11 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 7661B4A67D1F7224016B;
        Fri, 18 Sep 2020 21:23:08 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.177.253) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.487.0; Fri, 18 Sep 2020 21:22:58 +0800
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
Subject: [PATCH v3 1/9] clocksource: sp804: cleanup clk_get_sys()
Date:   Fri, 18 Sep 2020 21:22:29 +0800
Message-ID: <20200918132237.3552-2-thunder.leizhen@huawei.com>
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

From: Kefeng Wang <wangkefeng.wang@huawei.com>

Move the clk_get_sys() part into sp804_get_clock_rate(), cleanup the same
code.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 drivers/clocksource/timer-sp804.c | 30 ++++++++++--------------------
 1 file changed, 10 insertions(+), 20 deletions(-)

diff --git a/drivers/clocksource/timer-sp804.c b/drivers/clocksource/timer-sp804.c
index 5cd0abf9b3965fe..bec2d372e0df018 100644
--- a/drivers/clocksource/timer-sp804.c
+++ b/drivers/clocksource/timer-sp804.c
@@ -22,11 +22,18 @@
 
 #include "timer-sp.h"
 
-static long __init sp804_get_clock_rate(struct clk *clk)
+static long __init sp804_get_clock_rate(struct clk *clk, const char *name)
 {
 	long rate;
 	int err;
 
+	if (!clk)
+		clk = clk_get_sys("sp804", name);
+	if (IS_ERR(clk)) {
+		pr_err("sp804: %s clock not found: %ld\n", name, PTR_ERR(clk));
+		return PTR_ERR(clk);
+	}
+
 	err = clk_prepare(clk);
 	if (err) {
 		pr_err("sp804: clock failed to prepare: %d\n", err);
@@ -72,16 +79,7 @@ int  __init __sp804_clocksource_and_sched_clock_init(void __iomem *base,
 {
 	long rate;
 
-	if (!clk) {
-		clk = clk_get_sys("sp804", name);
-		if (IS_ERR(clk)) {
-			pr_err("sp804: clock not found: %d\n",
-			       (int)PTR_ERR(clk));
-			return PTR_ERR(clk);
-		}
-	}
-
-	rate = sp804_get_clock_rate(clk);
+	rate = sp804_get_clock_rate(clk, name);
 	if (rate < 0)
 		return -EINVAL;
 
@@ -173,15 +171,7 @@ int __init __sp804_clockevents_init(void __iomem *base, unsigned int irq, struct
 	struct clock_event_device *evt = &sp804_clockevent;
 	long rate;
 
-	if (!clk)
-		clk = clk_get_sys("sp804", name);
-	if (IS_ERR(clk)) {
-		pr_err("sp804: %s clock not found: %d\n", name,
-			(int)PTR_ERR(clk));
-		return PTR_ERR(clk);
-	}
-
-	rate = sp804_get_clock_rate(clk);
+	rate = sp804_get_clock_rate(clk, name);
 	if (rate < 0)
 		return -EINVAL;
 
-- 
1.8.3


