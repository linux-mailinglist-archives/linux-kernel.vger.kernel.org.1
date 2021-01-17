Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BAB92F9197
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jan 2021 10:56:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728322AbhAQJz5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jan 2021 04:55:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728193AbhAQJzO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jan 2021 04:55:14 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D996C061573
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jan 2021 01:54:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=mmYQInLNeEYiTgK8DZb4gNp3VuE8rkxCxGEUTvzjqw0=; b=YBI7ucbzX4OjMHI7dLfWDvnQTf
        eSi6gZ8lMsN/2aOZODuSeqQwAKrrEAkh4lw9/hTgFP6XzE2hGp3hg3a8mHr8yqPQ9liZMbCY/MXCb
        ZSlJR07L37UnEOpU+kb7ZlJdyUn5aNPCX2VIgzv1tCGLA0IG7efi/87B/GlAKex8+ihQK1Yxzp+C4
        M1uI8rt/jE/ujpHmgwR0syz6o46bUWR2kAvki/LwuRvBnMCmukA3uEe829iQK7DRf/SfE8CGx56Cf
        77dY1dwU24oYOluYOHL1LVGWpEW/ajMpZA5o0sEllUVXrMxSxos6XEwy74qJEKA1G0wZNJLY8Qjyg
        Q9lRynHg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1l14l7-00BOJn-A7; Sun, 17 Jan 2021 09:54:09 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C1609300F7A;
        Sun, 17 Jan 2021 10:54:07 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 89AE820298BA0; Sun, 17 Jan 2021 10:54:07 +0100 (CET)
Date:   Sun, 17 Jan 2021 10:54:07 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Lai Jiangshan <jiangshanlai@gmail.com>
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, Qian Cai <cai@redhat.com>,
        Vincent Donnefort <vincent.donnefort@arm.com>,
        Dexuan Cui <decui@microsoft.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>, Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 3/4] workqueue: Tag bound workers with KTHREAD_IS_PER_CPU
Message-ID: <YAQJP+5bmrrXZ6eu@hirez.programming.kicks-ass.net>
References: <CAJhGHyD_xuSpYOp5A9PumWGsBA=DNqM0ge3_NgRkfro7fafGqA@mail.gmail.com>
 <YABDI6Qkp5PNslUS@hirez.programming.kicks-ass.net>
 <jhjlfcvhcx5.mognet@arm.com>
 <YABknAqDe4h35+GY@hirez.programming.kicks-ass.net>
 <CAJhGHyBazDix9tLTV0HnobeSzneUK8Y9GKf6AgXspf=c9O5dhQ@mail.gmail.com>
 <YALf4xDwTKCERPbf@hirez.programming.kicks-ass.net>
 <CAJhGHyDT2FWsn15-_DQ4b_bkrRi74MzNnWt7YWTO49cSv4yjbg@mail.gmail.com>
 <YAMDUQ7JX2Fr8D+/@hirez.programming.kicks-ass.net>
 <CAJhGHyBKexR+UmR2Hzf-OU9_9zfc0V6r=s2rS=N8sc+2VnN3mw@mail.gmail.com>
 <YAM0l2WItxyaHr2N@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YAM0l2WItxyaHr2N@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 16, 2021 at 07:46:47PM +0100, Peter Zijlstra wrote:
> On Sun, Jan 17, 2021 at 12:14:34AM +0800, Lai Jiangshan wrote:
> 
> > BP:                 AP:                  worker:
> > cpus_write_lock()
> > bringup_cpu()                            work_item_func()
> >   bringup_wait_for_ap                      get_online_cpus()
> >                     kthread_park(worker)
> 
> Thanks, pictures are easier. Agreed, that a problem.
> 
> I've also found another problem I think.  rescuer_thread becomes part of
> for_each_pool_worker() between worker_attach_to_pool() and
> worker_detach_from_pool(), so it would try and do kthread_park() on
> rescuer, when things align. And rescuer_thread() doesn't have a
> kthread_parkme().
> 
> And we already rely on this 'ugly' thing of first doing
> kthread_set_per_cpu() and fixing up the affinity later for the rescuer.
> 
> Let me restart the SRCU-P testing with the below delta applied.
> 
> ---
>  kernel/workqueue.c | 14 +++++---------
>  1 file changed, 5 insertions(+), 9 deletions(-)
> 
> diff --git a/kernel/workqueue.c b/kernel/workqueue.c
> index 1db769b116a1..894bb885b40b 100644
> --- a/kernel/workqueue.c
> +++ b/kernel/workqueue.c
> @@ -2368,7 +2368,6 @@ static int worker_thread(void *__worker)
>  	/* tell the scheduler that this is a workqueue worker */
>  	set_pf_worker(true);
>  woke_up:
> -	kthread_parkme();
>  	raw_spin_lock_irq(&pool->lock);
>  
>  	/* am I supposed to die? */
> @@ -2426,7 +2425,7 @@ static int worker_thread(void *__worker)
>  			move_linked_works(work, &worker->scheduled, NULL);
>  			process_scheduled_works(worker);
>  		}
> -	} while (keep_working(pool) && !kthread_should_park());
> +	} while (keep_working(pool));
>  
>  	worker_set_flags(worker, WORKER_PREP);
>  sleep:
> @@ -2438,12 +2437,9 @@ static int worker_thread(void *__worker)
>  	 * event.
>  	 */
>  	worker_enter_idle(worker);
> -	set_current_state(TASK_IDLE);
> +	__set_current_state(TASK_IDLE);
>  	raw_spin_unlock_irq(&pool->lock);
> -
> -	if (!kthread_should_park())
> -		schedule();
> -
> +	schedule();
>  	goto woke_up;
>  }
>  
> @@ -4979,9 +4975,9 @@ static void rebind_workers(struct worker_pool *pool)
>  	 * from CPU_ONLINE, the following shouldn't fail.
>  	 */
>  	for_each_pool_worker(worker, pool) {
> -		WARN_ON_ONCE(kthread_park(worker->task) < 0);
>  		kthread_set_per_cpu(worker->task, pool->cpu);
> -		kthread_unpark(worker->task);
> +		WARN_ON_ONCE(set_cpus_allowed_ptr(worker->task,
> +						  pool->attrs->cpumask) < 0);
>  	}
>  
>  	raw_spin_lock_irq(&pool->lock);

In the roughly 80 instances of 18*SRCU-P since sending this, I've got
one sched_cpu_dying splat about a stray kworker, so somthing isn't
right.

My intention was to not think today, so I'll delay that until tomorrow.
