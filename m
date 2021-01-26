Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01DDD304602
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 19:11:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394109AbhAZSKN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 13:10:13 -0500
Received: from foss.arm.com ([217.140.110.172]:47348 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390025AbhAZQhc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 11:37:32 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 125C431B;
        Tue, 26 Jan 2021 08:36:46 -0800 (PST)
Received: from e107158-lin (unknown [10.1.194.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 65A983F66E;
        Tue, 26 Jan 2021 08:36:44 -0800 (PST)
Date:   Tue, 26 Jan 2021 16:36:41 +0000
From:   Qais Yousef <qais.yousef@arm.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Paul McKenney <paulmck@kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Dietmar Eggeman <dietmar.eggemann@arm.com>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mel Gorman <mgorman@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH] sched/fair: Rate limit calls to
 update_blocked_averages() for NOHZ
Message-ID: <20210126163641.2cptgrksaeefitzw@e107158-lin>
References: <20210122154600.1722680-1-joel@joelfernandes.org>
 <CAKfTPtAnzhDKXayicDdymWpK1UswfkTaO8vL-WHxVaoj7DaCFw@mail.gmail.com>
 <20210122183927.ivqyapttzd6lflwk@e107158-lin>
 <CAKfTPtA=Cv3N6EQ7UcgeUsRaAMy7U242xzH+rfJJzE73bYFZ5A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKfTPtA=Cv3N6EQ7UcgeUsRaAMy7U242xzH+rfJJzE73bYFZ5A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/25/21 14:23, Vincent Guittot wrote:
> On Fri, 22 Jan 2021 at 19:39, Qais Yousef <qais.yousef@arm.com> wrote:
> >
> > On 01/22/21 17:56, Vincent Guittot wrote:
> > > > ---
> > > >  kernel/sched/fair.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > > > index 04a3ce20da67..fe2dc0024db5 100644
> > > > --- a/kernel/sched/fair.c
> > > > +++ b/kernel/sched/fair.c
> > > > @@ -8381,7 +8381,7 @@ static bool update_nohz_stats(struct rq *rq, bool force)
> > > >         if (!cpumask_test_cpu(cpu, nohz.idle_cpus_mask))
> > > >                 return false;
> > > >
> > > > -       if (!force && !time_after(jiffies, rq->last_blocked_load_update_tick))
> > > > +       if (!force && !time_after(jiffies, rq->last_blocked_load_update_tick + (HZ/20)))
> > >
> > > This condition is there to make sure to update blocked load at most
> > > once a tick in order to filter newly idle case otherwise the rate
> > > limit is already done by load balance interval
> > > This hard coded (HZ/20) looks really like an ugly hack
> >
> > This was meant as an RFC patch to discuss the problem really.
> >
> > Joel is seeing update_blocked_averages() taking ~100us. Half of it seems in
> > processing __update_blocked_fair() and the other half in sugov_update_shared().
> > So roughly 50us each. Note that each function is calling an iterator in
> 
> Can I assume that a freq change happens if sugov_update_shared() takes 50us ?
> which would mean that the update was useful at the end ?

I couldn't reproduce his problem on Juno. But I think it is not actually doing
any frequency update. sugov_update_shared() is rate limited by
sugov_should_update_freq(). Joel has a 1ms rate limit for schedutil in sysfs.
The function traces showed that it is continuously doing the full scan which
indicates that sugov_update_next_freq() is continuously bailing out at

	if else (sg_policy->next_freq == next_freq)
		return false;

> 
> > return. Correct me if my numbers are wrong Joel.
> >
> > Running on a little core on low frequency these numbers don't look too odd.
> > So I'm not seeing how we can speed these functions up.
> >
> > But since update_sg_lb_stats() will end up with multiple calls to
> > update_blocked_averages() in one go, this latency adds up quickly.
> >
> > One noticeable factor in Joel's system is the presence of a lot of cgroups.
> > Which is essentially what makes __update_blocked_fair() expensive, and it seems
> > to always return something has decayed so we end up with a call to
> > sugov_update_shared() in every call.
> >
> > I think we should limit the expensive call to update_blocked_averages() but
> 
> At the opposite, some will complain that block values  stay stall to
> high value and prevent any useful adjustment.
> 
> Also update_blocked average is already rate limited with idle and busy
> load_balance
> 
> Seems like the problem raised by Joel is the number of newly idle load balance

It could be. When Joel comments out the update_blocked_averages() or rate limit
it the big schedule delay disappears. Which is just an indication of where we
could do better. Either by making update_blocked_averages() faster, or control
how often we do it in a row. I thought the latter made more sense - though
implementation wise I'm not sure how we should do that.

We might actually help update_blocked_averages() being a bit faster by not
doing cpufreq_update_util() in every call and do it once in the last call to
update_blocked_averages(). Since it seemed the for_each_leaf_cfs_rq_safe() loop
in __update_blocked_fair() is expensive too, not sure if reducing the calls to
cpufreq_update_util() will be enough.

Thanks

--
Qais Yousef
