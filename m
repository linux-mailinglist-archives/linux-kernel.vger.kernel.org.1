Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 921B62CD8A8
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 15:13:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436610AbgLCOM3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 09:12:29 -0500
Received: from outbound-smtp61.blacknight.com ([46.22.136.249]:49949 "EHLO
        outbound-smtp61.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728975AbgLCOMS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 09:12:18 -0500
Received: from mail.blacknight.com (pemlinmail03.blacknight.ie [81.17.254.16])
        by outbound-smtp61.blacknight.com (Postfix) with ESMTPS id BEBCAFA919
        for <linux-kernel@vger.kernel.org>; Thu,  3 Dec 2020 14:11:26 +0000 (GMT)
Received: (qmail 22934 invoked from network); 3 Dec 2020 14:11:26 -0000
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
Subject: [PATCH 09/10] sched/fair: Limit the search for an idle core
Date:   Thu,  3 Dec 2020 14:11:23 +0000
Message-Id: <20201203141124.7391-10-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201203141124.7391-1-mgorman@techsingularity.net>
References: <20201203141124.7391-1-mgorman@techsingularity.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Note: This is a bad idea, it's for illustration only to show how the
	search space can be filtered at each stage. Searching an
	idle_cpu_mask would be a potential option. select_idle_core()
	would be left alone as it has its own throttling mechanism

select_idle_core() may search a full domain for an idle core even if idle
CPUs exist result in an excessive search. This patch partially limits
the search for an idle core similar to select_idle_cpu() once an idle
candidate is found.

Note that this patch can *increase* the number of runqueues considered.
Any searching done by select_idle_core() is duplicated by select_idle_cpu()
if an idle candidate is not found. If there is an idle CPU then aborting
select_idle_core() can have a negative impact. This is addressed in the
next patch.

Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
---
 kernel/sched/fair.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 33ce65b67381..cd95daf9f53e 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6095,7 +6095,8 @@ void __update_idle_core(struct rq *rq)
  * there are no idle cores left in the system; tracked through
  * sd_llc->shared->has_idle_cores and enabled through update_idle_core() above.
  */
-static int select_idle_core(struct task_struct *p, struct sched_domain *sd, int target)
+static int select_idle_core(struct task_struct *p, struct sched_domain *sd,
+							int target, int nr)
 {
 	int idle_candidate = -1;
 	struct cpumask *cpus = this_cpu_cpumask_var_ptr(select_idle_mask);
@@ -6115,6 +6116,11 @@ static int select_idle_core(struct task_struct *p, struct sched_domain *sd, int
 
 		for_each_cpu(cpu, cpu_smt_mask(core)) {
 			schedstat_inc(this_rq()->sis_scanned);
+
+			/* Apply limits if there is an idle candidate */
+			if (idle_candidate != -1)
+				nr--;
+
 			if (!available_idle_cpu(cpu)) {
 				idle = false;
 				if (idle_candidate != -1)
@@ -6130,6 +6136,9 @@ static int select_idle_core(struct task_struct *p, struct sched_domain *sd, int
 		if (idle)
 			return core;
 
+		if (!nr)
+			break;
+
 		cpumask_andnot(cpus, cpus, cpu_smt_mask(core));
 	}
 
@@ -6165,7 +6174,8 @@ static int select_idle_smt(struct task_struct *p, struct sched_domain *sd, int t
 
 #else /* CONFIG_SCHED_SMT */
 
-static inline int select_idle_core(struct task_struct *p, struct sched_domain *sd, int target)
+static inline int select_idle_core(struct task_struct *p, struct sched_domain *sd,
+							int target, int nr)
 {
 	return -1;
 }
@@ -6349,7 +6359,7 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
 	depth = sis_search_depth(sd, this_sd);
 
 	schedstat_inc(this_rq()->sis_domain_search);
-	i = select_idle_core(p, sd, target);
+	i = select_idle_core(p, sd, target, depth);
 	if ((unsigned)i < nr_cpumask_bits)
 		return i;
 
-- 
2.26.2

