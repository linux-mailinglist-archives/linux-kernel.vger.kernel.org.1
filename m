Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B9022EF0A7
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 11:29:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727434AbhAHK2c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 05:28:32 -0500
Received: from outbound-smtp46.blacknight.com ([46.22.136.58]:36069 "EHLO
        outbound-smtp46.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727105AbhAHK2c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 05:28:32 -0500
Received: from mail.blacknight.com (pemlinmail06.blacknight.ie [81.17.255.152])
        by outbound-smtp46.blacknight.com (Postfix) with ESMTPS id EAAA7FAEA7
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jan 2021 10:27:39 +0000 (GMT)
Received: (qmail 2434 invoked from network); 8 Jan 2021 10:27:39 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.22.4])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 8 Jan 2021 10:27:39 -0000
Date:   Fri, 8 Jan 2021 10:27:38 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     "Li, Aubrey" <aubrey.li@linux.intel.com>,
        vincent.guittot@linaro.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, juri.lelli@redhat.com,
        valentin.schneider@arm.com, qais.yousef@arm.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        tim.c.chen@linux.intel.com, benbjiang@gmail.com
Subject: Re: [RFC][PATCH 1/5] sched/fair: Fix select_idle_cpu()s cost
 accounting
Message-ID: <20210108102738.GB3592@techsingularity.net>
References: <20201214164822.402812729@infradead.org>
 <20201214170017.877557652@infradead.org>
 <c4e31235-e1fb-52ac-99a8-ae943ee0de54@linux.intel.com>
 <20201215075911.GA3040@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20201215075911.GA3040@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 15, 2020 at 08:59:11AM +0100, Peter Zijlstra wrote:
> On Tue, Dec 15, 2020 at 11:36:35AM +0800, Li, Aubrey wrote:
> > On 2020/12/15 0:48, Peter Zijlstra wrote:
> > > We compute the average cost of the total scan, but then use it as a
> > > per-cpu scan cost when computing the scan proportion. Fix this by
> > > properly computing a per-cpu scan cost.
> > > 
> > > This also fixes a bug where we would terminate early (!--nr, case) and
> > > not account that cost at all.
> > 
> > I'm a bit worried this may introduce a regression under heavy load.
> > The overhead of adding another cpu_clock() and calculation becomes 
> > significant when sis_scan is throttled by nr.
> 
> The thing is, the code as it exists today makes no sense what so ever.
> It's plain broken batshit.
> 
> We calculate the total scanning time (irrespective of how many CPUs we
> touched), and then use that calculate the number of cpus to scan. That's
> just daft.
> 
> After this patch we calculate the avg cost of scanning 1 cpu and use
> that to calculate how many cpus to scan. Which is coherent and sane.
> 
> Maybe it can be improved, but that's a completely different thing.

In general I agree with everything you said so lets talk about the last
sentence.

1. avg_scan_cost is now based on the average scan cost of a rq but
   avg_idle is still scaled to the domain size. This is a bit problematic
   because it's comparing scan cost of a single rq with the estimated
   average idle time of a domain. As a result, the scan depth can be much
   larger than it was before the patch and led to some regressions.

2. Accounting for the scan cost of success makes sense but there is a
   big difference between a scan that finds an idle CPU and one that fails.
   For failures, the scan cost is wasted CPU time where as a success
   means that an uncontested CPU is used. This can cause a search to be
   truncated earlier than it should be when the domain is lightly loaded.

The patch below attempts to deal with both of those points. The
remaining difficulty is the "fuzz" factor which is necessary to bring
large avg_idle values into a reasonable range for comparing against
avg_scan_cost. The max avg_idle value can be anything but generally the
ceiling is 2*sysctl_sched_migration_cost. I didn't quickly spot a good way
of mapping avg_idle to a range between 0 and sd->span_weight.  The obvious
one was (weight*avg_idle/(2*sched_migration_cost)) but it did not work very
well as avg_scan_cost accounts for the full cost of accessing a remote rq.
However, this could be revisited later after this series is sorted out.

Anyway, for the enumerated concerns, how about this on top for your
first patch? It seemed to work well for a few workloads on 3 machines
at least and I'd like to nail this down before considering the remaining
patches. The first run indicated that the first patch offset some of the
benefits of the other patches.

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 65a2f208ada8..1e04a250e8ee 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6156,7 +6156,7 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int t
 	cpumask_and(cpus, sched_domain_span(sd), p->cpus_ptr);
 
 	if (sched_feat(SIS_PROP)) {
-		u64 avg_cost, avg_idle, span_avg;
+		u64 avg_cost, avg_idle;
 
 		/*
 		 * Due to large variance we need a large fuzz factor;
@@ -6164,25 +6164,25 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int t
 		 */
 		avg_idle = this_rq()->avg_idle / 512;
 		avg_cost = this_sd->avg_scan_cost + 1;
-
-		span_avg = sd->span_weight * avg_idle;
-		if (span_avg > 4*avg_cost)
-			nr = div_u64(span_avg, avg_cost);
-		else
+		nr = div_u64(avg_idle, avg_cost);
+		if (nr < 4)
 			nr = 4;
 
 		time = cpu_clock(this);
 	}
 
 	for_each_cpu_wrap(cpu, cpus, target) {
-		if (available_idle_cpu(cpu) || sched_idle_cpu(cpu))
+		if (available_idle_cpu(cpu) || sched_idle_cpu(cpu)) {
+			/* Adjust cost of a successful scan */
+			loops <<= 2;
+
 			break;
+		}
 
-		if (loops >= nr) {
+		if (++loops >= nr) {
 			cpu = -1;
 			break;
 		}
-		loops++;
 	}
 
 	if (sched_feat(SIS_PROP)) {

-- 
Mel Gorman
SUSE Labs
