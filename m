Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC73D2D2E5F
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 16:37:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730001AbgLHPgQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 10:36:16 -0500
Received: from outbound-smtp48.blacknight.com ([46.22.136.219]:35835 "EHLO
        outbound-smtp48.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729334AbgLHPgP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 10:36:15 -0500
Received: from mail.blacknight.com (pemlinmail04.blacknight.ie [81.17.254.17])
        by outbound-smtp48.blacknight.com (Postfix) with ESMTPS id E75BEFA902
        for <linux-kernel@vger.kernel.org>; Tue,  8 Dec 2020 15:35:23 +0000 (GMT)
Received: (qmail 10639 invoked from network); 8 Dec 2020 15:35:23 -0000
Received: from unknown (HELO stampy.112glenside.lan) (mgorman@techsingularity.net@[84.203.22.4])
  by 81.17.254.9 with ESMTPA; 8 Dec 2020 15:35:23 -0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Peter Ziljstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Aubrey Li <aubrey.li@linux.intel.com>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Linux-ARM <linux-arm-kernel@lists.infradead.org>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH 1/4] sched/fair: Remove SIS_AVG_CPU
Date:   Tue,  8 Dec 2020 15:34:58 +0000
Message-Id: <20201208153501.1467-2-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201208153501.1467-1-mgorman@techsingularity.net>
References: <20201208153501.1467-1-mgorman@techsingularity.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SIS_AVG_CPU was introduced as a means of avoiding a search when the
average search cost indicated that the search would likely fail. It
was a blunt instrument and disabled by 4c77b18cf8b7 ("sched/fair: Make
select_idle_cpu() more aggressive") and later replaced with a proportional
search depth by 1ad3aaf3fcd2 ("sched/core: Implement new approach to
scale select_idle_cpu()").

While there are corner cases where SIS_AVG_CPU is better, it has now been
disabled for almost three years. As the intent of SIS_PROP is to reduce
the time complexity of select_idle_cpu(), lets drop SIS_AVG_CPU and focus
on SIS_PROP as a throttling mechanism.

Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
---
 kernel/sched/fair.c     | 20 +++++++++-----------
 kernel/sched/features.h |  1 -
 2 files changed, 9 insertions(+), 12 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 98075f9ea9a8..ac7b34e7372b 100644
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

