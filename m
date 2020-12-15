Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DF592DACB8
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 13:10:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729044AbgLOMHj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 07:07:39 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:9531 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727282AbgLOMHi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 07:07:38 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4CwH6L6hsYzhs8G;
        Tue, 15 Dec 2020 20:06:18 +0800 (CST)
Received: from [10.174.176.199] (10.174.176.199) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.498.0; Tue, 15 Dec 2020 20:06:46 +0800
Subject: [PATCH] tick/nohz: Make the idle_exittime update correctly
From:   Yunfeng Ye <yeyunfeng@huawei.com>
To:     <fweisbec@gmail.com>, <tglx@linutronix.de>, <mingo@kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Shiyuan Hu <hushiyuan@huawei.com>,
        Hewenliang <hewenliang4@huawei.com>
References: <2e194669-c074-069c-4fda-ad5bc313a611@huawei.com>
Message-ID: <bc6f830d-21da-b334-9dfd-54dcf2d4f7a0@huawei.com>
Date:   Tue, 15 Dec 2020 20:06:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <2e194669-c074-069c-4fda-ad5bc313a611@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.176.199]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The idle_exittime field of tick_sched is used to record the time when
the idle state was left. but currently the idle_exittime is updated in
the function tick_nohz_restart_sched_tick(), which is not always in idle
state when nohz_full is configured.

  tick_irq_exit
    tick_nohz_irq_exit
      tick_nohz_full_update_tick
        tick_nohz_restart_sched_tick
          ts->idle_exittime = now;

So move to tick_nohz_stop_idle() to make the idle_exittime update
correctly.

Signed-off-by: Yunfeng Ye <yeyunfeng@huawei.com>
---
 kernel/time/tick-sched.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index 749ec2a583de..be2e5d772d50 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -591,6 +591,7 @@ static void tick_nohz_stop_idle(struct tick_sched *ts, ktime_t now)
 {
 	update_ts_time_stats(smp_processor_id(), ts, now, NULL);
 	ts->idle_active = 0;
+	ts->idle_exittime = now;

 	sched_clock_idle_wakeup_event();
 }
@@ -901,7 +902,6 @@ static void tick_nohz_restart_sched_tick(struct tick_sched *ts, ktime_t now)
 	 * Cancel the scheduled timer and restore the tick
 	 */
 	ts->tick_stopped  = 0;
-	ts->idle_exittime = now;

 	tick_nohz_restart(ts, now);
 }
-- 
2.18.4

