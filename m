Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF0082B3CCA
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 07:08:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726742AbgKPGHp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 01:07:45 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:8091 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725379AbgKPGHp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 01:07:45 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4CZJWd6X6JzLp93;
        Mon, 16 Nov 2020 14:07:25 +0800 (CST)
Received: from [10.174.176.199] (10.174.176.199) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.487.0; Mon, 16 Nov 2020 14:07:01 +0800
Subject: Re: [PATCH] tick/nohz: Reduce the critical region for jiffies_seq
To:     Thomas Gleixner <tglx@linutronix.de>, <fweisbec@gmail.com>,
        <mingo@kernel.org>, <linux-kernel@vger.kernel.org>,
        Shiyuan Hu <hushiyuan@huawei.com>,
        Hewenliang <hewenliang4@huawei.com>
References: <ac822c72-673e-73e1-9622-c5f12591b373@huawei.com>
 <87h7pq8kyc.fsf@nanos.tec.linutronix.de>
From:   Yunfeng Ye <yeyunfeng@huawei.com>
Message-ID: <66c172ec-72a1-022a-d387-6c836a698912@huawei.com>
Date:   Mon, 16 Nov 2020 14:07:00 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <87h7pq8kyc.fsf@nanos.tec.linutronix.de>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.176.199]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2020/11/16 3:43, Thomas Gleixner wrote:
> On Wed, Nov 11 2020 at 17:11, Yunfeng Ye wrote:
>> When nohz or nohz_full is configured, the concurrency calls of
>> tick_do_update_jiffies64 increases,
> 
> Why?
> 
When nohz=off, tick_do_update_jiffies64() is called by tick_sched_do_timer()
on the tick_do_timer_cpu only. But when nohz and nohz_full is on, the
concurrency calls of tick_do_update_jiffies64() increases, and it may be
called on every cpu cores, for example:

1)
irq_enter
    tick_irq_enter
        tick_nohz_irq_enter
            tick_nohz_update_jiffies
2)
irq_exit
    irq_exit_rcu
        tick_irq_exit
            tick_nohz_irq_exit
                tick_nohz_full_update_tick
                    tick_nohz_restart_sched_tick
                        tick_do_update_jiffies64
3)
tick_nohz_idle_exit
    __tick_nohz_idle_restart_tick
        tick_nohz_restart_sched_tick
            tick_do_update_jiffies64

>> and the conflict between jiffies_lock and jiffies_seq increases,
>> especially in multi-core scenarios.
> 
> This does not make sense. The sequence counter is updated when holding
> the lock, so there is no conflict between the lock and the sequence
> count.
> 
Yes, there is no conflict between the lock and the sequence count, but
when tick_do_update_jiffies64() is called one by one, the sequence count
will be updated, it will affect the latency of tick_nohz_next_event(),
because the priority of read seqcount is less than writer.

We meet a problem, the latency between irq_handler_exit and schedule cost
up to 9us, or more, we want to schedule quickly. below is the trace:

    =>262651:           <...>-87332 [013] dnh.  3773.487455: irq_handler_exit: irq=4 ret=handled
    =>262666:           <...>-87332 [013] dn..  3773.487464: rcu_utilization: Start context switch
      262667:           <...>-87332 [013] dn..  3773.487464: rcu_utilization: End context switch

We use function_graph ftrace to find which function cost so much, and
find that it is tick_nohz_irq_exit():

      80519.988765 |   31)               |  irq_exit() {
      80519.988766 |   31)               |    tick_nohz_irq_exit() {
    =>80519.988766 |   31)               |      tick_nohz_next_event() {
    =>80519.988774 |   31)   0.570 us    |        get_next_timer_interrupt();
      80519.988775 |   31)   0.390 us    |        timekeeping_max_deferment();
      80519.988775 |   31)   9.200 us    |      }
      80519.988776 |   31)   0.390 us    |      tick_nohz_stop_tick();
      80519.988776 |   31) + 10.700 us   |    }
      80519.988777 |   31) + 11.630 us   |  }
      80519.988777 |   31)               |  /* rcu_utilization: Start context switch */

The time between timestamp 80519.988766 and 80519.988774 is most, in function
tick_nohz_next_event(), there are the codes before calling
get_next_timer_interrupt():

    static ktime_t tick_nohz_next_event(struct tick_sched *ts, int cpu)
    {
        u64 basemono, next_tick, next_tmr, next_rcu, delta, expires;
        unsigned long basejiff;
        unsigned int seq;

        /* Read jiffies and the time when jiffies were updated last */
        do {
            seq = read_seqcount_begin(&jiffies_seq);
            basemono = last_jiffies_update;
            basejiff = jiffies;
        } while (read_seqcount_retry(&jiffies_seq, seq));
        ts->last_jiffies = basejiff;
        ts->timer_expires_base = basemono;

So the reason is that the read_seqcount leading to the latency problem. we
want to reduce the critical region of the jiffies_seq.

We still to trace tick_do_update_jiffies64 function:

    167044.988746 |    5) + 34.720 us   |  } /* tick_do_update_jiffies64.part.2 */
    167044.988747 |   90) + 24.920 us   |  } /* tick_nohz_next_event */
    167044.988747 |    2) + 18.990 us   |  } /* tick_nohz_next_event */
    167044.988747 |   84) + 17.430 us   |  } /* irq_exit */
    167044.988748 |   92) + 34.150 us   |  } /* irq_exit */
    167044.988749 |   63)   7.150 us    |  } /* generic_handle_irq */
    167044.988750 |    5)   3.120 us    |  } /* generic_handle_irq */
    167044.988750 |   14) + 38.940 us   |  } /* tick_do_update_jiffies64.part.2 */
    167044.988751 |   61)   5.080 us    |  } /* tick_nohz_next_event */
    167044.988751 |   23) + 35.010 us   |  } /* tick_nohz_next_event */
    167044.988751 |   22) + 24.830 us   |  } /* tick_nohz_next_event */
    167044.988751 |   28) + 40.140 us   |  } /* tick_do_update_jiffies64.part.2 */

During a tick period, the tick_do_update_jiffies64() is called concurrency, and the
time is up to 30+us. so the lockless quick check in tick_do_update_jiffies64()
cannot intercept all concurrency.

Currently we use the cmdline parameter "skew_tick=1" can reduce the the latency mostly,
because the conflict is mainly caused by tick timer. But we still want to reduce the
critical region of the jiffies_seq to reduce some latency, maybe many other
interrupt or timer happens at the same will still trigger the conflict.

>> However, it is unnecessary to update the jiffies_seq lock multiple
>> times in a tick period, so the critical region of the jiffies_seq
>> can be reduced to reduce latency overheads.
> 
> This does not make sense either. Before taking the lock we have:
> 
>         delta = ktime_sub(now, READ_ONCE(last_jiffies_update));
>         if (delta < tick_period)
>                 return;
> 
> as a lockless quick check.
> 
> We also have mechanisms to avoid that a gazillion of CPUs call this. Why
> are they not working or are some of the callsites missing them?
> 
> I'm not against reducing the seqcount write scope per se, but it needs a
> proper and correct explanation.
> 
Yes, there is a lockless quick check, but we have hundreds of cpu cores,
this lockless detection cannot intercept all concurrency.

>> By the way, last_jiffies_update is protected by jiffies_lock, so
>> reducing the jiffies_seq critical area is safe.
> 
> This is misleading. The write to last_jiffies_update is serialized by
> the jiffies lock, but the write has also to be inside the sequence write
> held section because tick_nohz_next_event() does:
> 
> 	/* Read jiffies and the time when jiffies were updated last */
> 	do {
> 		seq = read_seqcount_begin(&jiffies_seq);
> 		basemono = last_jiffies_update;
> 		basejiff = jiffies;
> 	} while (read_seqcount_retry(&jiffies_seq, seq));
> 
> So there is no 'By the way'.
> 
It is misleading indeed, I means when reducing the critical region of the jiffies_seq,
the read of last_jiffies_update is still under the protected by jiffies_lock.

Thanks.

> Thanks,
> 
>         tglx
> .
> 
