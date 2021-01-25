Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B01D3034F7
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 06:32:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727470AbhAZFbX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 00:31:23 -0500
Received: from outbound-smtp49.blacknight.com ([46.22.136.233]:48943 "EHLO
        outbound-smtp49.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727499AbhAYKV6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 05:21:58 -0500
Received: from mail.blacknight.com (pemlinmail01.blacknight.ie [81.17.254.10])
        by outbound-smtp49.blacknight.com (Postfix) with ESMTPS id B858241C026
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 08:59:10 +0000 (GMT)
Received: (qmail 12105 invoked from network); 25 Jan 2021 08:59:10 -0000
Received: from unknown (HELO stampy.112glenside.lan) (mgorman@techsingularity.net@[84.203.22.4])
  by 81.17.254.9 with ESMTPA; 25 Jan 2021 08:59:10 -0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Li Aubrey <aubrey.li@linux.intel.com>,
        Qais Yousef <qais.yousef@arm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH 2/4] sched/fair: Move avg_scan_cost calculations under SIS_PROP
Date:   Mon, 25 Jan 2021 08:59:07 +0000
Message-Id: <20210125085909.4600-3-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210125085909.4600-1-mgorman@techsingularity.net>
References: <20210125085909.4600-1-mgorman@techsingularity.net>
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
index 9f5682aeda2e..c8d8e185cf3b 100644
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

