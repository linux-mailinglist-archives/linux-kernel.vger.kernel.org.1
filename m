Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7177D2932C2
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 03:43:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390122AbgJTBnu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 21:43:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390104AbgJTBnu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 21:43:50 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96DB4C0613CE
        for <linux-kernel@vger.kernel.org>; Mon, 19 Oct 2020 18:43:49 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id u19so588273ion.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Oct 2020 18:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FBgj9ERprlfOexlak2KuJBuaUoR9Pt3PrMYKwU7Q8ZI=;
        b=IwrnN7bwsKSuhQxbVJZEKv8R1YM59ThLWWI5G92ZItcXuypJfJ/mD6AWElLzE46S0c
         Ejc9T+qHXmkWkd0cHg1l6Z6vc4OIIM570ELaSR/ZuuiwCN1PMXLOYWexgjNsCgUHlp0+
         waMnKoHGLKjmz00h/09dHDR0UB3aKD8by7VsQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FBgj9ERprlfOexlak2KuJBuaUoR9Pt3PrMYKwU7Q8ZI=;
        b=eDB2qURvnyXud0XP4uwisXGWHvhw/kSxbr3S8k2jj8oCKvkdZUqk/fydoaUX1H0yNn
         urv05Y9aeBOHFJ8EeD41RzCnEZKAWYQks4W/bIanQeEmZ9jfiadyCFUOdOdYqwx4kRp3
         mfNE24XaP8lrtrIX20j05X6UzOdXsN17OLLxeCGAXc6/GkguEa2UHiaH84vtsVR2KrVu
         ZQZJeqjmPjyBFvj9yAZ8DEHVgquoLPFwOQJR1d+LJK/HGnyhHbp35rnzayQA9lGme4cJ
         dZtHdQABh2n3jjAiNYORZn+1VJoecimKkvX04sJD7c6b2Ilaf74lkxiezZ+24cSj2/vm
         +GQg==
X-Gm-Message-State: AOAM5336WFxLX/t7WXMyz0Dh8y7EUb5iGP6XOAyV8c2rBHQK3hd6ZBQZ
        eDfax65g0p0/KT/bKj3W+vpETg==
X-Google-Smtp-Source: ABdhPJwK0w7PhlSbJ6W0T4rijhQyKUENVJ2zC6mCfjFR2p4tVBQqI3Xs7K2t9/Fv/B2Xvyzx3MPDrA==
X-Received: by 2002:a05:6602:2dc2:: with SMTP id l2mr472736iow.179.1603158228769;
        Mon, 19 Oct 2020 18:43:48 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id t22sm485306ili.9.2020.10.19.18.43.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2020 18:43:48 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>, tglx@linutronix.de,
        linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, torvalds@linux-foundation.org,
        fweisbec@gmail.com, keescook@chromium.org, kerrnel@google.com,
        Phil Auld <pauld@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>, joel@joelfernandes.org,
        vineeth@bitbyteword.org, Chen Yu <yu.c.chen@intel.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Agata Gruza <agata.gruza@intel.com>,
        Antonio Gomez Iglesias <antonio.gomez.iglesias@intel.com>,
        graf@amazon.com, konrad.wilk@oracle.com, dfaggioli@suse.com,
        pjt@google.com, rostedt@goodmis.org, derkling@google.com,
        benbjiang@tencent.com,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        James.Bottomley@hansenpartnership.com, OWeisse@umich.edu,
        Dhaval Giani <dhaval.giani@oracle.com>,
        Junaid Shahid <junaids@google.com>, jsbarnes@google.com,
        chris.hyser@oracle.com,
        Vineeth Remanan Pillai <vpillai@digitalocean.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Tim Chen <tim.c.chen@intel.com>
Subject: [PATCH v8 -tip 01/26] sched: Wrap rq::lock access
Date:   Mon, 19 Oct 2020 21:43:11 -0400
Message-Id: <20201020014336.2076526-2-joel@joelfernandes.org>
X-Mailer: git-send-email 2.29.0.rc1.297.gfa9743e501-goog
In-Reply-To: <20201020014336.2076526-1-joel@joelfernandes.org>
References: <20201020014336.2076526-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Zijlstra <peterz@infradead.org>

In preparation of playing games with rq->lock, abstract the thing
using an accessor.

Tested-by: Julien Desfossez <jdesfossez@digitalocean.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Vineeth Remanan Pillai <vpillai@digitalocean.com>
Signed-off-by: Julien Desfossez <jdesfossez@digitalocean.com>
---
 kernel/sched/core.c     |  46 +++++++++---------
 kernel/sched/cpuacct.c  |  12 ++---
 kernel/sched/deadline.c |  18 +++----
 kernel/sched/debug.c    |   4 +-
 kernel/sched/fair.c     |  38 +++++++--------
 kernel/sched/idle.c     |   4 +-
 kernel/sched/pelt.h     |   2 +-
 kernel/sched/rt.c       |   8 +--
 kernel/sched/sched.h    | 105 +++++++++++++++++++++-------------------
 kernel/sched/topology.c |   4 +-
 10 files changed, 122 insertions(+), 119 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index d2003a7d5ab5..97181b3d12eb 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -186,12 +186,12 @@ struct rq *__task_rq_lock(struct task_struct *p, struct rq_flags *rf)
 
 	for (;;) {
 		rq = task_rq(p);
-		raw_spin_lock(&rq->lock);
+		raw_spin_lock(rq_lockp(rq));
 		if (likely(rq == task_rq(p) && !task_on_rq_migrating(p))) {
 			rq_pin_lock(rq, rf);
 			return rq;
 		}
-		raw_spin_unlock(&rq->lock);
+		raw_spin_unlock(rq_lockp(rq));
 
 		while (unlikely(task_on_rq_migrating(p)))
 			cpu_relax();
@@ -210,7 +210,7 @@ struct rq *task_rq_lock(struct task_struct *p, struct rq_flags *rf)
 	for (;;) {
 		raw_spin_lock_irqsave(&p->pi_lock, rf->flags);
 		rq = task_rq(p);
-		raw_spin_lock(&rq->lock);
+		raw_spin_lock(rq_lockp(rq));
 		/*
 		 *	move_queued_task()		task_rq_lock()
 		 *
@@ -232,7 +232,7 @@ struct rq *task_rq_lock(struct task_struct *p, struct rq_flags *rf)
 			rq_pin_lock(rq, rf);
 			return rq;
 		}
-		raw_spin_unlock(&rq->lock);
+		raw_spin_unlock(rq_lockp(rq));
 		raw_spin_unlock_irqrestore(&p->pi_lock, rf->flags);
 
 		while (unlikely(task_on_rq_migrating(p)))
@@ -302,7 +302,7 @@ void update_rq_clock(struct rq *rq)
 {
 	s64 delta;
 
-	lockdep_assert_held(&rq->lock);
+	lockdep_assert_held(rq_lockp(rq));
 
 	if (rq->clock_update_flags & RQCF_ACT_SKIP)
 		return;
@@ -611,7 +611,7 @@ void resched_curr(struct rq *rq)
 	struct task_struct *curr = rq->curr;
 	int cpu;
 
-	lockdep_assert_held(&rq->lock);
+	lockdep_assert_held(rq_lockp(rq));
 
 	if (test_tsk_need_resched(curr))
 		return;
@@ -635,10 +635,10 @@ void resched_cpu(int cpu)
 	struct rq *rq = cpu_rq(cpu);
 	unsigned long flags;
 
-	raw_spin_lock_irqsave(&rq->lock, flags);
+	raw_spin_lock_irqsave(rq_lockp(rq), flags);
 	if (cpu_online(cpu) || cpu == smp_processor_id())
 		resched_curr(rq);
-	raw_spin_unlock_irqrestore(&rq->lock, flags);
+	raw_spin_unlock_irqrestore(rq_lockp(rq), flags);
 }
 
 #ifdef CONFIG_SMP
@@ -1137,7 +1137,7 @@ static inline void uclamp_rq_inc_id(struct rq *rq, struct task_struct *p,
 	struct uclamp_se *uc_se = &p->uclamp[clamp_id];
 	struct uclamp_bucket *bucket;
 
-	lockdep_assert_held(&rq->lock);
+	lockdep_assert_held(rq_lockp(rq));
 
 	/* Update task effective clamp */
 	p->uclamp[clamp_id] = uclamp_eff_get(p, clamp_id);
@@ -1177,7 +1177,7 @@ static inline void uclamp_rq_dec_id(struct rq *rq, struct task_struct *p,
 	unsigned int bkt_clamp;
 	unsigned int rq_clamp;
 
-	lockdep_assert_held(&rq->lock);
+	lockdep_assert_held(rq_lockp(rq));
 
 	/*
 	 * If sched_uclamp_used was enabled after task @p was enqueued,
@@ -1733,7 +1733,7 @@ static inline bool is_cpu_allowed(struct task_struct *p, int cpu)
 static struct rq *move_queued_task(struct rq *rq, struct rq_flags *rf,
 				   struct task_struct *p, int new_cpu)
 {
-	lockdep_assert_held(&rq->lock);
+	lockdep_assert_held(rq_lockp(rq));
 
 	deactivate_task(rq, p, DEQUEUE_NOCLOCK);
 	set_task_cpu(p, new_cpu);
@@ -1845,7 +1845,7 @@ void do_set_cpus_allowed(struct task_struct *p, const struct cpumask *new_mask)
 		 * Because __kthread_bind() calls this on blocked tasks without
 		 * holding rq->lock.
 		 */
-		lockdep_assert_held(&rq->lock);
+		lockdep_assert_held(rq_lockp(rq));
 		dequeue_task(rq, p, DEQUEUE_SAVE | DEQUEUE_NOCLOCK);
 	}
 	if (running)
@@ -1982,7 +1982,7 @@ void set_task_cpu(struct task_struct *p, unsigned int new_cpu)
 	 * task_rq_lock().
 	 */
 	WARN_ON_ONCE(debug_locks && !(lockdep_is_held(&p->pi_lock) ||
-				      lockdep_is_held(&task_rq(p)->lock)));
+				      lockdep_is_held(rq_lockp(task_rq(p)))));
 #endif
 	/*
 	 * Clearly, migrating tasks to offline CPUs is a fairly daft thing.
@@ -2493,7 +2493,7 @@ ttwu_do_activate(struct rq *rq, struct task_struct *p, int wake_flags,
 {
 	int en_flags = ENQUEUE_WAKEUP | ENQUEUE_NOCLOCK;
 
-	lockdep_assert_held(&rq->lock);
+	lockdep_assert_held(rq_lockp(rq));
 
 	if (p->sched_contributes_to_load)
 		rq->nr_uninterruptible--;
@@ -3495,10 +3495,10 @@ prepare_lock_switch(struct rq *rq, struct task_struct *next, struct rq_flags *rf
 	 * do an early lockdep release here:
 	 */
 	rq_unpin_lock(rq, rf);
-	spin_release(&rq->lock.dep_map, _THIS_IP_);
+	spin_release(&rq_lockp(rq)->dep_map, _THIS_IP_);
 #ifdef CONFIG_DEBUG_SPINLOCK
 	/* this is a valid case when another task releases the spinlock */
-	rq->lock.owner = next;
+	rq_lockp(rq)->owner = next;
 #endif
 }
 
@@ -3509,8 +3509,8 @@ static inline void finish_lock_switch(struct rq *rq)
 	 * fix up the runqueue lock - which gets 'carried over' from
 	 * prev into current:
 	 */
-	spin_acquire(&rq->lock.dep_map, 0, 0, _THIS_IP_);
-	raw_spin_unlock_irq(&rq->lock);
+	spin_acquire(&rq_lockp(rq)->dep_map, 0, 0, _THIS_IP_);
+	raw_spin_unlock_irq(rq_lockp(rq));
 }
 
 /*
@@ -3660,7 +3660,7 @@ static void __balance_callback(struct rq *rq)
 	void (*func)(struct rq *rq);
 	unsigned long flags;
 
-	raw_spin_lock_irqsave(&rq->lock, flags);
+	raw_spin_lock_irqsave(rq_lockp(rq), flags);
 	head = rq->balance_callback;
 	rq->balance_callback = NULL;
 	while (head) {
@@ -3671,7 +3671,7 @@ static void __balance_callback(struct rq *rq)
 
 		func(rq);
 	}
-	raw_spin_unlock_irqrestore(&rq->lock, flags);
+	raw_spin_unlock_irqrestore(rq_lockp(rq), flags);
 }
 
 static inline void balance_callback(struct rq *rq)
@@ -6521,7 +6521,7 @@ void init_idle(struct task_struct *idle, int cpu)
 	__sched_fork(0, idle);
 
 	raw_spin_lock_irqsave(&idle->pi_lock, flags);
-	raw_spin_lock(&rq->lock);
+	raw_spin_lock(rq_lockp(rq));
 
 	idle->state = TASK_RUNNING;
 	idle->se.exec_start = sched_clock();
@@ -6559,7 +6559,7 @@ void init_idle(struct task_struct *idle, int cpu)
 #ifdef CONFIG_SMP
 	idle->on_cpu = 1;
 #endif
-	raw_spin_unlock(&rq->lock);
+	raw_spin_unlock(rq_lockp(rq));
 	raw_spin_unlock_irqrestore(&idle->pi_lock, flags);
 
 	/* Set the preempt count _outside_ the spinlocks! */
@@ -7131,7 +7131,7 @@ void __init sched_init(void)
 		struct rq *rq;
 
 		rq = cpu_rq(i);
-		raw_spin_lock_init(&rq->lock);
+		raw_spin_lock_init(&rq->__lock);
 		rq->nr_running = 0;
 		rq->calc_load_active = 0;
 		rq->calc_load_update = jiffies + LOAD_FREQ;
diff --git a/kernel/sched/cpuacct.c b/kernel/sched/cpuacct.c
index 941c28cf9738..38c1a68e91f0 100644
--- a/kernel/sched/cpuacct.c
+++ b/kernel/sched/cpuacct.c
@@ -112,7 +112,7 @@ static u64 cpuacct_cpuusage_read(struct cpuacct *ca, int cpu,
 	/*
 	 * Take rq->lock to make 64-bit read safe on 32-bit platforms.
 	 */
-	raw_spin_lock_irq(&cpu_rq(cpu)->lock);
+	raw_spin_lock_irq(rq_lockp(cpu_rq(cpu)));
 #endif
 
 	if (index == CPUACCT_STAT_NSTATS) {
@@ -126,7 +126,7 @@ static u64 cpuacct_cpuusage_read(struct cpuacct *ca, int cpu,
 	}
 
 #ifndef CONFIG_64BIT
-	raw_spin_unlock_irq(&cpu_rq(cpu)->lock);
+	raw_spin_unlock_irq(rq_lockp(cpu_rq(cpu)));
 #endif
 
 	return data;
@@ -141,14 +141,14 @@ static void cpuacct_cpuusage_write(struct cpuacct *ca, int cpu, u64 val)
 	/*
 	 * Take rq->lock to make 64-bit write safe on 32-bit platforms.
 	 */
-	raw_spin_lock_irq(&cpu_rq(cpu)->lock);
+	raw_spin_lock_irq(rq_lockp(cpu_rq(cpu)));
 #endif
 
 	for (i = 0; i < CPUACCT_STAT_NSTATS; i++)
 		cpuusage->usages[i] = val;
 
 #ifndef CONFIG_64BIT
-	raw_spin_unlock_irq(&cpu_rq(cpu)->lock);
+	raw_spin_unlock_irq(rq_lockp(cpu_rq(cpu)));
 #endif
 }
 
@@ -253,13 +253,13 @@ static int cpuacct_all_seq_show(struct seq_file *m, void *V)
 			 * Take rq->lock to make 64-bit read safe on 32-bit
 			 * platforms.
 			 */
-			raw_spin_lock_irq(&cpu_rq(cpu)->lock);
+			raw_spin_lock_irq(rq_lockp(cpu_rq(cpu)));
 #endif
 
 			seq_printf(m, " %llu", cpuusage->usages[index]);
 
 #ifndef CONFIG_64BIT
-			raw_spin_unlock_irq(&cpu_rq(cpu)->lock);
+			raw_spin_unlock_irq(rq_lockp(cpu_rq(cpu)));
 #endif
 		}
 		seq_puts(m, "\n");
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 6d93f4518734..814ec49502b1 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -119,7 +119,7 @@ void __add_running_bw(u64 dl_bw, struct dl_rq *dl_rq)
 {
 	u64 old = dl_rq->running_bw;
 
-	lockdep_assert_held(&(rq_of_dl_rq(dl_rq))->lock);
+	lockdep_assert_held(rq_lockp(rq_of_dl_rq(dl_rq)));
 	dl_rq->running_bw += dl_bw;
 	SCHED_WARN_ON(dl_rq->running_bw < old); /* overflow */
 	SCHED_WARN_ON(dl_rq->running_bw > dl_rq->this_bw);
@@ -132,7 +132,7 @@ void __sub_running_bw(u64 dl_bw, struct dl_rq *dl_rq)
 {
 	u64 old = dl_rq->running_bw;
 
-	lockdep_assert_held(&(rq_of_dl_rq(dl_rq))->lock);
+	lockdep_assert_held(rq_lockp(rq_of_dl_rq(dl_rq)));
 	dl_rq->running_bw -= dl_bw;
 	SCHED_WARN_ON(dl_rq->running_bw > old); /* underflow */
 	if (dl_rq->running_bw > old)
@@ -146,7 +146,7 @@ void __add_rq_bw(u64 dl_bw, struct dl_rq *dl_rq)
 {
 	u64 old = dl_rq->this_bw;
 
-	lockdep_assert_held(&(rq_of_dl_rq(dl_rq))->lock);
+	lockdep_assert_held(rq_lockp(rq_of_dl_rq(dl_rq)));
 	dl_rq->this_bw += dl_bw;
 	SCHED_WARN_ON(dl_rq->this_bw < old); /* overflow */
 }
@@ -156,7 +156,7 @@ void __sub_rq_bw(u64 dl_bw, struct dl_rq *dl_rq)
 {
 	u64 old = dl_rq->this_bw;
 
-	lockdep_assert_held(&(rq_of_dl_rq(dl_rq))->lock);
+	lockdep_assert_held(rq_lockp(rq_of_dl_rq(dl_rq)));
 	dl_rq->this_bw -= dl_bw;
 	SCHED_WARN_ON(dl_rq->this_bw > old); /* underflow */
 	if (dl_rq->this_bw > old)
@@ -966,7 +966,7 @@ static int start_dl_timer(struct task_struct *p)
 	ktime_t now, act;
 	s64 delta;
 
-	lockdep_assert_held(&rq->lock);
+	lockdep_assert_held(rq_lockp(rq));
 
 	/*
 	 * We want the timer to fire at the deadline, but considering
@@ -1076,9 +1076,9 @@ static enum hrtimer_restart dl_task_timer(struct hrtimer *timer)
 		 * If the runqueue is no longer available, migrate the
 		 * task elsewhere. This necessarily changes rq.
 		 */
-		lockdep_unpin_lock(&rq->lock, rf.cookie);
+		lockdep_unpin_lock(rq_lockp(rq), rf.cookie);
 		rq = dl_task_offline_migration(rq, p);
-		rf.cookie = lockdep_pin_lock(&rq->lock);
+		rf.cookie = lockdep_pin_lock(rq_lockp(rq));
 		update_rq_clock(rq);
 
 		/*
@@ -1727,7 +1727,7 @@ static void migrate_task_rq_dl(struct task_struct *p, int new_cpu __maybe_unused
 	 * from try_to_wake_up(). Hence, p->pi_lock is locked, but
 	 * rq->lock is not... So, lock it
 	 */
-	raw_spin_lock(&rq->lock);
+	raw_spin_lock(rq_lockp(rq));
 	if (p->dl.dl_non_contending) {
 		sub_running_bw(&p->dl, &rq->dl);
 		p->dl.dl_non_contending = 0;
@@ -1742,7 +1742,7 @@ static void migrate_task_rq_dl(struct task_struct *p, int new_cpu __maybe_unused
 			put_task_struct(p);
 	}
 	sub_rq_bw(&p->dl, &rq->dl);
-	raw_spin_unlock(&rq->lock);
+	raw_spin_unlock(rq_lockp(rq));
 }
 
 static void check_preempt_equal_dl(struct rq *rq, struct task_struct *p)
diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 0655524700d2..c8fee8d9dfd4 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -551,7 +551,7 @@ void print_cfs_rq(struct seq_file *m, int cpu, struct cfs_rq *cfs_rq)
 	SEQ_printf(m, "  .%-30s: %Ld.%06ld\n", "exec_clock",
 			SPLIT_NS(cfs_rq->exec_clock));
 
-	raw_spin_lock_irqsave(&rq->lock, flags);
+	raw_spin_lock_irqsave(rq_lockp(rq), flags);
 	if (rb_first_cached(&cfs_rq->tasks_timeline))
 		MIN_vruntime = (__pick_first_entity(cfs_rq))->vruntime;
 	last = __pick_last_entity(cfs_rq);
@@ -559,7 +559,7 @@ void print_cfs_rq(struct seq_file *m, int cpu, struct cfs_rq *cfs_rq)
 		max_vruntime = last->vruntime;
 	min_vruntime = cfs_rq->min_vruntime;
 	rq0_min_vruntime = cpu_rq(0)->cfs.min_vruntime;
-	raw_spin_unlock_irqrestore(&rq->lock, flags);
+	raw_spin_unlock_irqrestore(rq_lockp(rq), flags);
 	SEQ_printf(m, "  .%-30s: %Ld.%06ld\n", "MIN_vruntime",
 			SPLIT_NS(MIN_vruntime));
 	SEQ_printf(m, "  .%-30s: %Ld.%06ld\n", "min_vruntime",
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index aa4c6227cd6d..dbd9368a959d 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1101,7 +1101,7 @@ struct numa_group {
 static struct numa_group *deref_task_numa_group(struct task_struct *p)
 {
 	return rcu_dereference_check(p->numa_group, p == current ||
-		(lockdep_is_held(&task_rq(p)->lock) && !READ_ONCE(p->on_cpu)));
+		(lockdep_is_held(rq_lockp(task_rq(p))) && !READ_ONCE(p->on_cpu)));
 }
 
 static struct numa_group *deref_curr_numa_group(struct task_struct *p)
@@ -5291,7 +5291,7 @@ static void __maybe_unused update_runtime_enabled(struct rq *rq)
 {
 	struct task_group *tg;
 
-	lockdep_assert_held(&rq->lock);
+	lockdep_assert_held(rq_lockp(rq));
 
 	rcu_read_lock();
 	list_for_each_entry_rcu(tg, &task_groups, list) {
@@ -5310,7 +5310,7 @@ static void __maybe_unused unthrottle_offline_cfs_rqs(struct rq *rq)
 {
 	struct task_group *tg;
 
-	lockdep_assert_held(&rq->lock);
+	lockdep_assert_held(rq_lockp(rq));
 
 	rcu_read_lock();
 	list_for_each_entry_rcu(tg, &task_groups, list) {
@@ -6772,7 +6772,7 @@ static void migrate_task_rq_fair(struct task_struct *p, int new_cpu)
 		 * In case of TASK_ON_RQ_MIGRATING we in fact hold the 'old'
 		 * rq->lock and can modify state directly.
 		 */
-		lockdep_assert_held(&task_rq(p)->lock);
+		lockdep_assert_held(rq_lockp(task_rq(p)));
 		detach_entity_cfs_rq(&p->se);
 
 	} else {
@@ -7400,7 +7400,7 @@ static int task_hot(struct task_struct *p, struct lb_env *env)
 {
 	s64 delta;
 
-	lockdep_assert_held(&env->src_rq->lock);
+	lockdep_assert_held(rq_lockp(env->src_rq));
 
 	if (p->sched_class != &fair_sched_class)
 		return 0;
@@ -7498,7 +7498,7 @@ int can_migrate_task(struct task_struct *p, struct lb_env *env)
 {
 	int tsk_cache_hot;
 
-	lockdep_assert_held(&env->src_rq->lock);
+	lockdep_assert_held(rq_lockp(env->src_rq));
 
 	/*
 	 * We do not migrate tasks that are:
@@ -7576,7 +7576,7 @@ int can_migrate_task(struct task_struct *p, struct lb_env *env)
  */
 static void detach_task(struct task_struct *p, struct lb_env *env)
 {
-	lockdep_assert_held(&env->src_rq->lock);
+	lockdep_assert_held(rq_lockp(env->src_rq));
 
 	deactivate_task(env->src_rq, p, DEQUEUE_NOCLOCK);
 	set_task_cpu(p, env->dst_cpu);
@@ -7592,7 +7592,7 @@ static struct task_struct *detach_one_task(struct lb_env *env)
 {
 	struct task_struct *p;
 
-	lockdep_assert_held(&env->src_rq->lock);
+	lockdep_assert_held(rq_lockp(env->src_rq));
 
 	list_for_each_entry_reverse(p,
 			&env->src_rq->cfs_tasks, se.group_node) {
@@ -7628,7 +7628,7 @@ static int detach_tasks(struct lb_env *env)
 	struct task_struct *p;
 	int detached = 0;
 
-	lockdep_assert_held(&env->src_rq->lock);
+	lockdep_assert_held(rq_lockp(env->src_rq));
 
 	if (env->imbalance <= 0)
 		return 0;
@@ -7750,7 +7750,7 @@ static int detach_tasks(struct lb_env *env)
  */
 static void attach_task(struct rq *rq, struct task_struct *p)
 {
-	lockdep_assert_held(&rq->lock);
+	lockdep_assert_held(rq_lockp(rq));
 
 	BUG_ON(task_rq(p) != rq);
 	activate_task(rq, p, ENQUEUE_NOCLOCK);
@@ -9684,7 +9684,7 @@ static int load_balance(int this_cpu, struct rq *this_rq,
 		if (need_active_balance(&env)) {
 			unsigned long flags;
 
-			raw_spin_lock_irqsave(&busiest->lock, flags);
+			raw_spin_lock_irqsave(rq_lockp(busiest), flags);
 
 			/*
 			 * Don't kick the active_load_balance_cpu_stop,
@@ -9692,7 +9692,7 @@ static int load_balance(int this_cpu, struct rq *this_rq,
 			 * moved to this_cpu:
 			 */
 			if (!cpumask_test_cpu(this_cpu, busiest->curr->cpus_ptr)) {
-				raw_spin_unlock_irqrestore(&busiest->lock,
+				raw_spin_unlock_irqrestore(rq_lockp(busiest),
 							    flags);
 				env.flags |= LBF_ALL_PINNED;
 				goto out_one_pinned;
@@ -9708,7 +9708,7 @@ static int load_balance(int this_cpu, struct rq *this_rq,
 				busiest->push_cpu = this_cpu;
 				active_balance = 1;
 			}
-			raw_spin_unlock_irqrestore(&busiest->lock, flags);
+			raw_spin_unlock_irqrestore(rq_lockp(busiest), flags);
 
 			if (active_balance) {
 				stop_one_cpu_nowait(cpu_of(busiest),
@@ -10460,7 +10460,7 @@ static void nohz_newidle_balance(struct rq *this_rq)
 	    time_before(jiffies, READ_ONCE(nohz.next_blocked)))
 		return;
 
-	raw_spin_unlock(&this_rq->lock);
+	raw_spin_unlock(rq_lockp(this_rq));
 	/*
 	 * This CPU is going to be idle and blocked load of idle CPUs
 	 * need to be updated. Run the ilb locally as it is a good
@@ -10469,7 +10469,7 @@ static void nohz_newidle_balance(struct rq *this_rq)
 	 */
 	if (!_nohz_idle_balance(this_rq, NOHZ_STATS_KICK, CPU_NEWLY_IDLE))
 		kick_ilb(NOHZ_STATS_KICK);
-	raw_spin_lock(&this_rq->lock);
+	raw_spin_lock(rq_lockp(this_rq));
 }
 
 #else /* !CONFIG_NO_HZ_COMMON */
@@ -10535,7 +10535,7 @@ static int newidle_balance(struct rq *this_rq, struct rq_flags *rf)
 		goto out;
 	}
 
-	raw_spin_unlock(&this_rq->lock);
+	raw_spin_unlock(rq_lockp(this_rq));
 
 	update_blocked_averages(this_cpu);
 	rcu_read_lock();
@@ -10573,7 +10573,7 @@ static int newidle_balance(struct rq *this_rq, struct rq_flags *rf)
 	}
 	rcu_read_unlock();
 
-	raw_spin_lock(&this_rq->lock);
+	raw_spin_lock(rq_lockp(this_rq));
 
 	if (curr_cost > this_rq->max_idle_balance_cost)
 		this_rq->max_idle_balance_cost = curr_cost;
@@ -11049,9 +11049,9 @@ void unregister_fair_sched_group(struct task_group *tg)
 
 		rq = cpu_rq(cpu);
 
-		raw_spin_lock_irqsave(&rq->lock, flags);
+		raw_spin_lock_irqsave(rq_lockp(rq), flags);
 		list_del_leaf_cfs_rq(tg->cfs_rq[cpu]);
-		raw_spin_unlock_irqrestore(&rq->lock, flags);
+		raw_spin_unlock_irqrestore(rq_lockp(rq), flags);
 	}
 }
 
diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index f324dc36fc43..8ce6e80352cf 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -421,10 +421,10 @@ struct task_struct *pick_next_task_idle(struct rq *rq)
 static void
 dequeue_task_idle(struct rq *rq, struct task_struct *p, int flags)
 {
-	raw_spin_unlock_irq(&rq->lock);
+	raw_spin_unlock_irq(rq_lockp(rq));
 	printk(KERN_ERR "bad: scheduling from the idle thread!\n");
 	dump_stack();
-	raw_spin_lock_irq(&rq->lock);
+	raw_spin_lock_irq(rq_lockp(rq));
 }
 
 /*
diff --git a/kernel/sched/pelt.h b/kernel/sched/pelt.h
index 795e43e02afc..e850bd71a8ce 100644
--- a/kernel/sched/pelt.h
+++ b/kernel/sched/pelt.h
@@ -141,7 +141,7 @@ static inline void update_idle_rq_clock_pelt(struct rq *rq)
 
 static inline u64 rq_clock_pelt(struct rq *rq)
 {
-	lockdep_assert_held(&rq->lock);
+	lockdep_assert_held(rq_lockp(rq));
 	assert_clock_updated(rq);
 
 	return rq->clock_pelt - rq->lost_idle_time;
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index f215eea6a966..e57fca05b660 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -887,7 +887,7 @@ static int do_sched_rt_period_timer(struct rt_bandwidth *rt_b, int overrun)
 		if (skip)
 			continue;
 
-		raw_spin_lock(&rq->lock);
+		raw_spin_lock(rq_lockp(rq));
 		update_rq_clock(rq);
 
 		if (rt_rq->rt_time) {
@@ -925,7 +925,7 @@ static int do_sched_rt_period_timer(struct rt_bandwidth *rt_b, int overrun)
 
 		if (enqueue)
 			sched_rt_rq_enqueue(rt_rq);
-		raw_spin_unlock(&rq->lock);
+		raw_spin_unlock(rq_lockp(rq));
 	}
 
 	if (!throttled && (!rt_bandwidth_enabled() || rt_b->rt_runtime == RUNTIME_INF))
@@ -2094,9 +2094,9 @@ void rto_push_irq_work_func(struct irq_work *work)
 	 * When it gets updated, a check is made if a push is possible.
 	 */
 	if (has_pushable_tasks(rq)) {
-		raw_spin_lock(&rq->lock);
+		raw_spin_lock(rq_lockp(rq));
 		push_rt_tasks(rq);
-		raw_spin_unlock(&rq->lock);
+		raw_spin_unlock(rq_lockp(rq));
 	}
 
 	raw_spin_lock(&rd->rto_lock);
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index df80bfcea92e..587ebabebaff 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -894,7 +894,7 @@ DECLARE_STATIC_KEY_FALSE(sched_uclamp_used);
  */
 struct rq {
 	/* runqueue lock: */
-	raw_spinlock_t		lock;
+	raw_spinlock_t		__lock;
 
 	/*
 	 * nr_running and cpu_load should be in the same cacheline because
@@ -1075,6 +1075,10 @@ static inline int cpu_of(struct rq *rq)
 #endif
 }
 
+static inline raw_spinlock_t *rq_lockp(struct rq *rq)
+{
+	return &rq->__lock;
+}
 
 #ifdef CONFIG_SCHED_SMT
 extern void __update_idle_core(struct rq *rq);
@@ -1142,7 +1146,7 @@ static inline void assert_clock_updated(struct rq *rq)
 
 static inline u64 rq_clock(struct rq *rq)
 {
-	lockdep_assert_held(&rq->lock);
+	lockdep_assert_held(rq_lockp(rq));
 	assert_clock_updated(rq);
 
 	return rq->clock;
@@ -1150,7 +1154,7 @@ static inline u64 rq_clock(struct rq *rq)
 
 static inline u64 rq_clock_task(struct rq *rq)
 {
-	lockdep_assert_held(&rq->lock);
+	lockdep_assert_held(rq_lockp(rq));
 	assert_clock_updated(rq);
 
 	return rq->clock_task;
@@ -1176,7 +1180,7 @@ static inline u64 rq_clock_thermal(struct rq *rq)
 
 static inline void rq_clock_skip_update(struct rq *rq)
 {
-	lockdep_assert_held(&rq->lock);
+	lockdep_assert_held(rq_lockp(rq));
 	rq->clock_update_flags |= RQCF_REQ_SKIP;
 }
 
@@ -1186,7 +1190,7 @@ static inline void rq_clock_skip_update(struct rq *rq)
  */
 static inline void rq_clock_cancel_skipupdate(struct rq *rq)
 {
-	lockdep_assert_held(&rq->lock);
+	lockdep_assert_held(rq_lockp(rq));
 	rq->clock_update_flags &= ~RQCF_REQ_SKIP;
 }
 
@@ -1215,7 +1219,7 @@ struct rq_flags {
  */
 static inline void rq_pin_lock(struct rq *rq, struct rq_flags *rf)
 {
-	rf->cookie = lockdep_pin_lock(&rq->lock);
+	rf->cookie = lockdep_pin_lock(rq_lockp(rq));
 
 #ifdef CONFIG_SCHED_DEBUG
 	rq->clock_update_flags &= (RQCF_REQ_SKIP|RQCF_ACT_SKIP);
@@ -1230,12 +1234,12 @@ static inline void rq_unpin_lock(struct rq *rq, struct rq_flags *rf)
 		rf->clock_update_flags = RQCF_UPDATED;
 #endif
 
-	lockdep_unpin_lock(&rq->lock, rf->cookie);
+	lockdep_unpin_lock(rq_lockp(rq), rf->cookie);
 }
 
 static inline void rq_repin_lock(struct rq *rq, struct rq_flags *rf)
 {
-	lockdep_repin_lock(&rq->lock, rf->cookie);
+	lockdep_repin_lock(rq_lockp(rq), rf->cookie);
 
 #ifdef CONFIG_SCHED_DEBUG
 	/*
@@ -1256,7 +1260,7 @@ static inline void __task_rq_unlock(struct rq *rq, struct rq_flags *rf)
 	__releases(rq->lock)
 {
 	rq_unpin_lock(rq, rf);
-	raw_spin_unlock(&rq->lock);
+	raw_spin_unlock(rq_lockp(rq));
 }
 
 static inline void
@@ -1265,7 +1269,7 @@ task_rq_unlock(struct rq *rq, struct task_struct *p, struct rq_flags *rf)
 	__releases(p->pi_lock)
 {
 	rq_unpin_lock(rq, rf);
-	raw_spin_unlock(&rq->lock);
+	raw_spin_unlock(rq_lockp(rq));
 	raw_spin_unlock_irqrestore(&p->pi_lock, rf->flags);
 }
 
@@ -1273,7 +1277,7 @@ static inline void
 rq_lock_irqsave(struct rq *rq, struct rq_flags *rf)
 	__acquires(rq->lock)
 {
-	raw_spin_lock_irqsave(&rq->lock, rf->flags);
+	raw_spin_lock_irqsave(rq_lockp(rq), rf->flags);
 	rq_pin_lock(rq, rf);
 }
 
@@ -1281,7 +1285,7 @@ static inline void
 rq_lock_irq(struct rq *rq, struct rq_flags *rf)
 	__acquires(rq->lock)
 {
-	raw_spin_lock_irq(&rq->lock);
+	raw_spin_lock_irq(rq_lockp(rq));
 	rq_pin_lock(rq, rf);
 }
 
@@ -1289,7 +1293,7 @@ static inline void
 rq_lock(struct rq *rq, struct rq_flags *rf)
 	__acquires(rq->lock)
 {
-	raw_spin_lock(&rq->lock);
+	raw_spin_lock(rq_lockp(rq));
 	rq_pin_lock(rq, rf);
 }
 
@@ -1297,7 +1301,7 @@ static inline void
 rq_relock(struct rq *rq, struct rq_flags *rf)
 	__acquires(rq->lock)
 {
-	raw_spin_lock(&rq->lock);
+	raw_spin_lock(rq_lockp(rq));
 	rq_repin_lock(rq, rf);
 }
 
@@ -1306,7 +1310,7 @@ rq_unlock_irqrestore(struct rq *rq, struct rq_flags *rf)
 	__releases(rq->lock)
 {
 	rq_unpin_lock(rq, rf);
-	raw_spin_unlock_irqrestore(&rq->lock, rf->flags);
+	raw_spin_unlock_irqrestore(rq_lockp(rq), rf->flags);
 }
 
 static inline void
@@ -1314,7 +1318,7 @@ rq_unlock_irq(struct rq *rq, struct rq_flags *rf)
 	__releases(rq->lock)
 {
 	rq_unpin_lock(rq, rf);
-	raw_spin_unlock_irq(&rq->lock);
+	raw_spin_unlock_irq(rq_lockp(rq));
 }
 
 static inline void
@@ -1322,7 +1326,7 @@ rq_unlock(struct rq *rq, struct rq_flags *rf)
 	__releases(rq->lock)
 {
 	rq_unpin_lock(rq, rf);
-	raw_spin_unlock(&rq->lock);
+	raw_spin_unlock(rq_lockp(rq));
 }
 
 static inline struct rq *
@@ -1387,7 +1391,7 @@ queue_balance_callback(struct rq *rq,
 		       struct callback_head *head,
 		       void (*func)(struct rq *rq))
 {
-	lockdep_assert_held(&rq->lock);
+	lockdep_assert_held(rq_lockp(rq));
 
 	if (unlikely(head->next))
 		return;
@@ -2091,7 +2095,7 @@ static inline int _double_lock_balance(struct rq *this_rq, struct rq *busiest)
 	__acquires(busiest->lock)
 	__acquires(this_rq->lock)
 {
-	raw_spin_unlock(&this_rq->lock);
+	raw_spin_unlock(rq_lockp(this_rq));
 	double_rq_lock(this_rq, busiest);
 
 	return 1;
@@ -2110,20 +2114,22 @@ static inline int _double_lock_balance(struct rq *this_rq, struct rq *busiest)
 	__acquires(busiest->lock)
 	__acquires(this_rq->lock)
 {
-	int ret = 0;
-
-	if (unlikely(!raw_spin_trylock(&busiest->lock))) {
-		if (busiest < this_rq) {
-			raw_spin_unlock(&this_rq->lock);
-			raw_spin_lock(&busiest->lock);
-			raw_spin_lock_nested(&this_rq->lock,
-					      SINGLE_DEPTH_NESTING);
-			ret = 1;
-		} else
-			raw_spin_lock_nested(&busiest->lock,
-					      SINGLE_DEPTH_NESTING);
+	if (rq_lockp(this_rq) == rq_lockp(busiest))
+		return 0;
+
+	if (likely(raw_spin_trylock(rq_lockp(busiest))))
+		return 0;
+
+	if (rq_lockp(busiest) >= rq_lockp(this_rq)) {
+		raw_spin_lock_nested(rq_lockp(busiest), SINGLE_DEPTH_NESTING);
+		return 0;
 	}
-	return ret;
+
+	raw_spin_unlock(rq_lockp(this_rq));
+	raw_spin_lock(rq_lockp(busiest));
+	raw_spin_lock_nested(rq_lockp(this_rq), SINGLE_DEPTH_NESTING);
+
+	return 1;
 }
 
 #endif /* CONFIG_PREEMPTION */
@@ -2133,11 +2139,7 @@ static inline int _double_lock_balance(struct rq *this_rq, struct rq *busiest)
  */
 static inline int double_lock_balance(struct rq *this_rq, struct rq *busiest)
 {
-	if (unlikely(!irqs_disabled())) {
-		/* printk() doesn't work well under rq->lock */
-		raw_spin_unlock(&this_rq->lock);
-		BUG_ON(1);
-	}
+	lockdep_assert_irqs_disabled();
 
 	return _double_lock_balance(this_rq, busiest);
 }
@@ -2145,8 +2147,9 @@ static inline int double_lock_balance(struct rq *this_rq, struct rq *busiest)
 static inline void double_unlock_balance(struct rq *this_rq, struct rq *busiest)
 	__releases(busiest->lock)
 {
-	raw_spin_unlock(&busiest->lock);
-	lock_set_subclass(&this_rq->lock.dep_map, 0, _RET_IP_);
+	if (rq_lockp(this_rq) != rq_lockp(busiest))
+		raw_spin_unlock(rq_lockp(busiest));
+	lock_set_subclass(&rq_lockp(this_rq)->dep_map, 0, _RET_IP_);
 }
 
 static inline void double_lock(spinlock_t *l1, spinlock_t *l2)
@@ -2187,16 +2190,16 @@ static inline void double_rq_lock(struct rq *rq1, struct rq *rq2)
 	__acquires(rq2->lock)
 {
 	BUG_ON(!irqs_disabled());
-	if (rq1 == rq2) {
-		raw_spin_lock(&rq1->lock);
+	if (rq_lockp(rq1) == rq_lockp(rq2)) {
+		raw_spin_lock(rq_lockp(rq1));
 		__acquire(rq2->lock);	/* Fake it out ;) */
 	} else {
-		if (rq1 < rq2) {
-			raw_spin_lock(&rq1->lock);
-			raw_spin_lock_nested(&rq2->lock, SINGLE_DEPTH_NESTING);
+		if (rq_lockp(rq1) < rq_lockp(rq2)) {
+			raw_spin_lock(rq_lockp(rq1));
+			raw_spin_lock_nested(rq_lockp(rq2), SINGLE_DEPTH_NESTING);
 		} else {
-			raw_spin_lock(&rq2->lock);
-			raw_spin_lock_nested(&rq1->lock, SINGLE_DEPTH_NESTING);
+			raw_spin_lock(rq_lockp(rq2));
+			raw_spin_lock_nested(rq_lockp(rq1), SINGLE_DEPTH_NESTING);
 		}
 	}
 }
@@ -2211,9 +2214,9 @@ static inline void double_rq_unlock(struct rq *rq1, struct rq *rq2)
 	__releases(rq1->lock)
 	__releases(rq2->lock)
 {
-	raw_spin_unlock(&rq1->lock);
-	if (rq1 != rq2)
-		raw_spin_unlock(&rq2->lock);
+	raw_spin_unlock(rq_lockp(rq1));
+	if (rq_lockp(rq1) != rq_lockp(rq2))
+		raw_spin_unlock(rq_lockp(rq2));
 	else
 		__release(rq2->lock);
 }
@@ -2236,7 +2239,7 @@ static inline void double_rq_lock(struct rq *rq1, struct rq *rq2)
 {
 	BUG_ON(!irqs_disabled());
 	BUG_ON(rq1 != rq2);
-	raw_spin_lock(&rq1->lock);
+	raw_spin_lock(rq_lockp(rq1));
 	__acquire(rq2->lock);	/* Fake it out ;) */
 }
 
@@ -2251,7 +2254,7 @@ static inline void double_rq_unlock(struct rq *rq1, struct rq *rq2)
 	__releases(rq2->lock)
 {
 	BUG_ON(rq1 != rq2);
-	raw_spin_unlock(&rq1->lock);
+	raw_spin_unlock(rq_lockp(rq1));
 	__release(rq2->lock);
 }
 
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index dd7770226086..eeb9aca1c853 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -454,7 +454,7 @@ void rq_attach_root(struct rq *rq, struct root_domain *rd)
 	struct root_domain *old_rd = NULL;
 	unsigned long flags;
 
-	raw_spin_lock_irqsave(&rq->lock, flags);
+	raw_spin_lock_irqsave(rq_lockp(rq), flags);
 
 	if (rq->rd) {
 		old_rd = rq->rd;
@@ -480,7 +480,7 @@ void rq_attach_root(struct rq *rq, struct root_domain *rd)
 	if (cpumask_test_cpu(rq->cpu, cpu_active_mask))
 		set_rq_online(rq);
 
-	raw_spin_unlock_irqrestore(&rq->lock, flags);
+	raw_spin_unlock_irqrestore(rq_lockp(rq), flags);
 
 	if (old_rd)
 		call_rcu(&old_rd->rcu, free_rootdomain);
-- 
2.29.0.rc1.297.gfa9743e501-goog

