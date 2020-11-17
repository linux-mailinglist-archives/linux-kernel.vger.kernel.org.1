Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CD522B63EA
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 14:44:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732595AbgKQNme (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 08:42:34 -0500
Received: from outbound-smtp07.blacknight.com ([46.22.139.12]:60203 "EHLO
        outbound-smtp07.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387430AbgKQNm1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 08:42:27 -0500
Received: from mail.blacknight.com (pemlinmail04.blacknight.ie [81.17.254.17])
        by outbound-smtp07.blacknight.com (Postfix) with ESMTPS id 162DE1C4AF6
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 13:42:25 +0000 (GMT)
Received: (qmail 10631 invoked from network); 17 Nov 2020 13:42:24 -0000
Received: from unknown (HELO stampy.112glenside.lan) (mgorman@techsingularity.net@[84.203.22.4])
  by 81.17.254.9 with ESMTPA; 17 Nov 2020 13:42:24 -0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH 3/3] sched/numa: Limit the amount of imbalance that can exist at fork time
Date:   Tue, 17 Nov 2020 13:42:22 +0000
Message-Id: <20201117134222.31482-4-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201117134222.31482-1-mgorman@techsingularity.net>
References: <20201117134222.31482-1-mgorman@techsingularity.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

At fork time currently, a local node can be allowed to fill completely
and allow the periodic load balancer to fix the problem. This can
be problematic in cases where a task creates lots of threads that
idle until woken as part of a worker poll causing a memory bandwidth
problem.

This patch tries to pick a line between allowing a local node to
fill a little but to limit imbalances even at fork time. This will
not be a universal win. Specifically, very short-lived workloads
that fit within a NUMA node would prefer the memory bandwidth.

However, a "real" workload suffers badly from this behaviour. The workload
in question is mostly NUMA aware but spawns large numbers of threads
that act as a worker pool that can be called from anywhere. These need to
spread early to get reasonable behaviour. The best proxy measure I found
for illustration was a page fault microbenchmark. It's not representative
of the workload but demonstrates the hazard of the current behaviour.

pft timings
                                 5.10.0-rc2             5.10.0-rc2
                        imbalancefloat-v1r4        forkspread-v1r4
Amean     elapsed-1        46.00 (   0.00%)       46.46 *  -1.00%*
Amean     elapsed-4        12.39 (   0.00%)       12.63 *  -1.99%*
Amean     elapsed-7         7.34 (   0.00%)        7.58 *  -3.28%*
Amean     elapsed-12        4.62 (   0.00%)        4.79 *  -3.78%*
Amean     elapsed-21        3.13 (   0.00%)        3.11 (   0.53%)
Amean     elapsed-30        3.59 (   0.00%)        2.44 *  31.96%*
Amean     elapsed-48        3.05 (   0.00%)        2.15 *  29.59%*
Amean     elapsed-79        1.97 (   0.00%)        1.98 (  -0.44%)

This is showing the time to fault regions belonging to threads. The target
machine has 80 logical CPUs and two nodes. Note the ~30% gain when the
machine is approximately the point where one node becomes fully utilised.
The slower results are borderline noise.

Kernel building shows similar benefits for similar reasons as can be
need with -j32 which is the point where the number of jobs approach
the capacity of one node.

Amean     elsp-2        454.21 (   0.00%)      456.07 (  -0.41%)
Amean     elsp-4        247.27 (   0.00%)      247.68 (  -0.16%)
Amean     elsp-8        136.11 (   0.00%)      136.42 (  -0.23%)
Amean     elsp-16        76.76 (   0.00%)       76.26 (   0.64%)
Amean     elsp-32        49.63 (   0.00%)       44.20 *  10.94%*
Amean     elsp-64        34.05 (   0.00%)       34.03 (   0.04%)
Amean     elsp-128       33.10 (   0.00%)       33.10 (   0.00%)
Amean     elsp-160       33.24 (   0.00%)       33.13 (   0.33%)

Generally performance was either neutral or better in the tests conducted.

Note that the main consideration with this patch is the point where fork
stops spreading a task. Some workloads may benefit from different balance
points but it would be a risky tuning parameter.

Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
---
 kernel/sched/fair.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 33709dfac24d..adfab218a498 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8779,9 +8779,6 @@ find_idlest_group(struct sched_domain *sd, struct task_struct *p, int this_cpu)
 			.group_type = group_overloaded,
 	};
 
-	imbalance = scale_load_down(NICE_0_LOAD) *
-				(sd->imbalance_pct-100) / 100;
-
 	do {
 		int local_group;
 
@@ -8835,6 +8832,11 @@ find_idlest_group(struct sched_domain *sd, struct task_struct *p, int this_cpu)
 	switch (local_sgs.group_type) {
 	case group_overloaded:
 	case group_fully_busy:
+
+		/* Calculate allowed imbalance based on load */
+		imbalance = scale_load_down(NICE_0_LOAD) *
+				(sd->imbalance_pct-100) / 100;
+
 		/*
 		 * When comparing groups across NUMA domains, it's possible for
 		 * the local domain to be very lightly loaded relative to the
@@ -8887,11 +8889,12 @@ find_idlest_group(struct sched_domain *sd, struct task_struct *p, int this_cpu)
 #endif
 			/*
 			 * Otherwise, keep the task on this node to stay close
-			 * its wakeup source and improve locality. If there is
-			 * a real need of migration, periodic load balance will
-			 * take care of it.
+			 * to its wakeup source if utilisation is not too high
+			 * where "high" is related to adjust_numa_imbalance.
+			 * If there is a real need of migration, periodic load
+			 * balance will take care of it.
 			 */
-			if (local_sgs.idle_cpus)
+			if (local_sgs.idle_cpus >= (sd->span_weight >> 2))
 				return NULL;
 		}
 
-- 
2.26.2

