Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED4CE2F1A1B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 16:53:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387906AbhAKPvq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 10:51:46 -0500
Received: from outbound-smtp33.blacknight.com ([81.17.249.66]:34986 "EHLO
        outbound-smtp33.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387725AbhAKPvo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 10:51:44 -0500
Received: from mail.blacknight.com (pemlinmail03.blacknight.ie [81.17.254.16])
        by outbound-smtp33.blacknight.com (Postfix) with ESMTPS id 5ED83BAC01
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 15:50:52 +0000 (GMT)
Received: (qmail 15404 invoked from network); 11 Jan 2021 15:50:52 -0000
Received: from unknown (HELO stampy.112glenside.lan) (mgorman@techsingularity.net@[84.203.22.4])
  by 81.17.254.9 with ESMTPA; 11 Jan 2021 15:50:52 -0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Li Aubrey <aubrey.li@linux.intel.com>,
        Qais Yousef <qais.yousef@arm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH 3/5] sched/fair: Make select_idle_cpu() proportional to cores
Date:   Mon, 11 Jan 2021 15:50:45 +0000
Message-Id: <20210111155047.10657-4-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210111155047.10657-1-mgorman@techsingularity.net>
References: <20210111155047.10657-1-mgorman@techsingularity.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Zijlstra (Intel) <peterz@infradead.org>

Instead of calculating how many (logical) CPUs to scan, compute how
many cores to scan.

This changes behaviour for anything !SMT2.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
---
 kernel/sched/core.c | 19 ++++++++++++++-----
 kernel/sched/fair.c | 12 ++++++++++--
 2 files changed, 24 insertions(+), 7 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 15d2562118d1..7bfa73de6a8d 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -7444,11 +7444,20 @@ int sched_cpu_activate(unsigned int cpu)
 	balance_push_set(cpu, false);
 
 #ifdef CONFIG_SCHED_SMT
-	/*
-	 * When going up, increment the number of cores with SMT present.
-	 */
-	if (cpumask_weight(cpu_smt_mask(cpu)) == 2)
-		static_branch_inc_cpuslocked(&sched_smt_present);
+	do {
+		int weight = cpumask_weight(cpu_smt_mask(cpu));
+		extern int sched_smt_weight;
+
+		if (weight > sched_smt_weight)
+			sched_smt_weight = weight;
+
+		/*
+		 * When going up, increment the number of cores with SMT present.
+		 */
+		if (weight == 2)
+			static_branch_inc_cpuslocked(&sched_smt_present);
+
+	} while (0);
 #endif
 	set_cpu_active(cpu, true);
 
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index c8d8e185cf3b..0811e2fe4f19 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6010,6 +6010,8 @@ static inline int find_idlest_cpu(struct sched_domain *sd, struct task_struct *p
 DEFINE_STATIC_KEY_FALSE(sched_smt_present);
 EXPORT_SYMBOL_GPL(sched_smt_present);
 
+int sched_smt_weight __read_mostly = 1;
+
 static inline void set_idle_cores(int cpu, int val)
 {
 	struct sched_domain_shared *sds;
@@ -6124,6 +6126,8 @@ static int select_idle_smt(struct task_struct *p, struct sched_domain *sd, int t
 
 #else /* CONFIG_SCHED_SMT */
 
+#define sched_smt_weight	1
+
 static inline int select_idle_core(struct task_struct *p, struct sched_domain *sd, int target)
 {
 	return -1;
@@ -6136,6 +6140,8 @@ static inline int select_idle_smt(struct task_struct *p, struct sched_domain *sd
 
 #endif /* CONFIG_SCHED_SMT */
 
+#define sis_min_cores		2
+
 /*
  * Scan the LLC domain for idle CPUs; this is dynamically regulated by
  * comparing the average scan cost (tracked in sd->avg_scan_cost) against the
@@ -6166,10 +6172,12 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int t
 		avg_cost = this_sd->avg_scan_cost + 1;
 
 		span_avg = sd->span_weight * avg_idle;
-		if (span_avg > 4*avg_cost)
+		if (span_avg > sis_min_cores*avg_cost)
 			nr = div_u64(span_avg, avg_cost);
 		else
-			nr = 4;
+			nr = sis_min_cores;
+
+		nr *= sched_smt_weight;
 
 		time = cpu_clock(this);
 	}
-- 
2.26.2

