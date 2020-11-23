Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 379B82C0B45
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 14:56:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388981AbgKWNW1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 08:22:27 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:7667 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731825AbgKWNWV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 08:22:21 -0500
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Cfnqq5QnKz15Qyl;
        Mon, 23 Nov 2020 21:21:59 +0800 (CST)
Received: from [10.174.176.199] (10.174.176.199) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.487.0; Mon, 23 Nov 2020 21:22:09 +0800
To:     <fweisbec@gmail.com>, <tglx@linutronix.de>, <mingo@kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Shiyuan Hu <hushiyuan@huawei.com>,
        Hewenliang <hewenliang4@huawei.com>
From:   Yunfeng Ye <yeyunfeng@huawei.com>
Subject: nohz: Update tick instead of restarting tick in tick_nohz_idle_exit()
Message-ID: <66014fea-7b84-358b-137d-d15190241528@huawei.com>
Date:   Mon, 23 Nov 2020 21:22:08 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.176.199]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In realtime scenarios, the "nohz_full" parameter is configured. Tick
interference is not expected when there is only one realtime thread.
But when the idle thread is switched to the realtime thread, the tick
timer is restarted always.

So on the nohz full mode, it is unnecessary to restart the tick timer
when there is only one realtime thread. Adding can_stop_full_tick()
before restarting the tick, if it return true, keep tick stopped.

Signed-off-by: Yunfeng Ye <yeyunfeng@huawei.com>
---
 kernel/time/tick-sched.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index cc7cba20382e..f664c7735cab 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -1208,6 +1208,20 @@ void tick_nohz_idle_restart_tick(void)
 		__tick_nohz_idle_restart_tick(ts, ktime_get());
 }

+static void tick_nohz_update_tick(struct tick_sched *ts, ktime_t now)
+{
+#ifdef CONFIG_NO_HZ_FULL
+	int cpu = smp_processor_id();
+
+	if (tick_nohz_full_cpu(cpu) && can_stop_full_tick(cpu, ts)) {
+		tick_nohz_stop_sched_tick(ts, cpu);
+		tick_nohz_account_idle_ticks(ts);
+		return;
+	}
+#endif
+	__tick_nohz_idle_restart_tick(ts, now);
+}
+
 /**
  * tick_nohz_idle_exit - restart the idle tick from the idle task
  *
@@ -1237,7 +1251,7 @@ void tick_nohz_idle_exit(void)
 		tick_nohz_stop_idle(ts, now);

 	if (tick_stopped)
-		__tick_nohz_idle_restart_tick(ts, now);
+		tick_nohz_update_tick(ts, now);

 	local_irq_enable();
 }
-- 
2.18.4
