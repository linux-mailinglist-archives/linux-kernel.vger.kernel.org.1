Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94FC02F20AD
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 21:24:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404224AbhAKUYR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 15:24:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404215AbhAKUYH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 15:24:07 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 794B8C0617A2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 12:23:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=orCyTZSnN03hFZvwldkDQYF8mMKY/JPU7MNVoG+tbqs=; b=fe1NySHDpXXVVCHdXiw0z7HXKx
        eAvbikpbNbNrUHwpPTn9OleDpJtX+EyF79OqL+O8LqXqEsLHhhjrbHoBmWTvPBJFOvCX14YegRY5W
        rGfDmEekx3akEOTSR5valn+L299kek07mkAohb+QTxFYMHXlVz8TbRtTs1rT28EzWdBHLEmNpqEo7
        srE+gRyF4prH3uic0XpGJSYvPGwMzkYx35QYqGUzOgfI0hQ46ruwQgGysmYyIv0YBdgeW9flgtarh
        +ulZeEKHnvaHx+HDf8QkGUyZcM4hCEg6uz0tse6e/As1CjqhDJ53GgcqjSmMwmFS0FB/SyWT+ir5j
        BKEd5KOg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kz3iY-000279-IC; Mon, 11 Jan 2021 20:23:10 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 975D2304E03;
        Mon, 11 Jan 2021 21:23:08 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5A2292C2868E4; Mon, 11 Jan 2021 21:23:08 +0100 (CET)
Date:   Mon, 11 Jan 2021 21:23:08 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-kernel@vger.kernel.org, Qian Cai <cai@redhat.com>,
        Vincent Donnefort <vincent.donnefort@arm.com>,
        Dexuan Cui <decui@microsoft.com>,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        Paul McKenney <paulmck@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH -tip V3 0/8] workqueue: break affinity initiatively
Message-ID: <X/yzrJw4UbQsK3KB@hirez.programming.kicks-ass.net>
References: <20201226025117.2770-1-jiangshanlai@gmail.com>
 <X/hGHNGB9fltElWB@hirez.programming.kicks-ass.net>
 <87o8hv7pnd.fsf@nanos.tec.linutronix.de>
 <X/wv7+PP8ywNYmIS@hirez.programming.kicks-ass.net>
 <X/yH9+MGa1JCNZ8x@hirez.programming.kicks-ass.net>
 <jhj7doj1dr1.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <jhj7doj1dr1.mognet@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 11, 2021 at 07:21:06PM +0000, Valentin Schneider wrote:
> On 11/01/21 18:16, Peter Zijlstra wrote:
> > Sadly it appears like io_uring() uses kthread_create_on_cpu() without
> > then having any hotplug crud on, so that needs additinoal frobbing.
> >
> 
> I noticed that as well sometime ago, and I believed then (still do) this
> usage is broken. I don't think usage of kthread_create_on_cpu() outside
> of smpboot makes sense, because without any hotplug step to park the
> thread, its affinity can end up being reset after its dedicated CPU gets
> offlined.
> 
> I'm clueless about io_uring, but if it *actually* has a good reason to
> use some pcpu kthreads (it seems it doesn't have to be on all CPUs?),
> then it needs to register some hotplug step to park them / do something
> sensible on hotplug.

+Jens, could you perhaps elucidate us as to what io_uring wants from
that kthread?

> > Also, init_task is PF_KTHREAD but doesn't have a struct kthread on.. and
> > I suppose bound workqueues don't go through this either.
> >
> > Let me rummage around a bit...
> >
> > This seems to not insta-explode... opinions?
> >
> 
> I like having a proper distinction between 'intended' and 'accidental'
> pcpu kthreads.
> 
> I'm less fond of the workqueue pcpu flag toggling, but it gets us what
> we want: allow those threads to run on !active CPUs during online, but
> move them away before !online during offline.
> 
> Before I get ahead of myself, do we *actually* require that first part
> for workqueue kthreads? I'm thinking (raise alarm) we could try another
> approach of making them pcpu kthreads that don't abide by the !active &&
> online rule.

There is code that really requires percpu workqueues to be percpu. Such
code will flush the percpu workqueue on hotplug and never hit the unbind
scenario.

Other code uses those same percpu workqueues and only uses it as a
performance enhancer, it likes things to stay local, but if not, meh..
And these users are what got us the weird ass semantics of workqueue.

Sadly workqueue itself can't tell them apart.

> > ---
> >  include/linux/kthread.h |  3 +++
> >  kernel/kthread.c        | 25 ++++++++++++++++++++++++-
> >  kernel/sched/core.c     |  2 +-
> >  kernel/sched/sched.h    |  4 ++--
> >  kernel/smpboot.c        |  1 +
> >  kernel/workqueue.c      | 12 +++++++++---
> >  6 files changed, 40 insertions(+), 7 deletions(-)
> >
> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index 15d2562118d1..e71f9e44789e 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -7277,7 +7277,7 @@ static void balance_push(struct rq *rq)
> >        * Both the cpu-hotplug and stop task are in this case and are
> >        * required to complete the hotplug process.
> >        */
> > -	if (is_per_cpu_kthread(push_task) || is_migration_disabled(push_task)) {
> > +	if (rq->idle == push_task || is_per_cpu_kthread(push_task) || is_migration_disabled(push_task)) {
> 
> I take it the p->set_child_tid thing you were complaining about on IRC
> is what prevents us from having the idle task seen as a pcpu kthread?

Yes, to to_kthread() only tests PF_KTHREAD and then assumes
p->set_child_tid points to struct kthread, _however_ init_task has
PF_KTHREAD set, but a NULL ->set_child_tid.

This then means the idle thread for the boot CPU will malfunction with
to_kthread() and will certainly not have KTHREAD_IS_PER_CPU set. Per
construction (fork_idle()) none of the other idle threads will have that
cured either.

For fun and giggles, init (pid-1) will have PF_KTHREAD set for a while
as well, until we exec /sbin/init.

Anyway, idle will fail kthread_is_per_cpu(), and hence without the
above, we'll try and push the idle task away, which results in much
fail.

> > diff --git a/kernel/smpboot.c b/kernel/smpboot.c
> > index 2efe1e206167..b0abe575a524 100644
> > --- a/kernel/smpboot.c
> > +++ b/kernel/smpboot.c
> > @@ -188,6 +188,7 @@ __smpboot_create_thread(struct smp_hotplug_thread *ht, unsigned int cpu)
> >               kfree(td);
> >               return PTR_ERR(tsk);
> >       }
> > +	kthread_set_per_cpu(tsk, true);
> >       /*
> >        * Park the thread so that it could start right on the CPU
> >        * when it is available.
> > diff --git a/kernel/workqueue.c b/kernel/workqueue.c
> > index 9880b6c0e272..824276e4fb2e 100644
> > --- a/kernel/workqueue.c
> > +++ b/kernel/workqueue.c
> > @@ -1861,6 +1861,8 @@ static void worker_attach_to_pool(struct worker *worker,
> >        */
> >       if (pool->flags & POOL_DISASSOCIATED)
> >               worker->flags |= WORKER_UNBOUND;
> > +	else
> > +		kthread_set_per_cpu(worker->task, true);
> >
> 
> I thought only pcpu pools would get the POOL_DISASSOCIATED flag on
> offline, but it seems unbound pools also get it at init time. Did I get
> that right?

That's how I read it too...

> Also, shouldn't this be done before the previous set_cpus_allowed_ptr()
> call (in the same function)? 

Don't see why; we need nr_cpus_allowed == 1, so best do it after, right?

> That is, if we patch
> __set_cpus_allowed_ptr() to also use kthread_is_per_cpu().

That seems wrong.

> >       list_add_tail(&worker->node, &pool->workers);
> >       worker->pool = pool;
