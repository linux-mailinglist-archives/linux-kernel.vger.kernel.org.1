Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 472532D2DF6
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 16:15:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729909AbgLHPNV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 10:13:21 -0500
Received: from outbound-smtp27.blacknight.com ([81.17.249.195]:47794 "EHLO
        outbound-smtp27.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727925AbgLHPNU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 10:13:20 -0500
Received: from mail.blacknight.com (pemlinmail06.blacknight.ie [81.17.255.152])
        by outbound-smtp27.blacknight.com (Postfix) with ESMTPS id A7966CAC7A
        for <linux-kernel@vger.kernel.org>; Tue,  8 Dec 2020 15:12:28 +0000 (GMT)
Received: (qmail 7102 invoked from network); 8 Dec 2020 15:12:28 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.22.4])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 8 Dec 2020 15:12:28 -0000
Date:   Tue, 8 Dec 2020 15:12:26 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Ziljstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Linux-ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 1/4] sched/fair: Remove SIS_AVG_CPU
Message-ID: <20201208151226.GK3371@techsingularity.net>
References: <20201207091516.24683-1-mgorman@techsingularity.net>
 <20201207091516.24683-2-mgorman@techsingularity.net>
 <25a8c4bd-792b-2851-b10a-c4375eb83dfe@arm.com>
 <20201208105900.GG3371@techsingularity.net>
 <CAKfTPtBgo5vCrN87fqKjyaowONLMWeUusLmvE4bmGmDq10+Yrw@mail.gmail.com>
 <20201208133650.GI3371@techsingularity.net>
 <CAKfTPtDbUoVSvnjFrpomvTJD0jCA6vH_Y3LP=csW8fHntOG_6A@mail.gmail.com>
 <20201208135358.GJ3371@techsingularity.net>
 <CAKfTPtCqGXJa=GfpBZk5To-xVWVtVL8YVMab9PoxFN1=vOwTWQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <CAKfTPtCqGXJa=GfpBZk5To-xVWVtVL8YVMab9PoxFN1=vOwTWQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 08, 2020 at 03:47:40PM +0100, Vincent Guittot wrote:
> > I considered it but made the choice to exclude the cost of cpumask_and()
> > from the avg_scan_cost instead. It's minor but when doing the original
> 
> At the cost of a less readable code
> 

Slightly less readable, yes.

> > prototype, I didn't think it was appropriate to count the cpumask
> > clearing as part of the scan cost as it's not directly related.
> 
> hmm... I think it is because the number of loop is directly related to
> the allowed cpus
> 

While that is true, the cost of initialising the map is constant and
what is most important is tracking the scan cost which is variable.
Without SIS_AVG_CPU, the cpumask init can go before SIS_PROP without any
penalty so is this version preferable?

--8<--
sched/fair: Move avg_scan_cost calculations under SIS_PROP

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
