Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C30B92CD8A4
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 15:13:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436484AbgLCOMT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 09:12:19 -0500
Received: from outbound-smtp45.blacknight.com ([46.22.136.57]:39365 "EHLO
        outbound-smtp45.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727189AbgLCOMR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 09:12:17 -0500
Received: from mail.blacknight.com (pemlinmail03.blacknight.ie [81.17.254.16])
        by outbound-smtp45.blacknight.com (Postfix) with ESMTPS id EFFBBFA8E4
        for <linux-kernel@vger.kernel.org>; Thu,  3 Dec 2020 14:11:24 +0000 (GMT)
Received: (qmail 22661 invoked from network); 3 Dec 2020 14:11:24 -0000
Received: from unknown (HELO stampy.112glenside.lan) (mgorman@techsingularity.net@[84.203.22.4])
  by 81.17.254.9 with ESMTPA; 3 Dec 2020 14:11:24 -0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Aubrey Li <aubrey.li@linux.intel.com>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Ziljstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Linux-ARM <linux-arm-kernel@lists.infradead.org>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH 01/10] sched/fair: Track efficiency of select_idle_sibling
Date:   Thu,  3 Dec 2020 14:11:15 +0000
Message-Id: <20201203141124.7391-2-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201203141124.7391-1-mgorman@techsingularity.net>
References: <20201203141124.7391-1-mgorman@techsingularity.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

select_idle_sibling is an important path that finds a nearby idle CPU on
wakeup. As it is examining other CPUs state, it can be expensive in terms
of cache usage. This patch tracks the search efficiency if schedstats
are enabled. In general, this is only useful for kernel developers but
schedstats are typically disabled by default so it is convenient for
development and mostly free otherwise.

It is not required that this patch be merged with the series but if we
are looking at time or search complexity, the stats generate hard data
on what the search costs actually are.

SIS Search: Number of calls to select_idle_sibling

SIS Domain Search: Number of times the domain was searched because the
	fast path failed.

SIS Scanned: Generally the number of runqueues scanned but the fast
	path counts as 1 regardless of the values for target, prev
	and recent.

SIS Domain Scanned: Number of runqueues scanned during a search of the
	LLC domain.

SIS Failures: Number of SIS calls that failed to find an idle CPU

SIS Search Efficiency: A ratio expressed as a percentage of runqueues
	scanned versus idle CPUs found. A 100% efficiency indicates that
	the target, prev or recent CPU of a task was idle at wakeup. The
	lower the efficiency, the more runqueues were scanned before an
	idle CPU was found.

SIS Domain Search Efficiency: Similar, except only for the slower SIS
	patch.

SIS Fast Success Rate: Percentage of SIS that used target, prev or
	recent CPUs.

SIS Success rate: Percentage of scans that found an idle CPU.

Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
---
 kernel/sched/debug.c |  4 ++++
 kernel/sched/fair.c  | 14 ++++++++++++++
 kernel/sched/sched.h |  6 ++++++
 kernel/sched/stats.c |  8 +++++---
 4 files changed, 29 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 2357921580f9..2386cc5e79e5 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -714,6 +714,10 @@ do {									\
 		P(sched_goidle);
 		P(ttwu_count);
 		P(ttwu_local);
+		P(sis_search);
+		P(sis_domain_search);
+		P(sis_scanned);
+		P(sis_failed);
 	}
 #undef P
 
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 98075f9ea9a8..494ba01f3414 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6081,6 +6081,7 @@ static int select_idle_core(struct task_struct *p, struct sched_domain *sd, int
 		bool idle = true;
 
 		for_each_cpu(cpu, cpu_smt_mask(core)) {
+			schedstat_inc(this_rq()->sis_scanned);
 			if (!available_idle_cpu(cpu)) {
 				idle = false;
 				break;
@@ -6112,6 +6113,7 @@ static int select_idle_smt(struct task_struct *p, struct sched_domain *sd, int t
 		return -1;
 
 	for_each_cpu(cpu, cpu_smt_mask(target)) {
+		schedstat_inc(this_rq()->sis_scanned);
 		if (!cpumask_test_cpu(cpu, p->cpus_ptr) ||
 		    !cpumask_test_cpu(cpu, sched_domain_span(sd)))
 			continue;
@@ -6177,6 +6179,7 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int t
 	cpumask_and(cpus, sched_domain_span(sd), p->cpus_ptr);
 
 	for_each_cpu_wrap(cpu, cpus, target) {
+		schedstat_inc(this_rq()->sis_scanned);
 		if (!--nr)
 			return -1;
 		if (available_idle_cpu(cpu) || sched_idle_cpu(cpu))
@@ -6240,6 +6243,15 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
 	unsigned long task_util;
 	int i, recent_used_cpu;
 
+	schedstat_inc(this_rq()->sis_search);
+
+	/*
+	 * Checking if prev, target and recent is treated as one scan. A
+	 * perfect hit on one of those is considered 100% efficiency.
+	 * Further scanning impairs efficiency.
+	 */
+	schedstat_inc(this_rq()->sis_scanned);
+
 	/*
 	 * On asymmetric system, update task utilization because we will check
 	 * that the task fits with cpu's capacity.
@@ -6315,6 +6327,7 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
 	if (!sd)
 		return target;
 
+	schedstat_inc(this_rq()->sis_domain_search);
 	i = select_idle_core(p, sd, target);
 	if ((unsigned)i < nr_cpumask_bits)
 		return i;
@@ -6327,6 +6340,7 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
 	if ((unsigned)i < nr_cpumask_bits)
 		return i;
 
+	schedstat_inc(this_rq()->sis_failed);
 	return target;
 }
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index f5acb6c5ce49..90a62dd9293d 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1049,6 +1049,12 @@ struct rq {
 	/* try_to_wake_up() stats */
 	unsigned int		ttwu_count;
 	unsigned int		ttwu_local;
+
+	/* select_idle_sibling stats */
+	unsigned int		sis_search;
+	unsigned int		sis_domain_search;
+	unsigned int		sis_scanned;
+	unsigned int		sis_failed;
 #endif
 
 #ifdef CONFIG_CPU_IDLE
diff --git a/kernel/sched/stats.c b/kernel/sched/stats.c
index 750fb3c67eed..390bfcc3842c 100644
--- a/kernel/sched/stats.c
+++ b/kernel/sched/stats.c
@@ -10,7 +10,7 @@
  * Bump this up when changing the output format or the meaning of an existing
  * format, so that tools can adapt (or abort)
  */
-#define SCHEDSTAT_VERSION 15
+#define SCHEDSTAT_VERSION 16
 
 static int show_schedstat(struct seq_file *seq, void *v)
 {
@@ -30,12 +30,14 @@ static int show_schedstat(struct seq_file *seq, void *v)
 
 		/* runqueue-specific stats */
 		seq_printf(seq,
-		    "cpu%d %u 0 %u %u %u %u %llu %llu %lu",
+		    "cpu%d %u 0 %u %u %u %u %llu %llu %lu %u %u %u %u",
 		    cpu, rq->yld_count,
 		    rq->sched_count, rq->sched_goidle,
 		    rq->ttwu_count, rq->ttwu_local,
 		    rq->rq_cpu_time,
-		    rq->rq_sched_info.run_delay, rq->rq_sched_info.pcount);
+		    rq->rq_sched_info.run_delay, rq->rq_sched_info.pcount,
+		    rq->sis_search, rq->sis_domain_search,
+		    rq->sis_scanned, rq->sis_failed);
 
 		seq_printf(seq, "\n");
 
-- 
2.26.2

