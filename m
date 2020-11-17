Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7786A2B6BB9
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 18:30:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727327AbgKQR2v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 12:28:51 -0500
Received: from outbound-smtp08.blacknight.com ([46.22.139.13]:40101 "EHLO
        outbound-smtp08.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726174AbgKQR2u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 12:28:50 -0500
Received: from mail.blacknight.com (pemlinmail06.blacknight.ie [81.17.255.152])
        by outbound-smtp08.blacknight.com (Postfix) with ESMTPS id CF71D1C3431
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 17:28:48 +0000 (GMT)
Received: (qmail 23366 invoked from network); 17 Nov 2020 17:28:48 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.22.4])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 17 Nov 2020 17:28:48 -0000
Date:   Tue, 17 Nov 2020 17:28:47 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>
Subject: Re: [PATCH 3/3] sched/numa: Limit the amount of imbalance that can
 exist at fork time
Message-ID: <20201117172847.GC3371@techsingularity.net>
References: <20201117134222.31482-1-mgorman@techsingularity.net>
 <20201117134222.31482-4-mgorman@techsingularity.net>
 <20201117141814.GN3121392@hirez.programming.kicks-ass.net>
 <CAKfTPtDQgv8RCe1RRCGg0px0Bp6GbdAhXbRKTH5zeVaRDmK+vg@mail.gmail.com>
 <20201117151740.GB3371@techsingularity.net>
 <CAKfTPtD27L0Epg7wPzw7G2zDL8XgdVbB45dZEZEsLmuwRp5gcg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <CAKfTPtD27L0Epg7wPzw7G2zDL8XgdVbB45dZEZEsLmuwRp5gcg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 17, 2020 at 04:53:10PM +0100, Vincent Guittot wrote:
> On Tue, 17 Nov 2020 at 16:17, Mel Gorman <mgorman@techsingularity.net> wrote:
> >
> > On Tue, Nov 17, 2020 at 03:31:19PM +0100, Vincent Guittot wrote:
> > > On Tue, 17 Nov 2020 at 15:18, Peter Zijlstra <peterz@infradead.org> wrote:
> > > >
> > > > On Tue, Nov 17, 2020 at 01:42:22PM +0000, Mel Gorman wrote:
> > > > > -                     if (local_sgs.idle_cpus)
> > > > > +                     if (local_sgs.idle_cpus >= (sd->span_weight >> 2))
> > > > >                               return NULL;
> > > >
> > > > Is that the same 25% ?
> > >
> > > same question for me
> >
> > It's the same 25%. It's in the comment as -- utilisation is not too high
> 
> utilization is misleading, it usually refers to pelt utilization
> whereas whet you check is the number of busy cpus
> 

Will fix.

> > where "high" is related to adjust_numa_imbalance.
> >
> > > could we encapsulate this 25% allowed imbalance like for adjust_numa_imbalance
> >
> > Using adjust_numa_imbalance() directly in this context would be awkward
> 
> Would be good to use the same function to say if we allow or not the imbalance
> 
> something like numa_allow_imbalance(sg_lb_stats * group_stats)
> 

Also can be done.

> which would return how much margin remains available before not
> allowing the imbalance
> 

Easier to just make it a bool as the available margin is not relevant
(yet).

> 
> > but the threshold could be shared with something like the additional
> > diff below. Is that what you had in mind or something different?
> >
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index adfab218a498..49ef3484c56c 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -5878,6 +5878,8 @@ static int wake_affine(struct sched_domain *sd, struct task_struct *p,
> >  static struct sched_group *
> >  find_idlest_group(struct sched_domain *sd, struct task_struct *p, int this_cpu);
> >
> > +static inline int numa_imbalance_threshold(int weight);
> > +
> >  /*
> >   * find_idlest_group_cpu - find the idlest CPU among the CPUs in the group.
> >   */
> > @@ -8894,7 +8896,7 @@ find_idlest_group(struct sched_domain *sd, struct task_struct *p, int this_cpu)
> >                          * If there is a real need of migration, periodic load
> >                          * balance will take care of it.
> >                          */
> > -                       if (local_sgs.idle_cpus >= (sd->span_weight >> 2))
> 
> also here you use idle_cpus and on the other part you use nr_running.
> Can't we use the same metrics on both sides?
> 

We can. Basing it on sum_nr_running is only an approximation of the number
of busy CPUs if tasks are bound to a subset of CPUs but it would mean that
the fork spreading decision is in line with adjust_numa_imbalance(). That
is a sensible starting point and we could pass in
(sd->span_weight - local_sgs.idle_cpus into numa_allow_imbalance()) if
there was strong justification for it.

Untested patch currently looks like

---
 kernel/sched/fair.c | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 33709dfac24d..4c8a3b570b0a 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1550,6 +1550,7 @@ struct task_numa_env {
 static unsigned long cpu_load(struct rq *rq);
 static unsigned long cpu_runnable(struct rq *rq);
 static unsigned long cpu_util(int cpu);
+static inline bool allow_numa_imbalance(int dst_running, int dst_weight);
 static inline long adjust_numa_imbalance(int imbalance,
 					int dst_running, int dst_weight);
 
@@ -8779,9 +8780,6 @@ find_idlest_group(struct sched_domain *sd, struct task_struct *p, int this_cpu)
 			.group_type = group_overloaded,
 	};
 
-	imbalance = scale_load_down(NICE_0_LOAD) *
-				(sd->imbalance_pct-100) / 100;
-
 	do {
 		int local_group;
 
@@ -8835,6 +8833,11 @@ find_idlest_group(struct sched_domain *sd, struct task_struct *p, int this_cpu)
 	switch (local_sgs.group_type) {
 	case group_overloaded:
 	case group_fully_busy:
+
+		/* Calculate allowed imbalance based on load */
+		imbalance = scale_load_down(NICE_0_LOAD) *
+				(sd->imbalance_pct-100) / 100;
+
 		/*
 		 * When comparing groups across NUMA domains, it's possible for
 		 * the local domain to be very lightly loaded relative to the
@@ -8891,7 +8894,7 @@ find_idlest_group(struct sched_domain *sd, struct task_struct *p, int this_cpu)
 			 * a real need of migration, periodic load balance will
 			 * take care of it.
 			 */
-			if (local_sgs.idle_cpus)
+			if (allow_numa_imbalance(local_sgs.sum_nr_running, sd->span_weight))
 				return NULL;
 		}
 
@@ -8995,9 +8998,22 @@ static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sd
 
 #define NUMA_IMBALANCE_MIN 2
 
+/*
+ * Allow a NUMA imbalance if busy CPUs is less than 25% of the domain.
+ * This is an approximation as the number of running tasks may not be
+ * related to the number of busy CPUs due to sched_setaffinity.
+ */
+static inline bool allow_numa_imbalance(int dst_running, int dst_weight)
+{
+	return (dst_running < (dst_weight >> 2));
+}
+
 static inline long adjust_numa_imbalance(int imbalance,
 				int dst_running, int dst_weight)
 {
+	if (!allow_numa_imbalance(dst_running, dst_weight))
+		return imbalance;
+
 	/*
 	 * Allow a small imbalance based on a simple pair of communicating
 	 * when the destination is lightly loaded so that pairs of
