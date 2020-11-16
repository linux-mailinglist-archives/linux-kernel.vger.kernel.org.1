Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9D812B44A8
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 14:25:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729064AbgKPNYg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 08:24:36 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:7545 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726615AbgKPNYg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 08:24:36 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4CZVCn2y74zhb1C;
        Mon, 16 Nov 2020 21:24:21 +0800 (CST)
Received: from [10.174.176.199] (10.174.176.199) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.487.0; Mon, 16 Nov 2020 21:24:23 +0800
Subject: Re: [PATCH] tick/nohz: Reduce the critical region for jiffies_seq
To:     Thomas Gleixner <tglx@linutronix.de>, <fweisbec@gmail.com>,
        <mingo@kernel.org>, <linux-kernel@vger.kernel.org>,
        Shiyuan Hu <hushiyuan@huawei.com>,
        Hewenliang <hewenliang4@huawei.com>
References: <ac822c72-673e-73e1-9622-c5f12591b373@huawei.com>
 <87h7pq8kyc.fsf@nanos.tec.linutronix.de>
 <66c172ec-72a1-022a-d387-6c836a698912@huawei.com>
 <87o8jxzgj7.fsf@nanos.tec.linutronix.de>
From:   Yunfeng Ye <yeyunfeng@huawei.com>
Message-ID: <b08bc867-91db-3fcc-8927-ac94db2327cd@huawei.com>
Date:   Mon, 16 Nov 2020 21:24:23 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <87o8jxzgj7.fsf@nanos.tec.linutronix.de>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.176.199]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2020/11/16 19:29, Thomas Gleixner wrote:
> On Mon, Nov 16 2020 at 14:07, Yunfeng Ye wrote:
>> On 2020/11/16 3:43, Thomas Gleixner wrote:
>>>> and the conflict between jiffies_lock and jiffies_seq increases,
>>>> especially in multi-core scenarios.
>>>
>>> This does not make sense. The sequence counter is updated when holding
>>> the lock, so there is no conflict between the lock and the sequence
>>> count.
>>>
>> Yes, there is no conflict between the lock and the sequence count, but
>> when tick_do_update_jiffies64() is called one by one, the sequence count
>> will be updated, it will affect the latency of tick_nohz_next_event(),
>> because the priority of read seqcount is less than writer.
> 
> It's clear to me because I know how that code works, but for someone who
> is not familiar with it your description of the problem is confusing at
> best.
> 
>> During a tick period,
> 
> 'During a tick period' is misleading. The tick period is the reciprocal
> value ot the tick frequency.
> 
> What you want to explain is that if jiffies require an update, i.e.
> 
>      now > last_update + period
> 
> then multiple CPUs might contend on it until last_update is forwarded
> and the quick check is preventing it again.
> 
Yes, your are right, thanks.

>> the tick_do_update_jiffies64() is called concurrency, and the
>> time is up to 30+us. so the lockless quick check in tick_do_update_jiffies64()
>> cannot intercept all concurrency.
> 
> It cannot catch all of it, right. 
> 
> There are quite some other inefficiencies in that code and the seqcount
> held time can be reduced way further. Let me stare at it.
> 
I think the write seqcount only protecting the last_jiffies_update/jiffies_64/
tick_next_period is enough. The modification which has not been tested,
look like this:

diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index f0199a4ba1ad..d5f9930e6bc7 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -66,15 +66,13 @@ static void tick_do_update_jiffies64(ktime_t now)

 	/* Reevaluate with jiffies_lock held */
 	raw_spin_lock(&jiffies_lock);
-	write_seqcount_begin(&jiffies_seq);

 	delta = ktime_sub(now, last_jiffies_update);
 	if (delta >= tick_period) {
+		ktime_t tmp_jiffies_update =
+			   ktime_add(last_jiffies_update, tick_period);

 		delta = ktime_sub(delta, tick_period);
-		/* Pairs with the lockless read in this function. */
-		WRITE_ONCE(last_jiffies_update,
-			   ktime_add(last_jiffies_update, tick_period));

 		/* Slow path for long timeouts */
 		if (unlikely(delta >= tick_period)) {
@@ -82,21 +80,25 @@ static void tick_do_update_jiffies64(ktime_t now)

 			ticks = ktime_divns(delta, incr);

-			/* Pairs with the lockless read in this function. */
-			WRITE_ONCE(last_jiffies_update,
-				   ktime_add_ns(last_jiffies_update,
-						incr * ticks));
+			tmp_jiffies_update =
+				   ktime_add_ns(tmp_jiffies_update,
+						incr * ticks);
 		}
-		do_timer(++ticks);
+		ticks++;
+
+		write_seqcount_begin(&jiffies_seq);
+		/* Pairs with the lockless read in this function. */
+		WRITE_ONCE(last_jiffies_update, tmp_jiffies_update);
+		jiffies_64 += ticks;

 		/* Keep the tick_next_period variable up to date */
 		tick_next_period = ktime_add(last_jiffies_update, tick_period);
-	} else {
 		write_seqcount_end(&jiffies_seq);
+		calc_global_load();
+	} else {
 		raw_spin_unlock(&jiffies_lock);
 		return;
 	}
-	write_seqcount_end(&jiffies_seq);
 	raw_spin_unlock(&jiffies_lock);
 	update_wall_time();
 }

> Thanks,
> 
>         tglx
> .
> 
