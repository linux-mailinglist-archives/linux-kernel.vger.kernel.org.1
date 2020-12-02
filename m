Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A03E2CC2AA
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 17:46:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730530AbgLBQqQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 11:46:16 -0500
Received: from mx2.suse.de ([195.135.220.15]:50586 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727482AbgLBQqP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 11:46:15 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id DC5D8AD4D;
        Wed,  2 Dec 2020 16:45:33 +0000 (UTC)
Date:   Wed, 2 Dec 2020 16:45:31 +0000
From:   Mel Gorman <mgorman@suse.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        dietmar.eggemann@arm.com, patrick.bellasi@matbug.net,
        lenb@kernel.org, linux-kernel@vger.kernel.org,
        valentin.schneider@arm.com, ionela.voinescu@arm.com,
        qperret@google.com, viresh.kumar@linaro.org
Subject: Re: [RFC] Documentation/scheduler/schedutil.txt
Message-ID: <20201202164531.GA3306@suse.de>
References: <20201120075527.GB2414@hirez.programming.kicks-ass.net>
 <20201202141835.GY3306@suse.de>
 <20201202155452.GK3021@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20201202155452.GK3021@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 02, 2020 at 04:54:52PM +0100, Peter Zijlstra wrote:
> > IIRC, this 32ms is tied to the value of LOAD_AVG_PERIOD and the length
> > of the ewma_sum series below. Might be worth expanding a little further.
> 
> It is LOAD_AVG_PERIOD. Some people (re)generate the PELT tables with a
> different period (16 and 64 are common).
> 
> Not sure what there is to expand; the whole of it is: y^32=0.5. We had
> to pick some half-life period, 32 seemed like a good number.
> 

No issue with the number other than the y^32 is tied to LOAD_AVG_PERIOD.
Again, it's something that someone looking at the source would eventually
figure out so it's probably for the best.

> > > To alleviate this (a default enabled option) UTIL_EST drives an (IIR) EWMA
> > 
> > Expand IIR -- Immediate Impulse Reponse?
> 
> Infinite Impuse Response
> 

Sorry, yes, still worth an expansion.

> > > with the 'running' value on dequeue -- when it is highest. A further default
> > > enabled option UTIL_EST_FASTUP modifies the IIR filter to instantly increase
> > > and only decay on decrease.
> > > 
> > > A further runqueue wide sum (of runnable tasks) is maintained of:
> > > 
> > >   util_est := \Sum_t max( t_running, t_util_est_ewma )
> > > 
> > > For more detail see: kernel/sched/fair.h:util_est_dequeue()
> > > 
> > 
> > It's less obvious what the consequence is unless the reader manages to
> > tie the IO-wait comment in "Schedutil / DVFS" to this section.
> 
> I'm not entirely sure I follow. The purpose of UTIL_EST is to avoid
> ramp-up issues and isn't related to IO-wait boosting.
> 

I mixed up the example. Historically io-wait boosting was one way of
avoiding DVFS ramp-up issues but now that I reread it, it's best to leave
it general like you already have in your current version.

> > Is it worth explicitly mentioning that a key advantage over
> > hardware-based approaches is that schedutil carries utilisation state on
> > CPU migration? You say that it is tracked but it's less obvious why that
> > matters as a pure hardware based approach loses utilisation information
> > about a task once it migrates.
> 
> Not sure that was the exact goal of the document; I set out to describe
> schedutil.
> 

Fair enough, it would simply lead to documentation creep.

> > Even moving note 3 below into this section and expanding it with an
> > example based on HWP would be helpful.
> 
> I might not be the best person to talk about HWP; even though I work for
> Intel I know remarkably little of it. I don't even think I've got a
> machine that has it on.
> 
> Latest version below... I'll probably send it as a patch soon and get it
> merged. We can always muck with it more later.
> 

True. At least any confusion can then be driven by specific questions :)

FWIW, after reading the new version I'll ack the patch when it shows up.

Thanks!

-- 
Mel Gorman
SUSE Labs
