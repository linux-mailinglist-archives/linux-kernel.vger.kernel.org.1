Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 691DF2CDCCF
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 18:54:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389241AbgLCRw6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 12:52:58 -0500
Received: from outbound-smtp63.blacknight.com ([46.22.136.252]:60717 "EHLO
        outbound-smtp63.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726222AbgLCRw5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 12:52:57 -0500
Received: from mail.blacknight.com (pemlinmail06.blacknight.ie [81.17.255.152])
        by outbound-smtp63.blacknight.com (Postfix) with ESMTPS id 15926FA945
        for <linux-kernel@vger.kernel.org>; Thu,  3 Dec 2020 17:52:06 +0000 (GMT)
Received: (qmail 24498 invoked from network); 3 Dec 2020 17:52:05 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.22.4])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 3 Dec 2020 17:52:05 -0000
Date:   Thu, 3 Dec 2020 17:52:04 +0000
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
Subject: Re: [PATCH 06/10] sched/fair: Clear the target CPU from the cpumask
 of CPUs searched
Message-ID: <20201203175204.GY3371@techsingularity.net>
References: <20201203141124.7391-1-mgorman@techsingularity.net>
 <20201203141124.7391-7-mgorman@techsingularity.net>
 <CAKfTPtDm880Rs7D1xUCQd_X9okqzhgrmCJVhwg90Rt3krq9ytg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <CAKfTPtDm880Rs7D1xUCQd_X9okqzhgrmCJVhwg90Rt3krq9ytg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 03, 2020 at 05:38:03PM +0100, Vincent Guittot wrote:
> On Thu, 3 Dec 2020 at 15:11, Mel Gorman <mgorman@techsingularity.net> wrote:
> >
> > The target CPU is definitely not idle in both select_idle_core and
> > select_idle_cpu. For select_idle_core(), the SMT is potentially
> > checked unnecessarily as the core is definitely not idle if the
> > target is busy. For select_idle_cpu(), the first CPU checked is
> > simply a waste.
> 
> >
> > Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
> > ---
> >  kernel/sched/fair.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 68dd9cd62fbd..1d8f5c4b4936 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -6077,6 +6077,7 @@ static int select_idle_core(struct task_struct *p, struct sched_domain *sd, int
> >                 return -1;
> >
> >         cpumask_and(cpus, sched_domain_span(sd), p->cpus_ptr);
> > +       __cpumask_clear_cpu(target, cpus);
> 
> should clear cpu_smt_mask(target) as we are sure that the core will not be idle
> 

The intent was that the sibling might still be an idle candidate. In
the current draft of the series, I do not even clear this so that the
SMT sibling is considered as an idle candidate. The reasoning is that if
there are no idle cores then an SMT sibling of the target is as good an
idle CPU to select as any.

-- 
Mel Gorman
SUSE Labs
