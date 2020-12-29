Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F40A42E70F5
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Dec 2020 14:45:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726529AbgL2Nma (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Dec 2020 08:42:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:46088 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726014AbgL2Nma (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Dec 2020 08:42:30 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 84F2A207C9;
        Tue, 29 Dec 2020 13:41:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609249309;
        bh=VuCd0jLKamgVdSAJt7eqtbZSWTgtjVCH9Kb4LIvXdUg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EwXuJfCTlOipxnh3yuQp3OK9O5o5owwCnVB5XMXTtPqt8hX6J0s1cOVc6QrHIffBR
         5bF72Jq+6thUzJPiATpFWS6m/ZmMp4flgNtEdpR6dWeVkD4kGJ7hvvKOPGtuK1dFmY
         w1oxGWyHGyTRrg1b6b+viQ8WVoeFYn57AkKXjWeHIjyL71ZqMo1GJ+CiNXc7Q+83if
         A4Rx4ZO4ew2fujxMxAEVY1dPQQWYo6XKKOUiLOZ+7uTbsz/kGuLg3Pc0n1YDnfRxag
         OcMQdr/MMH8vkYiZWweD21snsEFEwajy9/tRImyxFQRMNJc0XlXX3ppK6TsgVBhBvu
         kPMxbPzvOkAEg==
Date:   Tue, 29 Dec 2020 14:41:46 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Qais Yousef <qais.yousef@arm.com>
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
Message-ID: <20201229134146.GA21613@lothringen>
References: <20201202115732.27827-1-frederic@kernel.org>
 <20201202115732.27827-5-frederic@kernel.org>
 <20201228021529.2dlioupobocjcqzk@e107158-lin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201228021529.2dlioupobocjcqzk@e107158-lin>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 28, 2020 at 02:15:29AM +0000, Qais Yousef wrote:
> Hi Frederic
> 
> On 12/02/20 12:57, Frederic Weisbecker wrote:
> > @@ -66,9 +68,9 @@ void irqtime_account_irq(struct task_struct *curr)
> >  	 * in that case, so as not to confuse scheduler with a special task
> >  	 * that do not consume any time, but still wants to run.
> >  	 */
> > -	if (hardirq_count())
> > +	if (pc & HARDIRQ_MASK)
> >  		irqtime_account_delta(irqtime, delta, CPUTIME_IRQ);
> > -	else if (in_serving_softirq() && curr != this_cpu_ksoftirqd())
> > +	else if ((pc & SOFTIRQ_OFFSET) && curr != this_cpu_ksoftirqd())
> 
> Noob question. Why for SOFTIRQs we do sofirq_count() & *SOFTIRQ_OFFSET*? It
> seems we're in-softirq only if the count is odd numbered.
> 
> /me tries to dig more
> 
> Hmm could it be because the softirq count is actually 1 bit and the rest is
> for SOFTIRQ_DISABLE_OFFSET (BH disabled)?

Exactly!

> 
> IOW, 1 bit is for we're in softirq context, and the remaining 7 bits are to
> count BH disable nesting, right?
> 
> I guess this would make sense; we don't nest softirqs processing AFAIK. But
> I could be misreading the code too :-)

You got it right!

This is commented in softirq.c somewhere:

/*
 * preempt_count and SOFTIRQ_OFFSET usage:
 * - preempt_count is changed by SOFTIRQ_OFFSET on entering or leaving
 *   softirq processing.
 * - preempt_count is changed by SOFTIRQ_DISABLE_OFFSET (= 2 * SOFTIRQ_OFFSET)
 *   on local_bh_disable or local_bh_enable.
 * This lets us distinguish between whether we are currently processing
 * softirq and whether we just have bh disabled.
 */

But we should elaborate on the fact that, indeed, softirq processing can't nest,
while softirq disablement can. I should try to send a patch and comment more
thoroughly on the subtleties of preempt mask in preempt.h.

> 
> >  		irqtime_account_delta(irqtime, delta, CPUTIME_SOFTIRQ);
> >  }
> >  
> > @@ -417,11 +419,13 @@ void vtime_task_switch(struct task_struct *prev)
> >  }
> >  # endif
> >  
> > -void vtime_account_irq(struct task_struct *tsk)
> > +void vtime_account_irq(struct task_struct *tsk, unsigned int offset)
> >  {
> > -	if (hardirq_count()) {
> > +	unsigned int pc = preempt_count() - offset;
> > +
> > +	if (pc & HARDIRQ_OFFSET) {
> 
> Shouldn't this be HARDIRQ_MASK like above?

In the rare cases of nested hardirqs happening with broken drivers, Only the outer hardirq
does matter. All the time spent in the inner hardirqs is included in the outer
one.

Thanks.

> 
> >  		vtime_account_hardirq(tsk);
> > -	} else if (in_serving_softirq()) {
> > +	} else if (pc & SOFTIRQ_OFFSET) {
> >  		vtime_account_softirq(tsk);
> >  	} else if (!IS_ENABLED(CONFIG_HAVE_VIRT_CPU_ACCOUNTING_IDLE) &&
> >  		   is_idle_task(tsk)) {
> 
> Thanks
> 
> --
> Qais Yousef
