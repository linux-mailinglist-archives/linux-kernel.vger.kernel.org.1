Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53FC82CA62F
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 15:47:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403988AbgLAOr0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 09:47:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:58830 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389714AbgLAOrZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 09:47:25 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-104-11.bvtn.or.frontiernet.net [50.39.104.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A0956204EA;
        Tue,  1 Dec 2020 14:46:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606834004;
        bh=csvLksHWs85LbETQQSsiH967ScFP8TsaOmqFl4gtQzI=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=zV8m0uCeaM8LHXI4SuDf83+RLlDJNeavJvnBBwIPROYayDJJn9OuS7UhBJ7BEjY6t
         NckES+amWbkRWRXZIdXQP8Oa4hcWMn2IH+arQnrkwOKf+8ea1LKD4+zD/APDfT/ra5
         +1zl45/Ix6QW0WT3qGt6LBO+cM2Y1i10V80ERaRw=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 373A235226B6; Tue,  1 Dec 2020 06:46:44 -0800 (PST)
Date:   Tue, 1 Dec 2020 06:46:44 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Christian Borntraeger <borntraeger@de.ibm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sven Schnelle <svens@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>
Subject: Re: [GIT pull] locking/urgent for v5.10-rc6
Message-ID: <20201201144644.GF1437@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <CAHk-=wi3o-wwFVbAXb7YZZViDBsZ_yMVqyOAEZsx5qcskLsOcg@mail.gmail.com>
 <20201130075651.GJ2414@hirez.programming.kicks-ass.net>
 <yt9dh7p78d8l.fsf@linux.ibm.com>
 <yt9dpn3v3u1m.fsf@linux.ibm.com>
 <20201130125211.GN2414@hirez.programming.kicks-ass.net>
 <20201130130315.GJ3092@hirez.programming.kicks-ass.net>
 <CAHk-=whSdxfCW3YpoZafPaCD_DQsuxFWMKLyYFsdGWL2wu9haQ@mail.gmail.com>
 <dcdb13e3-36a0-031d-6ec3-3ab5ee4a69cb@de.ibm.com>
 <20201201080734.GQ2414@hirez.programming.kicks-ass.net>
 <20201201110724.GL3092@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201201110724.GL3092@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 01, 2020 at 12:07:24PM +0100, Peter Zijlstra wrote:
> On Tue, Dec 01, 2020 at 09:07:34AM +0100, Peter Zijlstra wrote:
> > On Mon, Nov 30, 2020 at 08:31:32PM +0100, Christian Borntraeger wrote:
> > > On 30.11.20 19:04, Linus Torvalds wrote:
> > > > On Mon, Nov 30, 2020 at 5:03 AM Peter Zijlstra <peterz@infradead.org> wrote:
> > > >>
> > > >>> But but but...
> > > >>>
> > > >>>   do_idle()                   # IRQs on
> > > >>>     local_irq_disable();      # IRQs off
> > > >>>     defaul_idle_call()        # IRQs off
> > > >>         lockdep_hardirqs_on();  # IRQs off, but lockdep things they're on
> > > >>>       arch_cpu_idle()         # IRQs off
> > > >>>         enabled_wait()        # IRQs off
> > > >>>         raw_local_save()      # still off
> > > >>>         psw_idle()            # very much off
> > > >>>           ext_int_handler     # get an interrupt ?!?!
> > > >>               rcu_irq_enter()   # lockdep thinks IRQs are on <- FAIL
> > > >>
> > > >> I can't much read s390 assembler, but ext_int_handler() has a
> > > >> TRACE_IRQS_OFF, which would be sufficient to re-align the lockdep state
> > > >> with the actual state, but there's some condition before it, what's that
> > > >> test and is that right?
> > > > 
> > > > I think that "psw_idle()" enables interrupts, exactly like x86 does.
> > 
> > (like ye olde x86, modern x86 idles with interrupts disabled)
> > 
> > > Yes, by definition.  Otherwise it would be an software error state.
> > > The interesting part is the lpswe instruction at the end (load PSW) 
> > > which loads the full PSW, which contains interrupt enablement, wait bit,
> > > condition code, paging enablement, machine check enablement the address
> > > and others. The idle psw is enabled for interrupts and has the wait bit
> > > set. If the wait bit is set and interrupts are off this is called "disabled
> > > wait" and is used for panic, shutdown etc. 
> > 
> > OK, but at that point, hardware interrupt state is on, lockdep thinks
> > it's on. And we take an interrupt, just like any old regular interrupt
> > enabled region.
> > 
> > But then the exception handler (ext_int_handler), which I'm assuming is
> > ran by the hardware with hardware interrupts disabled again, should be
> > calling into lockdep to tell interrupts were disabled. IOW that
> > TRACE_IRQS_OFF bit in there.
> > 
> > But that doesn't seem to be working right. Why? Because afaict this is
> > then the exact normal flow of things, but it's only going sideways
> > during this idle thing.
> > 
> > What's going 'funny' ?
> 
> So after having talked to Sven a bit, the thing that is happening, is
> that this is the one place where we take interrupts with RCU being
> disabled. Normally RCU is watching and all is well, except during idle.

Isn't interrupt entry supposed to invoke rcu_irq_enter() at some point?
Or did this fall victim to recent optimizations?

							Thanx, Paul
