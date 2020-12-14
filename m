Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 706A92D9D42
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 18:10:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502157AbgLNRIf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 12:08:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2502108AbgLNRIP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 12:08:15 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE1CCC061793
        for <linux-kernel@vger.kernel.org>; Mon, 14 Dec 2020 09:07:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=BO2JNTcLJJKsWGSs92KVZEoG426aAmF3ad3fveSpfjs=; b=Z32MW2GXUe+/GnBQ3Pi814itgP
        tdVNBAcJb/FK8kcKox43MEeZs0Vw06YU7sYSJS031aZDHmt/Kv8bm/IPJLHT2DKl+BKBdxazYm3HY
        FoMNDqFLUW3Rb9LoR0Jqdd7E1HBK2QC6GDPY+R5t2HN2IxQlEq3FZ7zrpYJy5y9gl3Vh4z0K+3I6n
        qAPa1jZIUqWb0fBPR2Xl9n8cB6ZO2ScTptdvr7MbUcjPO5rgVmNPYXglUJv2izFmgDTrr+Mvsbvvn
        SdaZwJ7wnC7QaTbKfezNV970OPB9spZhAeLnh70HtmJE9PLtQdeqT4/bPsF+F+t6pPncPxUAYfVqq
        zUmmHJkQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1korJT-0002Qp-7R; Mon, 14 Dec 2020 17:07:07 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3CBFA305DD1;
        Mon, 14 Dec 2020 18:07:05 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 781052364D0D8; Mon, 14 Dec 2020 18:07:04 +0100 (CET)
Message-ID: <20201214170018.126628741@infradead.org>
User-Agent: quilt/0.66
Date:   Mon, 14 Dec 2020 17:48:27 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     mgorman@techsingularity.net, vincent.guittot@linaro.org
Cc:     peterz@infradead.org, linux-kernel@vger.kernel.org,
        aubrey.li@linux.intel.com, mingo@redhat.com, juri.lelli@redhat.com,
        valentin.schneider@arm.com, qais.yousef@arm.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        tim.c.chen@linux.intel.com, benbjiang@gmail.com
Subject: [RFC][PATCH 5/5] sched/fair: SIS_PROP the idle core scan
References: <20201214164822.402812729@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Further unify the new select_idle_cpu() loop and remove the 'smt'
selection code and unconditionally use SIS_PROP, even for idle core
searches.

This effectively brings back the effects of select_idle_smt() which we
removed a few patches ago due to always iterating the target core.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/linux/sched/topology.h |    1 
 kernel/sched/fair.c            |   90 +++--------------------------------------
 kernel/sched/idle.c            |    1 
 kernel/sched/sched.h           |   13 -----
 4 files changed, 7 insertions(+), 98 deletions(-)

--- a/include/linux/sched/topology.h
+++ b/include/linux/sched/topology.h
@@ -73,7 +73,6 @@ struct sched_group;
 struct sched_domain_shared {
 	atomic_t	ref;
 	atomic_t	nr_busy_cpus;
-	int		has_idle_cores;
 };
 
 struct sched_domain {
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1581,11 +1581,9 @@ numa_type numa_classify(unsigned int imb
 
 #ifdef CONFIG_SCHED_SMT
 /* Forward declarations of select_idle_sibling helpers */
-static inline bool test_idle_cores(int cpu, bool def);
 static inline int numa_idle_core(int idle_core, int cpu)
 {
-	if (!static_branch_likely(&sched_smt_present) ||
-	    idle_core >= 0 || !test_idle_cores(cpu, false))
+	if (!static_branch_likely(&sched_smt_present) || idle_core >= 0)
 		return idle_core;
 
 	/*
@@ -6020,60 +6018,6 @@ EXPORT_SYMBOL_GPL(sched_smt_present);
 
 int sched_smt_weight = 1;
 
-static inline void set_idle_cores(int cpu, int val)
-{
-	struct sched_domain_shared *sds;
-
-	sds = rcu_dereference(per_cpu(sd_llc_shared, cpu));
-	if (sds)
-		WRITE_ONCE(sds->has_idle_cores, val);
-}
-
-static inline bool test_idle_cores(int cpu, bool def)
-{
-	struct sched_domain_shared *sds;
-
-	sds = rcu_dereference(per_cpu(sd_llc_shared, cpu));
-	if (sds)
-		return READ_ONCE(sds->has_idle_cores);
-
-	return def;
-}
-
-/*
- * Scans the local SMT mask to see if the entire core is idle, and records this
- * information in sd_llc_shared->has_idle_cores.
- *
- * Since SMT siblings share all cache levels, inspecting this limited remote
- * state should be fairly cheap.
- */
-void __update_idle_core(struct rq *rq)
-{
-	int core = cpu_of(rq);
-	int cpu;
-
-	rcu_read_lock();
-	if (test_idle_cores(core, true))
-		goto unlock;
-
-	for_each_cpu(cpu, cpu_smt_mask(core)) {
-		if (cpu == core)
-			continue;
-
-		if (!available_idle_cpu(cpu))
-			goto unlock;
-	}
-
-	set_idle_cores(core, 1);
-unlock:
-	rcu_read_unlock();
-}
-
-/*
- * Scan the entire LLC domain for idle cores; this dynamically switches off if
- * there are no idle cores left in the system; tracked through
- * sd_llc->shared->has_idle_cores and enabled through update_idle_core() above.
- */
 static int select_idle_core(struct task_struct *p, int core, struct cpumask *cpus, int *idle_cpu)
 {
 	bool idle = true;
@@ -6109,15 +6053,6 @@ static int select_idle_core(struct task_
 
 #define sched_smt_weight	1
 
-static inline void set_idle_cores(int cpu, int val)
-{
-}
-
-static inline bool test_idle_cores(int cpu, bool def)
-{
-	return def;
-}
-
 static inline int select_idle_core(struct task_struct *p, int core, struct cpumask *cpus, int *idle_cpu)
 {
 	return __select_idle_cpu(p, core, cpus, idle_cpu);
@@ -6136,7 +6071,6 @@ static int select_idle_cpu(struct task_s
 {
 	struct cpumask *cpus = this_cpu_cpumask_var_ptr(select_idle_mask);
 	int i, cpu, idle_cpu = -1, loops = 1, nr = INT_MAX;
-	bool smt = test_idle_cores(target, false);
 	int this = smp_processor_id();
 	struct sched_domain *this_sd;
 	u64 time;
@@ -6147,7 +6081,7 @@ static int select_idle_cpu(struct task_s
 
 	cpumask_and(cpus, sched_domain_span(sd), p->cpus_ptr);
 
-	if (sched_feat(SIS_PROP) && !smt) {
+	if (sched_feat(SIS_PROP)) {
 		u64 avg_cost, avg_idle, span_avg;
 
 		/*
@@ -6169,17 +6103,10 @@ static int select_idle_cpu(struct task_s
 	}
 
 	for_each_cpu_wrap(cpu, cpus, target) {
-		if (smt) {
-			i = select_idle_core(p, cpu, cpus, &idle_cpu);
-			if ((unsigned)i < nr_cpumask_bits)
-				return i;
-
-		} else {
-			i = __select_idle_cpu(p, cpu, cpus, &idle_cpu);
-			if ((unsigned)i < nr_cpumask_bits) {
-				idle_cpu = i;
-				break;
-			}
+		i = select_idle_core(p, cpu, cpus, &idle_cpu);
+		if ((unsigned)i < nr_cpumask_bits) {
+			idle_cpu = i;
+			break;
 		}
 
 		if (loops >= nr)
@@ -6188,10 +6115,7 @@ static int select_idle_cpu(struct task_s
 		loops++;
 	}
 
-	if (smt)
-		set_idle_cores(this, false);
-
-	if (sched_feat(SIS_PROP) && !smt) {
+	if (sched_feat(SIS_PROP)) {
 		time = cpu_clock(this) - time;
 		time = div_u64(time, loops);
 		update_avg(&this_sd->avg_scan_cost, time);
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -428,7 +428,6 @@ static void put_prev_task_idle(struct rq
 
 static void set_next_task_idle(struct rq *rq, struct task_struct *next, bool first)
 {
-	update_idle_core(rq);
 	schedstat_inc(rq->sched_goidle);
 }
 
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1099,19 +1099,6 @@ static inline bool is_migration_disabled
 #endif
 }
 
-#ifdef CONFIG_SCHED_SMT
-extern void __update_idle_core(struct rq *rq);
-
-static inline void update_idle_core(struct rq *rq)
-{
-	if (static_branch_unlikely(&sched_smt_present))
-		__update_idle_core(rq);
-}
-
-#else
-static inline void update_idle_core(struct rq *rq) { }
-#endif
-
 DECLARE_PER_CPU_SHARED_ALIGNED(struct rq, runqueues);
 
 #define cpu_rq(cpu)		(&per_cpu(runqueues, (cpu)))


