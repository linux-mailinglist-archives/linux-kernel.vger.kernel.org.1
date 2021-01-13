Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D64B2F4BF2
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 14:05:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725977AbhAMNDJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 08:03:09 -0500
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:58540 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725774AbhAMNDJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 08:03:09 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=laijs@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0ULcnSRR_1610542676;
Received: from C02XQCBJJG5H.local(mailfrom:laijs@linux.alibaba.com fp:SMTPD_---0ULcnSRR_1610542676)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 13 Jan 2021 20:58:59 +0800
Subject: Re: [PATCH -tip V3 0/8] workqueue: break affinity initiatively
To:     Peter Zijlstra <peterz@infradead.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Tejun Heo <tj@kernel.org>
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, Qian Cai <cai@redhat.com>,
        Vincent Donnefort <vincent.donnefort@arm.com>,
        Dexuan Cui <decui@microsoft.com>,
        Paul McKenney <paulmck@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Jens Axboe <axboe@kernel.dk>
References: <20201226025117.2770-1-jiangshanlai@gmail.com>
 <X/hGHNGB9fltElWB@hirez.programming.kicks-ass.net>
 <87o8hv7pnd.fsf@nanos.tec.linutronix.de>
 <X/wv7+PP8ywNYmIS@hirez.programming.kicks-ass.net>
 <X/yH9+MGa1JCNZ8x@hirez.programming.kicks-ass.net>
 <jhj7doj1dr1.mognet@arm.com>
 <X/yzrJw4UbQsK3KB@hirez.programming.kicks-ass.net>
 <CAJhGHyA0rfR92W7T7RnhPrmLMkmV4Mb7fUSeG2VEHhsH-pSxsw@mail.gmail.com>
 <X/236obyM0nqL5+X@hirez.programming.kicks-ass.net>
 <CAJhGHyDtku6PjLtkq7TGmcQnds5cakR6viki=bPoxxkdC0p-Tw@mail.gmail.com>
 <X/7VQ8pF5h/K+Cj1@hirez.programming.kicks-ass.net>
From:   Lai Jiangshan <laijs@linux.alibaba.com>
Message-ID: <7e92d3b2-2323-f608-1090-e2c91aa612ce@linux.alibaba.com>
Date:   Wed, 13 Jan 2021 20:57:56 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <X/7VQ8pF5h/K+Cj1@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2021/1/13 19:10, Peter Zijlstra wrote:
> On Tue, Jan 12, 2021 at 11:38:12PM +0800, Lai Jiangshan wrote:
> 
>> But the hard problem is "how to suppress the warning of
>> online&!active in __set_cpus_allowed_ptr()" for late spawned
>> unbound workers during hotplug.
> 
> I cannot see create_worker() go bad like that.
> 
> The thing is, it uses:
> 
>    kthread_bind_mask(, pool->attr->cpumask)
>    worker_attach_to_pool()
>      set_cpus_allowed_ptr(, pool->attr->cpumask)
> 
> which means set_cpus_allowed_ptr() must be a NOP, because the affinity
> is already set by kthread_bind_mask(). Further, the first wakeup of that
> worker will then hit:
> 
>    select_task_rq()
>      is_cpu_allowed()
>        is_per_cpu_kthread() -- false
>      select_fallback_rq()
> 
> 
> So normally that really isn't a problem. I can only see a tiny hole
> there, where someone changes the cpumask between kthread_bind_mask() and
> set_cpus_allowed_ptr(). AFAICT that can be fixed in two ways:
> 
>   - add wq_pool_mutex around things in create_worker(), or
>   - move the set_cpus_allowed_ptr() out of worker_attach_to_pool() and
>     into rescuer_thread().
> 
> Which then brings us to rescuer_thread...  If we manage to trigger the
> rescuer during hotplug, then yes, I think that can go wobbly.
> 

How about the following idea (not complied, not tested).
It does not call set_cpus_allowed_ptr() for just created workers.
It does not change cpumask for rescuer except when it is per cpu pool.

The only problem is that, unbound rescue worker doesn't comply with
wq_unbound_cpumask nor wq->unbound_attrs->cpumask.  Another 50 Lines
of code can make it complied,  but I don't want to type it in email
and complicated the idea.

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 9880b6c0e272..df2082283c1e 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -1849,10 +1849,30 @@ static void worker_attach_to_pool(struct worker *worker,
  	mutex_lock(&wq_pool_attach_mutex);

  	/*
-	 * set_cpus_allowed_ptr() will fail if the cpumask doesn't have any
-	 * online CPUs.  It'll be re-applied when any of the CPUs come up.
+	 * If we called from create_worker(), we don't need to call
+	 * set_cpus_allowed_ptr() since we just kthread_bind_mask() it.
+	 *
+	 * The only other path gets us here is rescuer_thread().
+	 *
+	 * When !(pool->flags & POOL_DISASSOCIATED), it is per-cpu pool
+	 * and we should rebind the rescuer worker to the target CPU.
+	 *
+	 * When it is a rescuer worker attaching to unbound pool, we keep
+	 * the affinity for rescuer worker to be cpu_possible_mask.
+	 *
+	 * Note: unbound rescue worker doesn't comply with wq_unbound_cpumask
+	 * nor wq->unbound_attrs->cpumask.  The optimal choice is to keep
+	 * the affinity for rescuer worker to be
+	 *	wq_unbound_cpumask & wq->unbound_attrs->cpumask
+	 * but there is no reliable way to set it back via
+	 * set_cpus_allowed_ptr() when its affinity is changed by scheduler
+	 * due to CPU hotplug, so we just use cpu_possible_mask for resuer.
+	 *
+	 * set_cpus_allowed_ptr() will not fail since
+	 * !(pool->flags & POOL_DISASSOCIATED)
  	 */
-	set_cpus_allowed_ptr(worker->task, pool->attrs->cpumask);
+	if (worker->rescue_wq && !(pool->flags & POOL_DISASSOCIATED))
+		WARN_ON_ONCE(set_cpus_allowed_ptr(worker->task, pool->attrs->cpumask) < 0);

  	/*
  	 * The wq_pool_attach_mutex ensures %POOL_DISASSOCIATED remains
@@ -5043,7 +5063,8 @@ static void restore_unbound_workers_cpumask(struct worker_pool *pool, int cpu)

  	/* as we're called from CPU_ONLINE, the following shouldn't fail */
  	for_each_pool_worker(worker, pool)
-		WARN_ON_ONCE(set_cpus_allowed_ptr(worker->task, &cpumask) < 0);
+		if (!worker->rescue_wq)
+			WARN_ON_ONCE(set_cpus_allowed_ptr(worker->task, &cpumask) < 0);
  }

  int workqueue_prepare_cpu(unsigned int cpu)




