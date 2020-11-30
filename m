Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 578DB2C7F68
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 08:58:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727529AbgK3H5n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 02:57:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726299AbgK3H5n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 02:57:43 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77F53C0613CF
        for <linux-kernel@vger.kernel.org>; Sun, 29 Nov 2020 23:57:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=8bZkvwy3CFq9HwUxMeKMBaZFd0BWaHfOhGOX+0uRRCM=; b=NZPsNqlwvQUBjI4w2ECBxEef8U
        6sv3uPKoxMeORZjb4/ab0zds+sZcx1EDLsAXX18q9fRmY9tVyZntPIxgjt3xEmlKSiYn+o7IOo7Nu
        ZOMkiJeaUeAUmKEuG9hJDlr2FhN/8btubYewT7Ap4zNzSYEzPH1bsiKABGOsrDcqSy/pfqC6llEuu
        UDikT1DcoHapgONCFHR19Nu+6fYnNKwtNnzgJNxceU2lppmsHm+n/dMlQK8af5CG793PoD5SpHo9b
        /bFDEDlqauE1gvmklqQtQIwuc3J89JB/uk364++iRqLGemnCwTQE7KztUByRAHylTAaF0H4CZQF4i
        6MjEi9fQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kje3L-00024v-RG; Mon, 30 Nov 2020 07:56:56 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C082A301179;
        Mon, 30 Nov 2020 08:56:51 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2AD242018E5B6; Mon, 30 Nov 2020 08:56:51 +0100 (CET)
Date:   Mon, 30 Nov 2020 08:56:51 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>
Subject: Re: [GIT pull] locking/urgent for v5.10-rc6
Message-ID: <20201130075651.GJ2414@hirez.programming.kicks-ass.net>
References: <160665707945.2808.5384034634184489471.tglx@nanos>
 <160665708065.2808.15317906761841446715.tglx@nanos>
 <CAHk-=wi3o-wwFVbAXb7YZZViDBsZ_yMVqyOAEZsx5qcskLsOcg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wi3o-wwFVbAXb7YZZViDBsZ_yMVqyOAEZsx5qcskLsOcg@mail.gmail.com>
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

Agreed.

The idea was to flip all of arch_cpu_idle() to not enable interrupts.

This is suboptimal for things like x86 where arch_cpu_idle() is
basically STI;HLT, but x86 isn't likely to actually use this code path
anyway, given all the various cpuidle drivers it has.

Many of the other archs are now doing things like arm's:
wfi();raw_local_irq_enable().

Doing that tree-wide interrupt-state flip was something I didn't want to
do at this late a stage, the chanse of messing that up is just too high.

After that I need to go look at flipping cpuidle, which is even more
'interesting'. cpuidle_enter() has the exact same semantics, and this is
the code path that x86 actually uses, and here it's inconsitent at best.
