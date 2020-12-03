Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B7CC2CD8A9
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 15:13:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436625AbgLCOMd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 09:12:33 -0500
Received: from outbound-smtp61.blacknight.com ([46.22.136.249]:34135 "EHLO
        outbound-smtp61.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727378AbgLCOMR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 09:12:17 -0500
Received: from mail.blacknight.com (pemlinmail03.blacknight.ie [81.17.254.16])
        by outbound-smtp61.blacknight.com (Postfix) with ESMTPS id C41A8FA907
        for <linux-kernel@vger.kernel.org>; Thu,  3 Dec 2020 14:11:25 +0000 (GMT)
Received: (qmail 22768 invoked from network); 3 Dec 2020 14:11:25 -0000
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
Subject: [PATCH 05/10] sched/fair: Do not replace recent_used_cpu with the new target
Date:   Thu,  3 Dec 2020 14:11:19 +0000
Message-Id: <20201203141124.7391-6-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201203141124.7391-1-mgorman@techsingularity.net>
References: <20201203141124.7391-1-mgorman@techsingularity.net>
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
                 idlecandidate-v1r10        altrecent-v1r10
Hmean     1        505.67 (   0.00%)      501.34 *  -0.86%*
Hmean     2        974.06 (   0.00%)      981.39 *   0.75%*
Hmean     4       1904.43 (   0.00%)     1926.13 *   1.14%*
Hmean     8       3721.02 (   0.00%)     3799.86 *   2.12%*
Hmean     16      6769.17 (   0.00%)     6938.40 *   2.50%*
Hmean     32     10312.58 (   0.00%)    10632.11 *   3.10%*
Hmean     64     13792.01 (   0.00%)    13670.17 *  -0.88%*
Hmean     128    20963.44 (   0.00%)    21456.33 *   2.35%*
Hmean     256    20335.62 (   0.00%)    21070.24 *   3.61%*
Hmean     320    20147.25 (   0.00%)    20624.92 *   2.37%*

The benefit is marginal, the main impact is on how it affects
p->recent_used_cpu and whether a domain search happens. From the schedstats
patches and schedstat enabled

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

(First interesting point is the ridiculous number of times runqueues are
enabled -- almost 97 billion times over the course of 40 minutes)

Note "Recent Used Hit" is over 2000 times more likely to succeed. The
failure rate also increases by quite a lot but the cost is marginal
even if the "Fast Success Rate" only increases by 2% overall. What
cannot be observed from these stats is where the biggest impact as
these stats cover low utilisation to over saturation.

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
index 845bc0cd9158..68dd9cd62fbd 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6293,6 +6293,7 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
 
 	/* Check a recently used CPU as a potential idle candidate: */
 	recent_used_cpu = p->recent_used_cpu;
+	p->recent_used_cpu = prev;
 	if (recent_used_cpu != prev &&
 	    recent_used_cpu != target &&
 	    cpus_share_cache(recent_used_cpu, target)) {
@@ -6789,9 +6790,6 @@ select_task_rq_fair(struct task_struct *p, int prev_cpu, int wake_flags)
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

