Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDAC12BA577
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 10:08:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727199AbgKTJGk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 04:06:40 -0500
Received: from outbound-smtp50.blacknight.com ([46.22.136.234]:56511 "EHLO
        outbound-smtp50.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726614AbgKTJGg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 04:06:36 -0500
Received: from mail.blacknight.com (pemlinmail01.blacknight.ie [81.17.254.10])
        by outbound-smtp50.blacknight.com (Postfix) with ESMTPS id C8FD0FBB69
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 09:06:33 +0000 (GMT)
Received: (qmail 11398 invoked from network); 20 Nov 2020 09:06:33 -0000
Received: from unknown (HELO stampy.112glenside.lan) (mgorman@techsingularity.net@[84.203.22.4])
  by 81.17.254.9 with ESMTPA; 20 Nov 2020 09:06:33 -0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH 3/4] sched/numa: Allow a floating imbalance between NUMA nodes
Date:   Fri, 20 Nov 2020 09:06:29 +0000
Message-Id: <20201120090630.3286-4-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201120090630.3286-1-mgorman@techsingularity.net>
References: <20201120090630.3286-1-mgorman@techsingularity.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, an imbalance is only allowed when a destination node
is almost completely idle. This solved one basic class of problems
and was the cautious approach.

This patch revisits the possibility that NUMA nodes can be imbalanced
until 25% of the CPUs are occupied. The reasoning behind 25% is somewhat
superficial -- it's half the cores when HT is enabled.  At higher
utilisations, balancing should continue as normal and keep things even
until scheduler domains are fully busy or over utilised.

Note that this is not expected to be a universal win. Any benchmark
that prefers spreading as wide as possible with limited communication
will favour the old behaviour as there is more memory bandwidth.
Workloads that communicate heavily in pairs such as netperf or tbench
benefit. For the tests I ran, the vast majority of workloads saw
a benefit so it seems to be a worthwhile trade-off.

Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
---
 kernel/sched/fair.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 9aded12aaa90..e17e6c5da1d5 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1550,7 +1550,8 @@ struct task_numa_env {
 static unsigned long cpu_load(struct rq *rq);
 static unsigned long cpu_runnable(struct rq *rq);
 static unsigned long cpu_util(int cpu);
-static inline long adjust_numa_imbalance(int imbalance, int dst_running);
+static inline long adjust_numa_imbalance(int imbalance,
+					int dst_running, int dst_weight);
 
 static inline enum
 numa_type numa_classify(unsigned int imbalance_pct,
@@ -1930,7 +1931,8 @@ static void task_numa_find_cpu(struct task_numa_env *env,
 		src_running = env->src_stats.nr_running - 1;
 		dst_running = env->dst_stats.nr_running + 1;
 		imbalance = max(0, dst_running - src_running);
-		imbalance = adjust_numa_imbalance(imbalance, dst_running);
+		imbalance = adjust_numa_imbalance(imbalance, dst_running,
+							env->dst_stats.weight);
 
 		/* Use idle CPU if there is no imbalance */
 		if (!imbalance) {
@@ -8995,16 +8997,14 @@ static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sd
 
 #define NUMA_IMBALANCE_MIN 2
 
-static inline long adjust_numa_imbalance(int imbalance, int dst_running)
+static inline long adjust_numa_imbalance(int imbalance,
+				int dst_running, int dst_weight)
 {
-	unsigned int imbalance_min;
-
 	/*
 	 * Allow a small imbalance based on a simple pair of communicating
-	 * tasks that remain local when the source domain is almost idle.
+	 * tasks that remain local when the destination is lightly loaded.
 	 */
-	imbalance_min = NUMA_IMBALANCE_MIN;
-	if (dst_running <= imbalance_min)
+	if (dst_running < (dst_weight >> 2) && imbalance <= NUMA_IMBALANCE_MIN)
 		return 0;
 
 	return imbalance;
@@ -9107,9 +9107,10 @@ static inline void calculate_imbalance(struct lb_env *env, struct sd_lb_stats *s
 		}
 
 		/* Consider allowing a small imbalance between NUMA groups */
-		if (env->sd->flags & SD_NUMA)
+		if (env->sd->flags & SD_NUMA) {
 			env->imbalance = adjust_numa_imbalance(env->imbalance,
-						busiest->sum_nr_running);
+				busiest->sum_nr_running, busiest->group_weight);
+		}
 
 		return;
 	}
-- 
2.26.2

