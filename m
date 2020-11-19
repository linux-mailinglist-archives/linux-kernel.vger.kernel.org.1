Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26B5C2B8D3D
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 09:32:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726537AbgKSIab (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 03:30:31 -0500
Received: from outbound-smtp63.blacknight.com ([46.22.136.252]:48551 "EHLO
        outbound-smtp63.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725853AbgKSIaa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 03:30:30 -0500
Received: from mail.blacknight.com (pemlinmail01.blacknight.ie [81.17.254.10])
        by outbound-smtp63.blacknight.com (Postfix) with ESMTPS id 80FC1FBBB0
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 08:30:28 +0000 (GMT)
Received: (qmail 4649 invoked from network); 19 Nov 2020 08:30:28 -0000
Received: from unknown (HELO stampy.112glenside.lan) (mgorman@techsingularity.net@[84.203.22.4])
  by 81.17.254.9 with ESMTPA; 19 Nov 2020 08:30:28 -0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH 1/4] sched/numa: Rename nr_running and break out the magic number
Date:   Thu, 19 Nov 2020 08:30:24 +0000
Message-Id: <20201119083027.31335-2-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201119083027.31335-1-mgorman@techsingularity.net>
References: <20201119083027.31335-1-mgorman@techsingularity.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is simply a preparation patch to make the following patches easier
to read. No functional change.

Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
---
 kernel/sched/fair.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 6d78b68847f9..5fbed29e4001 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1550,7 +1550,7 @@ struct task_numa_env {
 static unsigned long cpu_load(struct rq *rq);
 static unsigned long cpu_runnable(struct rq *rq);
 static unsigned long cpu_util(int cpu);
-static inline long adjust_numa_imbalance(int imbalance, int nr_running);
+static inline long adjust_numa_imbalance(int imbalance, int dst_running);
 
 static inline enum
 numa_type numa_classify(unsigned int imbalance_pct,
@@ -8991,7 +8991,9 @@ static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sd
 	}
 }
 
-static inline long adjust_numa_imbalance(int imbalance, int nr_running)
+#define NUMA_IMBALANCE_MIN 2
+
+static inline long adjust_numa_imbalance(int imbalance, int dst_running)
 {
 	unsigned int imbalance_min;
 
@@ -8999,8 +9001,8 @@ static inline long adjust_numa_imbalance(int imbalance, int nr_running)
 	 * Allow a small imbalance based on a simple pair of communicating
 	 * tasks that remain local when the source domain is almost idle.
 	 */
-	imbalance_min = 2;
-	if (nr_running <= imbalance_min)
+	imbalance_min = NUMA_IMBALANCE_MIN;
+	if (dst_running <= imbalance_min)
 		return 0;
 
 	return imbalance;
-- 
2.26.2

