Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B3472D9831
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 13:46:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439282AbgLNMnM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 07:43:12 -0500
Received: from outbound-smtp55.blacknight.com ([46.22.136.239]:45949 "EHLO
        outbound-smtp55.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2439090AbgLNMnL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 07:43:11 -0500
Received: from mail.blacknight.com (pemlinmail06.blacknight.ie [81.17.255.152])
        by outbound-smtp55.blacknight.com (Postfix) with ESMTPS id 9CB52FB441
        for <linux-kernel@vger.kernel.org>; Mon, 14 Dec 2020 12:42:19 +0000 (GMT)
Received: (qmail 9381 invoked from network); 14 Dec 2020 12:42:19 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.22.4])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 14 Dec 2020 12:42:19 -0000
Date:   Mon, 14 Dec 2020 12:42:17 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        "Li, Aubrey" <aubrey.li@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@suse.de>, Jiang Biao <benbjiang@gmail.com>
Subject: Re: [RFC PATCH v7] sched/fair: select idle cpu from idle cpumask for
 task wakeup
Message-ID: <20201214124217.GA3371@techsingularity.net>
References: <20201209062404.175565-1-aubrey.li@linux.intel.com>
 <20201209143510.GO3371@techsingularity.net>
 <3802e27a-56ed-9495-21b9-7c4277065155@linux.intel.com>
 <20201210113441.GS3371@techsingularity.net>
 <31308700-aa28-b1f7-398e-ee76772b6b87@linux.intel.com>
 <20201210125833.GT3371@techsingularity.net>
 <20201211174442.GU3040@hirez.programming.kicks-ass.net>
 <CAKfTPtB1sRmZAf5MEZOquHg3z7TTriAbqpwVup5xwu42DN2yCA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKfTPtB1sRmZAf5MEZOquHg3z7TTriAbqpwVup5xwu42DN2yCA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 14, 2020 at 10:18:16AM +0100, Vincent Guittot wrote:
> On Fri, 11 Dec 2020 at 18:45, Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Thu, Dec 10, 2020 at 12:58:33PM +0000, Mel Gorman wrote:
> > > The prequisite patch to make that approach work was rejected though
> > > as on its own, it's not very helpful and Vincent didn't like that the
> > > load_balance_mask was abused to make it effective.
> >
> > So last time I poked at all this, I found that using more masks was a
> > performance issue as well due to added cache misses.
> >
> > Anyway, I finally found some time to look at all this, and while reading
> > over the whole SiS crud to refresh the brain came up with the below...
> >
> > It's still naf, but at least it gets rid of a bunch of duplicate
> > scanning and LoC decreases, so it should be awesome. Ofcourse, as
> > always, benchmarks will totally ruin everything, we'll see, I started
> > some.
> >
> > It goes on top of Mel's first two patches (which is about as far as I
> > got)...
> 
> We have several different things that Aubrey and Mel patches are
> trying to achieve:
> 
> Aubrey wants to avoid scanning busy cpus
> - patch works well on busy system: I see a significant benefit with
> hackbench on a lot of group on my 2 nodes * 28 cores * 4 smt
>     hackbench -l 2000 -g 128
> tip 3.334
> w/ patch 2.978 (+12%)
> 

It's still the case that Aubrey's work does not conflict with what Peter
is doing. All that changes is what mask is applied.

Similarly, the p->recent_used_cpu changes I made initially (but got
rejected) reduces scanning. I intend to revisit that to use recent_used_cpu
as a search target because one side-effect of the patch was the siblings
can be used prematurely.

> - Aubey also tried to not scan the cpus which are idle for a short
> duration (when a tick not stopped) but there are problems because not
> stopping a tick doesn't mean a short idle. In fact , something similar
> to find_idlest_group_cpu() should be done in this case but then it's
> no more a fast path search
> 

The crowd most likely to complain about this is Facebook as they have
workloads that prefer deep searches to find idle CPUs.

> Mel wants to minimize looping over the cpus
> -patch 4 is an obvious win on light loaded system because it avoids
> looping twice the cpus mask when some cpus are idle but no core

Peter's patch replaces that entirely which I'm fine with.

> -But patch 3 generates perf régression
>     hackbench -l 2000 -g 1
> tip 12.293
> /w all Mel's patches 15.163 -14%
> /w Aubrey + Mel patches minus patch 3 : 12.788 +3.8% But I think that
> Aubreay's patch doesn't help here. Test without aubrey's patch are
> running
> 
> -he also tried to used load_balance_mask to do something similar to the below
> 

Peter's approach removes load_balance_mask abuse so I think it's a
better approach overall to scanning LLC domains in a single pass. It
needs refinement and a lot of testing but I think it's promising.

> > -static int select_idle_core(struct task_struct *p, struct sched_domain *sd, int target)
> > +static int __select_idle_core(int core, struct cpumask *cpus, int *idle_cpu)
> >  {
> > -       struct cpumask *cpus = this_cpu_cpumask_var_ptr(select_idle_mask);
> > -       int core, cpu;
> > -
> > -       if (!static_branch_likely(&sched_smt_present))
> > -               return -1;
> > -
> > -       if (!test_idle_cores(target, false))
> > -               return -1;
> > -
> > -       cpumask_and(cpus, sched_domain_span(sd), p->cpus_ptr);
> > -
> > -       for_each_cpu_wrap(core, cpus, target) {
> > -               bool idle = true;
> > +       bool idle = true;
> > +       int cpu;
> >
> > -               for_each_cpu(cpu, cpu_smt_mask(core)) {
> > -                       if (!available_idle_cpu(cpu)) {
> > -                               idle = false;
> > -                               break;
> > -                       }
> > +       for_each_cpu(cpu, cpu_smt_mask(core)) {
> > +               if (!available_idle_cpu(cpu)) {
> > +                       idle = false;
> > +                       continue;
> 
> By not breaking on the first not idle cpu of the core, you will
> largely increase the number of loops. On my system, it increases 4
> times from 28 up tu 112
> 

But breaking early will mean that SMT siblings are used prematurely.
However, if SIS_PROP was partially enforced for the idle core scan, it
could limit the search for an idle core once an idle candidate was
discovered.

-- 
Mel Gorman
SUSE Labs
