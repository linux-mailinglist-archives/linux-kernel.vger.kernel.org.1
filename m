Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 284B82E3393
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Dec 2020 03:16:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726427AbgL1CQU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Dec 2020 21:16:20 -0500
Received: from foss.arm.com ([217.140.110.172]:40338 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726361AbgL1CQT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Dec 2020 21:16:19 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EC1AC1FB;
        Sun, 27 Dec 2020 18:15:33 -0800 (PST)
Received: from e107158-lin (e107158-lin.cambridge.arm.com [10.1.194.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 527AF3F6CF;
        Sun, 27 Dec 2020 18:15:32 -0800 (PST)
Date:   Mon, 28 Dec 2020 02:15:29 +0000
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
Message-ID: <20201228021529.2dlioupobocjcqzk@e107158-lin>
References: <20201202115732.27827-1-frederic@kernel.org>
 <20201202115732.27827-5-frederic@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201202115732.27827-5-frederic@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Frederic

On 12/02/20 12:57, Frederic Weisbecker wrote:
>  #endif /* _LINUX_KERNEL_VTIME_H */
> diff --git a/kernel/sched/cputime.c b/kernel/sched/cputime.c
> index 02163d4260d7..5f611658eeab 100644
> --- a/kernel/sched/cputime.c
> +++ b/kernel/sched/cputime.c
> @@ -44,12 +44,13 @@ static void irqtime_account_delta(struct irqtime *irqtime, u64 delta,
>  }
>  
>  /*
> - * Called before incrementing preempt_count on {soft,}irq_enter
> + * Called after incrementing preempt_count on {soft,}irq_enter
>   * and before decrementing preempt_count on {soft,}irq_exit.
>   */
> -void irqtime_account_irq(struct task_struct *curr)
> +void irqtime_account_irq(struct task_struct *curr, unsigned int offset)
>  {
>  	struct irqtime *irqtime = this_cpu_ptr(&cpu_irqtime);
> +	unsigned int pc;
>  	s64 delta;
>  	int cpu;
>  
> @@ -59,6 +60,7 @@ void irqtime_account_irq(struct task_struct *curr)
>  	cpu = smp_processor_id();
>  	delta = sched_clock_cpu(cpu) - irqtime->irq_start_time;
>  	irqtime->irq_start_time += delta;
> +	pc = preempt_count() - offset;
>  
>  	/*
>  	 * We do not account for softirq time from ksoftirqd here.
> @@ -66,9 +68,9 @@ void irqtime_account_irq(struct task_struct *curr)
>  	 * in that case, so as not to confuse scheduler with a special task
>  	 * that do not consume any time, but still wants to run.
>  	 */
> -	if (hardirq_count())
> +	if (pc & HARDIRQ_MASK)
>  		irqtime_account_delta(irqtime, delta, CPUTIME_IRQ);
> -	else if (in_serving_softirq() && curr != this_cpu_ksoftirqd())
> +	else if ((pc & SOFTIRQ_OFFSET) && curr != this_cpu_ksoftirqd())

Noob question. Why for SOFTIRQs we do sofirq_count() & *SOFTIRQ_OFFSET*? It
seems we're in-softirq only if the count is odd numbered.

/me tries to dig more

Hmm could it be because the softirq count is actually 1 bit and the rest is
for SOFTIRQ_DISABLE_OFFSET (BH disabled)?

IOW, 1 bit is for we're in softirq context, and the remaining 7 bits are to
count BH disable nesting, right?

I guess this would make sense; we don't nest softirqs processing AFAIK. But
I could be misreading the code too :-)

>  		irqtime_account_delta(irqtime, delta, CPUTIME_SOFTIRQ);
>  }
>  
> @@ -417,11 +419,13 @@ void vtime_task_switch(struct task_struct *prev)
>  }
>  # endif
>  
> -void vtime_account_irq(struct task_struct *tsk)
> +void vtime_account_irq(struct task_struct *tsk, unsigned int offset)
>  {
> -	if (hardirq_count()) {
> +	unsigned int pc = preempt_count() - offset;
> +
> +	if (pc & HARDIRQ_OFFSET) {

Shouldn't this be HARDIRQ_MASK like above?

>  		vtime_account_hardirq(tsk);
> -	} else if (in_serving_softirq()) {
> +	} else if (pc & SOFTIRQ_OFFSET) {
>  		vtime_account_softirq(tsk);
>  	} else if (!IS_ENABLED(CONFIG_HAVE_VIRT_CPU_ACCOUNTING_IDLE) &&
>  		   is_idle_task(tsk)) {

Thanks

--
Qais Yousef
