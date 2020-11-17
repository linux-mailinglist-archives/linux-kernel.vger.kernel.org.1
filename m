Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE63D2B687D
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 16:18:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387583AbgKQPRp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 10:17:45 -0500
Received: from outbound-smtp10.blacknight.com ([46.22.139.15]:38697 "EHLO
        outbound-smtp10.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728883AbgKQPRo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 10:17:44 -0500
Received: from mail.blacknight.com (pemlinmail06.blacknight.ie [81.17.255.152])
        by outbound-smtp10.blacknight.com (Postfix) with ESMTPS id EF6F71C4B70
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 15:17:42 +0000 (GMT)
Received: (qmail 19707 invoked from network); 17 Nov 2020 15:17:42 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.22.4])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 17 Nov 2020 15:17:42 -0000
Date:   Tue, 17 Nov 2020 15:17:40 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>
Subject: Re: [PATCH 3/3] sched/numa: Limit the amount of imbalance that can
 exist at fork time
Message-ID: <20201117151740.GB3371@techsingularity.net>
References: <20201117134222.31482-1-mgorman@techsingularity.net>
 <20201117134222.31482-4-mgorman@techsingularity.net>
 <20201117141814.GN3121392@hirez.programming.kicks-ass.net>
 <CAKfTPtDQgv8RCe1RRCGg0px0Bp6GbdAhXbRKTH5zeVaRDmK+vg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <CAKfTPtDQgv8RCe1RRCGg0px0Bp6GbdAhXbRKTH5zeVaRDmK+vg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 17, 2020 at 03:31:19PM +0100, Vincent Guittot wrote:
> On Tue, 17 Nov 2020 at 15:18, Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Tue, Nov 17, 2020 at 01:42:22PM +0000, Mel Gorman wrote:
> > > -                     if (local_sgs.idle_cpus)
> > > +                     if (local_sgs.idle_cpus >= (sd->span_weight >> 2))
> > >                               return NULL;
> >
> > Is that the same 25% ?
> 
> same question for me

It's the same 25%. It's in the comment as -- utilisation is not too high
where "high" is related to adjust_numa_imbalance.

> could we encapsulate this 25% allowed imbalance like for adjust_numa_imbalance

Using adjust_numa_imbalance() directly in this context would be awkward
but the threshold could be shared with something like the additional
diff below. Is that what you had in mind or something different?

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index adfab218a498..49ef3484c56c 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5878,6 +5878,8 @@ static int wake_affine(struct sched_domain *sd, struct task_struct *p,
 static struct sched_group *
 find_idlest_group(struct sched_domain *sd, struct task_struct *p, int this_cpu);
 
+static inline int numa_imbalance_threshold(int weight);
+
 /*
  * find_idlest_group_cpu - find the idlest CPU among the CPUs in the group.
  */
@@ -8894,7 +8896,7 @@ find_idlest_group(struct sched_domain *sd, struct task_struct *p, int this_cpu)
 			 * If there is a real need of migration, periodic load
 			 * balance will take care of it.
 			 */
-			if (local_sgs.idle_cpus >= (sd->span_weight >> 2))
+			if (local_sgs.idle_cpus >= numa_imbalance_threshold(sd->span_weight))
 				return NULL;
 		}
 
@@ -8998,6 +9000,14 @@ static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sd
 
 #define NUMA_IMBALANCE_MIN 2
 
+/* Allows imbalances until active CPUs hits 25% of a domain */
+#define IMBALANCE_THRESHOLD_SHIFT 2
+
+static inline int numa_imbalance_threshold(int weight)
+{
+	return weight >> IMBALANCE_THRESHOLD_SHIFT;
+}
+
 static inline long adjust_numa_imbalance(int imbalance,
 				int dst_running, int dst_weight)
 {
@@ -9006,8 +9016,10 @@ static inline long adjust_numa_imbalance(int imbalance,
 	 * when the destination is lightly loaded so that pairs of
 	 * communicating tasks may remain local.
 	 */
-	if (dst_running < (dst_weight >> 2) && imbalance <= NUMA_IMBALANCE_MIN)
+	if (dst_running < numa_imbalance_threshold(dst_weight) &&
+	    imbalance <= NUMA_IMBALANCE_MIN) {
 		return 0;
+	}
 
 	return imbalance;
 }

-- 
Mel Gorman
SUSE Labs
