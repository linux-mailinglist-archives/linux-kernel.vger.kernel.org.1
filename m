Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD8EB2F61DE
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 14:25:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729054AbhANNWT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 08:22:19 -0500
Received: from foss.arm.com ([217.140.110.172]:50012 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726315AbhANNWT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 08:22:19 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 810D41FB;
        Thu, 14 Jan 2021 05:21:33 -0800 (PST)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E13E43F719;
        Thu, 14 Jan 2021 05:21:31 -0800 (PST)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, Qian Cai <cai@redhat.com>,
        Vincent Donnefort <vincent.donnefort@arm.com>,
        Dexuan Cui <decui@microsoft.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>, Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 3/4] workqueue: Tag bound workers with KTHREAD_IS_PER_CPU
In-Reply-To: <YABDI6Qkp5PNslUS@hirez.programming.kicks-ass.net>
References: <20210112144344.850850975@infradead.org> <20210112144843.849135905@infradead.org> <CAJhGHyD_xuSpYOp5A9PumWGsBA=DNqM0ge3_NgRkfro7fafGqA@mail.gmail.com> <YABDI6Qkp5PNslUS@hirez.programming.kicks-ass.net>
User-Agent: Notmuch/0.21 (http://notmuchmail.org) Emacs/26.3 (x86_64-pc-linux-gnu)
Date:   Thu, 14 Jan 2021 13:21:26 +0000
Message-ID: <jhjlfcvhcx5.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/01/21 14:12, Peter Zijlstra wrote:
> On Wed, Jan 13, 2021 at 09:28:13PM +0800, Lai Jiangshan wrote:
>> On Tue, Jan 12, 2021 at 10:51 PM Peter Zijlstra <peterz@infradead.org> wrote:
>> > @@ -4972,9 +4977,11 @@ static void rebind_workers(struct worker
>> >          * of all workers first and then clear UNBOUND.  As we're called
>> >          * from CPU_ONLINE, the following shouldn't fail.
>> >          */
>> > -       for_each_pool_worker(worker, pool)
>> > +       for_each_pool_worker(worker, pool) {
>> >                 WARN_ON_ONCE(set_cpus_allowed_ptr(worker->task,
>> >                                                   pool->attrs->cpumask) < 0);
>> > +               kthread_set_per_cpu(worker->task, true);
>>
>> Will the schedule break affinity in the middle of these two lines due to
>> patch4 allowing it and result in Paul's reported splat.
>
> So something like the below _should_ work, except i'm seeing odd WARNs.
> I'll prod at it some more.
>
> --- a/kernel/workqueue.c
> +++ b/kernel/workqueue.c
> @@ -2371,6 +2371,7 @@ static int worker_thread(void *__worker)
>       /* tell the scheduler that this is a workqueue worker */
>       set_pf_worker(true);
>  woke_up:
> +	kthread_parkme();
>       raw_spin_lock_irq(&pool->lock);
>
>       /* am I supposed to die? */
> @@ -2428,6 +2429,7 @@ static int worker_thread(void *__worker)
>                       move_linked_works(work, &worker->scheduled, NULL);
>                       process_scheduled_works(worker);
>               }
> +		kthread_parkme();
>       } while (keep_working(pool));
>
>       worker_set_flags(worker, WORKER_PREP);
> @@ -4978,9 +4980,9 @@ static void rebind_workers(struct worker
>        * from CPU_ONLINE, the following shouldn't fail.
>        */
>       for_each_pool_worker(worker, pool) {
> -		WARN_ON_ONCE(set_cpus_allowed_ptr(worker->task,
> -						  pool->attrs->cpumask) < 0);
> +		kthread_park(worker->task);

Don't we still need an affinity change here, to undo what was done in
unbind_workers()?

Would something like

  __kthread_bind_mask(worker->task, pool->attrs->cpumask, TASK_PARKED)

even work?

>               kthread_set_per_cpu(worker->task, true);
> +		kthread_unpark(worker->task);
>       }
>
>       raw_spin_lock_irq(&pool->lock);
