Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FF2C2E7203
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Dec 2020 17:00:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726350AbgL2P7m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Dec 2020 10:59:42 -0500
Received: from foss.arm.com ([217.140.110.172]:41244 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726126AbgL2P7m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Dec 2020 10:59:42 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D2FD830E;
        Tue, 29 Dec 2020 07:58:56 -0800 (PST)
Received: from e107158-lin (e107158-lin.cambridge.arm.com [10.1.194.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4DD4B3F6CF;
        Tue, 29 Dec 2020 07:58:55 -0800 (PST)
Date:   Tue, 29 Dec 2020 15:58:52 +0000
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
Message-ID: <20201229155852.paudsonz6m66x2nz@e107158-lin>
References: <20201202115732.27827-1-frederic@kernel.org>
 <20201202115732.27827-5-frederic@kernel.org>
 <20201228021529.2dlioupobocjcqzk@e107158-lin>
 <20201229134146.GA21613@lothringen>
 <20201229141231.c2ppmjucxxbz5j5h@e107158-lin>
 <20201229143054.GC21613@lothringen>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201229143054.GC21613@lothringen>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/29/20 15:30, Frederic Weisbecker wrote:
> On Tue, Dec 29, 2020 at 02:12:31PM +0000, Qais Yousef wrote:
> > On 12/29/20 14:41, Frederic Weisbecker wrote:
> > > > > -void vtime_account_irq(struct task_struct *tsk)
> > > > > +void vtime_account_irq(struct task_struct *tsk, unsigned int offset)
> > > > >  {
> > > > > -	if (hardirq_count()) {
> > > > > +	unsigned int pc = preempt_count() - offset;
> > > > > +
> > > > > +	if (pc & HARDIRQ_OFFSET) {
> > > > 
> > > > Shouldn't this be HARDIRQ_MASK like above?
> > > 
> > > In the rare cases of nested hardirqs happening with broken drivers, Only the outer hardirq
> > > does matter. All the time spent in the inner hardirqs is included in the outer
> > > one.
> > 
> > Ah I see. The original code was doing hardirq_count(), which apparently wasn't
> > right either.
> > 
> > Shouldn't it be pc == HARDIRQ_OFFSET then? All odd nest counts will trigger
> > this otherwise, and IIUC we want this to trigger once on first entry only.
> 
> Right but we must also handle hardirqs interrupting either preempt disabled sections
> or softirq servicing/disabled section.
> 
> 3 stacking hardirqs should be rare enough that we don't really care. In the
> worst case we are going to account the third IRQ seperately. Not a correctness
> issue, just a rare unoptimized case.

I admit I need to wrap my head around some more details to fully comprehend
that, but that's my own confusion to clear out :-)

Thanks for your answer.

Cheers

--
Qais Yousef
