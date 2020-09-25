Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8173D27867D
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 13:58:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728165AbgIYL6M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 07:58:12 -0400
Received: from foss.arm.com ([217.140.110.172]:43574 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727749AbgIYL6L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 07:58:11 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0C44A101E;
        Fri, 25 Sep 2020 04:58:11 -0700 (PDT)
Received: from [192.168.178.2] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DDF6C3F70D;
        Fri, 25 Sep 2020 04:58:07 -0700 (PDT)
Subject: Re: [PATCH 0/9] sched: Migrate disable support
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     tglx@linutronix.de, mingo@kernel.org, linux-kernel@vger.kernel.org,
        bigeasy@linutronix.de, qais.yousef@arm.com, swood@redhat.com,
        valentin.schneider@arm.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, rostedt@goodmis.org,
        bsegall@google.com, mgorman@suse.de, bristot@redhat.com,
        vincent.donnefort@arm.com
References: <20200921163557.234036895@infradead.org>
 <6f55a303-0e5c-8e84-65d3-798b589a5d75@arm.com>
 <20200925101030.GA2594@hirez.programming.kicks-ass.net>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <d26d81ec-01d6-f6c0-816b-fbd8bb71e132@arm.com>
Date:   Fri, 25 Sep 2020 13:58:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200925101030.GA2594@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/09/2020 12:10, Peter Zijlstra wrote:
> On Fri, Sep 25, 2020 at 11:12:09AM +0200, Dietmar Eggemann wrote:
> 
>> I get this when running 6 (periodic) RT50 tasks with CPU hp stress on my
>> 6 CPU JUNO board (!CONFIG_PREEMPT_RT).
>>
>> [   55.490263] ------------[ cut here ]------------
>> [   55.505261] Modules linked in:
>> [   55.508322] CPU: 3 PID: 24 Comm: migration/3 Not tainted
>> 5.9.0-rc1-00132-gc096e6406c50-dirty #90
>> [   55.517119] Hardware name: ARM Juno development board (r0) (DT)
>> [   55.523058] Stopper: multi_cpu_stop+0x0/0x170 <- 0x0
>> [   55.528029] pstate: 20000085 (nzCv daIf -PAN -UAO BTYPE=--)
>> [   55.533612] pc : sched_cpu_dying+0x124/0x130
>> [   55.537887] lr : sched_cpu_dying+0xd8/0x130
>> [   55.542071] sp : ffff800011f0bca0
>> [   55.545385] x29: ffff800011f0bca0 x28: 0000000000000002
>> [   55.550703] x27: 0000000000000000 x26: 0000000000000060
>> [   55.556022] x25: 0000000000000000 x24: 0000000000000001
>> [   55.561340] x23: 0000000000000000 x22: 0000000000000003
>> [   55.566659] x21: 0000000000000080 x20: 0000000000000003
>> [   55.571977] x19: ffff00097ef9e1c0 x18: 0000000000000010
>> [   55.577295] x17: 0000000000000000 x16: 0000000000000000
>> [   55.582613] x15: 0000000000000000 x14: 000000000000015c
>> [   55.587932] x13: 0000000000000000 x12: 00000000000006f1
>> [   55.593250] x11: 0000000000000080 x10: 0000000000000000
>> [   55.598567] x9 : 0000000000000003 x8 : ffff0009743f5900
>> [   55.603886] x7 : 0000000000000003 x6 : 0000000000000000
>> [   55.609204] x5 : 0000000000000001 x4 : 0000000000000002
>> [   55.614521] x3 : 0000000000000000 x2 : 0000000000000013
>> [   55.619839] x1 : 0000000000000008 x0 : 0000000000000003
>> [   55.625158] Call trace:
>> [   55.627607]  sched_cpu_dying+0x124/0x130
>> [   55.631535]  cpuhp_invoke_callback+0x88/0x210
>> [   55.635897]  take_cpu_down+0x7c/0xd8
>> [   55.639475]  multi_cpu_stop+0xac/0x170
>> [   55.643227]  cpu_stopper_thread+0x98/0x130
>> [   55.647327]  smpboot_thread_fn+0x1c4/0x280
>> [   55.651427]  kthread+0x140/0x160
>> [   55.654658]  ret_from_fork+0x10/0x34
>> [   55.658239] Code: f000e1c1 913fc021 1400034a 17ffffde (d4210000)
>> [   55.664342] ---[ end trace c5b8988b7b701e56 ]---
>> [   55.668963] note: migration/3[24] exited with preempt_count 3
>>
>> 7309 int sched_cpu_dying(unsigned int cpu)
>>     ...
>>     BUG_ON(rq->nr_running != 1 || rq_has_pinned_tasks(rq));
>>     ...
>>
>> rq->nr_running is always 2 here in this cases.
>>
>> balance_hotplug_wait and sched_cpu_wait_empty run in cpuhp/X (CFS)
>> whereas sched_cpu_dying in migration/X ?
> 
> takedown_cpu() has:
> 
>   kthread_park(per_cpu_ptr(&cpuhp_state, cpu)->thread);
> 
> before calling:
> 
>   err = stop_machine_cpuslocked(take_cpu_down, NULL, cpumask_of(cpu));
> 
> So when we get to sched_cpu_dying(), the only task that _should_ still
> be there is migration/X.
> 
> Do you have any idea what thread, other than migration/X, is still
> active on that CPU? per sched_cpu_wait_empty() we should've pushed out
> all userspace tasks, and the cpu hotplug machinery should've put all the
> per-cpu kthreads to sleep at this point.

With Valentin's print_rq() inspired test snippet I always see one of the
RT user tasks as the second guy? BTW, it has to be RT tasks, never
triggered with CFS tasks.

[   57.849268] CPU2 nr_running=2
[   57.852241]  p=migration/2
[   57.854967]  p=task0-0
