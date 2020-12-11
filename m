Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 429C42D7D36
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 18:47:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395531AbgLKRqS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 12:46:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394384AbgLKRqN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 12:46:13 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6B22C0613CF
        for <linux-kernel@vger.kernel.org>; Fri, 11 Dec 2020 09:45:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=LWH9StXLWJtKUxZJ6fydPmz/ywT9f3FKHdYIKxcfHh4=; b=JdUX16u4+5TIoDiFuanm22XVgw
        ezM/EVlXpYiyn4Ja/VvXTyHVk0loj+4aookRF7kUlnceNHiB3/Aa4WpBtzgnZN9dduSoCJ8OzQkfs
        eEklXZa5uViMkzqs9uSojmASnntuolqEIh8LT/KzMEyJJs/TUF9FrkV74iWxetcWEZrHQziALxoty
        hcHul2ROc1ymkro97gH+qfqvD5qld17OVv41zREilGISGMREgUFkk2mf5cJjbdXAoNsoOm3eu9B7Z
        SkKErsPzTRA/4HXpSsrFj01xb3pfQnryskN5/cKTbGfMwQjgv29uItU6Wkl1ydAV2g7h0VYRevXbK
        n5WvnezA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1knmTG-0007z0-OC; Fri, 11 Dec 2020 17:44:47 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id BF42D3011E6;
        Fri, 11 Dec 2020 18:44:42 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 86D8420218DB9; Fri, 11 Dec 2020 18:44:42 +0100 (CET)
Date:   Fri, 11 Dec 2020 18:44:42 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     "Li, Aubrey" <aubrey.li@linux.intel.com>, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        valentin.schneider@arm.com, qais.yousef@arm.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        tim.c.chen@linux.intel.com, linux-kernel@vger.kernel.org,
        Mel Gorman <mgorman@suse.de>, Jiang Biao <benbjiang@gmail.com>
Subject: Re: [RFC PATCH v7] sched/fair: select idle cpu from idle cpumask for
 task wakeup
Message-ID: <20201211174442.GU3040@hirez.programming.kicks-ass.net>
References: <20201209062404.175565-1-aubrey.li@linux.intel.com>
 <20201209143510.GO3371@techsingularity.net>
 <3802e27a-56ed-9495-21b9-7c4277065155@linux.intel.com>
 <20201210113441.GS3371@techsingularity.net>
 <31308700-aa28-b1f7-398e-ee76772b6b87@linux.intel.com>
 <20201210125833.GT3371@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201210125833.GT3371@techsingularity.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 10, 2020 at 12:58:33PM +0000, Mel Gorman wrote:
> The prequisite patch to make that approach work was rejected though
> as on its own, it's not very helpful and Vincent didn't like that the
> load_balance_mask was abused to make it effective.

So last time I poked at all this, I found that using more masks was a
performance issue as well due to added cache misses.

Anyway, I finally found some time to look at all this, and while reading
over the whole SiS crud to refresh the brain came up with the below...

It's still naf, but at least it gets rid of a bunch of duplicate
scanning and LoC decreases, so it should be awesome. Ofcourse, as
always, benchmarks will totally ruin everything, we'll see, I started
some.

It goes on top of Mel's first two patches (which is about as far as I
got)...

---
 fair.c |  124 ++++++++++++++++++++++++-----------------------------------------
 1 file changed, 47 insertions(+), 77 deletions(-)

--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6021,11 +6021,13 @@ static inline void set_idle_cores(int cp
 
 static inline bool test_idle_cores(int cpu, bool def)
 {
-	struct sched_domain_shared *sds;
+	if (static_branch_likely(&sched_smt_present)) {
+		struct sched_domain_shared *sds;
 
-	sds = rcu_dereference(per_cpu(sd_llc_shared, cpu));
-	if (sds)
-		return READ_ONCE(sds->has_idle_cores);
+		sds = rcu_dereference(per_cpu(sd_llc_shared, cpu));
+		if (sds)
+			return READ_ONCE(sds->has_idle_cores);
+	}
 
 	return def;
 }
@@ -6059,77 +6061,39 @@ void __update_idle_core(struct rq *rq)
 	rcu_read_unlock();
 }
 
-/*
- * Scan the entire LLC domain for idle cores; this dynamically switches off if
- * there are no idle cores left in the system; tracked through
- * sd_llc->shared->has_idle_cores and enabled through update_idle_core() above.
- */
-static int select_idle_core(struct task_struct *p, struct sched_domain *sd, int target)
+static int __select_idle_core(int core, struct cpumask *cpus, int *idle_cpu)
 {
-	struct cpumask *cpus = this_cpu_cpumask_var_ptr(select_idle_mask);
-	int core, cpu;
-
-	if (!static_branch_likely(&sched_smt_present))
-		return -1;
-
-	if (!test_idle_cores(target, false))
-		return -1;
-
-	cpumask_and(cpus, sched_domain_span(sd), p->cpus_ptr);
-
-	for_each_cpu_wrap(core, cpus, target) {
-		bool idle = true;
+	bool idle = true;
+	int cpu;
 
-		for_each_cpu(cpu, cpu_smt_mask(core)) {
-			if (!available_idle_cpu(cpu)) {
-				idle = false;
-				break;
-			}
+	for_each_cpu(cpu, cpu_smt_mask(core)) {
+		if (!available_idle_cpu(cpu)) {
+			idle = false;
+			continue;
 		}
-
-		if (idle)
-			return core;
-
-		cpumask_andnot(cpus, cpus, cpu_smt_mask(core));
+		if (idle_cpu)
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
 
-/*
- * Scan the local SMT mask for idle CPUs.
- */
-static int select_idle_smt(struct task_struct *p, struct sched_domain *sd, int target)
-{
-	int cpu;
-
-	if (!static_branch_likely(&sched_smt_present))
-		return -1;
-
-	for_each_cpu(cpu, cpu_smt_mask(target)) {
-		if (!cpumask_test_cpu(cpu, p->cpus_ptr) ||
-		    !cpumask_test_cpu(cpu, sched_domain_span(sd)))
-			continue;
-		if (available_idle_cpu(cpu) || sched_idle_cpu(cpu))
-			return cpu;
-	}
+#else /* CONFIG_SCHED_SMT */
 
-	return -1;
+static inline void set_idle_cores(int cpu, int val)
+{
 }
 
-#else /* CONFIG_SCHED_SMT */
-
-static inline int select_idle_core(struct task_struct *p, struct sched_domain *sd, int target)
+static inline bool test_idle_cores(int cpu, bool def)
 {
-	return -1;
+	return def;
 }
 
-static inline int select_idle_smt(struct task_struct *p, struct sched_domain *sd, int target)
+static inline int __select_idle_core(int core, struct cpumask *cpus, int *idle_cpu)
 {
 	return -1;
 }
@@ -6144,10 +6108,11 @@ static inline int select_idle_smt(struct
 static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int target)
 {
 	struct cpumask *cpus = this_cpu_cpumask_var_ptr(select_idle_mask);
+	int this = smp_processor_id();
+	bool smt = test_idle_cores(this, false);
+	int i, cpu, idle_cpu = -1, nr = INT_MAX;
 	struct sched_domain *this_sd;
 	u64 time;
-	int this = smp_processor_id();
-	int cpu, nr = INT_MAX;
 
 	this_sd = rcu_dereference(*this_cpu_ptr(&sd_llc));
 	if (!this_sd)
@@ -6155,7 +6120,7 @@ static int select_idle_cpu(struct task_s
 
 	cpumask_and(cpus, sched_domain_span(sd), p->cpus_ptr);
 
-	if (sched_feat(SIS_PROP)) {
+	if (sched_feat(SIS_PROP) && !smt) {
 		u64 avg_cost, avg_idle, span_avg;
 
 		/*
@@ -6175,18 +6140,31 @@ static int select_idle_cpu(struct task_s
 	}
 
 	for_each_cpu_wrap(cpu, cpus, target) {
-		if (!--nr)
-			return -1;
-		if (available_idle_cpu(cpu) || sched_idle_cpu(cpu))
-			break;
+		if (smt) {
+			i = __select_idle_core(cpu, cpus, &idle_cpu);
+			if ((unsigned)i < nr_cpumask_bits)
+				return i;
+
+		} else {
+			if (!--nr)
+				return -1;
+
+			if (available_idle_cpu(cpu) || sched_idle_cpu(cpu)) {
+				idle_cpu = cpu;
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
@@ -6315,18 +6293,10 @@ static int select_idle_sibling(struct ta
 	if (!sd)
 		return target;
 
-	i = select_idle_core(p, sd, target);
-	if ((unsigned)i < nr_cpumask_bits)
-		return i;
-
 	i = select_idle_cpu(p, sd, target);
 	if ((unsigned)i < nr_cpumask_bits)
 		return i;
 
-	i = select_idle_smt(p, sd, target);
-	if ((unsigned)i < nr_cpumask_bits)
-		return i;
-
 	return target;
 }
 
