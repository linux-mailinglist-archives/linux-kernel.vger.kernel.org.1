Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C0C72CD8A5
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 15:13:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436538AbgLCOMU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 09:12:20 -0500
Received: from outbound-smtp25.blacknight.com ([81.17.249.193]:58408 "EHLO
        outbound-smtp25.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727358AbgLCOMS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 09:12:18 -0500
Received: from mail.blacknight.com (pemlinmail03.blacknight.ie [81.17.254.16])
        by outbound-smtp25.blacknight.com (Postfix) with ESMTPS id 92AC3CABC6
        for <linux-kernel@vger.kernel.org>; Thu,  3 Dec 2020 14:11:25 +0000 (GMT)
Received: (qmail 22748 invoked from network); 3 Dec 2020 14:11:25 -0000
Received: from unknown (HELO stampy.112glenside.lan) (mgorman@techsingularity.net@[84.203.22.4])
  by 81.17.254.9 with ESMTPA; 3 Dec 2020 14:11:25 -0000
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
Subject: [PATCH 04/10] sched/fair: Return an idle cpu if one is found after a failed search for an idle core
Date:   Thu,  3 Dec 2020 14:11:18 +0000
Message-Id: <20201203141124.7391-5-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201203141124.7391-1-mgorman@techsingularity.net>
References: <20201203141124.7391-1-mgorman@techsingularity.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

select_idle_core is called when SMT is active and there is likely a free
core available. It may find idle CPUs but this information is simply
discarded and the scan starts over again with select_idle_cpu.

This patch caches information on idle CPUs found during the search for
a core and uses one if no core is found. This is a tradeoff. There may
be a slight impact when utilisation is low and an idle core can be
found quickly. It provides improvements as the number of busy CPUs
approaches 50% of the domain size when SMT is enabled.

With tbench on a 2-socket CascadeLake machine, 80 logical CPUs, HT enabled

                          5.10.0-rc6             5.10.0-rc6
                           schedstat          idlecandidate
Hmean     1        500.06 (   0.00%)      505.67 *   1.12%*
Hmean     2        975.90 (   0.00%)      974.06 *  -0.19%*
Hmean     4       1902.95 (   0.00%)     1904.43 *   0.08%*
Hmean     8       3761.73 (   0.00%)     3721.02 *  -1.08%*
Hmean     16      6713.93 (   0.00%)     6769.17 *   0.82%*
Hmean     32     10435.31 (   0.00%)    10312.58 *  -1.18%*
Hmean     64     12325.51 (   0.00%)    13792.01 *  11.90%*
Hmean     128    21225.21 (   0.00%)    20963.44 *  -1.23%*
Hmean     256    20532.83 (   0.00%)    20335.62 *  -0.96%*
Hmean     320    20334.81 (   0.00%)    20147.25 *  -0.92%*

In this particular test, the cost/benefit is marginal except
for 64 which was a point where the machine was over 50% busy
but not fully utilised.

Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
---
 kernel/sched/fair.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index fc48cc99b03d..845bc0cd9158 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6066,6 +6066,7 @@ void __update_idle_core(struct rq *rq)
  */
 static int select_idle_core(struct task_struct *p, struct sched_domain *sd, int target)
 {
+	int idle_candidate = -1;
 	struct cpumask *cpus = this_cpu_cpumask_var_ptr(select_idle_mask);
 	int core, cpu;
 
@@ -6084,7 +6085,13 @@ static int select_idle_core(struct task_struct *p, struct sched_domain *sd, int
 			schedstat_inc(this_rq()->sis_scanned);
 			if (!available_idle_cpu(cpu)) {
 				idle = false;
-				break;
+				if (idle_candidate != -1)
+					break;
+			}
+
+			if (idle_candidate == -1 &&
+			    cpumask_test_cpu(cpu, p->cpus_ptr)) {
+				idle_candidate = cpu;
 			}
 		}
 
@@ -6099,7 +6106,7 @@ static int select_idle_core(struct task_struct *p, struct sched_domain *sd, int
 	 */
 	set_idle_cores(target, 0);
 
-	return -1;
+	return idle_candidate;
 }
 
 /*
-- 
2.26.2

