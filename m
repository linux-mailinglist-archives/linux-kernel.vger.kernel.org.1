Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31E1C2D2C16
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 14:38:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729433AbgLHNho (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 08:37:44 -0500
Received: from outbound-smtp22.blacknight.com ([81.17.249.190]:47662 "EHLO
        outbound-smtp22.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729020AbgLHNho (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 08:37:44 -0500
Received: from mail.blacknight.com (pemlinmail02.blacknight.ie [81.17.254.11])
        by outbound-smtp22.blacknight.com (Postfix) with ESMTPS id 4F803BABD7
        for <linux-kernel@vger.kernel.org>; Tue,  8 Dec 2020 13:36:52 +0000 (GMT)
Received: (qmail 32152 invoked from network); 8 Dec 2020 13:36:52 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.22.4])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 8 Dec 2020 13:36:52 -0000
Date:   Tue, 8 Dec 2020 13:36:50 +0000
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
Message-ID: <20201208133650.GI3371@techsingularity.net>
References: <20201207091516.24683-1-mgorman@techsingularity.net>
 <20201207091516.24683-2-mgorman@techsingularity.net>
 <25a8c4bd-792b-2851-b10a-c4375eb83dfe@arm.com>
 <20201208105900.GG3371@techsingularity.net>
 <CAKfTPtBgo5vCrN87fqKjyaowONLMWeUusLmvE4bmGmDq10+Yrw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <CAKfTPtBgo5vCrN87fqKjyaowONLMWeUusLmvE4bmGmDq10+Yrw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 08, 2020 at 02:24:32PM +0100, Vincent Guittot wrote:
> > > Nitpick:
> > >
> > > Since now avg_cost and avg_idle are only used w/ SIS_PROP, they could go
> > > completely into the SIS_PROP if condition.
> > >
> >
> > Yeah, I can do that. In the initial prototype, that happened in a
> > separate patch that split out SIS_PROP into a helper function and I
> > never merged it back. It's a trivial change.
> 
> while doing this, should you also put the update of
> this_sd->avg_scan_cost under the SIS_PROP feature ?
> 

It's outside the scope of the series but why not. This?

--8<--
sched/fair: Move avg_scan_cost calculations under SIS_PROP

As noted by Vincent Guittot, avg_scan_costs are calculated for SIS_PROP
even if SIS_PROP is disabled. Move the time calculations under a SIS_PROP
check and while we are at it, exclude the cost of initialising the CPU
mask from the average scan cost.

Signed-off-by: Mel Gorman <mgorman@techsingularity.net>

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 19ca0265f8aa..0fee53b1aae4 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6176,10 +6176,10 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int t
 			nr = 4;
 	}
 
-	time = cpu_clock(this);
-
 	cpumask_and(cpus, sched_domain_span(sd), p->cpus_ptr);
 
+	if (sched_feat(SIS_PROP))
+		time = cpu_clock(this);
 	for_each_cpu_wrap(cpu, cpus, target) {
 		if (!--nr)
 			return -1;
@@ -6187,8 +6187,10 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int t
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
