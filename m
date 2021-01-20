Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 215FE2FCE28
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 11:52:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732360AbhATKSV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 05:18:21 -0500
Received: from outbound-smtp53.blacknight.com ([46.22.136.237]:43017 "EHLO
        outbound-smtp53.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729901AbhATJzO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 04:55:14 -0500
Received: from mail.blacknight.com (pemlinmail03.blacknight.ie [81.17.254.16])
        by outbound-smtp53.blacknight.com (Postfix) with ESMTPS id 64190FB168
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 09:54:22 +0000 (GMT)
Received: (qmail 4203 invoked from network); 20 Jan 2021 09:54:22 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.22.4])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 20 Jan 2021 09:54:22 -0000
Date:   Wed, 20 Jan 2021 09:54:20 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Gautham R Shenoy <ego@linux.vnet.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Li Aubrey <aubrey.li@linux.intel.com>,
        Qais Yousef <qais.yousef@arm.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 5/5] sched/fair: Merge select_idle_core/cpu()
Message-ID: <20210120095420.GU3592@techsingularity.net>
References: <20210119112211.3196-1-mgorman@techsingularity.net>
 <20210119112211.3196-6-mgorman@techsingularity.net>
 <20210120083018.GA14462@in.ibm.com>
 <20210120091235.GT3592@techsingularity.net>
 <CAKfTPtBYuxKywCPeEd=vYCu31Ni0=uXoJa4v3ZV_T9J0TsVyhg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <CAKfTPtBYuxKywCPeEd=vYCu31Ni0=uXoJa4v3ZV_T9J0TsVyhg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 20, 2021 at 10:21:47AM +0100, Vincent Guittot wrote:
> On Wed, 20 Jan 2021 at 10:12, Mel Gorman <mgorman@techsingularity.net> wrote:
> >
> > On Wed, Jan 20, 2021 at 02:00:18PM +0530, Gautham R Shenoy wrote:
> > > > @@ -6157,18 +6169,31 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int t
> > > >     }
> > > >
> > > >     for_each_cpu_wrap(cpu, cpus, target) {
> > > > -           if (!--nr)
> > > > -                   return -1;
> > > > -           if (available_idle_cpu(cpu) || sched_idle_cpu(cpu))
> > > > -                   break;
> > > > +           if (smt) {
> > > > +                   i = select_idle_core(p, cpu, cpus, &idle_cpu);
> > > > +                   if ((unsigned int)i < nr_cpumask_bits)
> > > > +                           return i;
> > > > +
> > > > +           } else {
> > > > +                   if (!--nr)
> > > > +                           return -1;
> > > > +                   i = __select_idle_cpu(cpu);
> > > > +                   if ((unsigned int)i < nr_cpumask_bits) {
> > > > +                           idle_cpu = i;
> > > > +                           break;
> > > > +                   }
> > > > +           }
> > > >     }
> > > >
> > > > -   if (sched_feat(SIS_PROP)) {
> > > > +   if (smt)
> > > > +           set_idle_cores(this, false);
> > >
> > > Shouldn't we set_idle_cores(false) only if this was the last idle
> > > core in the LLC ?
> > >
> >
> > That would involve rechecking the cpumask bits that have not been
> > scanned to see if any of them are an idle core. As the existance of idle
> > cores can change very rapidly, it's not worth the cost.
> 
> But don't we reach this point only if we scanned all CPUs and didn't
> find an idle core ?

Yes, but my understanding of Gauthams suggestion was to check if an
idle core found was the last idle core available and set has_idle_cores
to false in that case. I think this would be relatively expensive and
possibly futile as returning the last idle core for this wakeup does not
mean there will be no idle core on the next wakeup as other cores may go
idle between wakeups.

-- 
Mel Gorman
SUSE Labs
