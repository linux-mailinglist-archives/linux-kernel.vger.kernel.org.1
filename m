Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E72312CD8AB
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 15:13:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436665AbgLCOMi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 09:12:38 -0500
Received: from outbound-smtp09.blacknight.com ([46.22.139.14]:46935 "EHLO
        outbound-smtp09.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727242AbgLCOMR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 09:12:17 -0500
Received: from mail.blacknight.com (pemlinmail03.blacknight.ie [81.17.254.16])
        by outbound-smtp09.blacknight.com (Postfix) with ESMTPS id 27FFB1C372A
        for <linux-kernel@vger.kernel.org>; Thu,  3 Dec 2020 14:11:25 +0000 (GMT)
Received: (qmail 22688 invoked from network); 3 Dec 2020 14:11:25 -0000
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
Subject: [PATCH 02/10] sched/fair: Track efficiency of task recent_used_cpu
Date:   Thu,  3 Dec 2020 14:11:16 +0000
Message-Id: <20201203141124.7391-3-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201203141124.7391-1-mgorman@techsingularity.net>
References: <20201203141124.7391-1-mgorman@techsingularity.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This simply tracks the efficiency of the recent_used_cpu. The hit rate
of this matters as it can avoid a domain search. Similarly, the miss
rate matters because each miss is a penalty to the fast path.

It is not required that this patch be merged with the series but if we
are looking at the usefulness of p->recent_used_cpu, the stats generate
hard data on what the hit rate is.

MMTests uses this to generate additional metrics.

SIS Recent Used Hit: A recent CPU was eligible and used. Each hit is
	a domain search avoided.

SIS Recent Used Miss: A recent CPU was eligible but unavailable. Each
	time this is miss, there was a small penalty to the fast path
	before a domain search happened.

SIS Recent Success Rate: A percentage of the number of hits versus
	the total attempts to use the recent CPU.

SIS Recent Attempts: The total number of times the recent CPU was examined.
	A high number of Recent Attempts with a low Success Rate implies
	the fast path is being punished severely. This could have been
	presented as a weighting of hits and misses but calculating an
	appropriate weight for misses is problematic.

Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
---
 kernel/sched/debug.c |  2 ++
 kernel/sched/fair.c  | 23 +++++++++++++----------
 kernel/sched/sched.h |  2 ++
 kernel/sched/stats.c |  7 ++++---
 4 files changed, 21 insertions(+), 13 deletions(-)

diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 2386cc5e79e5..8f933a9e8c25 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -718,6 +718,8 @@ do {									\
 		P(sis_domain_search);
 		P(sis_scanned);
 		P(sis_failed);
+		P(sis_recent_hit);
+		P(sis_recent_miss);
 	}
 #undef P
 
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 494ba01f3414..d9acd55d309b 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6291,16 +6291,19 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
 	recent_used_cpu = p->recent_used_cpu;
 	if (recent_used_cpu != prev &&
 	    recent_used_cpu != target &&
-	    cpus_share_cache(recent_used_cpu, target) &&
-	    (available_idle_cpu(recent_used_cpu) || sched_idle_cpu(recent_used_cpu)) &&
-	    cpumask_test_cpu(p->recent_used_cpu, p->cpus_ptr) &&
-	    asym_fits_capacity(task_util, recent_used_cpu)) {
-		/*
-		 * Replace recent_used_cpu with prev as it is a potential
-		 * candidate for the next wake:
-		 */
-		p->recent_used_cpu = prev;
-		return recent_used_cpu;
+	    cpus_share_cache(recent_used_cpu, target)) {
+		if ((available_idle_cpu(recent_used_cpu) || sched_idle_cpu(recent_used_cpu)) &&
+		    cpumask_test_cpu(p->recent_used_cpu, p->cpus_ptr) &&
+		    asym_fits_capacity(task_util, recent_used_cpu)) {
+			/*
+			 * Replace recent_used_cpu with prev as it is a potential
+			 * candidate for the next wake:
+			 */
+			p->recent_used_cpu = prev;
+			schedstat_inc(this_rq()->sis_recent_hit);
+			return recent_used_cpu;
+		}
+		schedstat_inc(this_rq()->sis_recent_miss);
 	}
 
 	/*
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 90a62dd9293d..6a6578c4c24b 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1055,6 +1055,8 @@ struct rq {
 	unsigned int		sis_domain_search;
 	unsigned int		sis_scanned;
 	unsigned int		sis_failed;
+	unsigned int		sis_recent_hit;
+	unsigned int		sis_recent_miss;
 #endif
 
 #ifdef CONFIG_CPU_IDLE
diff --git a/kernel/sched/stats.c b/kernel/sched/stats.c
index 390bfcc3842c..402fab75aa14 100644
--- a/kernel/sched/stats.c
+++ b/kernel/sched/stats.c
@@ -10,7 +10,7 @@
  * Bump this up when changing the output format or the meaning of an existing
  * format, so that tools can adapt (or abort)
  */
-#define SCHEDSTAT_VERSION 16
+#define SCHEDSTAT_VERSION 17
 
 static int show_schedstat(struct seq_file *seq, void *v)
 {
@@ -30,14 +30,15 @@ static int show_schedstat(struct seq_file *seq, void *v)
 
 		/* runqueue-specific stats */
 		seq_printf(seq,
-		    "cpu%d %u 0 %u %u %u %u %llu %llu %lu %u %u %u %u",
+		    "cpu%d %u 0 %u %u %u %u %llu %llu %lu %u %u %u %u %u %u",
 		    cpu, rq->yld_count,
 		    rq->sched_count, rq->sched_goidle,
 		    rq->ttwu_count, rq->ttwu_local,
 		    rq->rq_cpu_time,
 		    rq->rq_sched_info.run_delay, rq->rq_sched_info.pcount,
 		    rq->sis_search, rq->sis_domain_search,
-		    rq->sis_scanned, rq->sis_failed);
+		    rq->sis_scanned, rq->sis_failed,
+		    rq->sis_recent_hit, rq->sis_recent_miss);
 
 		seq_printf(seq, "\n");
 
-- 
2.26.2

