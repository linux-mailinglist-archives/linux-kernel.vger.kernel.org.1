Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21EB92C7C1D
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 01:31:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727233AbgK3A37 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Nov 2020 19:29:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:51398 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726619AbgK3A37 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Nov 2020 19:29:59 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-104-11.bvtn.or.frontiernet.net [50.39.104.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5090820757;
        Mon, 30 Nov 2020 00:29:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606696158;
        bh=AFNPbcOvNO3axL1Cw9H6p7sMIexGAOqwTP/Qg274OEU=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=R9Wx3awIirqrfiEq3buaz1GniocImYWL1jIdYcmW7dWH+AmZWsKh/hjAY2bdfVOzO
         ZKfv9qlCklfgWURuY3HOeQ0uYBG9niWRRgDu9vuYNfCbQYVz+mfNXvK2tF/YkLXn+z
         7FHjcJwIO24DOs1iaxKPEXKbV/k+UNT7B5OX71W4=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 14E1A3522B57; Sun, 29 Nov 2020 16:29:18 -0800 (PST)
Date:   Sun, 29 Nov 2020 16:29:18 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>
Subject: Re: [GIT pull] locking/urgent for v5.10-rc6
Message-ID: <20201130002918.GD1437@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <160665707945.2808.5384034634184489471.tglx@nanos>
 <160665708065.2808.15317906761841446715.tglx@nanos>
 <CAHk-=wi3o-wwFVbAXb7YZZViDBsZ_yMVqyOAEZsx5qcskLsOcg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wi3o-wwFVbAXb7YZZViDBsZ_yMVqyOAEZsx5qcskLsOcg@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 29, 2020 at 11:31:41AM -0800, Linus Torvalds wrote:
> On Sun, Nov 29, 2020 at 5:38 AM Thomas Gleixner <tglx@linutronix.de> wrote:
> >
> > Yet two more places which invoke tracing from RCU disabled regions in the
> > idle path. Similar to the entry path the low level idle functions have to
> > be non-instrumentable.
> 
> This really seems less than optimal.
> 
> In particular, lookie here:
> 
> > @@ -94,9 +94,35 @@ void __cpuidle default_idle_call(void)
> >
> >                 trace_cpu_idle(1, smp_processor_id());
> >                 stop_critical_timings();
> > +
> > +               /*
> > +                * arch_cpu_idle() is supposed to enable IRQs, however
> > +                * we can't do that because of RCU and tracing.
> > +                *
> > +                * Trace IRQs enable here, then switch off RCU, and have
> > +                * arch_cpu_idle() use raw_local_irq_enable(). Note that
> > +                * rcu_idle_enter() relies on lockdep IRQ state, so switch that
> > +                * last -- this is very similar to the entry code.
> > +                */
> > +               trace_hardirqs_on_prepare();
> > +               lockdep_hardirqs_on_prepare(_THIS_IP_);
> >                 rcu_idle_enter();
> > +               lockdep_hardirqs_on(_THIS_IP_);
> > +
> >                 arch_cpu_idle();
> > +
> > +               /*
> > +                * OK, so IRQs are enabled here, but RCU needs them disabled to
> > +                * turn itself back on.. funny thing is that disabling IRQs
> > +                * will cause tracing, which needs RCU. Jump through hoops to
> > +                * make it 'work'.
> > +                */
> > +               raw_local_irq_disable();
> > +               lockdep_hardirqs_off(_THIS_IP_);
> >                 rcu_idle_exit();
> > +               lockdep_hardirqs_on(_THIS_IP_);
> > +               raw_local_irq_enable();
> > +
> >                 start_critical_timings();
> >                 trace_cpu_idle(PWR_EVENT_EXIT, smp_processor_id());
> >         }
> 
> And look at what the code generation for the idle exit path is when
> lockdep isn't even on.
> 
> It's *literally*
> 
>         cli
>         call rcu_idle_exit
>         sti
> 
> and guess what rcu_idle_exit does?
> 
> Yeah, that one does "pushf; cli; call rcu_eqs_exit; popf".
> 
> So here we are, in the somewhat critical "an interrupt woke us up"
> section, and we're doing just ridiculously stupid things.
> 
> I've pulled this, because it solves a problem, but there's a deeper
> problem here in how all this is done.
> 
> The idle path is actually quite important. I can point to real loads
> where this is a big part of the CPU profile, because you end up having
> lots of "go to sleep for very short times, because the thing we were
> waiting for takes almost no time at all".

This is because of the noinline implied by the noinstr on rcu_eqs_exit().
If I replace that with inline, it does get inlined.  Except that, if
I remember correctly, making that change messes up the tooling that
enforces the no-instrumentation regions.

I -think- that a combination of instrumentation_end() and s/noinstr/inline/
might work, but I will need to consult with the experts on this.

							Thanx, Paul
