Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30965267A21
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Sep 2020 13:48:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725871AbgILLsR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Sep 2020 07:48:17 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:58926 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725883AbgILLqD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Sep 2020 07:46:03 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 109DE72FCE2080428A1C;
        Sat, 12 Sep 2020 19:46:02 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.177.253) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.487.0; Sat, 12 Sep 2020 19:45:53 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>,
        Libin <huawei.libin@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Jianguo Chen <chenjianguo3@huawei.com>
Subject: [PATCH v2 4/9] clocksource: sp804: remove a mismatched comment
Date:   Sat, 12 Sep 2020 19:45:31 +0800
Message-ID: <20200912114536.2910-5-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
In-Reply-To: <20200912114536.2910-1-thunder.leizhen@huawei.com>
References: <20200912114536.2910-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.177.253]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
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
index 097f5a83163c..a443f392a8e7 100644
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
2.26.0.106.g9fadedd


