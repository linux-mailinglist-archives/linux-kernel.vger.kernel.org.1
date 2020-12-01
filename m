Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC1842CA1AC
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 12:42:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388138AbgLALlL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 06:41:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:50220 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730664AbgLALlK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 06:41:10 -0500
Received: from localhost (i15-lef02-th2-89-83-198-20.ft.lns.abo.bbox.fr [89.83.198.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6479A2084C;
        Tue,  1 Dec 2020 11:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606822830;
        bh=iYw6lui6dDC7149K260wkncZlQ2NhDrpOG50v8ppeuc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XwwB5LDYujcEWEQX5bJAoiD9ry3JwtOpEtLoy/773Jf/NjiHpC8gZEmPzblT9dYaG
         JPNj/WuZ+HkVZrtA3VIi+Ey9bI9DPDVSeiuKzPq3g3cYv+WeeK8dHaGP/w4Hh8bxeb
         TfQ9Vz41GrJqSKzFNWtTKV1yj4ZFdVu4ASdGAlbY=
Date:   Tue, 1 Dec 2020 12:40:26 +0100
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
Message-ID: <20201201114026.GB72897@lothringen>
References: <20201201001226.65107-1-frederic@kernel.org>
 <20201201001226.65107-5-frederic@kernel.org>
 <20201201092011.GS2414@hirez.programming.kicks-ass.net>
 <87im9lhibd.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87im9lhibd.fsf@nanos.tec.linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 01, 2020 at 12:33:26PM +0100, Thomas Gleixner wrote:
> On Tue, Dec 01 2020 at 10:20, Peter Zijlstra wrote:
> > On Tue, Dec 01, 2020 at 01:12:25AM +0100, Frederic Weisbecker wrote:
> > Why not something like:
> >
> > void irqtime_account_irq(struct task_struct *curr, unsigned int offset)
> > {
> > 	struct irqtime *irqtime = this_cpu_ptr(&cpu_irqtime);
> > 	unsigned int pc = preempt_count() - offset;
> > 	s64 delta;
> > 	int cpu;
> >
> > 	if (!sched_clock_irqtime)
> > 		return;
> >
> > 	cpu = smp_processor_id();
> > 	delta = sched_clock_cpu(cpu) - irqtime->irq_start_time;
> > 	irqtime->irq_start_time += delta;
> >
> > 	/*
> > 	 * We do not account for softirq time from ksoftirqd here.
> > 	 * We want to continue accounting softirq time to ksoftirqd thread
> > 	 * in that case, so as not to confuse scheduler with a special task
> > 	 * that do not consume any time, but still wants to run.
> > 	 */
> > 	if (pc & HARDIRQ_MASK)
> > 		irqtime_account_delta(irqtime, delta, CPUTIME_IRQ);
> > 	else if ((pc & SOFTIRQ_OFFSET) && curr != this_cpu_ksoftirqd())
> > 		irqtime_account_delta(irqtime, delta, CPUTIME_SOFTIRQ);
> > }
> 
> Why not making all of this explicit instead of these conditionals?

Hmm, I'm not sure I get what you suggest?

Thanks.
