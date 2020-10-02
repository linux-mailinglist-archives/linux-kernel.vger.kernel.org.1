Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5C5D281757
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 18:02:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388022AbgJBQB7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 12:01:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726017AbgJBQB7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 12:01:59 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E18EC0613D0
        for <linux-kernel@vger.kernel.org>; Fri,  2 Oct 2020 09:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=vHBmcqwNTnF0b6ZUSt9U0ET07tREwzNbDSKV+WbLxn4=; b=agc7kUOAO6up5LCA5nFGwvhSmk
        yTfuiklLPEU/quw1eYc+j3hHEfW1OXzjL9bEPygdoIgZUHmC0+Wm0Ml6nKAX7okacG8xUuMzHA2bg
        AEHJ64Ady2DHQOFyjsVFYZzPvmppC8ChtJNQjR4ItWHkz/aIyotmid9mk2iXvZ8REeTUjlU9jxHtt
        GTApTTCr2BCZBdfFIXgrDVhxsVm5sdH3XAfuTAU8GtspBLrVzlLBJG8wCpBpcLJkA1XpXTpGqdOGW
        IXz/QVsLM+6DVFZoTduC7i6JYgyUZCHglS/BsVOdJ4BBUTwY4qoUrguqybjW0BysyvoWsoz0vP8mY
        O9SvfJtg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kONV8-0007aX-To; Fri, 02 Oct 2020 16:01:43 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 7C3373056DE;
        Fri,  2 Oct 2020 18:01:39 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 69CA2203A8F62; Fri,  2 Oct 2020 18:01:39 +0200 (CEST)
Date:   Fri, 2 Oct 2020 18:01:39 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Daniel Bristot de Oliveira <bristot@redhat.com>
Cc:     Juri Lelli <juri.lelli@redhat.com>, Ingo Molnar <mingo@redhat.com>,
        Mark Simmons <msimmons@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/deadline: Unthrottle PI boosted threads while
 enqueuing
Message-ID: <20201002160139.GB2628@hirez.programming.kicks-ass.net>
References: <5076e003450835ec74e6fa5917d02c4fa41687e6.1600170294.git.bristot@redhat.com>
 <20200918060026.GC261845@localhost.localdomain>
 <f4316f5a-eccd-ec96-3f7b-85900f5f3124@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f4316f5a-eccd-ec96-3f7b-85900f5f3124@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 02, 2020 at 05:57:52PM +0200, Daniel Bristot de Oliveira wrote:
> On 9/18/20 8:00 AM, Juri Lelli wrote:
> > Hi Daniel,
> > 
> > On 16/09/20 09:06, Daniel Bristot de Oliveira wrote:
> >> stress-ng has a test (stress-ng --cyclic) that creates a set of threads
> >> under SCHED_DEADLINE with the following parameters:
> >>
> >>     dl_runtime   =  10000 (10 us)
> >>     dl_deadline  = 100000 (100 us)
> >>     dl_period    = 100000 (100 us)
> >>
> >> These parameters are very aggressive. When using a system without HRTICK
> >> set, these threads can easily execute longer than the dl_runtime because
> >> the throttling happens with 1/HZ resolution.
> >>
> >> During the main part of the test, the system works just fine because
> >> the workload does not try to run over the 10 us. The problem happens at
> >> the end of the test, on the exit() path. During exit(), the threads need
> >> to do some cleanups that require real-time mutex locks, mainly those
> >> related to memory management, resulting in this scenario:
> >>
> >> Note: locks are rt_mutexes...
> >>  ------------------------------------------------------------------------
> >>     TASK A:		TASK B:				TASK C:
> >>     activation
> >> 							activation
> >> 			activation
> >>
> >>     lock(a): OK!	lock(b): OK!
> >>     			<overrun runtime>
> >>     			lock(a)
> >>     			-> block (task A owns it)
> >> 			  -> self notice/set throttled
> >>  +--<			  -> arm replenished timer
> >>  |    			switch-out
> >>  |    							lock(b)
> >>  |    							-> <C prio > B prio>
> >>  |    							-> boost TASK B
> >>  |  unlock(a)						switch-out
> >>  |  -> handle lock a to B
> >>  |    -> wakeup(B)
> >>  |      -> B is throttled:
> >>  |        -> do not enqueue
> >>  |     switch-out
> >>  |
> >>  |
> >>  +---------------------> replenishment timer
> >> 			-> TASK B is boosted:
> >> 			  -> do not enqueue
> >>  ------------------------------------------------------------------------
> >>
> >> BOOM: TASK B is runnable but !enqueued, holding TASK C: the system
> >> crashes with hung task C.
> >>
> >> This problem is avoided by removing the throttle state from the boosted
> >> thread while boosting it (by TASK A in the example above), allowing it to
> >> be queued and run boosted.
> >>
> >> The next replenishment will take care of the runtime overrun, pushing
> >> the deadline further away. See the "while (dl_se->runtime <= 0)" on
> >> replenish_dl_entity() for more information.
> >>
> >> Signed-off-by: Daniel Bristot de Oliveira <bristot@redhat.com>
> >> Reported-by: Mark Simmons <msimmons@redhat.com>
> >> Reviewed-by: Juri Lelli <juri.lelli@redhat.com>
> >> Tested-by: Mark Simmons <msimmons@redhat.com>
> >> Cc: Ingo Molnar <mingo@redhat.com>
> >> Cc: Peter Zijlstra <peterz@infradead.org>
> >> Cc: Juri Lelli <juri.lelli@redhat.com>
> >> Cc: Vincent Guittot <vincent.guittot@linaro.org>
> >> Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
> >> Cc: Steven Rostedt <rostedt@goodmis.org>
> >> Cc: Ben Segall <bsegall@google.com>
> >> Cc: Mel Gorman <mgorman@suse.de>
> >> Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
> >> Cc: linux-kernel@vger.kernel.org
> >>
> >> ---
> > 
> > Thanks for this fix.
> > 
> > Acked-by: Juri Lelli <juri.lelli@redhat.com>
> 
> This is a gentle ping... [we are facing this bug in practice :-(].

Sorry, queued now.
