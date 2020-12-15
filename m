Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1ACB22DAFBD
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 16:08:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729848AbgLOPGw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 10:06:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729908AbgLOPG2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 10:06:28 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABDE3C0617A6
        for <linux-kernel@vger.kernel.org>; Tue, 15 Dec 2020 07:05:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=td1Jjyk7o6mnV+6gPnZkZUH5td29OCvZEoXHsXHktsw=; b=aYXQKUMeF3zOwPl+JyDW7MX5gR
        PqP+aXC9I3VeXXAFfEj6hbwBEAdvr3wd6/7WjfQGo0E0OitPM1/MxUOAx/EtCPyyCm9mimW6/75OE
        zwwDg7svfiIXmCD7EKG91aPvacFRn8hdkUA8LszFRbT+CxIZko+F27F93h8UeDC+aXeETsmzbaFE0
        wWXLE+rROZbSpNmwV9BTE1pG+zGiTUbuyQYQBWIvoQK2NNGAiN63miFq9eS1JHsNi8lbHtMZ7gSrP
        B0jDersmqcxCvymkRFtMiHD5abAp3wKxHYYRx0YwR/jU/Xgixh8W9C5tKgTKTs+MMsTOmbJ1ZkL9S
        ApRGP13Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kpBtL-0003R6-Lg; Tue, 15 Dec 2020 15:05:31 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3F125304D28;
        Tue, 15 Dec 2020 16:05:29 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 283C220325EBF; Tue, 15 Dec 2020 16:05:29 +0100 (CET)
Date:   Tue, 15 Dec 2020 16:05:29 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Anna-Maria Behnsen <anna-maria@linutronix.de>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] sched: Prevent raising SCHED_SOFTIRQ when CPU is !active
Message-ID: <20201215150529.GI3040@hirez.programming.kicks-ass.net>
References: <20201215104400.9435-1-anna-maria@linutronix.de>
 <20201215111806.GF3040@hirez.programming.kicks-ass.net>
 <alpine.DEB.2.21.2012151449260.1448@somnus>
 <20201215093415.5b2898ef@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201215093415.5b2898ef@gandalf.local.home>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 15, 2020 at 09:34:15AM -0500, Steven Rostedt wrote:
> On Tue, 15 Dec 2020 15:23:39 +0100 (CET)
> Anna-Maria Behnsen <anna-maria@linutronix.de> wrote:
> 
> > > > +	/*
> > > > +	 * Remove CPU from nohz.idle_cpus_mask to prevent participating in
> > > > +	 * load balancing when not active
> > > > +	 */
> > > > +	nohz_balance_exit_idle(rq);
> > > > +
> > > >  	set_cpu_active(cpu, false);
> > > >  	/*
> > > >  	 * We've cleared cpu_active_mask, wait for all preempt-disabled and RCU  
> > > 
> > > OK, so we must clear the state before !active, because getting an
> > > interrupt/softirq after would trigger the badness. And we're guaranteed
> > > nothing blocks between them to re-set it.  
> > 
> > As far as I understood, it is not a problem whether the delete is before or
> > after !active. When it is deleted after, the remote CPU will return in
> > kick_ilb() because cpu is not idle, because it is running the hotplug
> > thread.
> 
> I was thinking that disabling it after may also cause some badness. Even if
> it does not, I think there's no harm in clearing it just before setting cpu
> active to false. And I find that the safer option.

The paranoid in me wanted to write it like:

	preempt_disable();
	nohz_balance_exit_idle(rq);
	set_cpu_active(cpu, false);
	preempt_enable();

(or possibly even local_irq_disable), to guarantee we don't hit idle
between them (which could re-set the nohz idle state we just cleared).

But then I gave up :-)
