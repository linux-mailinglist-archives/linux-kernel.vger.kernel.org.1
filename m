Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AFD62FB7FD
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 15:28:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391531AbhASLfw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 06:35:52 -0500
Received: from outbound-smtp44.blacknight.com ([46.22.136.52]:51183 "EHLO
        outbound-smtp44.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390832AbhASLXL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 06:23:11 -0500
Received: from mail.blacknight.com (pemlinmail03.blacknight.ie [81.17.254.16])
        by outbound-smtp44.blacknight.com (Postfix) with ESMTPS id A7A59F867A
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 11:22:12 +0000 (GMT)
Received: (qmail 4711 invoked from network); 19 Jan 2021 11:22:12 -0000
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
Subject: [PATCH 4/5] sched/fair: Remove select_idle_smt()
Date:   Tue, 19 Jan 2021 11:22:10 +0000
Message-Id: <20210119112211.3196-5-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210119112211.3196-1-mgorman@techsingularity.net>
References: <20210119112211.3196-1-mgorman@techsingularity.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Zijlstra (Intel) <peterz@infradead.org>

In order to make the next patch more readable, and to quantify the
actual effectiveness of this pass, start by removing it.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
---
 kernel/sched/fair.c | 30 ------------------------------
 1 file changed, 30 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 0811e2fe4f19..12e08da90024 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6103,27 +6103,6 @@ static int select_idle_core(struct task_struct *p, struct sched_domain *sd, int
 	return -1;
 }
 
-/*
- * Scan the local SMT mask for idle CPUs.
- */
-static int select_idle_smt(struct task_struct *p, struct sched_domain *sd, int target)
-{
-	int cpu;
-
-	if (!static_branch_likely(&sched_smt_present))
-		return -1;
-
-	for_each_cpu(cpu, cpu_smt_mask(target)) {
-		if (!cpumask_test_cpu(cpu, p->cpus_ptr) ||
-		    !cpumask_test_cpu(cpu, sched_domain_span(sd)))
-			continue;
-		if (available_idle_cpu(cpu) || sched_idle_cpu(cpu))
-			return cpu;
-	}
-
-	return -1;
-}
-
 #else /* CONFIG_SCHED_SMT */
 
 #define sched_smt_weight	1
@@ -6133,11 +6112,6 @@ static inline int select_idle_core(struct task_struct *p, struct sched_domain *s
 	return -1;
 }
 
-static inline int select_idle_smt(struct task_struct *p, struct sched_domain *sd, int target)
-{
-	return -1;
-}
-
 #endif /* CONFIG_SCHED_SMT */
 
 #define sis_min_cores		2
@@ -6331,10 +6305,6 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
 	if ((unsigned)i < nr_cpumask_bits)
 		return i;
 
-	i = select_idle_smt(p, sd, target);
-	if ((unsigned)i < nr_cpumask_bits)
-		return i;
-
 	return target;
 }
 
-- 
2.26.2

