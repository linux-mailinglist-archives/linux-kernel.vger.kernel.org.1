Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1875F2DE361
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Dec 2020 14:41:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726316AbgLRNlC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Dec 2020 08:41:02 -0500
Received: from foss.arm.com ([217.140.110.172]:35694 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725911AbgLRNlB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Dec 2020 08:41:01 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ADADC1FB;
        Fri, 18 Dec 2020 05:40:15 -0800 (PST)
Received: from e123083-lin (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A47813F66B;
        Fri, 18 Dec 2020 05:40:13 -0800 (PST)
Date:   Fri, 18 Dec 2020 14:40:07 +0100
From:   Morten Rasmussen <morten.rasmussen@arm.com>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        dietmar.eggemann@arm.com, patrick.bellasi@matbug.net,
        lenb@kernel.org, linux-kernel@vger.kernel.org,
        ionela.voinescu@arm.com, qperret@google.com,
        viresh.kumar@linaro.org
Subject: Re: [PATCH] sched: Add schedutil overview
Message-ID: <20201218133655.GA10123@e123083-lin>
References: <20201218103258.GA3040@hirez.programming.kicks-ass.net>
 <jhjsg83s616.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <jhjsg83s616.mognet@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 18, 2020 at 11:33:09AM +0000, Valentin Schneider wrote:
> On 18/12/20 10:32, Peter Zijlstra wrote:
> > +Schedutil / DVFS
> > +----------------
> > +
> > +Every time the scheduler load tracking is updated (task wakeup, task
> > +migration, time progression) we call out to schedutil to update the hardware
> > +DVFS state.
> > +
> > +The basis is the CPU runqueue's 'running' metric, which per the above it is
> > +the frequency invariant utilization estimate of the CPU. From this we compute
> > +a desired frequency like:
> > +
> > +             max( running, util_est );	if UTIL_EST
> > +  u_cfs := { running;			otherwise
> > +
> > +  u_clamp := clamp( u_cfs, u_min, u_max )
> > +
> > +  u := u_cfs + u_rt + u_irq + u_dl;	[approx. see source for more detail]
> > +
> > +  f_des := min( f_max, 1.25 u * f_max )
> > +
> 
> In schedutil_cpu_util(), uclamp clamps both u_cfs and u_rt. I'm afraid the
> below might just bring more confusion; what do you think?
> 
>                clamp( u_cfs + u_rt, u_min, u_max );      if UCLAMP_TASK
>   u_clamp := { u_cfs + u_rt;                             otherwise
> 
>   u := u_clamp + u_irq + u_dl;	    [approx. see source for more detail]

It is reflecting the code so I think it is worth it. It also fixes the
typo in the original sum (u_cfs -> u_clamp).

> (also, does this need a word about runnable rt tasks => goto max?)

What is actually the intended policy there? I thought it was goto max
unless rt was clamped, but if I read the code correctly in
schedutil_cpu_util() the current policy is only goto max if uclamp isn't
in use at all, including cfs.

The write-up looks good to me.

Reviewed-by: Morten Rasmussen <morten.rasmussen@arm.com>

Morten
