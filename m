Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79BB82AE938
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 07:49:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726041AbgKKGtL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 01:49:11 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:7880 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725882AbgKKGsz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 01:48:55 -0500
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4CWFgW3R4Sz74wP;
        Wed, 11 Nov 2020 14:48:39 +0800 (CST)
Received: from huawei.com (10.175.103.91) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.487.0; Wed, 11 Nov 2020
 14:48:38 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <daniel.lezcano@linaro.org>, <tglx@linutronix.de>,
        <yangyingliang@huawei.com>
Subject: [PATCH] clocksource/drivers/orion: add missing clk_disable_unprepare() on error path
Date:   Wed, 11 Nov 2020 14:47:06 +0800
Message-ID: <20201111064706.3397156-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After calling clk_prepare_enable(), clk_disable_unprepare() need
be called on error path.

Fixes: fbe4b3566ddc ("clocksource/drivers/orion: Convert init function...")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/clocksource/timer-orion.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/clocksource/timer-orion.c b/drivers/clocksource/timer-orion.c
index d01ff4181867..5101e834d78f 100644
--- a/drivers/clocksource/timer-orion.c
+++ b/drivers/clocksource/timer-orion.c
@@ -143,7 +143,8 @@ static int __init orion_timer_init(struct device_node *np)
 	irq = irq_of_parse_and_map(np, 1);
 	if (irq <= 0) {
 		pr_err("%pOFn: unable to parse timer1 irq\n", np);
-		return -EINVAL;
+		ret = -EINVAL;
+		goto out_unprep_clk;
 	}
 
 	rate = clk_get_rate(clk);
@@ -160,7 +161,7 @@ static int __init orion_timer_init(struct device_node *np)
 				    clocksource_mmio_readl_down);
 	if (ret) {
 		pr_err("Failed to initialize mmio timer\n");
-		return ret;
+		goto out_unprep_clk;
 	}
 
 	sched_clock_register(orion_read_sched_clock, 32, rate);
@@ -170,7 +171,7 @@ static int __init orion_timer_init(struct device_node *np)
 			  "orion_event", NULL);
 	if (ret) {
 		pr_err("%pOFn: unable to setup irq\n", np);
-		return ret;
+		goto out_unprep_clk;
 	}
 
 	ticks_per_jiffy = (clk_get_rate(clk) + HZ/2) / HZ;
@@ -183,5 +184,9 @@ static int __init orion_timer_init(struct device_node *np)
 	orion_delay_timer_init(rate);
 
 	return 0;
+
+out_unprep_clk:
+	clk_disable_unprepare(clk);
+	return ret;
 }
 TIMER_OF_DECLARE(orion_timer, "marvell,orion-timer", orion_timer_init);
-- 
2.25.1

