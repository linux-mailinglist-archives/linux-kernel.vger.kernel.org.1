Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0BEF2F6764
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 18:23:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727406AbhANRTN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 12:19:13 -0500
Received: from outbound-smtp22.blacknight.com ([81.17.249.190]:33383 "EHLO
        outbound-smtp22.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727291AbhANRTM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 12:19:12 -0500
Received: from mail.blacknight.com (pemlinmail05.blacknight.ie [81.17.254.26])
        by outbound-smtp22.blacknight.com (Postfix) with ESMTPS id 09906BB11A
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 17:18:20 +0000 (GMT)
Received: (qmail 25073 invoked from network); 14 Jan 2021 17:18:19 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.22.4])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 14 Jan 2021 17:18:19 -0000
Date:   Thu, 14 Jan 2021 17:18:18 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Li Aubrey <aubrey.li@linux.intel.com>,
        Qais Yousef <qais.yousef@arm.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 5/5] sched/fair: Merge select_idle_core/cpu()
Message-ID: <20210114171818.GO3592@techsingularity.net>
References: <20210111155047.10657-1-mgorman@techsingularity.net>
 <20210111155047.10657-6-mgorman@techsingularity.net>
 <CAKfTPtDPZA1CdE_t+co4DmvfEUys9OiUdgtessFdQe6dYjo4pg@mail.gmail.com>
 <20210114093543.GM3592@techsingularity.net>
 <CAKfTPtAbQLYgjRTqdpDPwA+1ff2cUtNqOVbd5cGz_cHpZO=9WA@mail.gmail.com>
 <20210114135328.GN3592@techsingularity.net>
 <CAKfTPtCCjsJG8G5EQfdyLgiaQUqZFiapRGtrP8wTP7k-6qvSxQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <CAKfTPtCCjsJG8G5EQfdyLgiaQUqZFiapRGtrP8wTP7k-6qvSxQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 14, 2021 at 04:44:46PM +0100, Vincent Guittot wrote:
> > domain. There is no need to make it specific to the core account and we
> > are already doing the full scan. Throttling that would be a separate patch.
> >
> > > This patch 5 should focus on merging select_idle_core and
> > > select_idle_cpu so we keep (almost) the same behavior but each CPU is
> > > checked only once.
> > >
> >
> > Which I think it's already doing. Main glitch really is that
> > __select_idle_cpu() shouldn't be taking *idle_cpu as it does not consume
> > the information.
> 
>  don't really like the if (smt) else in the for_each_cpu_wrap(cpu,
> cpus, target) loop  because it just looks like we fail to merge idle
> core and idle cpu search loop at the end.
> 

While it's not the best, I did at one point have a series that fully
unified this function and it wasn't pretty.

> But there is probably not much we can do without changing what is
> accounted idle core  search in the avg_scan_cost
> 

Indeed. Maybe in the future it'll make more sense to consolidate it
further but between the depth search and possibly using SIS_PROP core
core searches, we've bigger fish to fry.

Current delta between this series and what is being tested is simply

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 7bfa73de6a8d..ada8faac2e4d 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -7446,7 +7446,6 @@ int sched_cpu_activate(unsigned int cpu)
 #ifdef CONFIG_SCHED_SMT
 	do {
 		int weight = cpumask_weight(cpu_smt_mask(cpu));
-		extern int sched_smt_weight;
 
 		if (weight > sched_smt_weight)
 			sched_smt_weight = weight;
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 84f02abb29e3..6c0f841e9e75 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6006,7 +6006,7 @@ static inline int find_idlest_cpu(struct sched_domain *sd, struct task_struct *p
 	return new_cpu;
 }
 
-static inline int __select_idle_cpu(struct task_struct *p, int core, struct cpumask *cpus, int *idle_cpu)
+static inline int __select_idle_cpu(struct task_struct *p, int core, struct cpumask *cpus)
 {
 	if (available_idle_cpu(core) || sched_idle_cpu(core))
 		return core;
@@ -6080,7 +6080,7 @@ static int select_idle_core(struct task_struct *p, int core, struct cpumask *cpu
 	int cpu;
 
 	if (!static_branch_likely(&sched_smt_present))
-		return __select_idle_cpu(p, core, cpus, idle_cpu);
+		return __select_idle_cpu(p, core, cpus);
 
 	for_each_cpu(cpu, cpu_smt_mask(core)) {
 		if (!available_idle_cpu(cpu)) {
@@ -6120,7 +6120,7 @@ static inline bool test_idle_cores(int cpu, bool def)
 
 static inline int select_idle_core(struct task_struct *p, int core, struct cpumask *cpus, int *idle_cpu)
 {
-	return __select_idle_cpu(p, core, cpus, idle_cpu);
+	return __select_idle_cpu(p, core, cpus);
 }
 
 #endif /* CONFIG_SCHED_SMT */
@@ -6177,7 +6177,7 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int t
 				return i;
 
 		} else {
-			i = __select_idle_cpu(p, cpu, cpus, &idle_cpu);
+			i = __select_idle_cpu(p, cpu, cpus);
 			if ((unsigned int)i < nr_cpumask_bits) {
 				idle_cpu = i;
 				break;
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 12ada79d40f3..29aabe98dd1d 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1107,6 +1107,8 @@ static inline void update_idle_core(struct rq *rq)
 		__update_idle_core(rq);
 }
 
+extern int sched_smt_weight;
+
 #else
 static inline void update_idle_core(struct rq *rq) { }
 #endif
-- 
Mel Gorman
SUSE Labs
