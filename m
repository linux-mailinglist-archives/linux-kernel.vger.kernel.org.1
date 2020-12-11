Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2403F2D8026
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 21:46:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404189AbgLKUpE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 15:45:04 -0500
Received: from outbound-smtp14.blacknight.com ([46.22.139.231]:35967 "EHLO
        outbound-smtp14.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390252AbgLKUoc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 15:44:32 -0500
Received: from mail.blacknight.com (pemlinmail01.blacknight.ie [81.17.254.10])
        by outbound-smtp14.blacknight.com (Postfix) with ESMTPS id 73FA51C3EEB
        for <linux-kernel@vger.kernel.org>; Fri, 11 Dec 2020 20:43:39 +0000 (GMT)
Received: (qmail 16433 invoked from network); 11 Dec 2020 20:43:39 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.22.4])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 11 Dec 2020 20:43:39 -0000
Date:   Fri, 11 Dec 2020 20:43:37 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     "Li, Aubrey" <aubrey.li@linux.intel.com>, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        valentin.schneider@arm.com, qais.yousef@arm.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        tim.c.chen@linux.intel.com, linux-kernel@vger.kernel.org,
        Mel Gorman <mgorman@suse.de>, Jiang Biao <benbjiang@gmail.com>
Subject: Re: [RFC PATCH v7] sched/fair: select idle cpu from idle cpumask for
 task wakeup
Message-ID: <20201211204337.GX3371@techsingularity.net>
References: <20201209062404.175565-1-aubrey.li@linux.intel.com>
 <20201209143510.GO3371@techsingularity.net>
 <3802e27a-56ed-9495-21b9-7c4277065155@linux.intel.com>
 <20201210113441.GS3371@techsingularity.net>
 <31308700-aa28-b1f7-398e-ee76772b6b87@linux.intel.com>
 <20201210125833.GT3371@techsingularity.net>
 <20201211174442.GU3040@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20201211174442.GU3040@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 11, 2020 at 06:44:42PM +0100, Peter Zijlstra wrote:
> On Thu, Dec 10, 2020 at 12:58:33PM +0000, Mel Gorman wrote:
> > The prequisite patch to make that approach work was rejected though
> > as on its own, it's not very helpful and Vincent didn't like that the
> > load_balance_mask was abused to make it effective.
> 
> So last time I poked at all this, I found that using more masks was a
> performance issue as well due to added cache misses.
> 
> Anyway, I finally found some time to look at all this, and while reading
> over the whole SiS crud to refresh the brain came up with the below...
> 
> It's still naf, but at least it gets rid of a bunch of duplicate
> scanning and LoC decreases, so it should be awesome. Ofcourse, as
> always, benchmarks will totally ruin everything, we'll see, I started
> some.
> 
> It goes on top of Mel's first two patches (which is about as far as I
> got)...
> 

It's not free of bugs but it's interesting! The positive aspects are that
it does a single scan, inits select_idle_mask once and caches an idle
candidate when searching for an idle core but in a far cleaner fashion
than what I did.

One bug is in __select_idle_core() though. It's scanning the SMT mask,
not select_idle_mask so it can return an idle candidate that is not in
p->cpus_ptr.

I queued tests anyway to see what it looks like.

There are some other potential caveats.

This is a single pass so when test_idle_cores() is true, __select_idle_core
is used to to check all the siblings even if the core is not idle. That
could have been cut short if __select_idle_core checked *idle_cpu ==
1 and terminated the SMT scan if an idle candidate had already been found.

Second downside is related. If test_idle_cpus() was true but no idle
CPU is found then __select_idle_core has been called enough to scan
the entire domain. In this corner case, the new code does *more* work
because the old code would have failed select_idle_core() quickly and
then select_idle_cpu() would be throttled by SIS_PROP. I think this will
only be noticable in the heavily overloaded case but if the corner case
hits enough then the new code will be slower than the old code for the
over-saturated case (i.e. hackbench with lots of groups).

The third potential downside is that the SMT sibling is not guaranteed to
be checked due to SIS_PROP throttling but in the old code, that would have
been checked by select_idle_smt(). That might result in premature stacking
of runnable tasks on the same CPU. Similarly, as __select_idle_core may
find multiple idle candidates, it will not pick the targets SMT sibling
if it is idle like select_idle_smt would have.

That said, I am skeptical that select_idle_smt() matters all that often.
If select_idle_cpu() has been throttled heavily then the machine is
either over-saturated or was over-saturated in the very recent pass. In
that situation, the chances of the SMT siblings being free is slim.

Each of the downsides could potentially addressed with this untested
mess

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 637f610c7059..260592d143d8 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6061,7 +6061,7 @@ void __update_idle_core(struct rq *rq)
 	rcu_read_unlock();
 }
 
-static int __select_idle_core(int core, struct cpumask *cpus, int *idle_cpu)
+static int __select_idle_core(struct task_struct *p, int core, struct cpumask *cpus, int *idle_cpu)
 {
 	bool idle = true;
 	int cpu;
@@ -6070,9 +6070,11 @@ static int __select_idle_core(int core, struct cpumask *cpus, int *idle_cpu)
 		schedstat_inc(this_rq()->sis_scanned);
 		if (!available_idle_cpu(cpu)) {
 			idle = false;
-			continue;
+			if (*idle_cpu == -1)
+				continue;
+			break;
 		}
-		if (idle_cpu)
+		if (*idle_cpu == -1 && cpumask_test_cpu(cpu, p->cpus_ptr))
 			*idle_cpu = cpu;
 	}
 
@@ -6094,7 +6096,7 @@ static inline bool test_idle_cores(int cpu, bool def)
 	return def;
 }
 
-static inline int __select_idle_core(int core, struct cpumask *cpus, int *idle_cpu)
+static inline int __select_idle_core(struct task_struct *p, int core, struct cpumask *cpus, int *idle_cpu)
 {
 	return -1;
 }
@@ -6142,7 +6144,7 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int t
 
 	for_each_cpu_wrap(cpu, cpus, target) {
 		if (smt) {
-			i = __select_idle_core(cpu, cpus, &idle_cpu);
+			i = __select_idle_core(p, cpu, cpus, &idle_cpu);
 			if ((unsigned)i < nr_cpumask_bits)
 				return i;
 

-- 
Mel Gorman
SUSE Labs
