Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BA8728BA8C
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 16:15:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730620AbgJLOOu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 10:14:50 -0400
Received: from foss.arm.com ([217.140.110.172]:49524 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729253AbgJLOOu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 10:14:50 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CEC9831B;
        Mon, 12 Oct 2020 07:14:49 -0700 (PDT)
Received: from [192.168.178.2] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 079E63F66B;
        Mon, 12 Oct 2020 07:14:46 -0700 (PDT)
Subject: Re: [PATCH -v2 07/17] sched: Fix hotplug vs CPU bandwidth control
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     tglx@linutronix.de, mingo@kernel.org, linux-kernel@vger.kernel.org,
        bigeasy@linutronix.de, qais.yousef@arm.com, swood@redhat.com,
        valentin.schneider@arm.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, rostedt@goodmis.org,
        bsegall@google.com, mgorman@suse.de, bristot@redhat.com,
        vincent.donnefort@arm.com, tj@kernel.org
References: <20201005145717.346020688@infradead.org>
 <20201005150921.661842442@infradead.org>
 <336a3916-1dd8-98cf-44e8-88dbf27018d5@arm.com>
 <20201012125200.GW2628@hirez.programming.kicks-ass.net>
 <20201012131817.GP2651@hirez.programming.kicks-ass.net>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <328e84b9-bc57-578e-559e-817fe39038f1@arm.com>
Date:   Mon, 12 Oct 2020 16:14:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201012131817.GP2651@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/10/2020 15:18, Peter Zijlstra wrote:
> On Mon, Oct 12, 2020 at 02:52:00PM +0200, Peter Zijlstra wrote:
>> On Fri, Oct 09, 2020 at 10:41:11PM +0200, Dietmar Eggemann wrote:
>>> On 05/10/2020 16:57, Peter Zijlstra wrote:
>>>> Since we now migrate tasks away before DYING, we should also move
>>>> bandwidth unthrottle, otherwise we can gain tasks from unthrottle
>>>> after we expect all tasks to be gone already.
>>>>
>>>> Also; it looks like the RT balancers don't respect cpu_active() and
>>>> instead rely on rq->online in part, complete this. This too requires
>>>> we do set_rq_offline() earlier to match the cpu_active() semantics.
>>>> (The bigger patch is to convert RT to cpu_active() entirely)
>>>>
>>>> Since set_rq_online() is called from sched_cpu_activate(), place
>>>> set_rq_offline() in sched_cpu_deactivate().
>>
>>> [   76.215229] WARNING: CPU: 1 PID: 1913 at kernel/irq_work.c:95 irq_work_queue_on+0x108/0x110
>>
>>> [   76.341076]  irq_work_queue_on+0x108/0x110
>>> [   76.349185]  pull_rt_task+0x58/0x68
>>> [   76.352673]  balance_rt+0x84/0x88
>>
>>> balance_rt() checks via need_pull_rt_task() that rq is online but it
>>> looks like that with RT_PUSH_IPI pull_rt_task() -> tell_cpu_to_push()
>>> calls irq_work_queue_on() with cpu = rto_next_cpu(rq->rd) and this one
>>> can be offline here as well now.
>>
>> Hurmph... so if I read this right, we reach offline with overload set?
>>
>> Oooh, I think I see how that happens..
> 
> I think the below two hunks need to be reverted from the patch. Can you
> confirm?
> 
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -2326,9 +2326,6 @@ static void rq_online_dl(struct rq *rq)
>  /* Assumes rq->lock is held */
>  static void rq_offline_dl(struct rq *rq)
>  {
> -	if (rq->dl.overloaded)
> -		dl_clear_overload(rq);
> -
>  	cpudl_clear(&rq->rd->cpudl, rq->cpu);
>  	cpudl_clear_freecpu(&rq->rd->cpudl, rq->cpu);
>  }
> --- a/kernel/sched/rt.c
> +++ b/kernel/sched/rt.c
> @@ -2245,9 +2245,6 @@ static void rq_online_rt(struct rq *rq)
>  /* Assumes rq->lock is held */
>  static void rq_offline_rt(struct rq *rq)
>  {
> -	if (rq->rt.overloaded)
> -		rt_clear_overload(rq);
> -
>  	__disable_runtime(rq);
>  
>  	cpupri_set(&rq->rd->cpupri, rq->cpu, CPUPRI_INVALID);
> 

Yes, this seems to fix it. Tested with RT testcase for > 20min. This
issue did appear within 30 secs w/o this fix.

Looks like that we now bail out of pull_rt_task() in one of the
rt_overload_count related conditions before we call RT_PUSH_IPI
functionality (tell_cpu_to_push()).

Debug snippet w/o this fix with extra output in tell_cpu_to_push():

[  128.608880] sched: RT throttling activated
[  204.240351] CPU2 cpu=0 is offline rt_overloaded=1
[  204.245069] ------------[ cut here ]------------
[  204.249697] WARNING: CPU: 2 PID: 19 at kernel/irq_work.c:95
irq_work_queue_on+0x108/0x110
