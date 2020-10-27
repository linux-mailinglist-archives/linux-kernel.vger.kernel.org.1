Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 926E029AA53
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 12:11:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2899032AbgJ0LLi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 07:11:38 -0400
Received: from foss.arm.com ([217.140.110.172]:38390 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2896957AbgJ0LLi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 07:11:38 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9C9AB30E;
        Tue, 27 Oct 2020 04:11:37 -0700 (PDT)
Received: from e107158-lin (e107158-lin.cambridge.arm.com [10.1.194.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 81D973F66E;
        Tue, 27 Oct 2020 04:11:35 -0700 (PDT)
Date:   Tue, 27 Oct 2020 11:11:33 +0000
From:   Qais Yousef <qais.yousef@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Julia Lawall <julia.lawall@inria.fr>,
        Mel Gorman <mgorman@suse.de>, Ingo Molnar <mingo@redhat.com>,
        kernel-janitors@vger.kernel.org,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-kernel@vger.kernel.org,
        Valentin Schneider <valentin.schneider@arm.com>,
        Gilles Muller <Gilles.Muller@inria.fr>,
        srinivas.pandruvada@linux.intel.com
Subject: Re: default cpufreq gov, was: [PATCH] sched/fair: check for idle core
Message-ID: <20201027111133.ajlxn5lbnfeocfgb@e107158-lin>
References: <1603211879-1064-1-git-send-email-Julia.Lawall@inria.fr>
 <20201022071145.GM2628@hirez.programming.kicks-ass.net>
 <20201022104703.nw45dwor6wfn4ity@vireshk-i7>
 <34115486.YmRjPRKJaA@kreacher>
 <20201022120213.GG2611@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201022120213.GG2611@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/22/20 14:02, Peter Zijlstra wrote:
> On Thu, Oct 22, 2020 at 01:45:25PM +0200, Rafael J. Wysocki wrote:
> > On Thursday, October 22, 2020 12:47:03 PM CEST Viresh Kumar wrote:
> > > On 22-10-20, 09:11, Peter Zijlstra wrote:
> > > > Well, but we need to do something to force people onto schedutil,
> > > > otherwise we'll get more crap like this thread.
> > > > 
> > > > Can we take the choice away? Only let Kconfig select which governors are
> > > > available and then set the default ourselves? I mean, the end goal being
> > > > to not have selectable governors at all, this seems like a good step
> > > > anyway.
> > > 
> > > Just to clarify and complete the point a bit here, the users can still
> > > pass the default governor from cmdline using
> > > cpufreq.default_governor=, which will take precedence over the one the
> > > below code is playing with. And later once the kernel is up, they can
> > > still choose a different governor from userspace.
> > 
> > Right.
> > 
> > Also some people simply set "performance" as the default governor and then
> > don't touch cpufreq otherwise (the idea is to get everything to the max
> > freq right away and stay in that mode forever).  This still needs to be
> > possible IMO.
> 
> Performance/powersave make sense to keep.
> 
> However I do want to retire ondemand, conservative and also very much
> intel_pstate/active mode. I also have very little sympathy for
> userspace.

Userspace is useful for testing and sanity checking. Not sure if people use it
to measure voltage/current at each frequency to generate
dynamic-power-coefficient for their platform. Lukasz, Dietmar?

Thanks

--
Qais Yousef

> 
> We should start by making it hard to use them and eventually just delete
> them outright.
> 
