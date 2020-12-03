Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 108862CD8E3
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 15:21:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389160AbgLCOVG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 09:21:06 -0500
Received: from outbound-smtp45.blacknight.com ([46.22.136.57]:38533 "EHLO
        outbound-smtp45.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728814AbgLCOVF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 09:21:05 -0500
Received: from mail.blacknight.com (pemlinmail05.blacknight.ie [81.17.254.26])
        by outbound-smtp45.blacknight.com (Postfix) with ESMTPS id 6C8E7FA8D8
        for <linux-kernel@vger.kernel.org>; Thu,  3 Dec 2020 14:20:14 +0000 (GMT)
Received: (qmail 27425 invoked from network); 3 Dec 2020 14:20:14 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.22.4])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 3 Dec 2020 14:20:13 -0000
Date:   Thu, 3 Dec 2020 14:20:11 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Aubrey Li <aubrey.li@linux.intel.com>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Ziljstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Linux-ARM <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 10/10] sched/fair: Avoid revisiting CPUs multiple times
 during select_idle_sibling
Message-ID: <20201203142011.GW3371@techsingularity.net>
References: <20201203141124.7391-1-mgorman@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20201203141124.7391-1-mgorman@techsingularity.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Note: While this is done in the context of select_idle_core(), I would not
	expect it to be done like this. The intent is to illustrate how
	idle_cpu_mask could be filtered before select_idle_cpus() scans
	the rest of a domain or a wider scan was done across a cluster.

select_idle_core() potentially searches a number of CPUs for idle candidates
before select_idle_cpu() clears the mask and revisits the same CPUs. This
patch moves the initialisation of select_idle_mask to the top-level and
reuses the same mask across both select_idle_core and select_idle_cpu.
select_idle_smt() is left alone as the cost of checking one SMT sibling
is marginal relative to calling __clear_cpumask_cpu() for evey CPU
visited by select_idle_core().

Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
---
 kernel/sched/fair.c | 29 ++++++++++++++++-------------
 1 file changed, 16 insertions(+), 13 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index cd95daf9f53e..af2e108c20c0 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6096,10 +6096,9 @@ void __update_idle_core(struct rq *rq)
  * sd_llc->shared->has_idle_cores and enabled through update_idle_core() above.
  */
 static int select_idle_core(struct task_struct *p, struct sched_domain *sd,
-							int target, int nr)
+				int target, int nr, struct cpumask *cpus)
 {
 	int idle_candidate = -1;
-	struct cpumask *cpus = this_cpu_cpumask_var_ptr(select_idle_mask);
 	int core, cpu;
 
 	if (!static_branch_likely(&sched_smt_present))
@@ -6108,9 +6107,6 @@ static int select_idle_core(struct task_struct *p, struct sched_domain *sd,
 	if (!test_idle_cores(target, false))
 		return -1;
 
-	cpumask_and(cpus, sched_domain_span(sd), p->cpus_ptr);
-	__cpumask_clear_cpu(target, cpus);
-
 	for_each_cpu_wrap(core, cpus, target) {
 		bool idle = true;
 
@@ -6175,7 +6171,7 @@ static int select_idle_smt(struct task_struct *p, struct sched_domain *sd, int t
 #else /* CONFIG_SCHED_SMT */
 
 static inline int select_idle_core(struct task_struct *p, struct sched_domain *sd,
-							int target, int nr)
+					int target, int nr, struct cpumask *cpus)
 {
 	return -1;
 }
@@ -6193,14 +6189,10 @@ static inline int select_idle_smt(struct task_struct *p, struct sched_domain *sd
  * average idle time for this rq (as found in rq->avg_idle).
  */
 static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd,
-							int target, int nr)
+				int target, int nr, struct cpumask *cpus)
 {
-	struct cpumask *cpus = this_cpu_cpumask_var_ptr(select_idle_mask);
 	int cpu;
 
-	cpumask_and(cpus, sched_domain_span(sd), p->cpus_ptr);
-	__cpumask_clear_cpu(target, cpus);
-
 	for_each_cpu_wrap(cpu, cpus, target) {
 		schedstat_inc(this_rq()->sis_scanned);
 		if (!--nr)
@@ -6260,6 +6252,7 @@ static inline bool asym_fits_capacity(int task_util, int cpu)
 static int select_idle_sibling(struct task_struct *p, int prev, int target)
 {
 	struct sched_domain *sd, *this_sd;
+	struct cpumask *cpus_visited;
 	unsigned long task_util;
 	int i, recent_used_cpu, depth;
 	u64 time;
@@ -6358,13 +6351,23 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
 
 	depth = sis_search_depth(sd, this_sd);
 
+	/*
+	 * Init the select_idle_mask. select_idle_core() will mask
+	 * out the CPUs that have already been limited to limit the
+	 * search in select_idle_cpu(). Further clearing is not
+	 * done as select_idle_smt checks only one CPU.
+	 */
+	cpus_visited = this_cpu_cpumask_var_ptr(select_idle_mask);
+	cpumask_and(cpus_visited, sched_domain_span(sd), p->cpus_ptr);
+	__cpumask_clear_cpu(target, cpus_visited);
+
 	schedstat_inc(this_rq()->sis_domain_search);
-	i = select_idle_core(p, sd, target, depth);
+	i = select_idle_core(p, sd, target, depth, cpus_visited);
 	if ((unsigned)i < nr_cpumask_bits)
 		return i;
 
 	time = cpu_clock(smp_processor_id());
-	i = select_idle_cpu(p, sd, target, depth);
+	i = select_idle_cpu(p, sd, target, depth, cpus_visited);
 	if ((unsigned)i < nr_cpumask_bits)
 		goto acct_cost;
 
-- 
2.26.2

