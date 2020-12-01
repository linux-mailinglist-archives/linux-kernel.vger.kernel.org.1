Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BDD12C9D48
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 10:40:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390615AbgLAJVZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 04:21:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390476AbgLAJVH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 04:21:07 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A2C2C0613CF
        for <linux-kernel@vger.kernel.org>; Tue,  1 Dec 2020 01:20:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=dgq+4MNPkXY57/CtpOjPMqTwCmpe7EO+/vNzQu6O7nc=; b=lV1nj8mexXQXXzlqHSkn799Sd4
        B4fTfLUBffYWbKq6/fnZQqg1Mxz+nYbKh5aJueXOU/rW+LOBBKUM2DMAKZ33EflBICpOERNDXJRy/
        q9aM8PXTdSyCbyL7Zmm+D0uj73bnDr0c9b6mgGdPIEnyQdF9QmxPGeFL5bbceIMmNrOcS5bqDHKK2
        sOUZFEhOeke9TOrnwT4iti0HFe6+MBcwgWph4oi8bjkqGneEZgFSt2cw2r678F9DssalGk9ArUxvl
        xkD3fHJoqA16w6YRTzKleVkEvkp7jGAEneikltwij0mgOCNdowJVFSFteoVPcWutDZet8eR4WjxZS
        yV5wf7Cw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kk1pV-0003Et-5I; Tue, 01 Dec 2020 09:20:13 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 49CB2307A5F;
        Tue,  1 Dec 2020 10:20:11 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 34C0C200E0BD9; Tue,  1 Dec 2020 10:20:11 +0100 (CET)
Date:   Tue, 1 Dec 2020 10:20:11 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Frederic Weisbecker <frederic@kernel.org>
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
Message-ID: <20201201092011.GS2414@hirez.programming.kicks-ass.net>
References: <20201201001226.65107-1-frederic@kernel.org>
 <20201201001226.65107-5-frederic@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201201001226.65107-5-frederic@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 01, 2020 at 01:12:25AM +0100, Frederic Weisbecker wrote:
> +static s64 irqtime_get_delta(struct irqtime *irqtime)
>  {
> +	int cpu = smp_processor_id();
>  	s64 delta;
>  
>  	delta = sched_clock_cpu(cpu) - irqtime->irq_start_time;
>  	irqtime->irq_start_time += delta;
>  
> +	return delta;
> +}
> +
> +/* Called after incrementing preempt_count on {soft,}irq_enter */
> +void irqtime_account_enter(struct task_struct *curr)
> +{
> +	struct irqtime *irqtime = this_cpu_ptr(&cpu_irqtime);
> +	u64 delta;
> +
> +	if (!sched_clock_irqtime)
> +		return;
> +
> +	delta = irqtime_get_delta(irqtime);
> +	/*
> +	 * We do not account for softirq time from ksoftirqd here.
> +	 * We want to continue accounting softirq time to ksoftirqd thread
> +	 * in that case, so as not to confuse scheduler with a special task
> +	 * that do not consume any time, but still wants to run.
> +	 */
> +	if ((irq_count() == (SOFTIRQ_OFFSET | HARDIRQ_OFFSET)) &&
> +	    curr != this_cpu_ksoftirqd())
> +		irqtime_account_delta(irqtime, delta, CPUTIME_SOFTIRQ);
> +}
> +
> +/* Called before decrementing preempt_count on {soft,}irq_exit */
> +void irqtime_account_exit(struct task_struct *curr)
> +{
> +	struct irqtime *irqtime = this_cpu_ptr(&cpu_irqtime);
> +	u64 delta;
> +
> +	if (!sched_clock_irqtime)
> +		return;
> +
> +	delta = irqtime_get_delta(irqtime);
>  	/*
>  	 * We do not account for softirq time from ksoftirqd here.
>  	 * We want to continue accounting softirq time to ksoftirqd thread


Urgh...


Why not something like:

void irqtime_account_irq(struct task_struct *curr, unsigned int offset)
{
	struct irqtime *irqtime = this_cpu_ptr(&cpu_irqtime);
	unsigned int pc = preempt_count() - offset;
	s64 delta;
	int cpu;

	if (!sched_clock_irqtime)
		return;

	cpu = smp_processor_id();
	delta = sched_clock_cpu(cpu) - irqtime->irq_start_time;
	irqtime->irq_start_time += delta;

	/*
	 * We do not account for softirq time from ksoftirqd here.
	 * We want to continue accounting softirq time to ksoftirqd thread
	 * in that case, so as not to confuse scheduler with a special task
	 * that do not consume any time, but still wants to run.
	 */
	if (pc & HARDIRQ_MASK)
		irqtime_account_delta(irqtime, delta, CPUTIME_IRQ);
	else if ((pc & SOFTIRQ_OFFSET) && curr != this_cpu_ksoftirqd())
		irqtime_account_delta(irqtime, delta, CPUTIME_SOFTIRQ);
}


