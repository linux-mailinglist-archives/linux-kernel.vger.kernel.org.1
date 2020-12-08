Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 261262D205B
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 02:52:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727554AbgLHBwH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 20:52:07 -0500
Received: from mga01.intel.com ([192.55.52.88]:32407 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725877AbgLHBwG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 20:52:06 -0500
IronPort-SDR: fVtZi235F3dxxC+s8xx99nE6AyLIoF+D7f5ob5NL1VTfkP8/8esq1We7lpGEy/S2IpQC5PYdrI
 bEmjsldXSiwg==
X-IronPort-AV: E=McAfee;i="6000,8403,9828"; a="192092152"
X-IronPort-AV: E=Sophos;i="5.78,401,1599548400"; 
   d="scan'208";a="192092152"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2020 17:50:20 -0800
IronPort-SDR: WBpBR9Sdd31Ag7bLOrwZClcabZ70OXbKAayR+rvJhSyQZBj/1cOikfWBqpZGJdnhNtQZ0o/7d0
 dt+w7FkFQ2dw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,401,1599548400"; 
   d="scan'208";a="437193526"
Received: from aubrey-work.sh.intel.com ([10.239.53.113])
  by fmsmga001.fm.intel.com with ESMTP; 07 Dec 2020 17:50:17 -0800
From:   Aubrey Li <aubrey.li@linux.intel.com>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, mgorman@techsingularity.net,
        valentin.schneider@arm.com, qais.yousef@arm.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com
Cc:     tim.c.chen@linux.intel.com, linux-kernel@vger.kernel.org,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Mel Gorman <mgorman@suse.de>, Jiang Biao <benbjiang@gmail.com>
Subject: [RFC PATCH v6] sched/fair: select idle cpu from idle cpumask for task wakeup
Date:   Tue,  8 Dec 2020 09:49:57 +0800
Message-Id: <20201208014957.170845-1-aubrey.li@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add idle cpumask to track idle cpus in sched domain. Every time
a CPU enters idle, the CPU is set in idle cpumask to be a wakeup
target. And if the CPU is not in idle, the CPU is cleared in idle
cpumask during scheduler tick to ratelimit idle cpumask update.

When a task wakes up to select an idle cpu, scanning idle cpumask
has lower cost than scanning all the cpus in last level cache domain,
especially when the system is heavily loaded.

Benchmarks including hackbench, schbench, uperf, sysbench mysql
and kbuild were tested on a x86 4 socket system with 24 cores per
socket and 2 hyperthreads per core, total 192 CPUs, no significant
data change found.

v5->v6:
- decouple idle cpumask update from stop_tick signal, set idle CPU
  in idle cpumask every time the CPU enters idle

v4->v5:
- add update_idle_cpumask for s2idle case
- keep the same ordering of tick_nohz_idle_stop_tick() and update_
  idle_cpumask() everywhere

v3->v4:
- change setting idle cpumask from every idle entry to tickless idle
  if cpu driver is available.
- move clearing idle cpumask to scheduler_tick to decouple nohz mode.

v2->v3:
- change setting idle cpumask to every idle entry, otherwise schbench
  has a regression of 99th percentile latency.
- change clearing idle cpumask to nohz_balancer_kick(), so updating
  idle cpumask is ratelimited in the idle exiting path.
- set SCHED_IDLE cpu in idle cpumask to allow it as a wakeup target.

v1->v2:
- idle cpumask is updated in the nohz routines, by initializing idle
  cpumask with sched_domain_span(sd), nohz=off case remains the original
  behavior.

Cc: Mel Gorman <mgorman@suse.de>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Qais Yousef <qais.yousef@arm.com>
Cc: Valentin Schneider <valentin.schneider@arm.com>
Cc: Jiang Biao <benbjiang@gmail.com>
Cc: Tim Chen <tim.c.chen@linux.intel.com>
Signed-off-by: Aubrey Li <aubrey.li@linux.intel.com>
---
 include/linux/sched/topology.h | 13 +++++++++
 kernel/sched/core.c            |  2 ++
 kernel/sched/fair.c            | 52 +++++++++++++++++++++++++++++++++-
 kernel/sched/idle.c            |  5 ++++
 kernel/sched/sched.h           |  2 ++
 kernel/sched/topology.c        |  3 +-
 6 files changed, 75 insertions(+), 2 deletions(-)

diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
index 820511289857..b47b85163607 100644
--- a/include/linux/sched/topology.h
+++ b/include/linux/sched/topology.h
@@ -65,8 +65,21 @@ struct sched_domain_shared {
 	atomic_t	ref;
 	atomic_t	nr_busy_cpus;
 	int		has_idle_cores;
+	/*
+	 * Span of all idle CPUs in this domain.
+	 *
+	 * NOTE: this field is variable length. (Allocated dynamically
+	 * by attaching extra space to the end of the structure,
+	 * depending on how many CPUs the kernel has booted up with)
+	 */
+	unsigned long	idle_cpus_span[];
 };
 
+static inline struct cpumask *sds_idle_cpus(struct sched_domain_shared *sds)
+{
+	return to_cpumask(sds->idle_cpus_span);
+}
+
 struct sched_domain {
 	/* These fields must be setup */
 	struct sched_domain __rcu *parent;	/* top domain must be null terminated */
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index c4da7e17b906..b8af602dea79 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3999,6 +3999,7 @@ void scheduler_tick(void)
 	rq_lock(rq, &rf);
 
 	update_rq_clock(rq);
+	update_idle_cpumask(rq, false);
 	thermal_pressure = arch_scale_thermal_pressure(cpu_of(rq));
 	update_thermal_load_avg(rq_clock_thermal(rq), rq, thermal_pressure);
 	curr->sched_class->task_tick(rq, curr, 0);
@@ -7197,6 +7198,7 @@ void __init sched_init(void)
 		rq_csd_init(rq, &rq->nohz_csd, nohz_csd_func);
 #endif
 #endif /* CONFIG_SMP */
+		rq->last_idle_state = 1;
 		hrtick_rq_init(rq);
 		atomic_set(&rq->nr_iowait, 0);
 	}
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index c0c4d9ad7da8..1b5c7ed08544 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6146,7 +6146,12 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int t
 
 	time = cpu_clock(this);
 
-	cpumask_and(cpus, sched_domain_span(sd), p->cpus_ptr);
+	/*
+	 * sched_domain_shared is set only at shared cache level,
+	 * this works only because select_idle_cpu is called with
+	 * sd_llc.
+	 */
+	cpumask_and(cpus, sds_idle_cpus(sd->shared), p->cpus_ptr);
 
 	for_each_cpu_wrap(cpu, cpus, target) {
 		if (!--nr)
@@ -6808,6 +6813,51 @@ balance_fair(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 }
 #endif /* CONFIG_SMP */
 
+/*
+ * Update cpu idle state and record this information
+ * in sd_llc_shared->idle_cpus_span.
+ */
+void update_idle_cpumask(struct rq *rq, bool set_idle)
+{
+	struct sched_domain *sd;
+	int cpu = cpu_of(rq);
+	int idle_state;
+
+	/*
+	 * If called from scheduler tick, only update
+	 * idle cpumask if the CPU is busy, as idle
+	 * cpumask is also updated on idle entry.
+	 *
+	 */
+	if (!set_idle && idle_cpu(cpu))
+		return;
+	/*
+	 * Also set SCHED_IDLE cpu in idle cpumask to
+	 * allow SCHED_IDLE cpu as a wakeup target
+	 */
+	idle_state = set_idle || sched_idle_cpu(cpu);
+	/*
+	 * No need to update idle cpumask if the state
+	 * does not change.
+	 */
+	if (rq->last_idle_state == idle_state)
+		return;
+
+	rcu_read_lock();
+	sd = rcu_dereference(per_cpu(sd_llc, cpu));
+	if (!sd || !sd->shared)
+		goto unlock;
+
+	if (idle_state)
+		cpumask_set_cpu(cpu, sds_idle_cpus(sd->shared));
+	else
+		cpumask_clear_cpu(cpu, sds_idle_cpus(sd->shared));
+
+	rq->last_idle_state = idle_state;
+unlock:
+	rcu_read_unlock();
+}
+
 static unsigned long wakeup_gran(struct sched_entity *se)
 {
 	unsigned long gran = sysctl_sched_wakeup_granularity;
diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index f324dc36fc43..f995660edf2b 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -156,6 +156,11 @@ static void cpuidle_idle_call(void)
 		return;
 	}
 
+	/*
+	 * The CPU is about to go idle, set it in idle cpumask
+	 * to be a wake up target.
+	 */
+	update_idle_cpumask(this_rq(), true);
 	/*
 	 * The RCU framework needs to be told that we are entering an idle
 	 * section, so no more rcu read side critical sections and one more
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 8d1ca65db3b0..db460b20217a 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1004,6 +1004,7 @@ struct rq {
 	/* This is used to determine avg_idle's max value */
 	u64			max_idle_balance_cost;
 #endif /* CONFIG_SMP */
+	unsigned char		last_idle_state;
 
 #ifdef CONFIG_IRQ_TIME_ACCOUNTING
 	u64			prev_irq_time;
@@ -1088,6 +1089,7 @@ static inline void update_idle_core(struct rq *rq)
 #else
 static inline void update_idle_core(struct rq *rq) { }
 #endif
+void update_idle_cpumask(struct rq *rq, bool set_idle);
 
 DECLARE_PER_CPU_SHARED_ALIGNED(struct rq, runqueues);
 
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 1bd7e3af904f..541bd3a7de4d 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -1407,6 +1407,7 @@ sd_init(struct sched_domain_topology_level *tl,
 		sd->shared = *per_cpu_ptr(sdd->sds, sd_id);
 		atomic_inc(&sd->shared->ref);
 		atomic_set(&sd->shared->nr_busy_cpus, sd_weight);
+		cpumask_copy(sds_idle_cpus(sd->shared), sched_domain_span(sd));
 	}
 
 	sd->private = sdd;
@@ -1769,7 +1770,7 @@ static int __sdt_alloc(const struct cpumask *cpu_map)
 
 			*per_cpu_ptr(sdd->sd, j) = sd;
 
-			sds = kzalloc_node(sizeof(struct sched_domain_shared),
+			sds = kzalloc_node(sizeof(struct sched_domain_shared) + cpumask_size(),
 					GFP_KERNEL, cpu_to_node(j));
 			if (!sds)
 				return -ENOMEM;
-- 
2.25.1

