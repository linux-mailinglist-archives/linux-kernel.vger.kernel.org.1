Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F2DD2E1C0A
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Dec 2020 13:04:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728436AbgLWMC6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Dec 2020 07:02:58 -0500
Received: from foss.arm.com ([217.140.110.172]:49412 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728307AbgLWMC5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Dec 2020 07:02:57 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CE243101E;
        Wed, 23 Dec 2020 04:02:11 -0800 (PST)
Received: from e107158-lin (unknown [10.1.194.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5FC9E3F6CF;
        Wed, 23 Dec 2020 04:02:10 -0800 (PST)
Date:   Wed, 23 Dec 2020 12:02:07 +0000
From:   Qais Yousef <qais.yousef@arm.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: Re: sched: Reenable interrupts in do sched_yield()
Message-ID: <20201223120207.csiynjfmzavveesf@e107158-lin>
References: <87r1pt7y5c.fsf@nanos.tec.linutronix.de>
 <20201020113830.378b4a4c@gandalf.local.home>
 <87o8kw93n4.fsf@nanos.tec.linutronix.de>
 <20201020160732.5f8fc24e@oasis.local.home>
 <87h7qo6ntx.fsf@nanos.tec.linutronix.de>
 <20201021100714.5ba25a96@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201021100714.5ba25a96@gandalf.local.home>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/21/20 10:07, Steven Rostedt wrote:
> On Wed, 21 Oct 2020 09:27:22 +0200
> Thomas Gleixner <tglx@linutronix.de> wrote:
> 
> > On Tue, Oct 20 2020 at 16:07, Steven Rostedt wrote:
> > > On Tue, 20 Oct 2020 20:02:55 +0200
> > > Thomas Gleixner <tglx@linutronix.de> wrote:
> > > What I wrote wasn't exactly what I meant. What I meant to have:
> > >
> > > 	/*
> > > 	 * Since we are going to call schedule() anyways, there's
> > > 	 * no need to do the preemption check when the rq_lock is released.
> > > 	 */
> > >
> > > That is, to document why we have the preempt_disable() before the unlock:  
> > 
> > which is pretty obvious, but I let Peter decide on that.
> 
> To us maybe, but I like to have comments that explain why things are done to
> average people. ;-)
> 
> If I go to another kernel developer outside the core kernel, would they know
> why there's a preempt_disable() there?
> 
> 
>  	preempt_disable();
> 	rq_unlock_irq(rq, &rf);
>  	sched_preempt_enable_no_resched();
>  
>  	schedule();
> 
> 
> Not everyone knows that the rq_unlock_irq() would trigger a schedule if an
> interrupt happened as soon as irqs were enabled again and need_resched was
> set.

Sorry a bit late to the party.

Personally, what actually is tripping me off is that rq_unlock_irq() will end
up calling preempt_enable(), and then we do sched_preempt_enable_no_resched().
Was there an earlier preempt_disable() called up in the chain that I couldn't
figure out that's why it's okay to do the 2? Otherwise I see we have imbalanced
preempt_disable/enable.

	preempt_disable()
	rq_unlock_irq()
		__raw_spin_unlock_irq()
			local_irq_enable()
			preempt_enable()	// first preempt_count_dec()
	sched_preempt_enable_no_resched()	// second preempt_count_dec()

Thanks

--
Qais Yousef
