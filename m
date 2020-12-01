Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 388F92CA5CD
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 15:39:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731051AbgLAOg3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 09:36:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:54808 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730932AbgLAOg3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 09:36:29 -0500
Received: from localhost (i15-lef02-th2-89-83-198-20.ft.lns.abo.bbox.fr [89.83.198.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D18FA20757;
        Tue,  1 Dec 2020 14:35:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606833348;
        bh=F8JEtNGtvlTZ8A0qp87qI8ebeMe870vfZW1xNkPFJNk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Fwlz9FStLWpR6p2edL0kMd9f44jHO/k3MeAAKUvdk8qbcLc6FJGCH8LItKlk5mfvB
         4eiZ6OhvDc8N82cQhG4VSgoQLIrzjXn5inIuLj2rSQ24Op/Y3yKHpCyngbxbeW2Mmb
         2aCAG1acYoJgKx+Aq7O/RYKAa16aRKyEW9f3Q3oY=
Date:   Tue, 1 Dec 2020 15:35:45 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
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
Message-ID: <20201201143545.GC72897@lothringen>
References: <20201201001226.65107-1-frederic@kernel.org>
 <20201201001226.65107-5-frederic@kernel.org>
 <20201201092011.GS2414@hirez.programming.kicks-ass.net>
 <87im9lhibd.fsf@nanos.tec.linutronix.de>
 <20201201114026.GB72897@lothringen>
 <87blfdhcp2.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87blfdhcp2.fsf@nanos.tec.linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 01, 2020 at 02:34:49PM +0100, Thomas Gleixner wrote:
> On Tue, Dec 01 2020 at 12:40, Frederic Weisbecker wrote:
> > On Tue, Dec 01, 2020 at 12:33:26PM +0100, Thomas Gleixner wrote:
> >> > 	/*
> >> > 	 * We do not account for softirq time from ksoftirqd here.
> >> > 	 * We want to continue accounting softirq time to ksoftirqd thread
> >> > 	 * in that case, so as not to confuse scheduler with a special task
> >> > 	 * that do not consume any time, but still wants to run.
> >> > 	 */
> >> > 	if (pc & HARDIRQ_MASK)
> >> > 		irqtime_account_delta(irqtime, delta, CPUTIME_IRQ);
> >> > 	else if ((pc & SOFTIRQ_OFFSET) && curr != this_cpu_ksoftirqd())
> >> > 		irqtime_account_delta(irqtime, delta, CPUTIME_SOFTIRQ);
> >> > }
> >> 
> >> Why not making all of this explicit instead of these conditionals?
> >
> > Hmm, I'm not sure I get what you suggest?
> 
> Instead of playing games with preeempt count and offsets and checking
> for ksoftirqd, can't you just have:
> 
>         account_hardirqtime()
>         account_softirqtime()
> 
> and call them from the right spots. See the below for illustration (it's
> obviously incomplete).
> 
> Thanks,
> 
>         tglx
> ---
> --- a/kernel/softirq.c
> +++ b/kernel/softirq.c
> @@ -377,6 +377,7 @@ static inline void invoke_softirq(void)
>  		return;
>  
>  	if (!force_irqthreads) {
> +		account_softirq_enter_time(current);
>  #ifdef CONFIG_HAVE_IRQ_EXIT_ON_IRQ_STACK
>  		/*
>  		 * We can safely execute softirq on the current stack if
> @@ -391,6 +392,7 @@ static inline void invoke_softirq(void)
>  		 * to prevent from any overrun.
>  		 */
>  		do_softirq_own_stack();
> +		account_softirq_exit_time(current);

Indeed for the softirq part it simplifies things.


>  #endif
>  	} else {
>  		wakeup_softirqd();
> @@ -417,7 +419,7 @@ static inline void __irq_exit_rcu(void)
>  #else
>  	lockdep_assert_irqs_disabled();
>  #endif
> -	account_irq_exit_time(current);
> +	account_hardirq_exit_time(current);

And that one too makes things simple. But note that

    account_hardirq_enter_time()

will still need some preempt count checks to see if
this is a nested hardirq, a hardirq interrupting a softirq
or a hardirq interrupting a task.

But I think it's a win in the end. I'll try that.

Thanks.

>  	preempt_count_sub(HARDIRQ_OFFSET);
>  	if (!in_interrupt() && local_softirq_pending())
>  		invoke_softirq();
