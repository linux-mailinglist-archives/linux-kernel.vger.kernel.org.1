Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D7B82D9D59
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 18:15:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502128AbgLNRId (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 12:08:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2502090AbgLNRIP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 12:08:15 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ABEDC06179C
        for <linux-kernel@vger.kernel.org>; Mon, 14 Dec 2020 09:07:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=lXSNXh0aplj28q6nK50peY0KYUCvcBeMNiEuFVrzeug=; b=KgCuzF3a5lNiQtAjIZNqIeInzA
        5/pPCQw7m9Vtn89rqMB18JHkNmksu633+ySN5ITQnlUejj8WZl6S2NUQSE6zAUVCGrPMg0TifaWhC
        5uWxNMEwy3PboqfRZwegOxmwYejS09M8Awa3jK7OAF7GNOAyj4PnIN40e4IM8NebUwkcANLk5diAy
        1q8CH9I6SUjILkQ6zV+VGDhG1IlqGM/j4RvYfTFKIGX1/boJOAASosV1aXrHqjlvcfMiXpsFT2bLe
        kOwsVaGnzZXPxzIXt87d5df/sTcLedhIjWFTOh3PTqe99buG4DfK89NeKdAz2kOzgPDSWZlb+dwcq
        pB2oHGQA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1korJS-0000iG-Uc; Mon, 14 Dec 2020 17:07:07 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 6E2313060C5;
        Mon, 14 Dec 2020 18:07:04 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 72AA02364D0D7; Mon, 14 Dec 2020 18:07:04 +0100 (CET)
Message-ID: <20201214170018.064228967@infradead.org>
User-Agent: quilt/0.66
Date:   Mon, 14 Dec 2020 17:48:26 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     mgorman@techsingularity.net, vincent.guittot@linaro.org
Cc:     peterz@infradead.org, linux-kernel@vger.kernel.org,
        aubrey.li@linux.intel.com, mingo@redhat.com, juri.lelli@redhat.com,
        valentin.schneider@arm.com, qais.yousef@arm.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        tim.c.chen@linux.intel.com, benbjiang@gmail.com
Subject: [RFC][PATCH 4/5] sched/fair: Merge select_idle_core/cpu()
References: <20201214164822.402812729@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both select_idle_core() and select_idle_cpu() do a loop over the same
cpumask. Observe that by clearing the already visited CPUs, we can
fold the iteration and iterate a core at a time.

All we need to do is remember any non-idle CPU we encountered while
scanning for an idle core. This way we'll only iterate every CPU once.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sched/fair.c |  100 +++++++++++++++++++++++++++++++---------------------
 1 file changed, 60 insertions(+), 40 deletions(-)

--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6006,6 +6006,14 @@ static inline int find_idlest_cpu(struct
 	return new_cpu;
 }
 
+static inline int __select_idle_cpu(struct task_struct *p, int core, struct cpumask *cpus, int *idle_cpu)
+{
+	if (available_idle_cpu(core) || sched_idle_cpu(core))
+		return core;
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
+		return __select_idle_cpu(p, core, cpus, idle_cpu);
 
-	cpumask_and(cpus, sched_domain_span(sd), p->cpus_ptr);
-
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
 
@@ -6107,9 +6109,18 @@ static int select_idle_core(struct task_
 
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
+	return __select_idle_cpu(p, core, cpus, idle_cpu);
 }
 
 #endif /* CONFIG_SCHED_SMT */
@@ -6124,7 +6135,8 @@ static inline int select_idle_core(struc
 static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int target)
 {
 	struct cpumask *cpus = this_cpu_cpumask_var_ptr(select_idle_mask);
-	int cpu, loops = 1, nr = INT_MAX;
+	int i, cpu, idle_cpu = -1, loops = 1, nr = INT_MAX;
+	bool smt = test_idle_cores(target, false);
 	int this = smp_processor_id();
 	struct sched_domain *this_sd;
 	u64 time;
@@ -6135,7 +6147,7 @@ static int select_idle_cpu(struct task_s
 
 	cpumask_and(cpus, sched_domain_span(sd), p->cpus_ptr);
 
-	if (sched_feat(SIS_PROP)) {
+	if (sched_feat(SIS_PROP) && !smt) {
 		u64 avg_cost, avg_idle, span_avg;
 
 		/*
@@ -6157,23 +6169,35 @@ static int select_idle_cpu(struct task_s
 	}
 
 	for_each_cpu_wrap(cpu, cpus, target) {
-		if (available_idle_cpu(cpu) || sched_idle_cpu(cpu))
-			break;
+		if (smt) {
+			i = select_idle_core(p, cpu, cpus, &idle_cpu);
+			if ((unsigned)i < nr_cpumask_bits)
+				return i;
+
+		} else {
+			i = __select_idle_cpu(p, cpu, cpus, &idle_cpu);
+			if ((unsigned)i < nr_cpumask_bits) {
+				idle_cpu = i;
+				break;
+			}
+		}
 
-		if (loops >= nr) {
-			cpu = -1;
+		if (loops >= nr)
 			break;
-		}
+
 		loops++;
 	}
 
-	if (sched_feat(SIS_PROP)) {
+	if (smt)
+		set_idle_cores(this, false);
+
+	if (sched_feat(SIS_PROP) && !smt) {
 		time = cpu_clock(this) - time;
 		time = div_u64(time, loops);
 		update_avg(&this_sd->avg_scan_cost, time);
 	}
 
-	return cpu;
+	return idle_cpu;
 }
 
 /*
@@ -6302,10 +6326,6 @@ static int select_idle_sibling(struct ta
 	if (!sd)
 		return target;
 
-	i = select_idle_core(p, sd, target);
-	if ((unsigned)i < nr_cpumask_bits)
-		return i;
-
 	i = select_idle_cpu(p, sd, target);
 	if ((unsigned)i < nr_cpumask_bits)
 		return i;


