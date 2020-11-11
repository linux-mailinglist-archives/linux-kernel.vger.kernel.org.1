Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C209A2AED00
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 10:12:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726759AbgKKJMY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 04:12:24 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:7206 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726593AbgKKJMR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 04:12:17 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4CWJrj3WWnzkgWh;
        Wed, 11 Nov 2020 17:11:49 +0800 (CST)
Received: from [10.174.176.199] (10.174.176.199) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.487.0; Wed, 11 Nov 2020 17:11:52 +0800
To:     <fweisbec@gmail.com>, <tglx@linutronix.de>, <mingo@kernel.org>,
        <linux-kernel@vger.kernel.org>, Shiyuan Hu <hushiyuan@huawei.com>,
        Hewenliang <hewenliang4@huawei.com>
From:   Yunfeng Ye <yeyunfeng@huawei.com>
Subject: [PATCH] tick/nohz: Reduce the critical region for jiffies_seq
Message-ID: <ac822c72-673e-73e1-9622-c5f12591b373@huawei.com>
Date:   Wed, 11 Nov 2020 17:11:39 +0800
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

When nohz or nohz_full is configured, the concurrency calls of
tick_do_update_jiffies64 increases, and the conflict between
jiffies_lock and jiffies_seq increases, especially in multi-core
scenarios.

However, it is unnecessary to update the jiffies_seq lock multiple
times in a tick period, so the critical region of the jiffies_seq
can be reduced to reduce latency overheads. By the way,
last_jiffies_update is protected by jiffies_lock, so reducing the
jiffies_seq critical area is safe.

Signed-off-by: Yunfeng Ye <yeyunfeng@huawei.com>
---
 kernel/time/tick-sched.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index f0199a4ba1ad..41fb1400439b 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -66,11 +66,11 @@ static void tick_do_update_jiffies64(ktime_t now)

 	/* Reevaluate with jiffies_lock held */
 	raw_spin_lock(&jiffies_lock);
-	write_seqcount_begin(&jiffies_seq);

 	delta = ktime_sub(now, last_jiffies_update);
 	if (delta >= tick_period) {

+		write_seqcount_begin(&jiffies_seq);
 		delta = ktime_sub(delta, tick_period);
 		/* Pairs with the lockless read in this function. */
 		WRITE_ONCE(last_jiffies_update,
@@ -91,12 +91,11 @@ static void tick_do_update_jiffies64(ktime_t now)

 		/* Keep the tick_next_period variable up to date */
 		tick_next_period = ktime_add(last_jiffies_update, tick_period);
-	} else {
 		write_seqcount_end(&jiffies_seq);
+	} else {
 		raw_spin_unlock(&jiffies_lock);
 		return;
 	}
-	write_seqcount_end(&jiffies_seq);
 	raw_spin_unlock(&jiffies_lock);
 	update_wall_time();
 }
-- 
2.18.4
