Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A35F42CDCC0
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 18:51:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387646AbgLCRv3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 12:51:29 -0500
Received: from outbound-smtp22.blacknight.com ([81.17.249.190]:59764 "EHLO
        outbound-smtp22.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387485AbgLCRv2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 12:51:28 -0500
Received: from mail.blacknight.com (pemlinmail05.blacknight.ie [81.17.254.26])
        by outbound-smtp22.blacknight.com (Postfix) with ESMTPS id D52C9BAABC
        for <linux-kernel@vger.kernel.org>; Thu,  3 Dec 2020 17:50:35 +0000 (GMT)
Received: (qmail 7026 invoked from network); 3 Dec 2020 17:50:35 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.22.4])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 3 Dec 2020 17:50:35 -0000
Date:   Thu, 3 Dec 2020 17:50:34 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Ziljstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Linux-ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 04/10] sched/fair: Return an idle cpu if one is found
 after a failed search for an idle core
Message-ID: <20201203175034.GX3371@techsingularity.net>
References: <20201203141124.7391-1-mgorman@techsingularity.net>
 <20201203141124.7391-5-mgorman@techsingularity.net>
 <CAKfTPtBMc=3d0nyoCt7_0s_wFyr_kUX3kET4cqesYjQQwLDhYw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <CAKfTPtBMc=3d0nyoCt7_0s_wFyr_kUX3kET4cqesYjQQwLDhYw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 03, 2020 at 05:35:29PM +0100, Vincent Guittot wrote:
> > index fc48cc99b03d..845bc0cd9158 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -6066,6 +6066,7 @@ void __update_idle_core(struct rq *rq)
> >   */
> >  static int select_idle_core(struct task_struct *p, struct sched_domain *sd, int target)
> >  {
> > +       int idle_candidate = -1;
> >         struct cpumask *cpus = this_cpu_cpumask_var_ptr(select_idle_mask);
> >         int core, cpu;
> >
> > @@ -6084,7 +6085,13 @@ static int select_idle_core(struct task_struct *p, struct sched_domain *sd, int
> >                         schedstat_inc(this_rq()->sis_scanned);
> >                         if (!available_idle_cpu(cpu)) {
> >                                 idle = false;
> > -                               break;
> > +                               if (idle_candidate != -1)
> > +                                       break;
> 
> 
> If I get your changes correctly, it will now continue to loop on all
> cpus of the smt mask to try to find an idle cpu whereas it was

That was an oversight, the intent is that the SMT search breaks but
the search for an idle core continues. The patch was taken from a very
different series that unified all the select_idle_* functions as a single
function and I failed to fix it up properly. The unification series
didn't generate good results back 9 months ago when I tried and I never
finished it off. In the current context, it would not make sense to try
a unification again.

> With the change above you might end up looping all cpus of llc if
> there is only one idle cpu in the llc whereas before we were looping
> only 1 cpu per core at most. The bottom change makes sense but the
> above on is in some way replacing completely select_idle_cpu and
> bypass SIS_PROP and we should avoid that IMO
> 

You're right of course, it was never intended to behave like that.

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 0a3d338770c4..49b1590e60a9 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6084,8 +6084,7 @@ static int select_idle_core(struct task_struct *p, struct sched_domain *sd, int
 		for_each_cpu(cpu, cpu_smt_mask(core)) {
 			if (!available_idle_cpu(cpu)) {
 				idle = false;
-				if (idle_candidate != -1)
-					break;
+				break;
 			}
 
 			if (idle_candidate == -1 &&

-- 
Mel Gorman
SUSE Labs
