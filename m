Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5F2526D99C
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 12:55:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726549AbgIQKwE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 06:52:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726707AbgIQKs4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 06:48:56 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B62FC06174A
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 03:48:55 -0700 (PDT)
Message-Id: <20200917101624.813835219@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1600339730;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=fFLG9RTUmrjyme+Z5rRsAAROwAhL894YintIO/MCRwk=;
        b=gE7x6IyaH525+fqmPRV6vDJiyXH+GIAl2GTv2GnwTQKDw4iIrq95hNyh8KrZ6Jl+mOe/ac
        eWy/NsJrQHKHuRFrzF3yO2thMURJnZQ0wFWZI8Nw47XidK/bswI8ynvH8UtxyPdgaSUQM/
        F1DoBU4Yn8BXhQpj/NtdYmbIfIWDyI/8bQUMpm6bwWiHNpf2DpFbtpz9/s3EWaoTm9E4m8
        fRx0B9TvBQG/Qe0DyDKEAfw25t5CP0HxpBCTIAYH6mRo4tDixeytgE/JiRXIQjJwCiapQf
        iBbaHHIQ/y+IHZrzNR1hpUEMc81U5mpSRkhmqvk8iDJfupNcgGb8tAHzuwFz1A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1600339730;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=fFLG9RTUmrjyme+Z5rRsAAROwAhL894YintIO/MCRwk=;
        b=J4S6UgEEkOdQ/2c6UKvC73h20dp95u/xKEk5V5S9xPDVgQr8I+H03eqBSF5OKGiOtt9icn
        eAjyI4/7wq4awDDg==
Date:   Thu, 17 Sep 2020 11:42:11 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Sebastian Siewior <bigeasy@linutronix.de>,
        Qais Yousef <qais.yousef@arm.com>,
        Scott Wood <swood@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Vincent Donnefort <vincent.donnefort@arm.com>
Subject: [patch 09/10] sched/core: Add migrate_disable/enable()
References: <20200917094202.301694311@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On RT enabled kernels most of the code including spin/rw lock held sections
are preemptible, which also makes the tasks migrateable. That violates the
per CPU constraints. RT needs therefore a mechanism to control migration
independent of preemption.

Add a migrate_disable/enable() mechanism which is optimized for the hotpath
operation. migrate_disable() increments the per task disable
counter. migrate_enable() decrements it.

If a task is preempted in a migrate disabled region, the cpumask pointer of
the task is updated to point to the cpumask of the current CPU and the
task::nr_cpus_allowed is set to 1. This prevents the task from being
migrated through balancing. When the task leaves the migrate disabled
region it restores the cpumask pointer and task::nr_cpus_allowed.

In the case that the tasks affinity is attempted to be set while the task
is in a migrate disabled region, the affinity setter queues a request to
the task to migrate itself once it leaves the migrate disabled region.

Update relevant places, like balance_push(), is_cpu_allowed() and
smp_processor_id() debug code to take the migration disabled state into
account.

This code has a long history back to the 3.0-rt series and has been
optimized and rewritten several times by Peter Zijlstra, Steven Rostedt and
Scott Woods. This final distillation is heavily based on ideas and concepts
from these previous variants.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/preempt.h |   14 +++++
 include/linux/sched.h   |   33 +++++++++++++
 kernel/sched/core.c     |  117 +++++++++++++++++++++++++++++++++++++++++++++++-
 lib/smp_processor_id.c  |    7 ++
 4 files changed, 169 insertions(+), 2 deletions(-)

--- a/include/linux/preempt.h
+++ b/include/linux/preempt.h
@@ -322,6 +322,18 @@ static inline void preempt_notifier_init
 
 #endif
 
+#ifdef CONFIG_PREEMPT_RT
+
+# ifdef CONFIG_SMP
+extern void migrate_disable(void);
+extern void migrate_enable(void);
+# else /* CONFIG_SMP */
+static inline void migrate_disable(void) { }
+static inline void migrate_enable(void) { }
+#endif /* !CONFIG_SMP */
+
+#else /* CONFIG_PREEMPT_RT */
+
 /**
  * migrate_disable - Prevent migration of the current task
  *
@@ -352,4 +364,6 @@ static __always_inline void migrate_enab
 	preempt_enable();
 }
 
+#endif /* !CONFIG_PREEMPT_RT */
+
 #endif /* __LINUX_PREEMPT_H */
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1921,6 +1921,34 @@ static inline void task_migration_ctrl_i
 #endif
 }
 
+/**
+ * task_migrate_disabled - Check whether a task has migration disabled
+ * @task:	Task pointer to check
+ *
+ * On !PREEMPT_RT SMP kernels this returns always 0 as migrate disable is
+ * mapped to preempt disable and not individually controllable.
+ *
+ * On PREEMPT_RT SMP kernels migration control is distinct and this function
+ * returns task::migration_ctrl::disable_cnt. A non zero value indicates
+ * that migration is disabled.
+ *
+ * On UP kernels this returns always 0 because migration control is
+ * pointless there.
+ *
+ * This function is only to be used in scheduler and debug code and not
+ * meant for general consumption as the return value has only a meaning
+ * under specific configurations. The always return 0 stubs are also used
+ * to optimize code out if PREEMPT_RT is disabled.
+ */
+static inline int task_migrate_disabled(struct task_struct *p)
+{
+#ifdef CONFIG_PREEMPT_RT
+	return p->migration_ctrl.disable_cnt;
+#else
+	return 0;
+#endif
+}
+
 #else /* CONFIG_SMP */
 
 static inline unsigned int task_cpu(const struct task_struct *p)
@@ -1934,6 +1962,11 @@ static inline void set_task_cpu(struct t
 
 static inline void task_migration_ctrl_init(struct task_struct *p) { }
 
+static inline int task_migrate_disabled(struct task_struct *p)
+{
+	return 0;
+}
+
 #endif /* !CONFIG_SMP */
 
 /*
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1767,13 +1767,17 @@ void check_preempt_curr(struct rq *rq, s
 /*
  * Per-CPU kthreads are allowed to run on !active && online CPUs, see
  * __set_cpus_allowed_ptr() and select_fallback_rq().
+ *
+ * On PREEMPT_RT tasks can run on !active && online CPUs if they are in a
+ * migrate disabled section. Once they leave the section they are migrated
+ * away.
  */
 static inline bool is_cpu_allowed(struct task_struct *p, int cpu)
 {
 	if (!cpumask_test_cpu(cpu, p->cpus_ptr))
 		return false;
 
-	if (is_per_cpu_kthread(p))
+	if (is_per_cpu_kthread(p) || task_migrate_disabled(p))
 		return cpu_online(cpu);
 
 	return cpu_active(cpu);
@@ -3546,6 +3550,109 @@ fire_sched_out_preempt_notifiers(struct
 
 #endif /* CONFIG_PREEMPT_NOTIFIERS */
 
+/*
+ * Migrate disable control for PREEMPT_RT
+ */
+#if defined(CONFIG_SMP) && defined(CONFIG_PREEMPT_RT)
+
+static inline void update_nr_migratory(struct task_struct *p, long delta)
+{
+	if (p->nr_cpus_allowed > 1 && p->sched_class->update_migratory)
+		p->sched_class->update_migratory(p, delta);
+}
+
+/*
+ * The migrate_disable/enable() fastpath updates only the tasks migrate
+ * disable count which is sufficient as long as the task stays on the CPU.
+ *
+ * When a migrate disabled task is scheduled out it can become subject to
+ * load balancing. To prevent this, update task::cpus_ptr to point to the
+ * current CPUs cpumask and set task::nr_cpus_allowed to 1.
+ *
+ * If task::cpus_ptr does not point to task::cpus_mask then the update has
+ * been done already. This check is also used in in migrate_enable() as an
+ * indicator to restore task::cpus_ptr to point to task::cpus_mask
+ */
+static inline void sched_migration_ctrl(struct task_struct *prev, int cpu)
+{
+	if (!prev->migration_ctrl.disable_cnt ||
+	    prev->cpus_ptr != &prev->cpus_mask)
+		return;
+
+	prev->cpus_ptr = cpumask_of(cpu);
+	update_nr_migratory(prev, -1);
+	prev->nr_cpus_allowed = 1;
+}
+
+void migrate_disable(void)
+{
+	unsigned long flags;
+
+	if (!current->migration_ctrl.disable_cnt) {
+		raw_spin_lock_irqsave(&current->pi_lock, flags);
+		current->migration_ctrl.disable_cnt++;
+		raw_spin_unlock_irqrestore(&current->pi_lock, flags);
+	} else {
+		current->migration_ctrl.disable_cnt++;
+	}
+}
+EXPORT_SYMBOL(migrate_disable);
+
+void migrate_enable(void)
+{
+	struct task_migrate_data *pending;
+	struct task_struct *p = current;
+	struct rq_flags rf;
+	struct rq *rq;
+
+	if (WARN_ON_ONCE(p->migration_ctrl.disable_cnt <= 0))
+		return;
+
+	if (p->migration_ctrl.disable_cnt > 1) {
+		p->migration_ctrl.disable_cnt--;
+		return;
+	}
+
+	raw_spin_lock_irqsave(&p->pi_lock, rf.flags);
+	p->migration_ctrl.disable_cnt = 0;
+	pending = p->migration_ctrl.pending;
+	p->migration_ctrl.pending = NULL;
+
+	/*
+	 * If the task was never scheduled out while in the migrate
+	 * disabled region and there is no migration request pending,
+	 * return.
+	 */
+	if (!pending && p->cpus_ptr == &p->cpus_mask) {
+		raw_spin_unlock_irqrestore(&p->pi_lock, rf.flags);
+		return;
+	}
+
+	rq = __task_rq_lock(p, &rf);
+	/* Was it scheduled out while in a migrate disabled region? */
+	if (p->cpus_ptr != &p->cpus_mask) {
+		/* Restore the tasks CPU mask and update the weight */
+		p->cpus_ptr = &p->cpus_mask;
+		p->nr_cpus_allowed = cpumask_weight(&p->cpus_mask);
+		update_nr_migratory(p, 1);
+	}
+
+	/* If no migration request is pending, no further action required. */
+	if (!pending) {
+		task_rq_unlock(rq, p, &rf);
+		return;
+	}
+
+	/* Migrate self to the requested target */
+	pending->res = set_cpus_allowed_ptr_locked(p, pending->mask,
+						   pending->check, rq, &rf);
+	complete(pending->done);
+}
+EXPORT_SYMBOL(migrate_enable);
+#else /* CONFIG_SMP && CONFIG_PREEMPT_RT */
+static inline void sched_migration_ctrl(struct task_struct *prev, unsigned int cpu) { }
+#endif /* !(CONFIG_SMP && CONFIG_PREEMPT_RT) */
+
 static inline void prepare_task(struct task_struct *next)
 {
 #ifdef CONFIG_SMP
@@ -4579,6 +4686,9 @@ static void __sched notrace __schedule(b
 	rq_lock(rq, &rf);
 	smp_mb__after_spinlock();
 
+	/* Handle migrate disabled tasks being scheduled out */
+	sched_migration_ctrl(prev, cpu);
+
 	/* Promote REQ to ACT */
 	rq->clock_update_flags <<= 1;
 	update_rq_clock(rq);
@@ -6868,8 +6978,11 @@ static bool balance_push(struct rq *rq)
 	/*
 	 * Both the cpu-hotplug and stop task are in this class and are
 	 * required to complete the hotplug process.
+	 *
+	 * On RT kernels also regular tasks which are in a migrate disabled
+	 * section must stay on the CPU until they left the section.
 	 */
-	if (is_per_cpu_kthread(push_task)) {
+	if (is_per_cpu_kthread(push_task) || task_migrate_disabled(push_task)) {
 		/*
 		 * If this is the idle task on the outgoing CPU try to wake
 		 * up the hotplug control thread which might wait for the
--- a/lib/smp_processor_id.c
+++ b/lib/smp_processor_id.c
@@ -27,6 +27,13 @@ unsigned int check_preemption_disabled(c
 		goto out;
 
 	/*
+	 * Tasks which have migration disabled on a RT kernel can
+	 * safely use smp_processor_id() even in preemptible code.
+	 */
+	if (task_migrate_disabled(current))
+		goto out;
+
+	/*
 	 * It is valid to assume CPU-locality during early bootup:
 	 */
 	if (system_state < SYSTEM_SCHEDULING)

