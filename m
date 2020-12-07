Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3AC02D0CCC
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 10:18:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726732AbgLGJQi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 04:16:38 -0500
Received: from outbound-smtp32.blacknight.com ([81.17.249.64]:38486 "EHLO
        outbound-smtp32.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726423AbgLGJQh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 04:16:37 -0500
Received: from mail.blacknight.com (pemlinmail02.blacknight.ie [81.17.254.11])
        by outbound-smtp32.blacknight.com (Postfix) with ESMTPS id 9AD34BEC6F
        for <linux-kernel@vger.kernel.org>; Mon,  7 Dec 2020 09:15:48 +0000 (GMT)
Received: (qmail 13145 invoked from network); 7 Dec 2020 09:15:48 -0000
Received: from unknown (HELO stampy.112glenside.lan) (mgorman@techsingularity.net@[84.203.22.4])
  by 81.17.254.9 with ESMTPA; 7 Dec 2020 09:15:48 -0000
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
Subject: [PATCH 2/4] sched/fair: Do not replace recent_used_cpu with the new target
Date:   Mon,  7 Dec 2020 09:15:14 +0000
Message-Id: <20201207091516.24683-3-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201207091516.24683-1-mgorman@techsingularity.net>
References: <20201207091516.24683-1-mgorman@techsingularity.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After select_idle_sibling, p->recent_used_cpu is set to the
new target. However on the next wakeup, prev will be the same as
recent_used_cpu unless the load balancer has moved the task since the last
wakeup. It still works, but is less efficient than it can be after all
the changes that went in since that reduce unnecessary migrations, load
balancer changes etc.  This patch preserves recent_used_cpu for longer.

With tbench on a 2-socket CascadeLake machine, 80 logical CPUs, HT enabled

                          5.10.0-rc6             5.10.0-rc6
                 	 baseline-v2           altrecent-v2
Hmean     1        508.39 (   0.00%)      502.05 *  -1.25%*
Hmean     2        986.70 (   0.00%)      983.65 *  -0.31%*
Hmean     4       1914.55 (   0.00%)     1920.24 *   0.30%*
Hmean     8       3702.37 (   0.00%)     3663.96 *  -1.04%*
Hmean     16      6573.11 (   0.00%)     6545.58 *  -0.42%*
Hmean     32     10142.57 (   0.00%)    10253.73 *   1.10%*
Hmean     64     14348.40 (   0.00%)    12506.31 * -12.84%*
Hmean     128    21842.59 (   0.00%)    21967.13 *   0.57%*
Hmean     256    20813.75 (   0.00%)    21534.52 *   3.46%*
Hmean     320    20684.33 (   0.00%)    21070.14 *   1.87%*

The different was marginal except for 64 threads which showed in the
baseline that the result was very unstable where as the patch was much
more stable. This is somewhat machine specific as on a separate 80-cpu
Broadwell machine the same test reported.

                          5.10.0-rc6             5.10.0-rc6
                 	 baseline-v2           altrecent-v2
Hmean     1        310.36 (   0.00%)      291.81 *  -5.98%*
Hmean     2        340.86 (   0.00%)      547.22 *  60.54%*
Hmean     4        912.29 (   0.00%)     1063.21 *  16.54%*
Hmean     8       2116.40 (   0.00%)     2103.60 *  -0.60%*
Hmean     16      4232.90 (   0.00%)     4362.92 *   3.07%*
Hmean     32      8442.03 (   0.00%)     8642.10 *   2.37%*
Hmean     64     11733.91 (   0.00%)    11473.66 *  -2.22%*
Hmean     128    17727.24 (   0.00%)    16784.23 *  -5.32%*
Hmean     256    16089.23 (   0.00%)    16110.79 *   0.13%*
Hmean     320    15992.60 (   0.00%)    16071.64 *   0.49%*

schedstats were not used in this series but from an earlier debugging
effort, the schedstats after the test run were as follows;

Ops SIS Search               5653107942.00  5726545742.00
Ops SIS Domain Search        3365067916.00  3319768543.00
Ops SIS Scanned            112173512543.00 99194352541.00
Ops SIS Domain Scanned     109885472517.00 96787575342.00
Ops SIS Failures             2923185114.00  2950166441.00
Ops SIS Recent Used Hit           56547.00   118064916.00
Ops SIS Recent Used Miss     1590899250.00   354942791.00
Ops SIS Recent Attempts      1590955797.00   473007707.00
Ops SIS Search Efficiency             5.04           5.77
Ops SIS Domain Search Eff             3.06           3.43
Ops SIS Fast Success Rate            40.47          42.03
Ops SIS Success Rate                 48.29          48.48
Ops SIS Recent Success Rate           0.00          24.96

First interesting point is the ridiculous number of times runqueues are
enabled -- almost 97 billion times over the course of 40 minutes

With the patch, "Recent Used Hit" is over 2000 times more likely to
succeed. The failure rate also increases by quite a lot but the cost is
marginal even if the "Fast Success Rate" only increases by 2% overall. What
cannot be observed from these stats is where the biggest impact as these
stats cover low utilisation to over saturation.

If graphed over time, the graphs show that the sched domain is only
scanned at negligible rates until the machine is fully busy. With
low utilisation, the "Fast Success Rate" is almost 100% until the
machine is fully busy. For 320 clients, the success rate is close to
0% which is unsurprising.

Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
---
 kernel/sched/fair.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 23934dbac635..01b38fc17bca 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6274,6 +6274,7 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
 
 	/* Check a recently used CPU as a potential idle candidate: */
 	recent_used_cpu = p->recent_used_cpu;
+	p->recent_used_cpu = prev;
 	if (recent_used_cpu != prev &&
 	    recent_used_cpu != target &&
 	    cpus_share_cache(recent_used_cpu, target) &&
@@ -6765,9 +6766,6 @@ select_task_rq_fair(struct task_struct *p, int prev_cpu, int wake_flags)
 	} else if (wake_flags & WF_TTWU) { /* XXX always ? */
 		/* Fast path */
 		new_cpu = select_idle_sibling(p, prev_cpu, new_cpu);
-
-		if (want_affine)
-			current->recent_used_cpu = cpu;
 	}
 	rcu_read_unlock();
 
-- 
2.26.2

