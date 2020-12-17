Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B82A52DCCC3
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Dec 2020 07:53:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727358AbgLQGxC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Dec 2020 01:53:02 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:9628 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726569AbgLQGxB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Dec 2020 01:53:01 -0500
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4CxN2M5Ghnz15YMZ;
        Thu, 17 Dec 2020 14:51:39 +0800 (CST)
Received: from [10.174.176.199] (10.174.176.199) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.498.0; Thu, 17 Dec 2020 14:52:10 +0800
Subject: Re: [PATCH] tick/nohz: Make the idle_exittime update correctly
To:     Frederic Weisbecker <frederic@kernel.org>
CC:     <fweisbec@gmail.com>, <tglx@linutronix.de>, <mingo@kernel.org>,
        <linux-kernel@vger.kernel.org>, Shiyuan Hu <hushiyuan@huawei.com>,
        Hewenliang <hewenliang4@huawei.com>
References: <2e194669-c074-069c-4fda-ad5bc313a611@huawei.com>
 <bc6f830d-21da-b334-9dfd-54dcf2d4f7a0@huawei.com>
 <20201215144757.GA9391@lothringen>
From:   Yunfeng Ye <yeyunfeng@huawei.com>
Message-ID: <e1a3b328-6684-77d8-8d28-9baa36980403@huawei.com>
Date:   Thu, 17 Dec 2020 14:51:58 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20201215144757.GA9391@lothringen>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.176.199]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2020/12/15 22:47, Frederic Weisbecker wrote:
> On Tue, Dec 15, 2020 at 08:06:34PM +0800, Yunfeng Ye wrote:
>> The idle_exittime field of tick_sched is used to record the time when
>> the idle state was left. but currently the idle_exittime is updated in
>> the function tick_nohz_restart_sched_tick(), which is not always in idle
>> state when nohz_full is configured.
>>
>>   tick_irq_exit
>>     tick_nohz_irq_exit
>>       tick_nohz_full_update_tick
>>         tick_nohz_restart_sched_tick
>>           ts->idle_exittime = now;
>>
>> So move to tick_nohz_stop_idle() to make the idle_exittime update
>> correctly.
>>
>> Signed-off-by: Yunfeng Ye <yeyunfeng@huawei.com>
>> ---
>>  kernel/time/tick-sched.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
>> index 749ec2a583de..be2e5d772d50 100644
>> --- a/kernel/time/tick-sched.c
>> +++ b/kernel/time/tick-sched.c
>> @@ -591,6 +591,7 @@ static void tick_nohz_stop_idle(struct tick_sched *ts, ktime_t now)
>>  {
>>  	update_ts_time_stats(smp_processor_id(), ts, now, NULL);
>>  	ts->idle_active = 0;
>> +	ts->idle_exittime = now;
> 
> This changes a bit the meaning of idle_exittime then since this is also called
> from idle interrupt entry.
> 
> __tick_nohz_idle_restart_tick() would be a better place.
> 
So is it necessary to modify the comment "@idle_exittime:      Time when the idle state was left" ?

On the other hand, if the patch "nohz: Update tick instead of restarting tick in tick_nohz_idle_exit()"
(https://www.spinics.net/lists/kernel/msg3747039.html ) applied, __tick_nohz_idle_restart_tick will not
be called always, So is it put here also a better place?

Thanks.

> Thanks.
> 
>>
>>  	sched_clock_idle_wakeup_event();
>>  }
>> @@ -901,7 +902,6 @@ static void tick_nohz_restart_sched_tick(struct tick_sched *ts, ktime_t now)
>>  	 * Cancel the scheduled timer and restore the tick
>>  	 */
>>  	ts->tick_stopped  = 0;
>> -	ts->idle_exittime = now;
>>
>>  	tick_nohz_restart(ts, now);
>>  }
>> -- 
>> 2.18.4
>>
> .
> 
