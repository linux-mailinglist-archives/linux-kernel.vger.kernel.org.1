Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CE372F64C4
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 16:37:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728389AbhANPhG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 10:37:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725878AbhANPhG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 10:37:06 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9A38C061575
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 07:36:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=KMQ5a1jCaVWlGMjircKGxy9Cp4FtuzMM1Q3cqH1gOQE=; b=WlRlMPxdA0mn4qEgo8p4ly4XOt
        RbCYbuJ1jzUC/Ix985vWGPQokeGa+Iy1Bex5nfC+i1+vEd/7Lwa+689tIqdTATgAMHp+ZwpI+05PI
        jravGA1AZQNt2RZ3nsuKhjz6+ITxs7jdJxzQo+XmfUtQkkumlW+0S+k9xRkLJ5RqLxR7kN1mGoIV/
        hAcH9lf+rqGzNTrkU9Y5uZMw9EDOlsyspHqjzjLY1678Q3hkgaT1e/LEgUa8EUKxYq6bHrFirNTEV
        Lhw0F36RcqIb1osKkx/7D17yBELrZ9EBk4ip+s5rEfReKcVW/i0ivDqDPVOvnaf1GbFl8nSy6ZKuv
        aaEFnztw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1l04eG-007jrs-6z; Thu, 14 Jan 2021 15:35:04 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 08DD130015A;
        Thu, 14 Jan 2021 16:34:53 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E7F4520CC02C7; Thu, 14 Jan 2021 16:34:52 +0100 (CET)
Date:   Thu, 14 Jan 2021 16:34:52 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     Lai Jiangshan <jiangshanlai@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, Qian Cai <cai@redhat.com>,
        Vincent Donnefort <vincent.donnefort@arm.com>,
        Dexuan Cui <decui@microsoft.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>, Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 3/4] workqueue: Tag bound workers with KTHREAD_IS_PER_CPU
Message-ID: <YABknAqDe4h35+GY@hirez.programming.kicks-ass.net>
References: <20210112144344.850850975@infradead.org>
 <20210112144843.849135905@infradead.org>
 <CAJhGHyD_xuSpYOp5A9PumWGsBA=DNqM0ge3_NgRkfro7fafGqA@mail.gmail.com>
 <YABDI6Qkp5PNslUS@hirez.programming.kicks-ass.net>
 <jhjlfcvhcx5.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <jhjlfcvhcx5.mognet@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 14, 2021 at 01:21:26PM +0000, Valentin Schneider wrote:
> On 14/01/21 14:12, Peter Zijlstra wrote:

> > -		WARN_ON_ONCE(set_cpus_allowed_ptr(worker->task,
> > -						  pool->attrs->cpumask) < 0);
> > +		kthread_park(worker->task);
> 
> Don't we still need an affinity change here, to undo what was done in
> unbind_workers()?
> 
> Would something like
> 
>   __kthread_bind_mask(worker->task, pool->attrs->cpumask, TASK_PARKED)
> 
> even work?
> 
> >               kthread_set_per_cpu(worker->task, true);
> > +		kthread_unpark(worker->task);

Nope, look at what kthread_unpark() does, what was missing was assigning
kthread->cpu though.

The below seems to actually work. Rescuer is still a problem though.

---
 include/linux/kthread.h |  2 +-
 kernel/kthread.c        | 14 ++++++++------
 kernel/sched/core.c     | 19 ++++++++++++++++++-
 kernel/smpboot.c        |  2 +-
 kernel/workqueue.c      | 22 +++++++++++++---------
 5 files changed, 41 insertions(+), 18 deletions(-)

diff --git a/include/linux/kthread.h b/include/linux/kthread.h
index fdd5a52e35d8..2484ed97e72f 100644
--- a/include/linux/kthread.h
+++ b/include/linux/kthread.h
@@ -33,7 +33,7 @@ struct task_struct *kthread_create_on_cpu(int (*threadfn)(void *data),
 					  unsigned int cpu,
 					  const char *namefmt);
 
-void kthread_set_per_cpu(struct task_struct *k, bool set);
+void kthread_set_per_cpu(struct task_struct *k, int cpu);
 bool kthread_is_per_cpu(struct task_struct *k);
 
 /**
diff --git a/kernel/kthread.c b/kernel/kthread.c
index bead90275d2b..e0e4a423f184 100644
--- a/kernel/kthread.c
+++ b/kernel/kthread.c
@@ -497,19 +497,21 @@ struct task_struct *kthread_create_on_cpu(int (*threadfn)(void *data),
 	return p;
 }
 
-void kthread_set_per_cpu(struct task_struct *k, bool set)
+void kthread_set_per_cpu(struct task_struct *k, int cpu)
 {
 	struct kthread *kthread = to_kthread(k);
 	if (!kthread)
 		return;
 
-	if (set) {
-		WARN_ON_ONCE(!(k->flags & PF_NO_SETAFFINITY));
-		WARN_ON_ONCE(k->nr_cpus_allowed != 1);
-		set_bit(KTHREAD_IS_PER_CPU, &kthread->flags);
-	} else {
+	WARN_ON_ONCE(!(k->flags & PF_NO_SETAFFINITY));
+
+	if (cpu < 0) {
 		clear_bit(KTHREAD_IS_PER_CPU, &kthread->flags);
+		return;
 	}
+
+	kthread->cpu = cpu;
+	set_bit(KTHREAD_IS_PER_CPU, &kthread->flags);
 }
 
 bool kthread_is_per_cpu(struct task_struct *k)
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 60b257d845fa..c2fdeeb6af2b 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -7589,7 +7589,24 @@ int sched_cpu_dying(unsigned int cpu)
 	sched_tick_stop(cpu);
 
 	rq_lock_irqsave(rq, &rf);
-	BUG_ON(rq->nr_running != 1 || rq_has_pinned_tasks(rq));
+	if (rq->nr_running != 1 || rq_has_pinned_tasks(rq)) {
+		struct task_struct *g, *p;
+
+		pr_crit("CPU%d nr_running=%d\n", cpu, rq->nr_running);
+		rcu_read_lock();
+		for_each_process_thread(g, p) {
+			if (task_cpu(p) != cpu)
+				continue;
+
+			if (!task_on_rq_queued(p))
+				continue;
+
+			pr_crit("\tp=%s\n", p->comm);
+		}
+		rcu_read_unlock();
+
+		WARN_ON_ONCE(1);
+	}
 	rq_unlock_irqrestore(rq, &rf);
 
 	calc_load_migrate(rq);
diff --git a/kernel/smpboot.c b/kernel/smpboot.c
index b0abe575a524..f25208e8df83 100644
--- a/kernel/smpboot.c
+++ b/kernel/smpboot.c
@@ -188,7 +188,7 @@ __smpboot_create_thread(struct smp_hotplug_thread *ht, unsigned int cpu)
 		kfree(td);
 		return PTR_ERR(tsk);
 	}
-	kthread_set_per_cpu(tsk, true);
+	kthread_set_per_cpu(tsk, cpu);
 	/*
 	 * Park the thread so that it could start right on the CPU
 	 * when it is available.
diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index ec0771e4a3fb..b518fd67a792 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -1862,7 +1862,7 @@ static void worker_attach_to_pool(struct worker *worker,
 	if (pool->flags & POOL_DISASSOCIATED)
 		worker->flags |= WORKER_UNBOUND;
 	else
-		kthread_set_per_cpu(worker->task, true);
+		kthread_set_per_cpu(worker->task, pool->cpu);
 
 	list_add_tail(&worker->node, &pool->workers);
 	worker->pool = pool;
@@ -1885,7 +1885,7 @@ static void worker_detach_from_pool(struct worker *worker)
 
 	mutex_lock(&wq_pool_attach_mutex);
 
-	kthread_set_per_cpu(worker->task, false);
+	kthread_set_per_cpu(worker->task, -1);
 	list_del(&worker->node);
 	worker->pool = NULL;
 
@@ -2371,6 +2371,7 @@ static int worker_thread(void *__worker)
 	/* tell the scheduler that this is a workqueue worker */
 	set_pf_worker(true);
 woke_up:
+	kthread_parkme();
 	raw_spin_lock_irq(&pool->lock);
 
 	/* am I supposed to die? */
@@ -2428,7 +2429,7 @@ static int worker_thread(void *__worker)
 			move_linked_works(work, &worker->scheduled, NULL);
 			process_scheduled_works(worker);
 		}
-	} while (keep_working(pool));
+	} while (keep_working(pool) && !kthread_should_park());
 
 	worker_set_flags(worker, WORKER_PREP);
 sleep:
@@ -2440,9 +2441,12 @@ static int worker_thread(void *__worker)
 	 * event.
 	 */
 	worker_enter_idle(worker);
-	__set_current_state(TASK_IDLE);
+	set_current_state(TASK_IDLE);
 	raw_spin_unlock_irq(&pool->lock);
-	schedule();
+
+	if (!kthread_should_park())
+		schedule();
+
 	goto woke_up;
 }
 
@@ -4923,7 +4927,7 @@ static void unbind_workers(int cpu)
 		raw_spin_unlock_irq(&pool->lock);
 
 		for_each_pool_worker(worker, pool) {
-			kthread_set_per_cpu(worker->task, false);
+			kthread_set_per_cpu(worker->task, -1);
 			WARN_ON_ONCE(set_cpus_allowed_ptr(worker->task, cpu_possible_mask) < 0);
 		}
 
@@ -4978,9 +4982,9 @@ static void rebind_workers(struct worker_pool *pool)
 	 * from CPU_ONLINE, the following shouldn't fail.
 	 */
 	for_each_pool_worker(worker, pool) {
-		WARN_ON_ONCE(set_cpus_allowed_ptr(worker->task,
-						  pool->attrs->cpumask) < 0);
-		kthread_set_per_cpu(worker->task, true);
+		WARN_ON_ONCE(kthread_park(worker->task) < 0);
+		kthread_set_per_cpu(worker->task, pool->cpu);
+		kthread_unpark(worker->task);
 	}
 
 	raw_spin_lock_irq(&pool->lock);
