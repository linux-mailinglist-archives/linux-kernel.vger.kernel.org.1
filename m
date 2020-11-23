Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FECD2C0E25
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 15:51:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729077AbgKWOvk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 09:51:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728655AbgKWOvj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 09:51:39 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FB18C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 06:51:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=hCMzoWgM3bgXt1Nn6P6MgFspPwAKaZh1JClev6hLNoE=; b=jmKaUg4HB1ldJg9xSZ1V0AvoRA
        KCvAysd+XRC+mZ2Lbzqpf9909lOGx66xk5Cyy3GbgsQREgKMEd8tX97VazV3BOdZOEtuNkQKIbL7s
        A2Xkq4NGYbJBSg3QbUwDiOTptptZZuuhOGT0LmGJG9ma/d60i6uR6nfmoo88ajvdcsssL577kirto
        ST+wJJ1bpDwOSBG4skqd3zdjhDSLgj13XY4eZPR53hYeQcbFREp5/a0QnG1bEv2jR6Tm7XOBhM85W
        HQ0321RbI9MSEbqKIqpRAlJ09KcPycrhLyXCxZB0T37Zww0dNWlqsoUYYehIGVrYjjosdZzWz6XoL
        4opqzV9Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1khDBj-0001cu-9X; Mon, 23 Nov 2020 14:51:32 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3003D3062EA;
        Mon, 23 Nov 2020 15:51:28 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1ABBA2BD74AAF; Mon, 23 Nov 2020 15:51:28 +0100 (CET)
Date:   Mon, 23 Nov 2020 15:51:28 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        patrick.bellasi@matbug.net, lenb@kernel.org,
        linux-kernel@vger.kernel.org, valentin.schneider@arm.com,
        ionela.voinescu@arm.com, qperret@google.com,
        viresh.kumar@linaro.org
Subject: Re: [RFC] Documentation/scheduler/schedutil.txt
Message-ID: <20201123145128.GS3021@hirez.programming.kicks-ass.net>
References: <20201120075527.GB2414@hirez.programming.kicks-ass.net>
 <31ab5111-8cea-3a95-823e-f3a84476f7d6@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <31ab5111-8cea-3a95-823e-f3a84476f7d6@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 23, 2020 at 10:26:13AM +0100, Dietmar Eggemann wrote:
> On 20/11/2020 08:55, Peter Zijlstra wrote:
> 
> [...]
> 
> > PELT (Per Entity Load Tracking)
> > -------------------------------
> 
> [...]
> 
> > Using this we track 2 key metrics: 'running' and 'runnable'. 'Running'
> > reflects the time an entity spends on the CPU, while 'runnable' reflects the
> > time an entity spends on the runqueue. When there is only a single task these
> > two metrics are the same, but once there is contention for the CPU 'running'
> > will decrease to reflect the fraction of time each task spends on the CPU
> > while 'runnable' will increase to reflect the amount of contention.
> 
> People might find it confusing to map 'running and 'runnable' into the 3
> PELT signals (load_avg, runnable_avg and util_avg) being used in the
> scheduler ... with load_avg being 'runnable' and 'weight' based.

Yeah, but that's for another document, I suppose. much of pelt.c uses
runnable. Also, the comment that goes with struct sched_avg should
explain.

> > For more detail see: kernel/sched/pelt.c
> > 
> > 
> > Frequency- / Heterogeneous Invariance
> > -------------------------------------
> 
> We call 'Heterogeneous Invariance' CPU invariance in chapter 2.3
> Documentation/scheduler/sched-capacity.rst.
> 
> [...]

Fair enough; I've renamed it to match.

> > For more detail see:
> > 
> >  - kernel/sched/pelt.h:update_rq_clock_pelt()
> >  - arch/x86/kernel/smpboot.c:"APERF/MPERF frequency ratio computation."
> 
> drivers/base/arch_topology.c:"f_cur/f_max ratio computation".

I can't seem to find that in any tree near me (I tried tip/master and
next/master)

> > UTIL_EST / UTIL_EST_FASTUP
> > --------------------------
> 
> [...]
> 
> >   util_est := \Sum_t max( t_running, t_util_est_ewma )
> > 
> > For more detail see: kernel/sched/fair.h:util_est_dequeue()
> 
> s/fair.h/fair.c
> 
> > UCLAMP
> > ------
> > 
> > It is possible to set effective u_min and u_max clamps on each task; the
> 
> s/on each task/on each CFS or RT task

Thanks!
