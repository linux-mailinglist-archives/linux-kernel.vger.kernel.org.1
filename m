Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 909882F1F18
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 20:22:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404061AbhAKTWG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 14:22:06 -0500
Received: from foss.arm.com ([217.140.110.172]:34918 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404037AbhAKTWA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 14:22:00 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7D3EB101E;
        Mon, 11 Jan 2021 11:21:14 -0800 (PST)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 10D6B3F719;
        Mon, 11 Jan 2021 11:21:12 -0800 (PST)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-kernel@vger.kernel.org, Qian Cai <cai@redhat.com>,
        Vincent Donnefort <vincent.donnefort@arm.com>,
        Dexuan Cui <decui@microsoft.com>,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        Paul McKenney <paulmck@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH -tip V3 0/8] workqueue: break affinity initiatively
In-Reply-To: <X/yH9+MGa1JCNZ8x@hirez.programming.kicks-ass.net>
References: <20201226025117.2770-1-jiangshanlai@gmail.com> <X/hGHNGB9fltElWB@hirez.programming.kicks-ass.net> <87o8hv7pnd.fsf@nanos.tec.linutronix.de> <X/wv7+PP8ywNYmIS@hirez.programming.kicks-ass.net> <X/yH9+MGa1JCNZ8x@hirez.programming.kicks-ass.net>
User-Agent: Notmuch/0.21 (http://notmuchmail.org) Emacs/26.3 (x86_64-pc-linux-gnu)
Date:   Mon, 11 Jan 2021 19:21:06 +0000
Message-ID: <jhj7doj1dr1.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/01/21 18:16, Peter Zijlstra wrote:
> Sadly it appears like io_uring() uses kthread_create_on_cpu() without
> then having any hotplug crud on, so that needs additinoal frobbing.
>

I noticed that as well sometime ago, and I believed then (still do) this
usage is broken. I don't think usage of kthread_create_on_cpu() outside
of smpboot makes sense, because without any hotplug step to park the
thread, its affinity can end up being reset after its dedicated CPU gets
offlined.

I'm clueless about io_uring, but if it *actually* has a good reason to
use some pcpu kthreads (it seems it doesn't have to be on all CPUs?),
then it needs to register some hotplug step to park them / do something
sensible on hotplug.

> Also, init_task is PF_KTHREAD but doesn't have a struct kthread on.. and
> I suppose bound workqueues don't go through this either.
>
> Let me rummage around a bit...
>
> This seems to not insta-explode... opinions?
>

I like having a proper distinction between 'intended' and 'accidental'
pcpu kthreads.

I'm less fond of the workqueue pcpu flag toggling, but it gets us what
we want: allow those threads to run on !active CPUs during online, but
move them away before !online during offline.

Before I get ahead of myself, do we *actually* require that first part
for workqueue kthreads? I'm thinking (raise alarm) we could try another
approach of making them pcpu kthreads that don't abide by the !active &&
online rule.

> ---
>  include/linux/kthread.h |  3 +++
>  kernel/kthread.c        | 25 ++++++++++++++++++++++++-
>  kernel/sched/core.c     |  2 +-
>  kernel/sched/sched.h    |  4 ++--
>  kernel/smpboot.c        |  1 +
>  kernel/workqueue.c      | 12 +++++++++---
>  6 files changed, 40 insertions(+), 7 deletions(-)
>
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 15d2562118d1..e71f9e44789e 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -7277,7 +7277,7 @@ static void balance_push(struct rq *rq)
>        * Both the cpu-hotplug and stop task are in this case and are
>        * required to complete the hotplug process.
>        */
> -	if (is_per_cpu_kthread(push_task) || is_migration_disabled(push_task)) {
> +	if (rq->idle == push_task || is_per_cpu_kthread(push_task) || is_migration_disabled(push_task)) {

I take it the p->set_child_tid thing you were complaining about on IRC
is what prevents us from having the idle task seen as a pcpu kthread?

>               /*
>                * If this is the idle task on the outgoing CPU try to wake
>                * up the hotplug control thread which might wait for the
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 12ada79d40f3..3679f63e0aa2 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -2697,10 +2697,10 @@ static inline bool is_per_cpu_kthread(struct task_struct *p)
>       if (!(p->flags & PF_KTHREAD))
>               return false;
>
> -	if (p->nr_cpus_allowed != 1)
> +	if (!(p->flags & PF_NO_SETAFFINITY))
>               return false;
>
> -	return true;
> +	return kthread_is_per_cpu(p);
>  }
>  #endif
>
> diff --git a/kernel/smpboot.c b/kernel/smpboot.c
> index 2efe1e206167..b0abe575a524 100644
> --- a/kernel/smpboot.c
> +++ b/kernel/smpboot.c
> @@ -188,6 +188,7 @@ __smpboot_create_thread(struct smp_hotplug_thread *ht, unsigned int cpu)
>               kfree(td);
>               return PTR_ERR(tsk);
>       }
> +	kthread_set_per_cpu(tsk, true);
>       /*
>        * Park the thread so that it could start right on the CPU
>        * when it is available.
> diff --git a/kernel/workqueue.c b/kernel/workqueue.c
> index 9880b6c0e272..824276e4fb2e 100644
> --- a/kernel/workqueue.c
> +++ b/kernel/workqueue.c
> @@ -1861,6 +1861,8 @@ static void worker_attach_to_pool(struct worker *worker,
>        */
>       if (pool->flags & POOL_DISASSOCIATED)
>               worker->flags |= WORKER_UNBOUND;
> +	else
> +		kthread_set_per_cpu(worker->task, true);
>

I thought only pcpu pools would get the POOL_DISASSOCIATED flag on
offline, but it seems unbound pools also get it at init time. Did I get
that right?

Also, shouldn't this be done before the previous set_cpus_allowed_ptr()
call (in the same function)? That is, if we patch
__set_cpus_allowed_ptr() to also use kthread_is_per_cpu().

>       list_add_tail(&worker->node, &pool->workers);
>       worker->pool = pool;
