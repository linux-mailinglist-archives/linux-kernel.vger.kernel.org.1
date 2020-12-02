Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 383CA2CB912
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 10:41:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388221AbgLBJix (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 04:38:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388208AbgLBJiw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 04:38:52 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF854C0613CF
        for <linux-kernel@vger.kernel.org>; Wed,  2 Dec 2020 01:38:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Dq7RRhfsaifNT5HQEIdoQ3pAx7LiGBMZUX+onUtH7Ow=; b=Q1vJayOBieNfo5tgaOUkU+WX+g
        eY0H7I0U475tuHObpiXU2GkdJAGDmZKfOU4m7rjr5B9gsBxFQyK01T3YPi4irsJZ2Iud9MEW+E1c3
        V0XGjqDtoEPvcb6UhKmYFGNT8VHjCGrgCEVW9yADWf+UEEoVHSrwFk5W2F58tAdar8FlhAAALhXBg
        qfN8qMKnn9CPZLqtbL4VBXxHNDry8Bbpn5sMkBhSW86ZamwIVVeQkx27yXdizcqW9LwVwJqpgyHMC
        gjU6XPPYlzJnh7/WWDdHSxmZ5kBfPWdgsinKFAVWD3laRtGSAyWIPLoy7WGQuc9dMIdBkt2gdHLQ5
        6WlE5hlQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kkOaN-0004iB-3W; Wed, 02 Dec 2020 09:38:07 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id BC14430018A;
        Wed,  2 Dec 2020 10:38:05 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A78412C8A802B; Wed,  2 Dec 2020 10:38:05 +0100 (CET)
Date:   Wed, 2 Dec 2020 10:38:05 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Heiko Carstens <hca@linux.ibm.com>
Cc:     Sven Schnelle <svens@linux.ibm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>
Subject: Re: [GIT pull] locking/urgent for v5.10-rc6
Message-ID: <20201202093805.GB3040@hirez.programming.kicks-ass.net>
References: <160665707945.2808.5384034634184489471.tglx@nanos>
 <160665708065.2808.15317906761841446715.tglx@nanos>
 <CAHk-=wi3o-wwFVbAXb7YZZViDBsZ_yMVqyOAEZsx5qcskLsOcg@mail.gmail.com>
 <20201130075651.GJ2414@hirez.programming.kicks-ass.net>
 <yt9dh7p78d8l.fsf@linux.ibm.com>
 <yt9dpn3v3u1m.fsf@linux.ibm.com>
 <20201130125211.GN2414@hirez.programming.kicks-ass.net>
 <20201130130315.GJ3092@hirez.programming.kicks-ass.net>
 <20201202075427.GA5838@osiris>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201202075427.GA5838@osiris>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 02, 2020 at 08:54:27AM +0100, Heiko Carstens wrote:
> > > But but but...
> > > 
> > >   do_idle()			# IRQs on
> > >     local_irq_disable();	# IRQs off
> > >     defaul_idle_call()	# IRQs off
> > 	lockdep_hardirqs_on();	# IRQs off, but lockdep things they're on
> > >       arch_cpu_idle()		# IRQs off
> > >         enabled_wait()	# IRQs off
> > > 	  raw_local_save()	# still off
> > > 	  psw_idle()		# very much off
> > > 	    ext_int_handler	# get an interrupt ?!?!
> > 	      rcu_irq_enter()	# lockdep thinks IRQs are on <- FAIL
> > 
> > I can't much read s390 assembler, but ext_int_handler() has a
> > TRACE_IRQS_OFF, which would be sufficient to re-align the lockdep state
> > with the actual state, but there's some condition before it, what's that
> > test and is that right?
> 
> After digging a bit into our asm code: no, it is not right, and only
> for psw_idle() it is wrong.
> 
> What happens with the current code:
> 
> - default_idle_call() calls lockdep_hardirqs_on() before calling into
>   arch_cpu_idle()

Correct.

> - our arch_cpu_idle() calls psw_idle() which enables irqs. the irq
>   handler will call/use the SWITCH_ASYNC macro which clears the
>   interrupt enabled bits in the old program status word (_only_ for
>   psw_idle)

This is the condition at 0: that compares r13 to psw_idle_exit?

> - this again causes the interrupt handler to _not_ call TRACE_IRQS_OFF
>   and therefore lockdep thinks interrupts are enabled within the
>   interrupt handler
> 
> So I guess my patch which I sent yesterday evening should fix all that
> mess

Yes, afaict it does the right thing. Exceptions should call
TRACE_IRQS_OFF unconditionally, since the hardware will disable
interrupts upon taking an exception, irrespective of what the previous
context had.

On exception return the previous IRQ state is inspected and lockdep is
changed to match (except for NMIs, which either are ignored by lockdep
or need a little bit of extra care).
