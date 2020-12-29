Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D9282E7164
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Dec 2020 15:32:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbgL2Obi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Dec 2020 09:31:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:57010 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726126AbgL2Obh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Dec 2020 09:31:37 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A6D6E20825;
        Tue, 29 Dec 2020 14:30:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609252257;
        bh=0/Qq83f1tC/D+PQkSdueffqo+nc97r3irtoltp2NR1c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CgSwDfJNFbHSJZT0FF7f7bn8YZJjiPdsxpJw9CEfEPK1mM5HlJz0utbWU1JdtnmPV
         Sm9mRgIYKotUT3Z2CpQbONynYl6YJ11PWBxpBbQ299WHz33mIOSs5S86Or7BO1KW7O
         LzxGUGl9p0Z30dTnowVmZi5vxak/0t811uwilGiUFawOfUbNSLAz0JruZ26Z1ip1M4
         w3OoPgn/GfcHVF/B3BAIxgRnANM8M4erKbSGtFaskEgjhq8WHKkQogyBvv7KS8aVBl
         gmee0dKWAPRwVo3c2OaM00Ph+g9SN+OVJFAFhrnND3OlO88SbPz007eeQgyA+Q0V+H
         vFaLJaxeVTYgQ==
Date:   Tue, 29 Dec 2020 15:30:54 +0100
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
Message-ID: <20201229143054.GC21613@lothringen>
References: <20201202115732.27827-1-frederic@kernel.org>
 <20201202115732.27827-5-frederic@kernel.org>
 <20201228021529.2dlioupobocjcqzk@e107158-lin>
 <20201229134146.GA21613@lothringen>
 <20201229141231.c2ppmjucxxbz5j5h@e107158-lin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201229141231.c2ppmjucxxbz5j5h@e107158-lin>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 29, 2020 at 02:12:31PM +0000, Qais Yousef wrote:
> On 12/29/20 14:41, Frederic Weisbecker wrote:
> > > > -void vtime_account_irq(struct task_struct *tsk)
> > > > +void vtime_account_irq(struct task_struct *tsk, unsigned int offset)
> > > >  {
> > > > -	if (hardirq_count()) {
> > > > +	unsigned int pc = preempt_count() - offset;
> > > > +
> > > > +	if (pc & HARDIRQ_OFFSET) {
> > > 
> > > Shouldn't this be HARDIRQ_MASK like above?
> > 
> > In the rare cases of nested hardirqs happening with broken drivers, Only the outer hardirq
> > does matter. All the time spent in the inner hardirqs is included in the outer
> > one.
> 
> Ah I see. The original code was doing hardirq_count(), which apparently wasn't
> right either.
> 
> Shouldn't it be pc == HARDIRQ_OFFSET then? All odd nest counts will trigger
> this otherwise, and IIUC we want this to trigger once on first entry only.

Right but we must also handle hardirqs interrupting either preempt disabled sections
or softirq servicing/disabled section.

3 stacking hardirqs should be rare enough that we don't really care. In the
worst case we are going to account the third IRQ seperately. Not a correctness
issue, just a rare unoptimized case.

> 
> Thanks
> 
> --
> Qais Yousef
