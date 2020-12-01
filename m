Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF2722CA176
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 12:36:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730590AbgLALeJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 06:34:09 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:54926 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730583AbgLALeI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 06:34:08 -0500
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1606822406;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=16F09l0ttCem7YxuM0QIDRctBo+tVKI4girmiDzsCN0=;
        b=XOg8lkefm1ilLSeGwkySgonnesJ8YSKTA8kavqsQz5yFaNlwK8VUCXVXA4TLS23wR0Qolr
        +lsC6dtdmRnRWIMI7/OJHg/U8TdyHiZE0XtqDjTReo1p5I8VCtre6G2t/Sir8QTKZqwSWr
        SwQjQbnS8dnC6NKRcBqGn7LICAdxwYlbCN5Epx141FPh5C7UFEJbrc3G9euS460Yk83GHr
        TPCtEU8CIHPVAeKCV1uuXwIAR8JWCEAMMExx5a0w53iD1hcbH/UDg7RqUCHGO5z8oXTB4z
        HJv6c71W1oWgGsQ412ox3MPuxXY+UQ1ytCkwVxpSxn/RF7a6HFFOojpnAnauwA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1606822406;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=16F09l0ttCem7YxuM0QIDRctBo+tVKI4girmiDzsCN0=;
        b=YefYi6+MNut8ffsL9oogVMmvDv9jX1c2WZaSFPMN0TMJcAnXOTIpOQMPvAtlvvt3+Od6YM
        XKKp7uEVAJxxC3Dg==
To:     Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Heiko Carstens <hca@linux.ibm.com>
Subject: Re: [PATCH 4/5] irqtime: Move irqtime entry accounting after irq offset incrementation
In-Reply-To: <20201201092011.GS2414@hirez.programming.kicks-ass.net>
References: <20201201001226.65107-1-frederic@kernel.org> <20201201001226.65107-5-frederic@kernel.org> <20201201092011.GS2414@hirez.programming.kicks-ass.net>
Date:   Tue, 01 Dec 2020 12:33:26 +0100
Message-ID: <87im9lhibd.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 01 2020 at 10:20, Peter Zijlstra wrote:
> On Tue, Dec 01, 2020 at 01:12:25AM +0100, Frederic Weisbecker wrote:
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

Why not making all of this explicit instead of these conditionals?

Thanks,

        tglx


     
