Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 207E72F764F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 11:13:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731565AbhAOKKu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 05:10:50 -0500
Received: from outbound-smtp61.blacknight.com ([46.22.136.249]:49433 "EHLO
        outbound-smtp61.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730159AbhAOKJt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 05:09:49 -0500
Received: from mail.blacknight.com (pemlinmail01.blacknight.ie [81.17.254.10])
        by outbound-smtp61.blacknight.com (Postfix) with ESMTPS id 0187C57402B
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 10:08:56 +0000 (GMT)
Received: (qmail 28201 invoked from network); 15 Jan 2021 10:08:55 -0000
Received: from unknown (HELO stampy.112glenside.lan) (mgorman@techsingularity.net@[84.203.22.4])
  by 81.17.254.9 with ESMTPA; 15 Jan 2021 10:08:55 -0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Li Aubrey <aubrey.li@linux.intel.com>,
        Qais Yousef <qais.yousef@arm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH 1/5] sched/fair: Remove SIS_AVG_CPU
Date:   Fri, 15 Jan 2021 10:08:51 +0000
Message-Id: <20210115100855.23679-2-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210115100855.23679-1-mgorman@techsingularity.net>
References: <20210115100855.23679-1-mgorman@techsingularity.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SIS_AVG_CPU was introduced as a means of avoiding a search when the
average search cost indicated that the search would likely fail. It was
a blunt instrument and disabled by commit 4c77b18cf8b7 ("sched/fair: Make
select_idle_cpu() more aggressive") and later replaced with a proportional
search depth by commit 1ad3aaf3fcd2 ("sched/core: Implement new approach
to scale select_idle_cpu()").

While there are corner cases where SIS_AVG_CPU is better, it has now been
disabled for almost three years. As the intent of SIS_PROP is to reduce
the time complexity of select_idle_cpu(), lets drop SIS_AVG_CPU and focus
on SIS_PROP as a throttling mechanism.

Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/fair.c     | 20 +++++++++-----------
 kernel/sched/features.h |  1 -
 2 files changed, 9 insertions(+), 12 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 04a3ce20da67..9f5682aeda2e 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6145,7 +6145,6 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int t
 {
 	struct cpumask *cpus = this_cpu_cpumask_var_ptr(select_idle_mask);
 	struct sched_domain *this_sd;
-	u64 avg_cost, avg_idle;
 	u64 time;
 	int this = smp_processor_id();
 	int cpu, nr = INT_MAX;
@@ -6154,18 +6153,17 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int t
 	if (!this_sd)
 		return -1;
 
-	/*
-	 * Due to large variance we need a large fuzz factor; hackbench in
-	 * particularly is sensitive here.
-	 */
-	avg_idle = this_rq()->avg_idle / 512;
-	avg_cost = this_sd->avg_scan_cost + 1;
+	if (sched_feat(SIS_PROP)) {
+		u64 avg_cost, avg_idle, span_avg;
 
-	if (sched_feat(SIS_AVG_CPU) && avg_idle < avg_cost)
-		return -1;
+		/*
+		 * Due to large variance we need a large fuzz factor;
+		 * hackbench in particularly is sensitive here.
+		 */
+		avg_idle = this_rq()->avg_idle / 512;
+		avg_cost = this_sd->avg_scan_cost + 1;
 
-	if (sched_feat(SIS_PROP)) {
-		u64 span_avg = sd->span_weight * avg_idle;
+		span_avg = sd->span_weight * avg_idle;
 		if (span_avg > 4*avg_cost)
 			nr = div_u64(span_avg, avg_cost);
 		else
diff --git a/kernel/sched/features.h b/kernel/sched/features.h
index 68d369cba9e4..e875eabb6600 100644
--- a/kernel/sched/features.h
+++ b/kernel/sched/features.h
@@ -54,7 +54,6 @@ SCHED_FEAT(TTWU_QUEUE, true)
 /*
  * When doing wakeups, attempt to limit superfluous scans of the LLC domain.
  */
-SCHED_FEAT(SIS_AVG_CPU, false)
 SCHED_FEAT(SIS_PROP, true)
 
 /*
-- 
2.26.2

