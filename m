Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48FA42B8250
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 17:54:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727962AbgKRQuT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 11:50:19 -0500
Received: from outbound-smtp17.blacknight.com ([46.22.139.234]:38073 "EHLO
        outbound-smtp17.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726643AbgKRQuT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 11:50:19 -0500
Received: from mail.blacknight.com (pemlinmail01.blacknight.ie [81.17.254.10])
        by outbound-smtp17.blacknight.com (Postfix) with ESMTPS id 0FD321C381C
        for <linux-kernel@vger.kernel.org>; Wed, 18 Nov 2020 16:50:17 +0000 (GMT)
Received: (qmail 22772 invoked from network); 18 Nov 2020 16:50:16 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.22.4])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 18 Nov 2020 16:50:16 -0000
Date:   Wed, 18 Nov 2020 16:50:14 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>
Subject: Re: [PATCH 3/3] sched/numa: Limit the amount of imbalance that can
 exist at fork time
Message-ID: <20201118165014.GD3371@techsingularity.net>
References: <20201117134222.31482-1-mgorman@techsingularity.net>
 <20201117134222.31482-4-mgorman@techsingularity.net>
 <20201117141814.GN3121392@hirez.programming.kicks-ass.net>
 <CAKfTPtDQgv8RCe1RRCGg0px0Bp6GbdAhXbRKTH5zeVaRDmK+vg@mail.gmail.com>
 <20201117151740.GB3371@techsingularity.net>
 <CAKfTPtD27L0Epg7wPzw7G2zDL8XgdVbB45dZEZEsLmuwRp5gcg@mail.gmail.com>
 <20201117172847.GC3371@techsingularity.net>
 <CAKfTPtBdLJzbv0PFbYeveKeF2_+CgRzwexP5g7E5cgirfc6big@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <CAKfTPtBdLJzbv0PFbYeveKeF2_+CgRzwexP5g7E5cgirfc6big@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 18, 2020 at 05:06:32PM +0100, Vincent Guittot wrote:
> > > which would return how much margin remains available before not
> > > allowing the imbalance
> > >
> >
> > Easier to just make it a bool as the available margin is not relevant
> > (yet).
> 
> That's my point, preparing future evolution by providing directly the
> stats struct which have all this information and even more for further
> enhancement and return how much imbalance is still acceptable.
> 
> But this probably means to align numa stats with lb stats to share the
> same struct
> 

That's the problem -- a common struct that both sd-lb and numa balancing
share would be needed for it to make sense. sg_lb_stats and numa_stats are
used to gather only relevant information to the context they are used.
While there could be a baseline common struct with a union of sd-lb and
numa private extentions, it would not necessarily be easier to understand
and unnecessary information would be collected in both contexts. Sure,
that could be special cased too but then you would have to account for
what fields are available and not available in each context.

Without the unification and the consequences of that, the margin
information is not useful *right now*. If that changes, the helper
function could be updated with a demonstration on why using the margin
information helps.

> > @@ -8779,9 +8780,6 @@ find_idlest_group(struct sched_domain *sd, struct task_struct *p, int this_cpu)
> >                         .group_type = group_overloaded,
> >         };
> >
> > -       imbalance = scale_load_down(NICE_0_LOAD) *
> > -                               (sd->imbalance_pct-100) / 100;
> > -
> >         do {
> >                 int local_group;
> >
> > @@ -8835,6 +8833,11 @@ find_idlest_group(struct sched_domain *sd, struct task_struct *p, int this_cpu)
> >         switch (local_sgs.group_type) {
> >         case group_overloaded:
> >         case group_fully_busy:
> > +
> > +               /* Calculate allowed imbalance based on load */
> > +               imbalance = scale_load_down(NICE_0_LOAD) *
> > +                               (sd->imbalance_pct-100) / 100;
> 
> forgot to mention this previously, but this change seems unrelated to
> rest of this patch and could deserve a dedicated patch
> 

I can split it out as a preparation patch. It can be treated as a
trivial micro-optimisation to avoid an unnecessary calculation of the
imbalance for group_overloaded/group_fully_busy. The real motiviation is
to avoid confusing the group_overloaded/group_fully_busy imbalance with
allow_numa_imbalance and thinking they are somehow directly related to
each other.

-- 
Mel Gorman
SUSE Labs
