Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3F1B2C98CF
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 09:09:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726746AbgLAIIZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 03:08:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726402AbgLAIIZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 03:08:25 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21982C0613CF
        for <linux-kernel@vger.kernel.org>; Tue,  1 Dec 2020 00:07:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=AtNeN9oMiW1mC8TvT8/pkBeoxB72lR5hn6NDhBPhxOQ=; b=ajcAindFN+X4j+QKCMG3DQ//d2
        ZMAWNrm31t2MsuWlk2+ZO52QzjbWrY/L3InRU+j3mvSKSlYxpeUiBV9sjz8i9qCcw3X7t9zJgYycf
        I0ukm0qkulubrPggh34tdacR4dnkzngeyDeOZRKHRNjDVfwKKmW2QftDTW9MjREK+6sArkDVdy6g7
        0X5OuoaII3Bp6AteOewsnYtKYbpTq1vA+NY8/NNWsVH/qSNPjuOYU3V3FDI/Y0c3UCZSx1Jn+M6H4
        0VroL7+M5M8FpbG5fO2MGOUrje5UmNQLbd54/npyaaGhFgCU3F4LDRHT0bMxaXgLvKI0YFRBOdzdH
        9nMk0FZA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kk0hE-0002Am-8f; Tue, 01 Dec 2020 08:07:36 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 1661130018A;
        Tue,  1 Dec 2020 09:07:35 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id EC6732038998E; Tue,  1 Dec 2020 09:07:34 +0100 (CET)
Date:   Tue, 1 Dec 2020 09:07:34 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Christian Borntraeger <borntraeger@de.ibm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Sven Schnelle <svens@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>
Subject: Re: [GIT pull] locking/urgent for v5.10-rc6
Message-ID: <20201201080734.GQ2414@hirez.programming.kicks-ass.net>
References: <160665707945.2808.5384034634184489471.tglx@nanos>
 <160665708065.2808.15317906761841446715.tglx@nanos>
 <CAHk-=wi3o-wwFVbAXb7YZZViDBsZ_yMVqyOAEZsx5qcskLsOcg@mail.gmail.com>
 <20201130075651.GJ2414@hirez.programming.kicks-ass.net>
 <yt9dh7p78d8l.fsf@linux.ibm.com>
 <yt9dpn3v3u1m.fsf@linux.ibm.com>
 <20201130125211.GN2414@hirez.programming.kicks-ass.net>
 <20201130130315.GJ3092@hirez.programming.kicks-ass.net>
 <CAHk-=whSdxfCW3YpoZafPaCD_DQsuxFWMKLyYFsdGWL2wu9haQ@mail.gmail.com>
 <dcdb13e3-36a0-031d-6ec3-3ab5ee4a69cb@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dcdb13e3-36a0-031d-6ec3-3ab5ee4a69cb@de.ibm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 30, 2020 at 08:31:32PM +0100, Christian Borntraeger wrote:
> On 30.11.20 19:04, Linus Torvalds wrote:
> > On Mon, Nov 30, 2020 at 5:03 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >>
> >>> But but but...
> >>>
> >>>   do_idle()                   # IRQs on
> >>>     local_irq_disable();      # IRQs off
> >>>     defaul_idle_call()        # IRQs off
> >>         lockdep_hardirqs_on();  # IRQs off, but lockdep things they're on
> >>>       arch_cpu_idle()         # IRQs off
> >>>         enabled_wait()        # IRQs off
> >>>         raw_local_save()      # still off
> >>>         psw_idle()            # very much off
> >>>           ext_int_handler     # get an interrupt ?!?!
> >>               rcu_irq_enter()   # lockdep thinks IRQs are on <- FAIL
> >>
> >> I can't much read s390 assembler, but ext_int_handler() has a
> >> TRACE_IRQS_OFF, which would be sufficient to re-align the lockdep state
> >> with the actual state, but there's some condition before it, what's that
> >> test and is that right?
> > 
> > I think that "psw_idle()" enables interrupts, exactly like x86 does.

(like ye olde x86, modern x86 idles with interrupts disabled)

> Yes, by definition.  Otherwise it would be an software error state.
> The interesting part is the lpswe instruction at the end (load PSW) 
> which loads the full PSW, which contains interrupt enablement, wait bit,
> condition code, paging enablement, machine check enablement the address
> and others. The idle psw is enabled for interrupts and has the wait bit
> set. If the wait bit is set and interrupts are off this is called "disabled
> wait" and is used for panic, shutdown etc. 

OK, but at that point, hardware interrupt state is on, lockdep thinks
it's on. And we take an interrupt, just like any old regular interrupt
enabled region.

But then the exception handler (ext_int_handler), which I'm assuming is
ran by the hardware with hardware interrupts disabled again, should be
calling into lockdep to tell interrupts were disabled. IOW that
TRACE_IRQS_OFF bit in there.

But that doesn't seem to be working right. Why? Because afaict this is
then the exact normal flow of things, but it's only going sideways
during this idle thing.

What's going 'funny' ?
