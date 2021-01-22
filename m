Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 131C3300C9C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 20:36:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730616AbhAVT0U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 14:26:20 -0500
Received: from foss.arm.com ([217.140.110.172]:32964 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729651AbhAVSkY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 13:40:24 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3FA48139F;
        Fri, 22 Jan 2021 10:39:31 -0800 (PST)
Received: from e107158-lin (e107158-lin.cambridge.arm.com [10.1.194.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 943993F719;
        Fri, 22 Jan 2021 10:39:29 -0800 (PST)
Date:   Fri, 22 Jan 2021 18:39:27 +0000
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
Message-ID: <20210122183927.ivqyapttzd6lflwk@e107158-lin>
References: <20210122154600.1722680-1-joel@joelfernandes.org>
 <CAKfTPtAnzhDKXayicDdymWpK1UswfkTaO8vL-WHxVaoj7DaCFw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKfTPtAnzhDKXayicDdymWpK1UswfkTaO8vL-WHxVaoj7DaCFw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/22/21 17:56, Vincent Guittot wrote:
> > ---
> >  kernel/sched/fair.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 04a3ce20da67..fe2dc0024db5 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -8381,7 +8381,7 @@ static bool update_nohz_stats(struct rq *rq, bool force)
> >         if (!cpumask_test_cpu(cpu, nohz.idle_cpus_mask))
> >                 return false;
> >
> > -       if (!force && !time_after(jiffies, rq->last_blocked_load_update_tick))
> > +       if (!force && !time_after(jiffies, rq->last_blocked_load_update_tick + (HZ/20)))
> 
> This condition is there to make sure to update blocked load at most
> once a tick in order to filter newly idle case otherwise the rate
> limit is already done by load balance interval
> This hard coded (HZ/20) looks really like an ugly hack

This was meant as an RFC patch to discuss the problem really.

Joel is seeing update_blocked_averages() taking ~100us. Half of it seems in
processing __update_blocked_fair() and the other half in sugov_update_shared().
So roughly 50us each. Note that each function is calling an iterator in
return. Correct me if my numbers are wrong Joel.

Running on a little core on low frequency these numbers don't look too odd.
So I'm not seeing how we can speed these functions up.

But since update_sg_lb_stats() will end up with multiple calls to
update_blocked_averages() in one go, this latency adds up quickly.

One noticeable factor in Joel's system is the presence of a lot of cgroups.
Which is essentially what makes __update_blocked_fair() expensive, and it seems
to always return something has decayed so we end up with a call to
sugov_update_shared() in every call.

I think we should limit the expensive call to update_blocked_averages() but
I honestly don't know what would be the right way to do it :-/

Or maybe there's another better alternative too..

Thanks

--
Qais Yousef

> 
> >                 return true;
> >
> >         update_blocked_averages(cpu);
> > --
> > 2.30.0.280.ga3ce27912f-goog
> >
