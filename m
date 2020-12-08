Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8554B2D2E63
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 16:37:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730146AbgLHPgr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 10:36:47 -0500
Received: from outbound-smtp21.blacknight.com ([81.17.249.41]:44251 "EHLO
        outbound-smtp21.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729878AbgLHPgq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 10:36:46 -0500
Received: from mail.blacknight.com (pemlinmail04.blacknight.ie [81.17.254.17])
        by outbound-smtp21.blacknight.com (Postfix) with ESMTPS id 4E62BCCB18
        for <linux-kernel@vger.kernel.org>; Tue,  8 Dec 2020 15:35:54 +0000 (GMT)
Received: (qmail 13670 invoked from network); 8 Dec 2020 15:35:54 -0000
Received: from unknown (HELO stampy.112glenside.lan) (mgorman@techsingularity.net@[84.203.22.4])
  by 81.17.254.9 with ESMTPA; 8 Dec 2020 15:35:54 -0000
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
Subject: [PATCH 4/4] sched/fair: Return an idle cpu if one is found after a failed search for an idle core
Date:   Tue,  8 Dec 2020 15:35:01 +0000
Message-Id: <20201208153501.1467-5-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201208153501.1467-1-mgorman@techsingularity.net>
References: <20201208153501.1467-1-mgorman@techsingularity.net>
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

Note that there is a significant corner case. As the SMT scan may be
terminated early, not all CPUs have been visited and select_idle_cpu()
is still called for a full scan. This case is handled in the next
patch.

Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
---
 kernel/sched/fair.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 413d895bbbf8..ed6f45832d97 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6066,6 +6066,7 @@ void __update_idle_core(struct rq *rq)
  */
 static int select_idle_core(struct task_struct *p, struct sched_domain *sd, int target)
 {
+	int idle_candidate = -1;
 	struct cpumask *cpus = this_cpu_cpumask_var_ptr(select_idle_mask);
 	int core, cpu;
 
@@ -6085,6 +6086,11 @@ static int select_idle_core(struct task_struct *p, struct sched_domain *sd, int
 				idle = false;
 				break;
 			}
+
+			if (idle_candidate == -1 &&
+			    cpumask_test_cpu(cpu, p->cpus_ptr)) {
+				idle_candidate = cpu;
+			}
 		}
 
 		if (idle)
@@ -6098,7 +6104,7 @@ static int select_idle_core(struct task_struct *p, struct sched_domain *sd, int
 	 */
 	set_idle_cores(target, 0);
 
-	return -1;
+	return idle_candidate;
 }
 
 /*
-- 
2.26.2

