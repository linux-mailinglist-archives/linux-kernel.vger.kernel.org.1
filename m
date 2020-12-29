Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 084652E7149
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Dec 2020 15:16:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726328AbgL2ONV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Dec 2020 09:13:21 -0500
Received: from foss.arm.com ([217.140.110.172]:38678 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726014AbgL2ONV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Dec 2020 09:13:21 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 61E841FB;
        Tue, 29 Dec 2020 06:12:35 -0800 (PST)
Received: from e107158-lin (e107158-lin.cambridge.arm.com [10.1.194.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CF38A3F719;
        Tue, 29 Dec 2020 06:12:33 -0800 (PST)
Date:   Tue, 29 Dec 2020 14:12:31 +0000
From:   Qais Yousef <qais.yousef@arm.com>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
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
Message-ID: <20201229141231.c2ppmjucxxbz5j5h@e107158-lin>
References: <20201202115732.27827-1-frederic@kernel.org>
 <20201202115732.27827-5-frederic@kernel.org>
 <20201228021529.2dlioupobocjcqzk@e107158-lin>
 <20201229134146.GA21613@lothringen>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201229134146.GA21613@lothringen>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/29/20 14:41, Frederic Weisbecker wrote:
> On Mon, Dec 28, 2020 at 02:15:29AM +0000, Qais Yousef wrote:
> > Hi Frederic
> > 
> > On 12/02/20 12:57, Frederic Weisbecker wrote:
> > > @@ -66,9 +68,9 @@ void irqtime_account_irq(struct task_struct *curr)
> > >  	 * in that case, so as not to confuse scheduler with a special task
> > >  	 * that do not consume any time, but still wants to run.
> > >  	 */
> > > -	if (hardirq_count())
> > > +	if (pc & HARDIRQ_MASK)
> > >  		irqtime_account_delta(irqtime, delta, CPUTIME_IRQ);
> > > -	else if (in_serving_softirq() && curr != this_cpu_ksoftirqd())
> > > +	else if ((pc & SOFTIRQ_OFFSET) && curr != this_cpu_ksoftirqd())
> > 
> > Noob question. Why for SOFTIRQs we do sofirq_count() & *SOFTIRQ_OFFSET*? It
> > seems we're in-softirq only if the count is odd numbered.
> > 
> > /me tries to dig more
> > 
> > Hmm could it be because the softirq count is actually 1 bit and the rest is
> > for SOFTIRQ_DISABLE_OFFSET (BH disabled)?
> 
> Exactly!
> 
> > 
> > IOW, 1 bit is for we're in softirq context, and the remaining 7 bits are to
> > count BH disable nesting, right?
> > 
> > I guess this would make sense; we don't nest softirqs processing AFAIK. But
> > I could be misreading the code too :-)
> 
> You got it right!
> 
> This is commented in softirq.c somewhere:
> 
> /*
>  * preempt_count and SOFTIRQ_OFFSET usage:
>  * - preempt_count is changed by SOFTIRQ_OFFSET on entering or leaving
>  *   softirq processing.
>  * - preempt_count is changed by SOFTIRQ_DISABLE_OFFSET (= 2 * SOFTIRQ_OFFSET)
>  *   on local_bh_disable or local_bh_enable.
>  * This lets us distinguish between whether we are currently processing
>  * softirq and whether we just have bh disabled.
>  */
> 
> But we should elaborate on the fact that, indeed, softirq processing can't nest,
> while softirq disablement can. I should try to send a patch and comment more
> thoroughly on the subtleties of preempt mask in preempt.h.

Thanks for the info!

> 
> > 
> > >  		irqtime_account_delta(irqtime, delta, CPUTIME_SOFTIRQ);
> > >  }
> > >  
> > > @@ -417,11 +419,13 @@ void vtime_task_switch(struct task_struct *prev)
> > >  }
> > >  # endif
> > >  
> > > -void vtime_account_irq(struct task_struct *tsk)
> > > +void vtime_account_irq(struct task_struct *tsk, unsigned int offset)
> > >  {
> > > -	if (hardirq_count()) {
> > > +	unsigned int pc = preempt_count() - offset;
> > > +
> > > +	if (pc & HARDIRQ_OFFSET) {
> > 
> > Shouldn't this be HARDIRQ_MASK like above?
> 
> In the rare cases of nested hardirqs happening with broken drivers, Only the outer hardirq
> does matter. All the time spent in the inner hardirqs is included in the outer
> one.

Ah I see. The original code was doing hardirq_count(), which apparently wasn't
right either.

Shouldn't it be pc == HARDIRQ_OFFSET then? All odd nest counts will trigger
this otherwise, and IIUC we want this to trigger once on first entry only.

Thanks

--
Qais Yousef
