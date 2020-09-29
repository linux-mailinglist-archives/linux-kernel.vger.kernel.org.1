Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2DDB27C0B7
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 11:15:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727907AbgI2JPS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 05:15:18 -0400
Received: from foss.arm.com ([217.140.110.172]:38146 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727775AbgI2JPS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 05:15:18 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3526E31B;
        Tue, 29 Sep 2020 02:15:17 -0700 (PDT)
Received: from [192.168.178.2] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F32FA3F73B;
        Tue, 29 Sep 2020 02:15:14 -0700 (PDT)
Subject: Re: [PATCH 0/9] sched: Migrate disable support
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, tglx@linutronix.de,
        mingo@kernel.org, linux-kernel@vger.kernel.org,
        bigeasy@linutronix.de, qais.yousef@arm.com, swood@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vincent.donnefort@arm.com
References: <20200921163557.234036895@infradead.org>
 <6f55a303-0e5c-8e84-65d3-798b589a5d75@arm.com>
 <20200925101030.GA2594@hirez.programming.kicks-ass.net>
 <d26d81ec-01d6-f6c0-816b-fbd8bb71e132@arm.com> <jhj7dsi82w9.mognet@arm.com>
 <jhj1ripoift.mognet@arm.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <9116c582-60ff-9cb1-166b-1e1a9b38841d@arm.com>
Date:   Tue, 29 Sep 2020 11:15:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <jhj1ripoift.mognet@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/09/2020 19:49, Valentin Schneider wrote:
> 
> On 25/09/20 13:19, Valentin Schneider wrote:
>> On 25/09/20 12:58, Dietmar Eggemann wrote:
>>> With Valentin's print_rq() inspired test snippet I always see one of the
>>> RT user tasks as the second guy? BTW, it has to be RT tasks, never
>>> triggered with CFS tasks.
>>>
>>> [   57.849268] CPU2 nr_running=2
>>> [   57.852241]  p=migration/2
>>> [   57.854967]  p=task0-0
>>
>> I can also trigger the BUG_ON() using the built-in locktorture module
>> (+enabling hotplug torture), and it happens very early on. I can't trigger
>> it under qemu sadly :/ Also, in my case it's always a kworker:
>>
>> [    0.830462] CPU3 nr_running=2
>> [    0.833443]  p=migration/3
>> [    0.836150]  p=kworker/3:0
>>
>> I'm looking into what workqueue.c is doing about hotplug...
> 
> So with
> - The pending migration fixup (20200925095615.GA2651@hirez.programming.kicks-ass.net)
> - The workqueue set_cpus_allowed_ptr() change (from IRC)
> - The set_rq_offline() move + DL/RT pull && rq->online (also from IRC)
> 
> my Juno survives rtmutex + hotplug locktorture, where it would previously
> explode < 1s after boot (mostly due to the workqueue thing).
> 
> I stared a bit more at the rq_offline() + DL/RT bits and they look fine to
> me.
> 
> The one thing I'm not entirely sure about is while you plugged the
> class->balance() hole, AIUI we might still get RT (DL?) pull callbacks
> enqueued - say if we just unthrottled an RT RQ and something changes the
> priority of one of the freshly-released tasks (user or rtmutex
> interaction), I don't see any stopgap preventing a pull from happening.
> 
> I slapped the following on top of my kernel and it didn't die, although I'm
> not sure I'm correctly stressing this path. Perhaps we could limit that to
> the pull paths, since technically we're okay with pushing out of an !online
> RQ.
> 
> ---
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 50aac5b6db26..00d1a7b85e97 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -1403,7 +1403,7 @@ queue_balance_callback(struct rq *rq,
>  {
>         lockdep_assert_held(&rq->lock);
> 
> -	if (unlikely(head->next))
> +	if (unlikely(head->next || !rq->online))
>                 return;
> 
>         head->func = (void (*)(struct callback_head *))func;
> ---

When I use the original patch-set (i.e. without the pending migration
fixup and the two changes from IRC) it looks like that the rt task is
already on the rq before the rq_offline_rt() -> __disable_runtime() call.

pr_crit("CPU%d X: %d %d %lu %lu %d %d %d %llu %llu\n",
         cpu_of(rq), rq->nr_running,
         rt_rq->rt_nr_running, rt_rq->rt_nr_migratory,
         rt_rq->rt_nr_total, rt_rq->overloaded,
         rt_rq->rt_queued, rt_rq->rt_throttled,
         rt_rq->rt_time, rt_rq->rt_runtime);

X = 1 : in rq_offline_rt() before __disable_runtime()
    2 :       "            after        "
    3 : in rq_online_rt()  before __enable_runtime()
    4 :       "            after        "
    5 : in sched_cpu_dying() if (rq->nr_running > 1)

*[   70.369719] CPU0 1: 1 1 1 1 0 1 0 36093160 950000000
*[   70.374689] CPU0 2: 1 1 1 1 0 1 0 36093160 18446744073709551615
*[   70.380615] CPU0 3: 1 1 1 1 0 1 0 36093160 18446744073709551615
*[   70.386540] CPU0 4: 1 1 1 1 0 1 0 0 950000000
 [   70.395637] CPU1 1: 1 0 0 0 0 0 0 31033300 950000000
 [   70.400606] CPU1 2: 1 0 0 0 0 0 0 31033300 18446744073709551615
 [   70.406532] CPU1 3: 1 0 0 0 0 0 0 31033300 18446744073709551615
 [   70.412457] CPU1 4: 1 0 0 0 0 0 0 0 950000000
 [   70.421609] CPU4 1: 0 0 0 0 0 0 0 19397300 950000000
 [   70.426577] CPU4 2: 0 0 0 0 0 0 0 19397300 18446744073709551615
 [   70.432503] CPU4 3: 0 0 0 0 0 0 0 19397300 18446744073709551615
 [   70.438428] CPU4 4: 0 0 0 0 0 0 0 0 950000000
 [   70.484133] CPU3 3: 2 0 0 0 0 0 0 3907020 18446744073709551615
 [   70.489984] CPU3 4: 2 0 0 0 0 0 0 0 950000000
 [   70.540112] CPU2 3: 1 0 0 0 0 0 0 3605180 18446744073709551615
 [   70.545953] CPU2 4: 1 0 0 0 0 0 0 0 950000000
*[   70.647548] CPU0 1: 2 1 1 1 0 1 0 5150760 950000000
*[   70.652441] CPU0 2: 2 1 1 1 0 1 0 5150760 18446744073709551615
*[   70.658281] CPU0 nr_running=2
 [   70.661255]  p=migration/0
 [   70.664022]  p=task0-4
*[   70.666384] CPU0 5: 2 1 1 1 0 1 0 5150760 18446744073709551615
 [   70.672230] ------------[ cut here ]------------
 [   70.676850] kernel BUG at kernel/sched/core.c:7346!
 [   70.681733] Internal error: Oops - BUG: 0 [#1] PREEMPT SMP
 [   70.687223] Modules linked in:
 [   70.690284] CPU: 0 PID: 11 Comm: migration/0 Not tainted 5.9.0-
rc1-00134-g7104613975b6-dirty #173
 [   70.699168] Hardware name: ARM Juno development board (r0) (DT)
 [   70.705107] Stopper: multi_cpu_stop+0x0/0x170 <- 0x0
 [   70.710078] pstate: 20000085 (nzCv daIf -PAN -UAO BTYPE=--)
 [   70.715661] pc : sched_cpu_dying+0x210/0x250
 [   70.719936] lr : sched_cpu_dying+0x204/0x250
 [   70.724207] sp : ffff800011e7bc60
 [   70.727521] x29: ffff800011e7bc80 x28: 0000000000000002
 [   70.732840] x27: 0000000000000000 x26: ffff800011ab30c0
 [   70.738159] x25: ffff8000112d37e0 x24: ffff800011ab30c0
 [   70.743477] x23: ffff800011ab3440 x22: ffff000975e40790
 [   70.748796] x21: 0000000000000080 x20: 0000000000000000
 [   70.754115] x19: ffff00097ef591c0 x18: 0000000000000010
 [   70.759433] x17: 0000000000000000 x16: 0000000000000000
 [   70.764752] x15: ffff000975cf2108 x14: ffffffffffffffff
 [   70.770070] x13: ffff800091e7b9e7 x12: ffff800011e7b9ef
 [   70.775388] x11: ffff800011ac2000 x10: ffff800011ce86d0
 [   70.780707] x9 : 0000000000000001 x8 : ffff800011ce9000
 [   70.786026] x7 : ffff8000106edad8 x6 : 000000000000131c
 [   70.791344] x5 : ffff00097ef4f230 x4 : 0000000000000000
 [   70.796662] x3 : 0000000000000027 x2 : 414431aad459c700
 [   70.801981] x1 : 0000000000000000 x0 : 0000000000000002
 [   70.807299] Call trace:
 [   70.809747]  sched_cpu_dying+0x210/0x250
 [   70.813676]  cpuhp_invoke_callback+0x88/0x210
 [   70.818038]  take_cpu_down+0x7c/0xd8
 [   70.821617]  multi_cpu_stop+0xac/0x170
 [   70.825369]  cpu_stopper_thread+0x98/0x130
 [   70.829469]  smpboot_thread_fn+0x1c4/0x280
 [   70.833570]  kthread+0x140/0x160
 [   70.836801]  ret_from_fork+0x10/0x34
 [   70.840384] Code: 94011fd8 b9400660 7100041f 54000040 (d4210000)
 [   70.846487] ---[ end trace 7eb0e0efe803dcfe ]---
 [   70.851109] note: migration/0[11] exited with preempt_count 3
