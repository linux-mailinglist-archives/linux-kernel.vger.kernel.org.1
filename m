Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C893F2B74F4
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 04:49:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727160AbgKRDsg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 22:48:36 -0500
Received: from mga05.intel.com ([192.55.52.43]:32213 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725834AbgKRDsf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 22:48:35 -0500
IronPort-SDR: H7s5nymgOr+W7HHeybn7V50hOaD3vzgr2OHd4UjpoH1Jc3qyQ+bib4/ZpXgxmmQ7PT7KpMm0Ye
 +NuB42SR8b9Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9808"; a="255770627"
X-IronPort-AV: E=Sophos;i="5.77,486,1596524400"; 
   d="scan'208";a="255770627"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2020 19:48:34 -0800
IronPort-SDR: o4BSdoNgi9D1Qis7zaUen+aQE4dtWMg1zi2+T/m+/PI28h97h3IHrd8XGrlnFjP4Z61m53UsPa
 q8JZPLipyjeg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,486,1596524400"; 
   d="scan'208";a="430671986"
Received: from aubrey-work.sh.intel.com ([10.239.53.113])
  by fmsmga001.fm.intel.com with ESMTP; 17 Nov 2020 19:48:30 -0800
From:   Aubrey Li <aubrey.li@linux.intel.com>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, mgorman@techsingularity.net,
        valentin.schneider@arm.com, qais.yousef@arm.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com
Cc:     tim.c.chen@linux.intel.com, linux-kernel@vger.kernel.org,
        Aubrey Li <aubrey.li@intel.com>, Mel Gorman <mgorman@suse.de>,
        Jiang Biao <benbjiang@gmail.com>,
        Aubrey Li <aubrey.li@linux.intel.com>
Subject: [RFC PATCH v4] sched/fair: select idle cpu from idle cpumask for task wakeup
Date:   Tue, 17 Nov 2020 04:04:28 +0800
Message-Id: <20201116200428.47359-1-aubrey.li@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Aubrey Li <aubrey.li@intel.com>

Add idle cpumask to track idle cpus in sched domain. When a CPU
enters idle, if the idle driver indicates to stop tick, this CPU
is set in the idle cpumask to be a wakeup target. And if the CPU
is not in idle, the CPU is cleared in idle cpumask during scheduler
tick to ratelimit idle cpumask update.

When a task wakes up to select an idle cpu, scanning idle cpumask
has low cost than scanning all the cpus in last level cache domain,
especially when the system is heavily loaded.

Benchmarks were tested on a x86 4 socket system with 24 cores per
socket and 2 hyperthreads per core, total 192 CPUs. Hackbench and
schbench have no notable change, uperf has:

uperf throughput: netperf workload, tcp_nodelay, r/w size = 90

  threads       baseline-avg    %std    patch-avg       %std
  96            1               0.83    1.23            3.27
  144           1               1.03    1.67            2.67
  192           1               0.69    1.81            3.59
  240           1               2.84    1.51            2.67

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
 kernel/sched/idle.c            |  7 +++--
 kernel/sched/sched.h           |  2 ++
 kernel/sched/topology.c        |  3 +-
 6 files changed, 74 insertions(+), 5 deletions(-)

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
index b1e0da56abca..c86ae0495163 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3994,6 +3994,7 @@ void scheduler_tick(void)
 	rq_lock(rq, &rf);
 
 	update_rq_clock(rq);
+	update_idle_cpumask(rq, false);
 	thermal_pressure = arch_scale_thermal_pressure(cpu_of(rq));
 	update_thermal_load_avg(rq_clock_thermal(rq), rq, thermal_pressure);
 	curr->sched_class->task_tick(rq, curr, 0);
@@ -7192,6 +7193,7 @@ void __init sched_init(void)
 		rq_csd_init(rq, &rq->nohz_csd, nohz_csd_func);
 #endif
 #endif /* CONFIG_SMP */
+		rq->last_idle_state = 1;
 		hrtick_rq_init(rq);
 		atomic_set(&rq->nr_iowait, 0);
 	}
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 48a6d442b444..d67fba5e406b 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6145,7 +6145,12 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int t
 
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
@@ -6807,6 +6812,51 @@ balance_fair(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
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
index f324dc36fc43..0bd83c00c22a 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -164,7 +164,7 @@ static void cpuidle_idle_call(void)
 
 	if (cpuidle_not_available(drv, dev)) {
 		tick_nohz_idle_stop_tick();
-
+		update_idle_cpumask(this_rq(), true);
 		default_idle_call();
 		goto exit_idle;
 	}
@@ -205,9 +205,10 @@ static void cpuidle_idle_call(void)
 		 */
 		next_state = cpuidle_select(drv, dev, &stop_tick);
 
-		if (stop_tick || tick_nohz_tick_stopped())
+		if (stop_tick || tick_nohz_tick_stopped()) {
+			update_idle_cpumask(this_rq(), true);
 			tick_nohz_idle_stop_tick();
-		else
+		} else
 			tick_nohz_idle_retain_tick();
 
 		entered_state = call_cpuidle(drv, dev, next_state);
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

