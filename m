Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A28652F2352
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 01:26:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390528AbhALAYj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 19:24:39 -0500
Received: from foss.arm.com ([217.140.110.172]:37320 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390769AbhAKWsc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 17:48:32 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 89F1E31B;
        Mon, 11 Jan 2021 14:47:46 -0800 (PST)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 028F23F70D;
        Mon, 11 Jan 2021 14:47:44 -0800 (PST)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
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
In-Reply-To: <X/yzrJw4UbQsK3KB@hirez.programming.kicks-ass.net>
References: <20201226025117.2770-1-jiangshanlai@gmail.com> <X/hGHNGB9fltElWB@hirez.programming.kicks-ass.net> <87o8hv7pnd.fsf@nanos.tec.linutronix.de> <X/wv7+PP8ywNYmIS@hirez.programming.kicks-ass.net> <X/yH9+MGa1JCNZ8x@hirez.programming.kicks-ass.net> <jhj7doj1dr1.mognet@arm.com> <X/yzrJw4UbQsK3KB@hirez.programming.kicks-ass.net>
User-Agent: Notmuch/0.21 (http://notmuchmail.org) Emacs/26.3 (x86_64-pc-linux-gnu)
Date:   Mon, 11 Jan 2021 22:47:39 +0000
Message-ID: <jhj4kjn146s.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/01/21 21:23, Peter Zijlstra wrote:
> On Mon, Jan 11, 2021 at 07:21:06PM +0000, Valentin Schneider wrote:
>> I'm less fond of the workqueue pcpu flag toggling, but it gets us what
>> we want: allow those threads to run on !active CPUs during online, but
>> move them away before !online during offline.
>>
>> Before I get ahead of myself, do we *actually* require that first part
>> for workqueue kthreads? I'm thinking (raise alarm) we could try another
>> approach of making them pcpu kthreads that don't abide by the !active &&
>> online rule.
>
> There is code that really requires percpu workqueues to be percpu. Such
> code will flush the percpu workqueue on hotplug and never hit the unbind
> scenario.
>
> Other code uses those same percpu workqueues and only uses it as a
> performance enhancer, it likes things to stay local, but if not, meh..
> And these users are what got us the weird ass semantics of workqueue.
>
> Sadly workqueue itself can't tell them apart.
>

Oh well...

FWIW now that I've unconfused myself, that does look okay.

>> > ---
>> >  include/linux/kthread.h |  3 +++
>> >  kernel/kthread.c        | 25 ++++++++++++++++++++++++-
>> >  kernel/sched/core.c     |  2 +-
>> >  kernel/sched/sched.h    |  4 ++--
>> >  kernel/smpboot.c        |  1 +
>> >  kernel/workqueue.c      | 12 +++++++++---
>> >  6 files changed, 40 insertions(+), 7 deletions(-)
>> >
>> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
>> > index 15d2562118d1..e71f9e44789e 100644
>> > --- a/kernel/sched/core.c
>> > +++ b/kernel/sched/core.c
>> > @@ -7277,7 +7277,7 @@ static void balance_push(struct rq *rq)
>> >        * Both the cpu-hotplug and stop task are in this case and are
>> >        * required to complete the hotplug process.
>> >        */
>> > -	if (is_per_cpu_kthread(push_task) || is_migration_disabled(push_task)) {
>> > +	if (rq->idle == push_task || is_per_cpu_kthread(push_task) || is_migration_disabled(push_task)) {
>>
>> I take it the p->set_child_tid thing you were complaining about on IRC
>> is what prevents us from having the idle task seen as a pcpu kthread?
>
> Yes, to to_kthread() only tests PF_KTHREAD and then assumes
> p->set_child_tid points to struct kthread, _however_ init_task has
> PF_KTHREAD set, but a NULL ->set_child_tid.
>
> This then means the idle thread for the boot CPU will malfunction with
> to_kthread() and will certainly not have KTHREAD_IS_PER_CPU set. Per
> construction (fork_idle()) none of the other idle threads will have that
> cured either.
>
> For fun and giggles, init (pid-1) will have PF_KTHREAD set for a while
> as well, until we exec /sbin/init.
>
> Anyway, idle will fail kthread_is_per_cpu(), and hence without the
> above, we'll try and push the idle task away, which results in much
> fail.
>

Quite!

>> Also, shouldn't this be done before the previous set_cpus_allowed_ptr()
>> call (in the same function)?
>
> Don't see why; we need nr_cpus_allowed == 1, so best do it after, right?
>

Duh, yes.

>> That is, if we patch
>> __set_cpus_allowed_ptr() to also use kthread_is_per_cpu().
>
> That seems wrong.
>

It is, apologies.

>> >       list_add_tail(&worker->node, &pool->workers);
>> >       worker->pool = pool;
