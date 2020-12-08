Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25BB32D2E60
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 16:37:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730101AbgLHPg0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 10:36:26 -0500
Received: from outbound-smtp33.blacknight.com ([81.17.249.66]:60520 "EHLO
        outbound-smtp33.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729334AbgLHPgZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 10:36:25 -0500
Received: from mail.blacknight.com (pemlinmail04.blacknight.ie [81.17.254.17])
        by outbound-smtp33.blacknight.com (Postfix) with ESMTPS id 0AC17BABF5
        for <linux-kernel@vger.kernel.org>; Tue,  8 Dec 2020 15:35:34 +0000 (GMT)
Received: (qmail 11716 invoked from network); 8 Dec 2020 15:35:33 -0000
Received: from unknown (HELO stampy.112glenside.lan) (mgorman@techsingularity.net@[84.203.22.4])
  by 81.17.254.9 with ESMTPA; 8 Dec 2020 15:35:33 -0000
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
Subject: [PATCH 2/4] sched/fair: Move avg_scan_cost calculations under SIS_PROP
Date:   Tue,  8 Dec 2020 15:34:59 +0000
Message-Id: <20201208153501.1467-3-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201208153501.1467-1-mgorman@techsingularity.net>
References: <20201208153501.1467-1-mgorman@techsingularity.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As noted by Vincent Guittot, avg_scan_costs are calculated for SIS_PROP
even if SIS_PROP is disabled. Move the time calculations under a SIS_PROP
check and while we are at it, exclude the cost of initialising the CPU
mask from the average scan cost.

Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
---
 kernel/sched/fair.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index ac7b34e7372b..5c41875aec23 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6153,6 +6153,8 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int t
 	if (!this_sd)
 		return -1;
 
+	cpumask_and(cpus, sched_domain_span(sd), p->cpus_ptr);
+
 	if (sched_feat(SIS_PROP)) {
 		u64 avg_cost, avg_idle, span_avg;
 
@@ -6168,11 +6170,9 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int t
 			nr = div_u64(span_avg, avg_cost);
 		else
 			nr = 4;
-	}
-
-	time = cpu_clock(this);
 
-	cpumask_and(cpus, sched_domain_span(sd), p->cpus_ptr);
+		time = cpu_clock(this);
+	}
 
 	for_each_cpu_wrap(cpu, cpus, target) {
 		if (!--nr)
@@ -6181,8 +6181,10 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int t
 			break;
 	}
 
-	time = cpu_clock(this) - time;
-	update_avg(&this_sd->avg_scan_cost, time);
+	if (sched_feat(SIS_PROP)) {
+		time = cpu_clock(this) - time;
+		update_avg(&this_sd->avg_scan_cost, time);
+	}
 
 	return cpu;
 }
-- 
2.26.2

