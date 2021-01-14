Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C69DE2F5D95
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 10:31:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728245AbhANJ33 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 04:29:29 -0500
Received: from outbound-smtp14.blacknight.com ([46.22.139.231]:60521 "EHLO
        outbound-smtp14.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725989AbhANJ31 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 04:29:27 -0500
Received: from mail.blacknight.com (pemlinmail02.blacknight.ie [81.17.254.11])
        by outbound-smtp14.blacknight.com (Postfix) with ESMTPS id 5A0701C45A4
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 09:28:35 +0000 (GMT)
Received: (qmail 15601 invoked from network); 14 Jan 2021 09:28:35 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.22.4])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 14 Jan 2021 09:28:35 -0000
Date:   Thu, 14 Jan 2021 09:28:33 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Li Aubrey <aubrey.li@linux.intel.com>,
        Qais Yousef <qais.yousef@arm.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/5] sched/fair: Make select_idle_cpu() proportional to
 cores
Message-ID: <20210114092833.GL3592@techsingularity.net>
References: <20210111155047.10657-1-mgorman@techsingularity.net>
 <20210111155047.10657-4-mgorman@techsingularity.net>
 <CAKfTPtDjTa24UzNm-_As_OR0dF5V4Tw-7j=doF3kHy3i=q7VCg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <CAKfTPtDjTa24UzNm-_As_OR0dF5V4Tw-7j=doF3kHy3i=q7VCg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 13, 2021 at 05:49:58PM +0100, Vincent Guittot wrote:
> > @@ -7444,11 +7444,20 @@ int sched_cpu_activate(unsigned int cpu)
> >         balance_push_set(cpu, false);
> >
> >  #ifdef CONFIG_SCHED_SMT
> > -       /*
> > -        * When going up, increment the number of cores with SMT present.
> > -        */
> > -       if (cpumask_weight(cpu_smt_mask(cpu)) == 2)
> > -               static_branch_inc_cpuslocked(&sched_smt_present);
> > +       do {
> > +               int weight = cpumask_weight(cpu_smt_mask(cpu));
> > +               extern int sched_smt_weight;
> 
> coding style problem
> 

Presumably you are referring to an extern defined in a C file. That can
move to kernel/sched/sched.h in this patch.

> > <SNIP>
> >  /*
> >   * Scan the LLC domain for idle CPUs; this is dynamically regulated by
> >   * comparing the average scan cost (tracked in sd->avg_scan_cost) against the
> > @@ -6166,10 +6172,12 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int t
> >                 avg_cost = this_sd->avg_scan_cost + 1;
> >
> >                 span_avg = sd->span_weight * avg_idle;
> > -               if (span_avg > 4*avg_cost)
> > +               if (span_avg > sis_min_cores*avg_cost)
> >                         nr = div_u64(span_avg, avg_cost);
> >                 else
> > -                       nr = 4;
> > +                       nr = sis_min_cores;
> > +
> > +               nr *= sched_smt_weight;
> 
> Also,  patch 5 will look at all CPUs of a core in select_idle_core so
> nr will decrement by 1 per core so i don't see the need to multiply by
> sched_smt_weight one patch 5 is applied
> 

It makes sense in the context of this patch but can be removed again in
the last patch and then I think sched_smt_weight only exists in core.c

-- 
Mel Gorman
SUSE Labs
