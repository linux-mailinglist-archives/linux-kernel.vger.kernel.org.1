Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DC5928DB9C
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 10:33:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728734AbgJNIda (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 04:33:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728435AbgJNId3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 04:33:29 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6CD4C051111
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 01:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=SZk4ENvjqBcp2NaJaFEexFN2q87zoKwvZr4D/rU957Y=; b=uNsVFpZgwBoK4ErFiymIcoEXxz
        RptICUcU6wtLHNLS/oS77zev1GeDgu34UOaCUA65/TzwinCwQ2MRlDiH3W3wMCkT8n65S0iTL627f
        kU9A4+fpfYqUgXoIyNFZHEbIZwuw+nSHoNxp9BZ53J1lxUtLSvEZeMUtF+wCM0alN2OxDi7ORDrq8
        CwobtqODxu/YBm3zTR0tM8ynA3EvJNZxIewQZitvFRgcLC48j8S7z40c9trB5aUgFcQR2vPxVh0zF
        r7a/NIeMJqh2nN/KhZDT5MicqxgVHs7QXQVRknyaYD4NqEPQznKuLT3S04Mmszb6krfpgjyEBQUXa
        K2WatgHQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kScDt-0006Fw-Hs; Wed, 14 Oct 2020 08:33:25 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 20C5F306BCA;
        Wed, 14 Oct 2020 10:33:21 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 13E47203CD921; Wed, 14 Oct 2020 10:33:21 +0200 (CEST)
Date:   Wed, 14 Oct 2020 10:33:21 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Marcelo Tosatti <mtosatti@redhat.com>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        linux-kernel@vger.kernel.org,
        Nitesh Narayan Lal <nitesh@redhat.com>,
        Peter Xu <peterx@redhat.com>
Subject: Re: [patch 1/2] nohz: only wakeup a single target cpu when kicking a
 task
Message-ID: <20201014083321.GA2628@hirez.programming.kicks-ass.net>
References: <20201007180151.623061463@redhat.com>
 <20201007180229.724302019@redhat.com>
 <20201008122256.GW2628@hirez.programming.kicks-ass.net>
 <20201008175409.GB14207@fuller.cnet>
 <20201008195444.GB86389@lothringen>
 <20201013171328.GA19284@fuller.cnet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201013171328.GA19284@fuller.cnet>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 13, 2020 at 02:13:28PM -0300, Marcelo Tosatti wrote:

> > Yes but if the task isn't running, run_posix_cpu_timers() doesn't have
> > anything to elapse. So indeed we can spare the IPI if the task is not
> > running. Provided ordering makes sure that the task sees the new dependency
> > when it schedules in of course.
> 
> True.
> 
>  * p->on_cpu <- { 0, 1 }:
>  *
>  *   is set by prepare_task() and cleared by finish_task() such that it will be
>  *   set before p is scheduled-in and cleared after p is scheduled-out, both
>  *   under rq->lock. Non-zero indicates the task is running on its CPU.
> 
> 
> CPU-0 (tick_set_dep)            CPU-1 (task switch)
> 
> STORE p->tick_dep_mask
> smp_mb() (atomic_fetch_or())
> LOAD p->on_cpu
> 
> 
>                                 context_switch(prev, next)
>                                 STORE next->on_cpu = 1
>                                 ...                             [*]
> 
>                                 LOAD current->tick_dep_mask
> 

That load is in tick_nohz_task_switch() right? (which BTW is placed
completely wrong) You could easily do something like the below I
suppose.

diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index 81632cd5e3b7..2a5fafe66bb0 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -410,6 +410,14 @@ void __tick_nohz_task_switch(void)
 	ts = this_cpu_ptr(&tick_cpu_sched);
 
 	if (ts->tick_stopped) {
+		/*
+		 * tick_set_dep()		(this)
+		 *
+		 * STORE p->tick_dep_mask	STORE p->on_cpu
+		 * smp_mb()			smp_mb()
+		 * LOAD p->on_cpu		LOAD p->tick_dep_mask
+		 */
+		smp_mb();
 		if (atomic_read(&current->tick_dep_mask) ||
 		    atomic_read(&current->signal->tick_dep_mask))
 			tick_nohz_full_kick();



re tick_nohz_task_switch() being placed wrong, it should probably be
placed before finish_lock_switch(). Something like so.


diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index cf044580683c..5c92c959824f 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4084,6 +4084,7 @@ static struct rq *finish_task_switch(struct task_struct *prev)
 	vtime_task_switch(prev);
 	perf_event_task_sched_in(prev, current);
 	finish_task(prev);
+	tick_nohz_task_switch();
 	finish_lock_switch(rq);
 	finish_arch_post_lock_switch();
 	kcov_finish_switch(current);
@@ -4121,7 +4122,6 @@ static struct rq *finish_task_switch(struct task_struct *prev)
 		put_task_struct_rcu_user(prev);
 	}
 
-	tick_nohz_task_switch();
 	return rq;
 }
 
diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index 81632cd5e3b7..c8bddc9fb792 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -402,10 +402,8 @@ void __tick_nohz_task_switch(void)
 	unsigned long flags;
 	struct tick_sched *ts;
 
-	local_irq_save(flags);
-
 	if (!tick_nohz_full_cpu(smp_processor_id()))
-		goto out;
+		return;
 
 	ts = this_cpu_ptr(&tick_cpu_sched);
 
@@ -414,8 +412,6 @@ void __tick_nohz_task_switch(void)
 		    atomic_read(&current->signal->tick_dep_mask))
 			tick_nohz_full_kick();
 	}
-out:
-	local_irq_restore(flags);
 }
 
 /* Get the boot-time nohz CPU list from the kernel parameters. */
