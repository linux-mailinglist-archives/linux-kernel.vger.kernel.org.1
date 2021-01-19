Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA0AD2FB7FE
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 15:28:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391551AbhASLgJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 06:36:09 -0500
Received: from outbound-smtp47.blacknight.com ([46.22.136.64]:50451 "EHLO
        outbound-smtp47.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390910AbhASLXM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 06:23:12 -0500
Received: from mail.blacknight.com (pemlinmail03.blacknight.ie [81.17.254.16])
        by outbound-smtp47.blacknight.com (Postfix) with ESMTPS id 1240AFBA09
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 11:22:13 +0000 (GMT)
Received: (qmail 4748 invoked from network); 19 Jan 2021 11:22:12 -0000
Received: from unknown (HELO stampy.112glenside.lan) (mgorman@techsingularity.net@[84.203.22.4])
  by 81.17.254.9 with ESMTPA; 19 Jan 2021 11:22:12 -0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Li Aubrey <aubrey.li@linux.intel.com>,
        Qais Yousef <qais.yousef@arm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH 5/5] sched/fair: Merge select_idle_core/cpu()
Date:   Tue, 19 Jan 2021 11:22:11 +0000
Message-Id: <20210119112211.3196-6-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210119112211.3196-1-mgorman@techsingularity.net>
References: <20210119112211.3196-1-mgorman@techsingularity.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Zijlstra (Intel) <peterz@infradead.org>

Both select_idle_core() and select_idle_cpu() do a loop over the same
cpumask. Observe that by clearing the already visited CPUs, we can
fold the iteration and iterate a core at a time.

All we need to do is remember any non-idle CPU we encountered while
scanning for an idle core. This way we'll only iterate every CPU once.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
---
 kernel/sched/fair.c | 101 ++++++++++++++++++++++++++------------------
 1 file changed, 61 insertions(+), 40 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 12e08da90024..822851b39b65 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6006,6 +6006,14 @@ static inline int find_idlest_cpu(struct sched_domain *sd, struct task_struct *p
 	return new_cpu;
 }
 
+static inline int __select_idle_cpu(int cpu)
+{
+	if (available_idle_cpu(cpu) || sched_idle_cpu(cpu))
+		return cpu;
+
+	return -1;
+}
+
 #ifdef CONFIG_SCHED_SMT
 DEFINE_STATIC_KEY_FALSE(sched_smt_present);
 EXPORT_SYMBOL_GPL(sched_smt_present);
@@ -6066,40 +6074,34 @@ void __update_idle_core(struct rq *rq)
  * there are no idle cores left in the system; tracked through
  * sd_llc->shared->has_idle_cores and enabled through update_idle_core() above.
  */
-static int select_idle_core(struct task_struct *p, struct sched_domain *sd, int target)
+static int select_idle_core(struct task_struct *p, int core, struct cpumask *cpus, int *idle_cpu)
 {
-	struct cpumask *cpus = this_cpu_cpumask_var_ptr(select_idle_mask);
-	int core, cpu;
+	bool idle = true;
+	int cpu;
 
 	if (!static_branch_likely(&sched_smt_present))
-		return -1;
-
-	if (!test_idle_cores(target, false))
-		return -1;
-
-	cpumask_and(cpus, sched_domain_span(sd), p->cpus_ptr);
+		return __select_idle_cpu(core);
 
-	for_each_cpu_wrap(core, cpus, target) {
-		bool idle = true;
-
-		for_each_cpu(cpu, cpu_smt_mask(core)) {
-			if (!available_idle_cpu(cpu)) {
-				idle = false;
-				break;
+	for_each_cpu(cpu, cpu_smt_mask(core)) {
+		if (!available_idle_cpu(cpu)) {
+			idle = false;
+			if (*idle_cpu == -1) {
+				if (sched_idle_cpu(cpu) && cpumask_test_cpu(cpu, p->cpus_ptr)) {
+					*idle_cpu = cpu;
+					break;
+				}
+				continue;
 			}
+			break;
 		}
-
-		if (idle)
-			return core;
-
-		cpumask_andnot(cpus, cpus, cpu_smt_mask(core));
+		if (*idle_cpu == -1 && cpumask_test_cpu(cpu, p->cpus_ptr))
+			*idle_cpu = cpu;
 	}
 
-	/*
-	 * Failed to find an idle core; stop looking for one.
-	 */
-	set_idle_cores(target, 0);
+	if (idle)
+		return core;
 
+	cpumask_andnot(cpus, cpus, cpu_smt_mask(core));
 	return -1;
 }
 
@@ -6107,9 +6109,18 @@ static int select_idle_core(struct task_struct *p, struct sched_domain *sd, int
 
 #define sched_smt_weight	1
 
-static inline int select_idle_core(struct task_struct *p, struct sched_domain *sd, int target)
+static inline void set_idle_cores(int cpu, int val)
 {
-	return -1;
+}
+
+static inline bool test_idle_cores(int cpu, bool def)
+{
+	return def;
+}
+
+static inline int select_idle_core(struct task_struct *p, int core, struct cpumask *cpus, int *idle_cpu)
+{
+	return __select_idle_cpu(core);
 }
 
 #endif /* CONFIG_SCHED_SMT */
@@ -6124,10 +6135,11 @@ static inline int select_idle_core(struct task_struct *p, struct sched_domain *s
 static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int target)
 {
 	struct cpumask *cpus = this_cpu_cpumask_var_ptr(select_idle_mask);
+	int i, cpu, idle_cpu = -1, nr = INT_MAX;
+	bool smt = test_idle_cores(target, false);
+	int this = smp_processor_id();
 	struct sched_domain *this_sd;
 	u64 time;
-	int this = smp_processor_id();
-	int cpu, nr = INT_MAX;
 
 	this_sd = rcu_dereference(*this_cpu_ptr(&sd_llc));
 	if (!this_sd)
@@ -6135,7 +6147,7 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int t
 
 	cpumask_and(cpus, sched_domain_span(sd), p->cpus_ptr);
 
-	if (sched_feat(SIS_PROP)) {
+	if (sched_feat(SIS_PROP) && !smt) {
 		u64 avg_cost, avg_idle, span_avg;
 
 		/*
@@ -6157,18 +6169,31 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int t
 	}
 
 	for_each_cpu_wrap(cpu, cpus, target) {
-		if (!--nr)
-			return -1;
-		if (available_idle_cpu(cpu) || sched_idle_cpu(cpu))
-			break;
+		if (smt) {
+			i = select_idle_core(p, cpu, cpus, &idle_cpu);
+			if ((unsigned int)i < nr_cpumask_bits)
+				return i;
+
+		} else {
+			if (!--nr)
+				return -1;
+			i = __select_idle_cpu(cpu);
+			if ((unsigned int)i < nr_cpumask_bits) {
+				idle_cpu = i;
+				break;
+			}
+		}
 	}
 
-	if (sched_feat(SIS_PROP)) {
+	if (smt)
+		set_idle_cores(this, false);
+
+	if (sched_feat(SIS_PROP) && !smt) {
 		time = cpu_clock(this) - time;
 		update_avg(&this_sd->avg_scan_cost, time);
 	}
 
-	return cpu;
+	return idle_cpu;
 }
 
 /*
@@ -6297,10 +6322,6 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
 	if (!sd)
 		return target;
 
-	i = select_idle_core(p, sd, target);
-	if ((unsigned)i < nr_cpumask_bits)
-		return i;
-
 	i = select_idle_cpu(p, sd, target);
 	if ((unsigned)i < nr_cpumask_bits)
 		return i;
-- 
2.26.2

