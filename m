Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45FF32FB7FB
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 15:28:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391494AbhASLf1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 06:35:27 -0500
Received: from outbound-smtp38.blacknight.com ([46.22.139.221]:55355 "EHLO
        outbound-smtp38.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390022AbhASLXK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 06:23:10 -0500
Received: from mail.blacknight.com (pemlinmail03.blacknight.ie [81.17.254.16])
        by outbound-smtp38.blacknight.com (Postfix) with ESMTPS id 7C6222E22
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 11:22:12 +0000 (GMT)
Received: (qmail 4682 invoked from network); 19 Jan 2021 11:22:12 -0000
Received: from unknown (HELO stampy.112glenside.lan) (mgorman@techsingularity.net@[84.203.22.4])
  by 81.17.254.9 with ESMTPA; 19 Jan 2021 11:22:12 -0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Li Aubrey <aubrey.li@linux.intel.com>,
        Qais Yousef <qais.yousef@arm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH 3/5] sched/fair: Make select_idle_cpu() proportional to cores
Date:   Tue, 19 Jan 2021 11:22:09 +0000
Message-Id: <20210119112211.3196-4-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210119112211.3196-1-mgorman@techsingularity.net>
References: <20210119112211.3196-1-mgorman@techsingularity.net>
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
 kernel/sched/core.c  | 18 +++++++++++++-----
 kernel/sched/fair.c  | 12 ++++++++++--
 kernel/sched/sched.h |  2 ++
 3 files changed, 25 insertions(+), 7 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 15d2562118d1..ada8faac2e4d 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -7444,11 +7444,19 @@ int sched_cpu_activate(unsigned int cpu)
 	balance_push_set(cpu, false);
 
 #ifdef CONFIG_SCHED_SMT
-	/*
-	 * When going up, increment the number of cores with SMT present.
-	 */
-	if (cpumask_weight(cpu_smt_mask(cpu)) == 2)
-		static_branch_inc_cpuslocked(&sched_smt_present);
+	do {
+		int weight = cpumask_weight(cpu_smt_mask(cpu));
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
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 12ada79d40f3..29aabe98dd1d 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1107,6 +1107,8 @@ static inline void update_idle_core(struct rq *rq)
 		__update_idle_core(rq);
 }
 
+extern int sched_smt_weight;
+
 #else
 static inline void update_idle_core(struct rq *rq) { }
 #endif
-- 
2.26.2

