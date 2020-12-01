Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF5AA2CA140
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 12:27:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730547AbgLALYW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 06:24:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:39004 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730442AbgLALYW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 06:24:22 -0500
Received: from localhost (i15-lef02-th2-89-83-198-20.ft.lns.abo.bbox.fr [89.83.198.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ADB53206F9;
        Tue,  1 Dec 2020 11:23:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606821821;
        bh=DJLE8cKq1ofR6jhdOEvqGUxabCZ27pXAnvYOvylkSRE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GBB79V7D2kmEvwhDLFDqSGWzXLv1fHkwMaWoCO/PJUSJwaqrYbb2AkXx44M9Lj04L
         Kb06EYrE+kvXSQCiLMEmN67rEtiivmB+MFtXszdDCWpagiOdjsx6DPYisyyXHWx1Bp
         ATBBeNo+NRN/iJ5hAqurEaaJMNYWCRXRkc89uIS4=
Date:   Tue, 1 Dec 2020 12:23:38 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Heiko Carstens <hca@linux.ibm.com>
Subject: Re: [PATCH 4/5] irqtime: Move irqtime entry accounting after irq
 offset incrementation
Message-ID: <20201201112338.GA72897@lothringen>
References: <20201201001226.65107-1-frederic@kernel.org>
 <20201201001226.65107-5-frederic@kernel.org>
 <20201201092011.GS2414@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201201092011.GS2414@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 01, 2020 at 10:20:11AM +0100, Peter Zijlstra wrote:
> On Tue, Dec 01, 2020 at 01:12:25AM +0100, Frederic Weisbecker wrote:
> > +static s64 irqtime_get_delta(struct irqtime *irqtime)
> >  {
> > +	int cpu = smp_processor_id();
> >  	s64 delta;
> >  
> >  	delta = sched_clock_cpu(cpu) - irqtime->irq_start_time;
> >  	irqtime->irq_start_time += delta;
> >  
> > +	return delta;
> > +}
> > +
> > +/* Called after incrementing preempt_count on {soft,}irq_enter */
> > +void irqtime_account_enter(struct task_struct *curr)
> > +{
> > +	struct irqtime *irqtime = this_cpu_ptr(&cpu_irqtime);
> > +	u64 delta;
> > +
> > +	if (!sched_clock_irqtime)
> > +		return;
> > +
> > +	delta = irqtime_get_delta(irqtime);
> > +	/*
> > +	 * We do not account for softirq time from ksoftirqd here.
> > +	 * We want to continue accounting softirq time to ksoftirqd thread
> > +	 * in that case, so as not to confuse scheduler with a special task
> > +	 * that do not consume any time, but still wants to run.
> > +	 */
> > +	if ((irq_count() == (SOFTIRQ_OFFSET | HARDIRQ_OFFSET)) &&
> > +	    curr != this_cpu_ksoftirqd())
> > +		irqtime_account_delta(irqtime, delta, CPUTIME_SOFTIRQ);
> > +}
> > +
> > +/* Called before decrementing preempt_count on {soft,}irq_exit */
> > +void irqtime_account_exit(struct task_struct *curr)
> > +{
> > +	struct irqtime *irqtime = this_cpu_ptr(&cpu_irqtime);
> > +	u64 delta;
> > +
> > +	if (!sched_clock_irqtime)
> > +		return;
> > +
> > +	delta = irqtime_get_delta(irqtime);
> >  	/*
> >  	 * We do not account for softirq time from ksoftirqd here.
> >  	 * We want to continue accounting softirq time to ksoftirqd thread
> 
> 
> Urgh...
> 
> 
> Why not something like:
> 
> void irqtime_account_irq(struct task_struct *curr, unsigned int offset)
> {
> 	struct irqtime *irqtime = this_cpu_ptr(&cpu_irqtime);
> 	unsigned int pc = preempt_count() - offset;
> 	s64 delta;
> 	int cpu;
> 
> 	if (!sched_clock_irqtime)
> 		return;
> 
> 	cpu = smp_processor_id();
> 	delta = sched_clock_cpu(cpu) - irqtime->irq_start_time;
> 	irqtime->irq_start_time += delta;
> 
> 	/*
> 	 * We do not account for softirq time from ksoftirqd here.
> 	 * We want to continue accounting softirq time to ksoftirqd thread
> 	 * in that case, so as not to confuse scheduler with a special task
> 	 * that do not consume any time, but still wants to run.
> 	 */
> 	if (pc & HARDIRQ_MASK)
> 		irqtime_account_delta(irqtime, delta, CPUTIME_IRQ);
> 	else if ((pc & SOFTIRQ_OFFSET) && curr != this_cpu_ksoftirqd())
> 		irqtime_account_delta(irqtime, delta, CPUTIME_SOFTIRQ);
> }
> 
> 

Right that's better, I'll do that.

Thanks.
