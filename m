Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 250D52CD8A7
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 15:13:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436594AbgLCOMY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 09:12:24 -0500
Received: from outbound-smtp49.blacknight.com ([46.22.136.233]:49469 "EHLO
        outbound-smtp49.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728188AbgLCOMS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 09:12:18 -0500
Received: from mail.blacknight.com (pemlinmail03.blacknight.ie [81.17.254.16])
        by outbound-smtp49.blacknight.com (Postfix) with ESMTPS id 4CFEBFA90A
        for <linux-kernel@vger.kernel.org>; Thu,  3 Dec 2020 14:11:26 +0000 (GMT)
Received: (qmail 22879 invoked from network); 3 Dec 2020 14:11:26 -0000
Received: from unknown (HELO stampy.112glenside.lan) (mgorman@techsingularity.net@[84.203.22.4])
  by 81.17.254.9 with ESMTPA; 3 Dec 2020 14:11:26 -0000
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
Subject: [PATCH 07/10] sched/fair: Account for the idle cpu/smt search cost
Date:   Thu,  3 Dec 2020 14:11:21 +0000
Message-Id: <20201203141124.7391-8-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201203141124.7391-1-mgorman@techsingularity.net>
References: <20201203141124.7391-1-mgorman@techsingularity.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

select_idle_cpu() accounts average search cost for the purposes of
conducting a limited proportional search if SIS_PROP is enabled. The issue
is that select_idle_cpu() does not account for the cost if a candidate
is found and select_idle_smt() is ignored.

This patch moves the accounting of avg_cost to cover the cpu/smt search
costs. select_idle_core() costs could be accounted for but it has its
own throttling mechanism by tracking depending on whether idle cores are
expected to exist.

This patch is a bisection hazard becuse SIS_PROP and how it balances
avg_cost vs avg_idle was probably guided by the fact that avg_cost was
not always accounted for.

Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
---
 kernel/sched/fair.c | 82 +++++++++++++++++++++++++--------------------
 1 file changed, 46 insertions(+), 36 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 1d8f5c4b4936..185fc6e28f8e 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6006,6 +6006,29 @@ static inline int find_idlest_cpu(struct sched_domain *sd, struct task_struct *p
 	return new_cpu;
 }
 
+static int sis_search_depth(struct sched_domain *sd, struct sched_domain *this_sd)
+{
+	u64 avg_cost, avg_idle, span_avg;
+	int nr = INT_MAX;
+
+	if (sched_feat(SIS_PROP)) {
+		/*
+		 * Due to large variance we need a large fuzz factor; hackbench in
+		 * particularly is sensitive here.
+		 */
+		avg_idle = this_rq()->avg_idle / 512;
+		avg_cost = this_sd->avg_scan_cost + 1;
+
+		span_avg = sd->span_weight * avg_idle;
+		if (span_avg > 4*avg_cost)
+			nr = div_u64(span_avg, avg_cost);
+		else
+			nr = 4;
+	}
+
+	return nr;
+}
+
 #ifdef CONFIG_SCHED_SMT
 DEFINE_STATIC_KEY_FALSE(sched_smt_present);
 EXPORT_SYMBOL_GPL(sched_smt_present);
@@ -6151,35 +6174,11 @@ static inline int select_idle_smt(struct task_struct *p, struct sched_domain *sd
  * comparing the average scan cost (tracked in sd->avg_scan_cost) against the
  * average idle time for this rq (as found in rq->avg_idle).
  */
-static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int target)
+static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd,
+							int target, int nr)
 {
 	struct cpumask *cpus = this_cpu_cpumask_var_ptr(select_idle_mask);
-	struct sched_domain *this_sd;
-	u64 avg_cost, avg_idle;
-	u64 time;
-	int this = smp_processor_id();
-	int cpu, nr = INT_MAX;
-
-	this_sd = rcu_dereference(*this_cpu_ptr(&sd_llc));
-	if (!this_sd)
-		return -1;
-
-	/*
-	 * Due to large variance we need a large fuzz factor; hackbench in
-	 * particularly is sensitive here.
-	 */
-	avg_idle = this_rq()->avg_idle / 512;
-	avg_cost = this_sd->avg_scan_cost + 1;
-
-	if (sched_feat(SIS_PROP)) {
-		u64 span_avg = sd->span_weight * avg_idle;
-		if (span_avg > 4*avg_cost)
-			nr = div_u64(span_avg, avg_cost);
-		else
-			nr = 4;
-	}
-
-	time = cpu_clock(this);
+	int cpu;
 
 	cpumask_and(cpus, sched_domain_span(sd), p->cpus_ptr);
 	__cpumask_clear_cpu(target, cpus);
@@ -6192,9 +6191,6 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int t
 			break;
 	}
 
-	time = cpu_clock(this) - time;
-	update_avg(&this_sd->avg_scan_cost, time);
-
 	return cpu;
 }
 
@@ -6245,9 +6241,10 @@ static inline bool asym_fits_capacity(int task_util, int cpu)
  */
 static int select_idle_sibling(struct task_struct *p, int prev, int target)
 {
-	struct sched_domain *sd;
+	struct sched_domain *sd, *this_sd;
 	unsigned long task_util;
-	int i, recent_used_cpu;
+	int i, recent_used_cpu, depth;
+	u64 time;
 
 	schedstat_inc(this_rq()->sis_search);
 
@@ -6337,21 +6334,34 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
 	if (!sd)
 		return target;
 
+	this_sd = rcu_dereference(*this_cpu_ptr(&sd_llc));
+	if (!this_sd)
+		return target;
+
+	depth = sis_search_depth(sd, this_sd);
+
 	schedstat_inc(this_rq()->sis_domain_search);
 	i = select_idle_core(p, sd, target);
 	if ((unsigned)i < nr_cpumask_bits)
 		return i;
 
-	i = select_idle_cpu(p, sd, target);
+	time = cpu_clock(smp_processor_id());
+	i = select_idle_cpu(p, sd, target, depth);
 	if ((unsigned)i < nr_cpumask_bits)
-		return i;
+		goto acct_cost;
 
 	i = select_idle_smt(p, sd, target);
 	if ((unsigned)i < nr_cpumask_bits)
-		return i;
+		goto acct_cost;
 
 	schedstat_inc(this_rq()->sis_failed);
-	return target;
+	i = target;
+
+acct_cost:
+	time = cpu_clock(smp_processor_id()) - time;
+	update_avg(&this_sd->avg_scan_cost, time);
+
+	return i;
 }
 
 /**
-- 
2.26.2

