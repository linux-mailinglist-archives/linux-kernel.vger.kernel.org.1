Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB2232F6276
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 14:56:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727063AbhANNyW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 08:54:22 -0500
Received: from outbound-smtp07.blacknight.com ([46.22.139.12]:49409 "EHLO
        outbound-smtp07.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726367AbhANNyV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 08:54:21 -0500
Received: from mail.blacknight.com (pemlinmail03.blacknight.ie [81.17.254.16])
        by outbound-smtp07.blacknight.com (Postfix) with ESMTPS id 063CD1C4983
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 13:53:30 +0000 (GMT)
Received: (qmail 16287 invoked from network); 14 Jan 2021 13:53:29 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.22.4])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 14 Jan 2021 13:53:29 -0000
Date:   Thu, 14 Jan 2021 13:53:28 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Li Aubrey <aubrey.li@linux.intel.com>,
        Qais Yousef <qais.yousef@arm.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 5/5] sched/fair: Merge select_idle_core/cpu()
Message-ID: <20210114135328.GN3592@techsingularity.net>
References: <20210111155047.10657-1-mgorman@techsingularity.net>
 <20210111155047.10657-6-mgorman@techsingularity.net>
 <CAKfTPtDPZA1CdE_t+co4DmvfEUys9OiUdgtessFdQe6dYjo4pg@mail.gmail.com>
 <20210114093543.GM3592@techsingularity.net>
 <CAKfTPtAbQLYgjRTqdpDPwA+1ff2cUtNqOVbd5cGz_cHpZO=9WA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <CAKfTPtAbQLYgjRTqdpDPwA+1ff2cUtNqOVbd5cGz_cHpZO=9WA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 14, 2021 at 02:25:32PM +0100, Vincent Guittot wrote:
> On Thu, 14 Jan 2021 at 10:35, Mel Gorman <mgorman@techsingularity.net> wrote:
> >
> > On Wed, Jan 13, 2021 at 06:03:00PM +0100, Vincent Guittot wrote:
> > > > @@ -6159,16 +6171,29 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int t
> > > >         for_each_cpu_wrap(cpu, cpus, target) {
> > > >                 if (!--nr)
> > > >                         return -1;
> > > > -               if (available_idle_cpu(cpu) || sched_idle_cpu(cpu))
> > > > -                       break;
> > > > +               if (smt) {
> > >
> > > If we want to stay on something similar to the previous behavior, we
> > > want to check on all cores if test_idle_cores is true so nr should be
> > > set to number of cores
> > >
> >
> > I don't think we necessarily want to do that. has_idle_cores is an
> > effective throttling mechanism but it's not perfect. If the full domain
> > is always scanned for a core then there can be excessive scanning in
> 
> But that's what the code is currently doing. Can this change be done
> in another patch so we can check the impact of each change more
> easily?

Ok, when looking at this again instead of just the mail, the flow is;

        int i, cpu, idle_cpu = -1, nr = INT_MAX;
	...
        if (sched_feat(SIS_PROP) && !smt) {
		/* recalculate nr */
	}

The !smt check should mean that core scanning is still scanning the entire
domain. There is no need to make it specific to the core account and we
are already doing the full scan. Throttling that would be a separate patch.

> This patch 5 should focus on merging select_idle_core and
> select_idle_cpu so we keep (almost) the same behavior but each CPU is
> checked only once.
> 

Which I think it's already doing. Main glitch really is that
__select_idle_cpu() shouldn't be taking *idle_cpu as it does not consume
the information.

> > workloads like hackbench which tends to have has_idle_cores return false
> > positives. It becomes important once average busy CPUs is over half of
> > the domain for SMT2.
> >
> > At least with the patch if that change was made, we still would not scan
> > twice going over the same runqueues so it would still be an improvement
> 
> yeah, it's for me the main goal of this patchset with the calculation
> of avg_can_cost being done only when SIS_PROP is true and the remove
> of SIS_AVG
> 
> any changes in the number of cpu/core to loop on is sensitive to
> regression and should be done in a separate patch IMHO
> 

Understood.

-- 
Mel Gorman
SUSE Labs
