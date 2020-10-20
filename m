Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8229283920
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 17:10:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727028AbgJEPKa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 11:10:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726771AbgJEPJ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 11:09:59 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B762BC0613A7
        for <linux-kernel@vger.kernel.org>; Mon,  5 Oct 2020 08:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=0Qa6dypFY3aCt0zXCXiUEHXps4y20nSCKd5BjqpS2bY=; b=CkL/0iOIYsz5xDX3U2pKrRbIVx
        F9e1kFWXWdpmwBVQLvf+tAw3GHXY2kIZzFKeyUApTUbbGEPAgd7xsiXtk2KVcmkQkGTxOPkk1uCJe
        ahhvo7XuVJjPkpcwdLfL6PMjSxGfI3Th1k+aIXw+220Q83Eg+XweF6fWT4UjySGoAZmF8BFJeToRG
        KaSiEoQkJJ7YaYFhu9rIQSXbQVz87Ru+Pt5kLFkHopJATQ40LrM9C+PMMGUrOi8mgcWWS0l+c+wP3
        KNTrQQQ7JY975bhhkJULQM6jxFVRquVthZhcVLo9QaG1yn1Zb+B5H9Fziz7WK/BJl1TOeIhk0+qDx
        b1BmvZyg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kPS7W-0008PR-65; Mon, 05 Oct 2020 15:09:46 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 6CA4830767C;
        Mon,  5 Oct 2020 17:09:43 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id DE15729A897BA; Mon,  5 Oct 2020 17:09:42 +0200 (CEST)
Message-ID: <20201005150921.859981475@infradead.org>
User-Agent: quilt/0.66
Date:   Mon, 05 Oct 2020 16:57:26 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     tglx@linutronix.de, mingo@kernel.org
Cc:     linux-kernel@vger.kernel.org, bigeasy@linutronix.de,
        qais.yousef@arm.com, swood@redhat.com, peterz@infradead.org,
        valentin.schneider@arm.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vincent.donnefort@arm.com, tj@kernel.org
Subject: [PATCH -v2 09/17] sched: Add migrate_disable()
References: <20201005145717.346020688@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the base migrate_disable() support (under protest).

While migrate_disable() is (currently) required for PREEMPT_RT, it is
also one of the biggest flaws in the system.

Notably this is just the base implementation, it is broken vs
sched_setaffinity() and hotplug, both solved in additional patches for
ease of review.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/linux/preempt.h |   60 +++++++++++++++++++++++++
 include/linux/sched.h   |    3 +
 kernel/sched/core.c     |  112 +++++++++++++++++++++++++++++++++++++++++++++---
 kernel/sched/sched.h    |    6 +-
 lib/smp_processor_id.c  |    5 ++
 5 files changed, 178 insertions(+), 8 deletions(-)

--- a/include/linux/preempt.h
+++ b/include/linux/preempt.h
@@ -322,6 +322,64 @@ static inline void preempt_notifier_init
 
 #endif
 
+#if defined(CONFIG_SMP) && defined(CONFIG_PREEMPT_RT)
+
+/*
+ * Migrate-Disable and why it is (strongly) undesired.
+ *
+ * The premise of the Real-Time schedulers we have on Linux
+ * (SCHED_FIFO/SCHED_DEADLINE) is that M CPUs can/will run M tasks
+ * concurrently, provided there are sufficient runnable tasks, also known as
+ * work-conserving. For instance SCHED_DEADLINE tries to schedule the M
+ * earliest deadline threads, and SCHED_FIFO the M highest priority threads.
+ *
+ * The correctness of various scheduling models depends on this, but is it
+ * broken by migrate_disable() that doesn't imply preempt_disable(). Where
+ * preempt_disable() implies an immediate priority ceiling, preemptible
+ * migrate_disable() allows nesting.
+ *
+ * The worst case is that all tasks preempt one another in a migrate_disable()
+ * region and stack on a single CPU. This then reduces the available bandwidth
+ * to a single CPU. And since Real-Time schedulability theory considers the
+ * Worst-Case only, all Real-Time analysis shall revert to single-CPU
+ * (instantly solving the SMP analysis problem).
+ *
+ *
+ * The reason we have it anyway.
+ *
+ * PREEMPT_RT breaks a number of assumptions traditionally held. By forcing a
+ * number of primitives into becoming preemptible, they would also allow
+ * migration. This turns out to break a bunch of per-cpu usage. To this end,
+ * all these primitives employ migirate_disable() to restore this implicit
+ * assumption.
+ *
+ * This is a 'temporary' work-around at best. The correct solution is getting
+ * rid of the above assumptions and reworking the code to employ explicit
+ * per-cpu locking or short preempt-disable regions.
+ *
+ * The end goal must be to get rid of migrate_disable(), alternatively we need
+ * a schedulability theory that does not depend on abritrary migration.
+ *
+ *
+ * Notes on the implementation.
+ *
+ * The implementation is particularly tricky since existing code patterns
+ * dictate neither migrate_disable() nor migrate_enable() is allowed to block.
+ * This means that it cannot use cpus_read_lock() to serialize against hotplug,
+ * nor can it easily migrate itself into a pending affinity mask change on
+ * migrate_enable().
+ *
+ *
+ * Note: even non-work-conserving schedulers like semi-partitioned depends on
+ *       migration, so migrate_disable() is not only a problem for
+ *       work-conserving schedulers.
+ *
+ */
+extern void migrate_disable(void);
+extern void migrate_enable(void);
+
+#else /* !(CONFIG_SMP && CONFIG_PREEMPT_RT) */
+
 /**
  * migrate_disable - Prevent migration of the current task
  *
@@ -352,4 +410,6 @@ static __always_inline void migrate_enab
 	preempt_enable();
 }
 
+#endif /* CONFIG_SMP && CONFIG_PREEMPT_RT */
+
 #endif /* __LINUX_PREEMPT_H */
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -713,6 +713,9 @@ struct task_struct {
 	int				nr_cpus_allowed;
 	const cpumask_t			*cpus_ptr;
 	cpumask_t			cpus_mask;
+#if defined(CONFIG_SMP) && defined(CONFIG_PREEMPT_RT)
+	int				migration_disabled;
+#endif
 
 #ifdef CONFIG_PREEMPT_RCU
 	int				rcu_read_lock_nesting;
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1700,6 +1700,61 @@ void check_preempt_curr(struct rq *rq, s
 
 #ifdef CONFIG_SMP
 
+#ifdef CONFIG_PREEMPT_RT
+
+static void
+__do_set_cpus_allowed(struct task_struct *p, const struct cpumask *new_mask, u32 flags);
+
+static int __set_cpus_allowed_ptr(struct task_struct *p,
+				  const struct cpumask *new_mask,
+				  u32 flags);
+
+static void migrate_disable_switch(struct rq *rq, struct task_struct *p)
+{
+	if (likely(!p->migration_disabled))
+		return;
+
+	if (p->cpus_ptr != &p->cpus_mask)
+		return;
+
+	/*
+	 * Violates locking rules! see comment in __do_set_cpus_allowed().
+	 */
+	__do_set_cpus_allowed(p, cpumask_of(rq->cpu), SCA_MIGRATE_DISABLE);
+}
+
+void migrate_disable(void)
+{
+	if (current->migration_disabled++)
+		return;
+
+	barrier();
+}
+EXPORT_SYMBOL_GPL(migrate_disable);
+
+void migrate_enable(void)
+{
+	struct task_struct *p = current;
+
+	if (--p->migration_disabled)
+		return;
+
+	barrier();
+
+	if (p->cpus_ptr == &p->cpus_mask)
+		return;
+
+	__set_cpus_allowed_ptr(p, &p->cpus_mask, SCA_MIGRATE_ENABLE);
+}
+EXPORT_SYMBOL_GPL(migrate_enable);
+
+static inline bool is_migration_disabled(struct task_struct *p)
+{
+	return p->migration_disabled;
+}
+
+#endif
+
 /*
  * Per-CPU kthreads are allowed to run on !active && online CPUs, see
  * __set_cpus_allowed_ptr() and select_fallback_rq().
@@ -1709,7 +1764,7 @@ static inline bool is_cpu_allowed(struct
 	if (!cpumask_test_cpu(cpu, p->cpus_ptr))
 		return false;
 
-	if (is_per_cpu_kthread(p))
+	if (is_per_cpu_kthread(p) || is_migration_disabled(p))
 		return cpu_online(cpu);
 
 	return cpu_active(cpu);
@@ -1830,6 +1885,11 @@ static int migration_cpu_stop(void *data
  */
 void set_cpus_allowed_common(struct task_struct *p, const struct cpumask *new_mask, u32 flags)
 {
+	if (flags & (SCA_MIGRATE_ENABLE | SCA_MIGRATE_DISABLE)) {
+		p->cpus_ptr = new_mask;
+		return;
+	}
+
 	cpumask_copy(&p->cpus_mask, new_mask);
 	p->nr_cpus_allowed = cpumask_weight(new_mask);
 }
@@ -1840,7 +1900,22 @@ __do_set_cpus_allowed(struct task_struct
 	struct rq *rq = task_rq(p);
 	bool queued, running;
 
-	lockdep_assert_held(&p->pi_lock);
+	/*
+	 * This here violates the locking rules for affinity, since we're only
+	 * supposed to change these variables while holding both rq->lock and
+	 * p->pi_lock.
+	 *
+	 * HOWEVER, it magically works, because ttwu() is the only code that
+	 * accesses these variables under p->pi_lock and only does so after
+	 * smp_cond_load_acquire(&p->on_cpu, !VAL), and we're in __schedule()
+	 * before finish_task().
+	 *
+	 * XXX do further audits, this smells like something putrid.
+	 */
+	if (flags & SCA_MIGRATE_DISABLE)
+		SCHED_WARN_ON(!p->on_cpu);
+	else
+		lockdep_assert_held(&p->pi_lock);
 
 	queued = task_on_rq_queued(p);
 	running = task_current(rq, p);
@@ -1891,9 +1966,14 @@ static int __set_cpus_allowed_ptr(struct
 	rq = task_rq_lock(p, &rf);
 	update_rq_clock(rq);
 
-	if (p->flags & PF_KTHREAD) {
+	if (p->flags & PF_KTHREAD || is_migration_disabled(p)) {
 		/*
-		 * Kernel threads are allowed on online && !active CPUs
+		 * Kernel threads are allowed on online && !active CPUs.
+		 *
+		 * Specifically, migration_disabled() tasks must not fail the
+		 * cpumask_any_and_distribute() pick below, esp. so on
+		 * SCA_MIGRATE_ENABLE, otherwise we'll not call
+		 * set_cpus_allowed_common() and actually reset p->cpus_ptr.
 		 */
 		cpu_valid_mask = cpu_online_mask;
 	}
@@ -1907,7 +1987,7 @@ static int __set_cpus_allowed_ptr(struct
 		goto out;
 	}
 
-	if (cpumask_equal(&p->cpus_mask, new_mask))
+	if (!(flags & SCA_MIGRATE_ENABLE) && cpumask_equal(&p->cpus_mask, new_mask))
 		goto out;
 
 	/*
@@ -1999,6 +2079,8 @@ void set_task_cpu(struct task_struct *p,
 	 * Clearly, migrating tasks to offline CPUs is a fairly daft thing.
 	 */
 	WARN_ON_ONCE(!cpu_online(new_cpu));
+
+	WARN_ON_ONCE(is_migration_disabled(p));
 #endif
 
 	trace_sched_migrate_task(p, new_cpu);
@@ -2329,6 +2411,12 @@ static int select_fallback_rq(int cpu, s
 			}
 			fallthrough;
 		case possible:
+			/*
+			 * XXX When called from select_task_rq() we only
+			 * hold p->pi_lock and again violate locking order.
+			 *
+			 * More yuck to audit.
+			 */
 			do_set_cpus_allowed(p, cpu_possible_mask);
 			state = fail;
 			break;
@@ -2363,7 +2451,7 @@ int select_task_rq(struct task_struct *p
 {
 	lockdep_assert_held(&p->pi_lock);
 
-	if (p->nr_cpus_allowed > 1)
+	if (p->nr_cpus_allowed > 1 && !is_migration_disabled(p))
 		cpu = p->sched_class->select_task_rq(p, cpu, sd_flags, wake_flags);
 	else
 		cpu = cpumask_any(p->cpus_ptr);
@@ -2425,6 +2513,17 @@ static inline int __set_cpus_allowed_ptr
 
 #endif /* CONFIG_SMP */
 
+#if !defined(CONFIG_SMP) || !defined(CONFIG_PREEMPT_RT)
+
+static inline void migrate_disable_switch(struct rq *rq, struct task_struct *p) { }
+
+static inline bool is_migration_disabled(struct task_struct *p)
+{
+	return false;
+}
+
+#endif
+
 static void
 ttwu_stat(struct task_struct *p, int cpu, int wake_flags)
 {
@@ -4589,6 +4688,7 @@ static void __sched notrace __schedule(b
 		 */
 		++*switch_count;
 
+		migrate_disable_switch(rq, prev);
 		psi_sched_switch(prev, next, !task_on_rq_queued(prev));
 
 		trace_sched_switch(preempt, prev, next);
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1895,14 +1895,16 @@ static inline bool sched_fair_runnable(s
 extern struct task_struct *pick_next_task_fair(struct rq *rq, struct task_struct *prev, struct rq_flags *rf);
 extern struct task_struct *pick_next_task_idle(struct rq *rq);
 
+#define SCA_CHECK		0x01
+#define SCA_MIGRATE_DISABLE	0x02
+#define SCA_MIGRATE_ENABLE	0x04
+
 #ifdef CONFIG_SMP
 
 extern void update_group_capacity(struct sched_domain *sd, int cpu);
 
 extern void trigger_load_balance(struct rq *rq);
 
-#define SCA_CHECK		0x01
-
 extern void set_cpus_allowed_common(struct task_struct *p, const struct cpumask *new_mask, u32 flags);
 
 #endif
--- a/lib/smp_processor_id.c
+++ b/lib/smp_processor_id.c
@@ -26,6 +26,11 @@ unsigned int check_preemption_disabled(c
 	if (current->nr_cpus_allowed == 1)
 		goto out;
 
+#if defined(CONFIG_SMP) && defined(CONFIG_PREEMPT_RT)
+	if (current->migration_disabled)
+		goto out;
+#endif
+
 	/*
 	 * It is valid to assume CPU-locality during early bootup:
 	 */


