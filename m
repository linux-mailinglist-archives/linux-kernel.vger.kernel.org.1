Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B126294B2E
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 12:24:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438699AbgJUKYm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 06:24:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389754AbgJUKYl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 06:24:41 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64942C0613CE
        for <linux-kernel@vger.kernel.org>; Wed, 21 Oct 2020 03:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=zdVtZLGXrXjTjfLYKbgWl2VfqJngIQhphEE14IVvPAo=; b=g9NBHmC/3OnTYl9Tdn68HYyTjd
        kIcD9FAj1zBU3/PukVc9Dw6EweA05aMq5cgYZRJZno3KeqcueA34jDqi9zBjkPXcKLVTpsGe9C1us
        5tYO1T5m2snlspaU/1jFHgxOPIAEUrtkUzfqn8BH31GZtbRe4IbPqwj/bINbLd0i5mK7o2G7nca0+
        CB3Oa7iSZ2IT+/r7nma9EGj6rZDgZeca8z49OaUmxkq3Mwc4Z5SJPoLwTvT6qNVAnU/uChSTI+Xu4
        6p1NTKTlJU5ygLNYGwq6f6eh6OQ3AWCGLpam9g8tLnTQV/7yioVyZjDgD7th6iFMLK8Tr8k/HRlMm
        kE9Di48g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kVBI6-0006ff-3k; Wed, 21 Oct 2020 10:24:22 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 36040304BAE;
        Wed, 21 Oct 2020 12:24:21 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E865E203CC49D; Wed, 21 Oct 2020 12:24:20 +0200 (CEST)
Date:   Wed, 21 Oct 2020 12:24:20 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Xi Wang <xii@google.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Josh Don <joshdon@google.com>, linux-kernel@vger.kernel.org,
        Paul Turner <pjt@google.com>,
        Paul McKenney <paulmck@kernel.org>
Subject: Re: [PATCH v2 1/1] sched: watchdog: Touch kernel watchdog with sched
 count
Message-ID: <20201021102420.GW2651@hirez.programming.kicks-ass.net>
References: <20201020205704.1741543-1-xii@google.com>
 <20201020205704.1741543-2-xii@google.com>
 <20201021101257.GC2628@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201021101257.GC2628@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 21, 2020 at 12:12:57PM +0200, Peter Zijlstra wrote:
> On Tue, Oct 20, 2020 at 01:57:04PM -0700, Xi Wang wrote:
> 
> > +	if (watchdog_touch_with_sched) {
> > +		/* Trigger reschedule for the next round */
> > +		set_tsk_need_resched(current);
> > +		set_preempt_need_resched();
> 
> Blergh.. that's gross. This relies on this being in IRQ context and
> either: PREEMPT=y *OR* this always being from userspace. Otherwise
> there's no guarantee the return-from-interrupt will actually schedule.

*compeltely* untested.

---
diff --git a/arch/s390/mm/fault.c b/arch/s390/mm/fault.c
index 996884dcc9fd..f3913a6ed5e1 100644
--- a/arch/s390/mm/fault.c
+++ b/arch/s390/mm/fault.c
@@ -745,8 +745,7 @@ static void pfault_interrupt(struct ext_code ext_code,
 			 * is no kernel task state to trample. Rely on the
 			 * return to userspace schedule() to block. */
 			__set_current_state(TASK_UNINTERRUPTIBLE);
-			set_tsk_need_resched(tsk);
-			set_preempt_need_resched();
+			resched_current_from_IRQ();
 		}
 	}
 out:
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 8583b15dbc83..e5447b8473d1 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1832,6 +1832,8 @@ static inline int test_tsk_need_resched(struct task_struct *tsk)
 	return unlikely(test_tsk_thread_flag(tsk,TIF_NEED_RESCHED));
 }
 
+extern void resched_current_from_IRQ(void);
+
 /*
  * cond_resched() and cond_resched_lock(): latency reduction via
  * explicit rescheduling in places that are safe. The return
diff --git a/kernel/rcu/tiny.c b/kernel/rcu/tiny.c
index aa897c3f2e92..a21c16089452 100644
--- a/kernel/rcu/tiny.c
+++ b/kernel/rcu/tiny.c
@@ -70,8 +70,7 @@ void rcu_sched_clock_irq(int user)
 	if (user) {
 		rcu_qs();
 	} else if (rcu_ctrlblk.donetail != rcu_ctrlblk.curtail) {
-		set_tsk_need_resched(current);
-		set_preempt_need_resched();
+		resched_current_from_IRQ();
 	}
 }
 
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index edeabc232c21..39aae3663bea 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2558,8 +2558,7 @@ void rcu_sched_clock_irq(int user)
 	if (smp_load_acquire(this_cpu_ptr(&rcu_data.rcu_urgent_qs))) {
 		/* Idle and userspace execution already are quiescent states. */
 		if (!rcu_is_cpu_rrupt_from_idle() && !user) {
-			set_tsk_need_resched(current);
-			set_preempt_need_resched();
+			resched_current_from_IRQ();
 		}
 		__this_cpu_write(rcu_data.rcu_urgent_qs, false);
 	}
@@ -2687,8 +2686,7 @@ static __latent_entropy void rcu_core(void)
 	if (!(preempt_count() & PREEMPT_MASK)) {
 		rcu_preempt_deferred_qs(current);
 	} else if (rcu_preempt_need_deferred_qs(current)) {
-		set_tsk_need_resched(current);
-		set_preempt_need_resched();
+		resched_current_from_IRQ();
 	}
 
 	/* Update RCU state based on any recent quiescent states. */
diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
index 8760b6ead770..fbafc3aba268 100644
--- a/kernel/rcu/tree_exp.h
+++ b/kernel/rcu/tree_exp.h
@@ -656,8 +656,7 @@ static void rcu_exp_handler(void *unused)
 			rcu_report_exp_rdp(rdp);
 		} else {
 			rdp->exp_deferred_qs = true;
-			set_tsk_need_resched(t);
-			set_preempt_need_resched();
+			resched_current_from_IRQ();
 		}
 		return;
 	}
@@ -725,8 +724,7 @@ static void rcu_exp_need_qs(void)
 	__this_cpu_write(rcu_data.cpu_no_qs.b.exp, true);
 	/* Store .exp before .rcu_urgent_qs. */
 	smp_store_release(this_cpu_ptr(&rcu_data.rcu_urgent_qs), true);
-	set_tsk_need_resched(current);
-	set_preempt_need_resched();
+	resched_current_from_IRQ();
 }
 
 /* Invoked on each online non-idle CPU for expedited quiescent state. */
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index fd8a52e9a887..b98294585c56 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -625,8 +625,7 @@ static void rcu_read_unlock_special(struct task_struct *t)
 			// Enabling BH or preempt does reschedule, so...
 			// Also if no expediting, slow is OK.
 			// Plus nohz_full CPUs eventually get tick enabled.
-			set_tsk_need_resched(current);
-			set_preempt_need_resched();
+			resched_current_from_IRQ();
 			if (IS_ENABLED(CONFIG_IRQ_WORK) && irqs_were_disabled &&
 			    !rdp->defer_qs_iw_pending && exp) {
 				// Get scheduler to re-evaluate and call hooks.
@@ -689,8 +688,7 @@ static void rcu_flavor_sched_clock_irq(int user)
 	    (preempt_count() & (PREEMPT_MASK | SOFTIRQ_MASK))) {
 		/* No QS, force context switch if deferred. */
 		if (rcu_preempt_need_deferred_qs(t)) {
-			set_tsk_need_resched(t);
-			set_preempt_need_resched();
+			resched_current_from_IRQ();
 		}
 	} else if (rcu_preempt_need_deferred_qs(t)) {
 		rcu_preempt_deferred_qs(t); /* Report deferred QS. */
diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index 0fde39b8daab..74973ab3c14d 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -566,8 +566,7 @@ static void print_cpu_stall(unsigned long gps)
 	 * progress and it could be we're stuck in kernel space without context
 	 * switches for an entirely unreasonable amount of time.
 	 */
-	set_tsk_need_resched(current);
-	set_preempt_need_resched();
+	resched_current_from_IRQ();
 }
 
 static void check_cpu_stall(struct rcu_data *rdp)
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 4a51461a2708..79c4ee72c9b6 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -641,6 +641,17 @@ void resched_cpu(int cpu)
 	raw_spin_unlock_irqrestore(&rq->lock, flags);
 }
 
+void resched_current_from_IRQ(void)
+{
+	struct pt_regs *regs = get_irq_regs();
+
+	WARN_ON_ONCE(!in_irq());
+	WARN_ON_ONCE(user_mode(regs) || IS_ENABLED(CONFIG_PREEMPTION));
+
+	set_tsk_need_resched(tsk);
+	set_preempt_need_resched();
+}
+
 #ifdef CONFIG_SMP
 #ifdef CONFIG_NO_HZ_COMMON
 /*
