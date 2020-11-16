Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 682AA2B3D74
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 08:04:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727249AbgKPHEh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 02:04:37 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:7904 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727096AbgKPHEg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 02:04:36 -0500
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4CZKnL1xRBz6vVR;
        Mon, 16 Nov 2020 15:04:22 +0800 (CST)
Received: from huawei.com (10.175.127.227) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.487.0; Mon, 16 Nov 2020
 15:04:25 +0800
From:   Yu Kuai <yukuai3@huawei.com>
To:     <michal.simek@xilinx.com>, <daniel.lezcano@linaro.org>,
        <tglx@linutronix.de>, <soren.brinkmann@xilinx.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <yukuai3@huawei.com>,
        <yi.zhang@huawei.com>, <zhangxiaoxu5@huawei.com>
Subject: [PATCH V3] clocksource/drivers/cadence_ttc: fix memory leak in ttc_setup_clockevent()
Date:   Mon, 16 Nov 2020 15:08:02 +0800
Message-ID: <20201116070802.1353842-1-yukuai3@huawei.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <cd03869c-6ad1-1463-d7da-c8500adb32c8@linaro.org>
References: <cd03869c-6ad1-1463-d7da-c8500adb32c8@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If clk_notifier_register() failed, ttc_setup_clockevent() will return
without freeing 'ttcce', which will leak memory.

Fixes: 70504f311d4b ("clocksource/drivers/cadence_ttc: Convert init function to return error")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 drivers/clocksource/timer-cadence-ttc.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/clocksource/timer-cadence-ttc.c b/drivers/clocksource/timer-cadence-ttc.c
index 80e960602030..c410d1620e24 100644
--- a/drivers/clocksource/timer-cadence-ttc.c
+++ b/drivers/clocksource/timer-cadence-ttc.c
@@ -413,10 +413,8 @@ static int __init ttc_setup_clockevent(struct clk *clk,
 	ttcce->ttc.clk = clk;
 
 	err = clk_prepare_enable(ttcce->ttc.clk);
-	if (err) {
-		kfree(ttcce);
-		return err;
-	}
+	if (err)
+		go out_kfree;
 
 	ttcce->ttc.clk_rate_change_nb.notifier_call =
 		ttc_rate_change_clockevent_cb;
@@ -426,7 +424,7 @@ static int __init ttc_setup_clockevent(struct clk *clk,
 				    &ttcce->ttc.clk_rate_change_nb);
 	if (err) {
 		pr_warn("Unable to register clock notifier.\n");
-		return err;
+		goto out_kfree;
 	}
 
 	ttcce->ttc.freq = clk_get_rate(ttcce->ttc.clk);
@@ -455,15 +453,17 @@ static int __init ttc_setup_clockevent(struct clk *clk,
 
 	err = request_irq(irq, ttc_clock_event_interrupt,
 			  IRQF_TIMER, ttcce->ce.name, ttcce);
-	if (err) {
-		kfree(ttcce);
-		return err;
-	}
+	if (err)
+		goto out_kfree;
 
 	clockevents_config_and_register(&ttcce->ce,
 			ttcce->ttc.freq / PRESCALE, 1, 0xfffe);
 
 	return 0;
+
+out_kfree:
+	kfree(ttcce);
+	return err;
 }
 
 static int __init ttc_timer_probe(struct platform_device *pdev)
-- 
2.25.4

