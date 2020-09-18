Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6ADAA26FE4C
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 15:26:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726840AbgIRNXa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 09:23:30 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:13305 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726126AbgIRNXR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 09:23:17 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 7B91DB9DB31F4614ACC2;
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
Subject: [PATCH v3 4/9] clocksource: sp804: remove a mismatched comment
Date:   Fri, 18 Sep 2020 21:22:32 +0800
Message-ID: <20200918132237.3552-5-thunder.leizhen@huawei.com>
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

writel(0, base + TIMER_CTRL);
... ...
writel(xxx | TIMER_CTRL_PERIODIC, base + TIMER_CTRL);

The timer is just temporarily disabled, and it will be set to periodic
mode later.

The description of the field TimerMode of the register TimerXControl
as shown below:
0 = Timer module is in free-running mode (default)
1 = Timer module is in periodic mode.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 drivers/clocksource/timer-sp804.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/clocksource/timer-sp804.c b/drivers/clocksource/timer-sp804.c
index 097f5a83163c6e1..a443f392a8e7d63 100644
--- a/drivers/clocksource/timer-sp804.c
+++ b/drivers/clocksource/timer-sp804.c
@@ -76,7 +76,6 @@ int __init sp804_clocksource_and_sched_clock_init(void __iomem *base,
 	if (rate < 0)
 		return -EINVAL;
 
-	/* setup timer 0 as free-running clocksource */
 	writel(0, base + TIMER_CTRL);
 	writel(0xffffffff, base + TIMER_LOAD);
 	writel(0xffffffff, base + TIMER_VALUE);
-- 
1.8.3


