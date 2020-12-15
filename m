Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C9E52DAF08
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 15:37:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728109AbgLOOfj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 09:35:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:45726 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727879AbgLOOfD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 09:35:03 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CBE95207AD;
        Tue, 15 Dec 2020 14:34:16 +0000 (UTC)
Date:   Tue, 15 Dec 2020 09:34:15 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] sched: Prevent raising SCHED_SOFTIRQ when CPU is
 !active
Message-ID: <20201215093415.5b2898ef@gandalf.local.home>
In-Reply-To: <alpine.DEB.2.21.2012151449260.1448@somnus>
References: <20201215104400.9435-1-anna-maria@linutronix.de>
        <20201215111806.GF3040@hirez.programming.kicks-ass.net>
        <alpine.DEB.2.21.2012151449260.1448@somnus>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Dec 2020 15:23:39 +0100 (CET)
Anna-Maria Behnsen <anna-maria@linutronix.de> wrote:

> > > +	/*
> > > +	 * Remove CPU from nohz.idle_cpus_mask to prevent participating in
> > > +	 * load balancing when not active
> > > +	 */
> > > +	nohz_balance_exit_idle(rq);
> > > +
> > >  	set_cpu_active(cpu, false);
> > >  	/*
> > >  	 * We've cleared cpu_active_mask, wait for all preempt-disabled and RCU  
> > 
> > OK, so we must clear the state before !active, because getting an
> > interrupt/softirq after would trigger the badness. And we're guaranteed
> > nothing blocks between them to re-set it.  
> 
> As far as I understood, it is not a problem whether the delete is before or
> after !active. When it is deleted after, the remote CPU will return in
> kick_ilb() because cpu is not idle, because it is running the hotplug
> thread.

I was thinking that disabling it after may also cause some badness. Even if
it does not, I think there's no harm in clearing it just before setting cpu
active to false. And I find that the safer option.

-- Steve
